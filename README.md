# Samples for PackageCompiler presentation
The repository contains sample projects with different aspects of [PackageCompiler.jl](https://github.com/JuliaLang/PackageCompiler.jl) use.

## Simple Sysimage with aspects of precompiling
[01_SampleSysimage](./01_SampleSysimage)

The sample explains code precompiling specifics and shows time differences depending on how a sysimage was created.

## Sysimage issue with huge static initilized variables
[02_BigInitSample](./02_BigInitSample)

The sample demonstrates an issue with keeping huge memory structures in a global scope.

## Application sample
[03_SampleApp](./03_SampleApp)

The project contains scripts for generating binary applications and demonstrates the advantages of proper precompiling code trace.

## Issues with DocOpt in application
[04_SampleAppDocOpt](./04_SampleAppDocOpt)

The project demonstrates a workaround to integrate tools like DocOpt. The key aspect here is an incompatibility of the code style to combine script- and binary-oriented code writing.

## Sample of a web service with image processing logic
[JWebImageDemo](https://github.com/rssdev10/JWebImageDemo.jl)

Independent service for demonstrating Julia facilities with sysimage use inside a Docker container.
