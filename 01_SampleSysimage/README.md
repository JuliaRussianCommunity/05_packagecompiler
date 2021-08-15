# Creating sysimage

The sample explains code precompiling specifics and shows time differences depending on how a sysimage was created.

Run [`./precompile.sh`](precompile.sh) to create a sysimage of `SampleSysimage` with `__init__()` activation only.

Run [`./precompile_with_tests.sh`](precompile_with_tests.sh) to create a sysimage with real test code run and all the methods trace.

See difference of `sysimage/precompile.jl` and `sysimage_test/precompile.jl`. The first file contains only one method from `SampleSysimage`:

```julia
precompile(Tuple{typeof(SampleSysimage.__init__)})
...
```

In precompile file after the tests trace contains all the methods of `SampleSysimage`:
```julia
precompile(Tuple{typeof(SampleSysimage.__init__)})
precompile(Tuple{typeof(SampleSysimage.greet)})
precompile(Tuple{typeof(SampleSysimage.mul), Int64, Int64})
precompile(Tuple{typeof(SampleSysimage.mul), String, String})
precompile(Tuple{typeof(SampleSysimage.table)}
...
```

## Further experiments

After the sysimage actication all the methods and variable of the module are available by default.
```sh
julia --project=@. -Jsysimage/custom_image.so -e 'SampleSysimage.greet()'
julia --project=@. -Jsysimage/custom_image.so -e 'using SampleSysimage; greet()'
julia --project=@. -Jsysimage/custom_image.so -e 'println(SampleSysimage.global_initialized_string)'
```

Also, see load times for `using SampleSysimage` and the first call of `table()` method.

Pure julia run without precompiling:
```sh
julia --project=@. -e '@time using SampleSysimage; @time table();'
```

Use sysimage with the only `__init__()` method precompiling:
```sh
julia --project=@. -Jsysimage/custom_image.so -e '@time using SampleSysimage; @time table();'
```

Use sysimage with all the methods precompiling:
```sh
julia --project=@. -Jsysimage_tests/custom_image.so -e '@time using SampleSysimage; @time table();'
```
