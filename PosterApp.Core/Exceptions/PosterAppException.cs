namespace PosterApp.Core.namespacec class PosterAppException : ExceptionExceptionblic PosterAppException(string message) : base(message) { }
    public PosterAppException(string message, Exception innerException) : base(message, innerException) { }
}

public class ValidationException : PosterAppException
{
    public ValidationException(string message) : base(message) { }
}

public class BusinessRuleException : PosterAppException
{
    public BusinessRuleException(string message) : base(message) { }
}
