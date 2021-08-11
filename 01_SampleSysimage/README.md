```sh
julia --project=@. -Jsysimage/custom_image.so -e 'SampleSysimage.greet()'
julia --project=@. -Jsysimage/custom_image.so -e 'using SampleSysimage; greet()'
```

```sh
julia --project=@. -e '@time using SampleSysimage; @time table();'
julia --project=@. -Jsysimage/custom_image.so -e '@time using SampleSysimage; @time table();'
julia --project=@. -Jsysimage_tests/custom_image.so -e '@time using SampleSysimage; @time table();'
```
