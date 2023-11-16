import sentry_sdk

sentry_sdk.init(
    dsn="https://576bbdc414a7a756bf53577434ecc3d1@o4506234325434368.ingest.sentry.io/4506234404995072",
    traces_sample_rate=1.0,
    profiles_sample_rate=1.0,
    environment="development",
    release="1.0"
)

if __name__ == "__main__":
  divizion_zero = 1/0
  unknown_function_call()
