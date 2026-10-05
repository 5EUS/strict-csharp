using Xunit;

namespace StrictCommon.Tests;

/// <summary>Tests for <see cref="Greeter"/>.</summary>
public sealed class GreeterTests
{
    /// <summary>The greeting embeds the supplied name.</summary>
    [Fact]
    public void GreetIncludesName() =>
        Assert.Equal("Hello World with C#", Greeter.Greet("C#"));
}
