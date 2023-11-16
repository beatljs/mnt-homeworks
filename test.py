import sentry_sdk

sentry_sdk.init(
    dsn="https://576bbdc414a7a756bf53577434ecc3d1@o4506234325434368.ingest.sentry.io/4506234404995072",
    traces_sample_rate=1.0,
    profiles_sample_rate=1.0,
    environment="development",
    release="1.0"
)

def test_function(choice):
  if choice == 1:
    print('One is selected.')
  elif choice == 2:
    print('Two is selected.')
  else:
    print('Another is selected.')

if __name__ == "__main__":
  test_function(1)
  test_function(2)
  test_function(5)
  test_function(3,15)
