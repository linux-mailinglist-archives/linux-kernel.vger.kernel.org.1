Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8F42E6B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbgL1Wz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:59 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:33713 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgL1U1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:27:14 -0500
Date:   Mon, 28 Dec 2020 20:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1609187185;
        bh=jZba/tXWLrglw6sSGOg0ZPEdQZYHt2iSfcxHYnINLTA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=qwO+cHrw+FYvE0pzHZiIvN8q40KZQA15zxF/r29wGVyF/bZVbvdpagRjDt6mBV22b
         k7ukd5i44kAHmSNDTD25eN7L1vG5VwNFLORxn11RaLsOtaiayso6rWdHiyIo7W1UJp
         ZBJF9UeZHZGCFvNzgrf+AOI9lSPM7VytM5AZXkYQ=
To:     Perry Yuan <Perry.Yuan@dell.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Limonciello Mario <Mario.Limonciello@dell.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell hardware privacy
Message-ID: <mXtNUreCVsPKizG-fnNKPId9_lQGit0S6pYEpk-aNT1hGQjVwblZDiO4E-YX3hxnrbbNN1-6hSntiv13wz66RxbhXjPJhpAVOIlZmmwUI7w=@protonmail.com>
In-Reply-To: <20201228132855.17544-1-Perry_Yuan@Dell.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


Firstly, a minor note: the newly created sysfs attributes are not documente=
d, so
I believe you should either move them to debugfs or add documentation. And =
I
believe you might have forgotten to send the second patch in the series.

I added a couple comments regarding the code, but unfortunately I believe t=
here
are deeper, architectural problems. I cannot help but think that this is a =
bit
over-complicated with its 1 platform device, 1 platform driver, 1 WMI drive=
r,
2 source files, not-immediately-clear relationship between the two "submodu=
les",
and (a bit) forced integration with the dell-wmi module.

If it were up to me I would do it the simplest way: a single module,
exports dell_privacy_is_ok() and dell_privacy_event(); its probe checks the=
 WMI
GUID, the EC handle, and the ECAK method; registers a single platform devic=
e
with PLATFORM_DEVID_NONE and with the necessary attributes (devices_support=
ed,
current_state); registers the LED and input device under the platform devic=
e.

But, of course, you should wait for Hans or Mark to see what they'd prefer.


2020. december 28., h=C3=A9tf=C5=91 14:28 keltez=C3=A9ssel, Perry Yuan =
=C3=ADrta:

> From: Perry Yuan <perry_yuan@dell.com>
>
> add support for dell privacy driver for the dell units equipped
> hardware privacy design, which protect users privacy
> of audio and camera from hardware level. once the audio or camera
> privacy mode enabled, any applications will not get any audio or
> video stream.
> when user pressed ctrl+F4 hotkey, audio privacy mode will be
> enabled,Micmute led will be also changed accordingly.
> The micmute led is fully controlled by hardware & EC.

I believe at the first occurrence of "EC" it should be noted what it stands=
 for.


> and camera mute hotkey is ctrl+F9.currently design only emmit
> SW_CAMERA_LENS_COVER event while the camera LENS shutter will be

Why is "LENS" capitalized?


> changed by EC & HW control.
>
> *The flow is like this:
> 1) User presses key. HW does stuff with this key (timeout is started)
> 2) Event is emitted from FW
> 3) Event received by dell-privacy
> 4) KEY_MICMUTE emitted from dell-privacy
> 5) Userland picks up key and modifies kcontrol for SW mute
> 6) Codec kernel driver catches and calls ledtrig_audio_set, like this:
> =09ledtrig_audio_set(LED_AUDIO_MICMUTE,
> =09=09rt715->micmute_led ? LED_ON :LED_OFF);
> 7) If "LED" is set to on dell-privacy notifies ec,
>   and timeout is cancelled,HW mic mute activated.
>

Please proofread the commit message again, and pay attention to capitalizat=
ion
and spacing.


> Signed-off-by: Perry Yuan  <perry_yuan@dell.com>
> Signed-off-by: Limonciello Mario <mario_limonciello@dell.com>
> ---
> v1 -> v2:
> * query EC handle from EC driver directly.
> * fix some code style.
> * add KEY_END to keymap array.
> * clean platform device when cleanup called
> * use hexadecimal format for log print in dev_dbg
> * remove __set_bit for the report keys from probe.
> * fix keymap leak
> * add err_free_keymap in dell_privacy_wmi_probe
> * wmi driver will be unregistered if privacy_acpi_init() fails
> * add sysfs attribute files for user space query.
> * add leds micmute driver to privacy acpi
> * add more design info the commit info
> ---
> ---
>  drivers/platform/x86/Kconfig             |  17 ++
>  drivers/platform/x86/Makefile            |   4 +-
>  drivers/platform/x86/dell-laptop.c       |  29 ++-
>  drivers/platform/x86/dell-privacy-acpi.c | 165 ++++++++++++
>  drivers/platform/x86/dell-privacy-wmi.c  | 309 +++++++++++++++++++++++
>  drivers/platform/x86/dell-privacy-wmi.h  |  33 +++
>  drivers/platform/x86/dell-wmi.c          |  26 +-
>  7 files changed, 567 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/platform/x86/dell-privacy-acpi.c
>  create mode 100644 drivers/platform/x86/dell-privacy-wmi.c
>  create mode 100644 drivers/platform/x86/dell-privacy-wmi.h
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 91e6176cdfbd..9d5cc2454b3e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -491,6 +491,23 @@ config DELL_WMI_LED
>  =09  This adds support for the Latitude 2100 and similar
>  =09  notebooks that have an external LED.
>
> +config DELL_PRIVACY
> +=09tristate "Dell Hardware Privacy Support"
> +=09depends on ACPI
> +=09depends on ACPI_WMI
> +=09depends on INPUT
> +=09depends on DELL_LAPTOP
> +=09depends on LEDS_TRIGGER_AUDIO
> +=09select DELL_WMI
> +=09help
> +=09This driver provides support for the "Dell Hardware Privacy" feature
> +=09of Dell laptops.
> +=09Support for a micmute and camera mute privacy will be provided as
> +=09hardware button Ctrl+F4 and Ctrl+F9 hotkey
> +
> +=09To compile this driver as a module, choose M here: the module will
> +=09be called dell_privacy.
> +
>  config AMILO_RFKILL
>  =09tristate "Fujitsu-Siemens Amilo rfkill support"
>  =09depends on RFKILL
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index 581475f59819..18c430456de7 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -51,7 +51,9 @@ obj-$(CONFIG_DELL_WMI_DESCRIPTOR)=09+=3D dell-wmi-descr=
iptor.o
>  obj-$(CONFIG_DELL_WMI_AIO)=09=09+=3D dell-wmi-aio.o
>  obj-$(CONFIG_DELL_WMI_LED)=09=09+=3D dell-wmi-led.o
>  obj-$(CONFIG_DELL_WMI_SYSMAN)=09=09+=3D dell-wmi-sysman/
> -
> +obj-$(CONFIG_DELL_PRIVACY)              +=3D dell-privacy.o
> +dell-privacy-objs                       :=3D dell-privacy-wmi.o \
> +=09                                   dell-privacy-acpi.o
>  # Fujitsu
>  obj-$(CONFIG_AMILO_RFKILL)=09+=3D amilo-rfkill.o
>  obj-$(CONFIG_FUJITSU_LAPTOP)=09+=3D fujitsu-laptop.o
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/de=
ll-laptop.c
> index 70edc5bb3a14..ea0c8a8099ff 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -30,6 +30,7 @@
>  #include <acpi/video.h>
>  #include "dell-rbtn.h"
>  #include "dell-smbios.h"
> +#include "dell-privacy-wmi.h"
>
>  struct quirk_entry {
>  =09bool touchpad_led;
> @@ -90,6 +91,7 @@ static struct rfkill *wifi_rfkill;
>  static struct rfkill *bluetooth_rfkill;
>  static struct rfkill *wwan_rfkill;
>  static bool force_rfkill;
> +static bool privacy_valid;
>
>  module_param(force_rfkill, bool, 0444);
>  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models"=
);
> @@ -1587,10 +1589,10 @@ static ssize_t kbd_led_timeout_store(struct devic=
e *dev,
>  =09=09switch (unit) {
>  =09=09case KBD_TIMEOUT_DAYS:
>  =09=09=09value *=3D 24;
> -=09=09=09fallthrough;
> +=09=09=09/* fall through */
>  =09=09case KBD_TIMEOUT_HOURS:
>  =09=09=09value *=3D 60;
> -=09=09=09fallthrough;
> +=09=09=09/* fall through */

What is the reason behind changing "fallthrough;" to a comment?


>  =09=09case KBD_TIMEOUT_MINUTES:
>  =09=09=09value *=3D 60;
>  =09=09=09unit =3D KBD_TIMEOUT_SECONDS;
> @@ -2205,11 +2207,18 @@ static int __init dell_init(void)
>  =09dell_laptop_register_notifier(&dell_laptop_notifier);
>
>  =09if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
> -=09    dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> -=09=09micmute_led_cdev.brightness =3D ledtrig_audio_get(LED_AUDIO_MICMUT=
E);
> -=09=09ret =3D led_classdev_register(&platform_device->dev, &micmute_led_=
cdev);
> -=09=09if (ret < 0)
> -=09=09=09goto fail_led;
> +=09=09=09dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
> +=09=09ret =3D dell_privacy_valid();
> +=09=09if (!ret)
> +=09=09=09privacy_valid =3D true;
> +#endif
> +=09=09if (!privacy_valid) {
> +=09=09=09micmute_led_cdev.brightness =3D ledtrig_audio_get(LED_AUDIO_MIC=
MUTE);
> +=09=09=09ret =3D led_classdev_register(&platform_device->dev, &micmute_l=
ed_cdev);
> +=09=09=09if (ret < 0)
> +=09=09=09=09goto fail_led;
> +=09=09}
>  =09}
>
>  =09if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
> @@ -2257,7 +2266,8 @@ static int __init dell_init(void)
>  fail_get_brightness:
>  =09backlight_device_unregister(dell_backlight_device);
>  fail_backlight:
> -=09led_classdev_unregister(&micmute_led_cdev);
> +=09if (!privacy_valid)
> +=09=09led_classdev_unregister(&micmute_led_cdev);
>  fail_led:
>  =09dell_cleanup_rfkill();
>  fail_rfkill:
> @@ -2278,7 +2288,8 @@ static void __exit dell_exit(void)
>  =09=09touchpad_led_exit();
>  =09kbd_led_exit();
>  =09backlight_device_unregister(dell_backlight_device);
> -=09led_classdev_unregister(&micmute_led_cdev);
> +=09if (!privacy_valid)
> +=09=09led_classdev_unregister(&micmute_led_cdev);
>  =09dell_cleanup_rfkill();
>  =09if (platform_device) {
>  =09=09platform_device_unregister(platform_device);
> diff --git a/drivers/platform/x86/dell-privacy-acpi.c b/drivers/platform/=
x86/dell-privacy-acpi.c
> new file mode 100644
> index 000000000000..fef781555b67
> --- /dev/null
> +++ b/drivers/platform/x86/dell-privacy-acpi.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Dell privacy notification driver
> + *
> + * Copyright (C) 2021 Dell Inc. All Rights Reserved.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/wmi.h>
> +#include <linux/slab.h>
> +#include <linux/bits.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include "dell-privacy-wmi.h"

I believe it would be preferable to sort the list of includes lexicographic=
ally.
("dell-privacy-wmi.h" can remain separate)


> +
> +#define PRIVACY_PLATFORM_NAME=09"dell-privacy-acpi"
> +#define DELL_PRIVACY_GUID=09"6932965F-1671-4CEB-B988-D3AB0A901919"
> +
> +struct privacy_acpi_priv {
> +=09struct device *dev;
> +=09struct platform_device *platform_device;
> +=09struct led_classdev cdev;
> +};
> +static struct privacy_acpi_priv *privacy_acpi;

Any reason it needs to be dynamically allocated?


> +
> +static int dell_privacy_micmute_led_set(struct led_classdev *led_cdev,
> +=09=09enum led_brightness brightness)
> +{
> +=09struct privacy_acpi_priv *priv =3D privacy_acpi;
> +=09acpi_status status;
> +=09acpi_handle handle;
> +=09char *acpi_method;
> +
> +=09handle =3D ec_get_handle();
> +=09if (!handle)
> +=09=09return -EIO;
> +=09if (acpi_has_method(handle, "ECAK"))
> +=09=09acpi_method =3D "ECAK";
> +=09else
> +=09=09return -ENODEV;

I find this if-else a bit cumbersome. Any reason why

if (!acpi_has_method(handle, "ECAK"))
  return ...;

would not work? I believe you could also easily do away with the `acpi_meth=
od`
variable.


> +
> +=09status =3D acpi_evaluate_object(handle, acpi_method, NULL, NULL);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09dev_err(priv->dev, "Error setting privacy EC ack value: %s\n",
> +=09=09=09=09acpi_format_exception(status));
> +=09=09return -EIO;
> +=09}
> +=09return 0;
> +}
> +
> +static int dell_privacy_acpi_remove(struct platform_device *pdev)
> +{
> +=09struct privacy_acpi_priv *priv =3D dev_get_drvdata(privacy_acpi->dev)=
;
> +
> +=09led_classdev_unregister(&priv->cdev);
> +=09dev_set_drvdata(&pdev->dev, NULL);

This is not needed as the driver sets the driver data to NULL when a driver
unbinds from a device.


> +
> +=09return 0;
> +}
> +/*
> + * Pressing the mute key activates a time delayed circuit to physically =
cut
> + * off the mute. The LED is in the same circuit, so it reflects the true
> + * state of the HW mute.  The reason for the EC "ack" is so that softwar=
e
> + * can first invoke a SW mute before the HW circuit is cut off.  Without=
 SW
> + * cutting this off first does not affect the time delayed muting or sta=
tus
> + * of the LED but there is a possibility of a "popping" noise.
> + *
> + * If the EC receives the SW ack, the circuit will be activated before t=
he
> + * delay completed.
> + *
> + * Exposing as an LED device allows the codec drivers notification path =
to
> + * EC ACK to work
> + */
> +static void dell_privacy_leds_setup(struct device *dev)
> +{
> +=09struct privacy_acpi_priv *priv =3D dev_get_drvdata(dev);
> +
> +=09priv->cdev.name =3D "privacy::micmute";

Maybe "dell-privacy::micmute"?


> +=09priv->cdev.max_brightness =3D 1;
> +=09priv->cdev.brightness_set_blocking =3D dell_privacy_micmute_led_set;
> +=09priv->cdev.default_trigger =3D "audio-micmute";
> +=09priv->cdev.brightness =3D ledtrig_audio_get(LED_AUDIO_MICMUTE);
> +=09priv->cdev.dev =3D dev;

There is no need for this assignment.


> +=09devm_led_classdev_register(dev, &priv->cdev);

I believe it'd be preferable to return the return value of this call.


> +}
> +
> +static int dell_privacy_acpi_probe(struct platform_device *pdev)
> +{
> +=09platform_set_drvdata(pdev, privacy_acpi);
> +=09privacy_acpi->dev =3D &pdev->dev;
> +=09privacy_acpi->platform_device =3D pdev;
> +=09return 0;
> +}
> +
> +static const struct acpi_device_id privacy_acpi_device_ids[] =3D {
> +=09{"PNP0C09", 0},
> +=09{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, privacy_acpi_device_ids);
> +
> +static struct platform_driver dell_privacy_platform_drv =3D {
> +=09.driver =3D {
> +=09=09.name =3D PRIVACY_PLATFORM_NAME,
> +=09=09.acpi_match_table =3D ACPI_PTR(privacy_acpi_device_ids),
> +=09},
> +=09.remove =3D dell_privacy_acpi_remove,
> +};

I think using a platform driver here just complicates things for no reason.
Furthermore, I'm not sure if there's actually any need for the ACPI match t=
able.


> +
> +int dell_privacy_acpi_init(void)

I believe this could be marked __init.


> +{
> +=09int err;
> +=09struct platform_device *pdev;
> +=09int privacy_capable =3D wmi_has_guid(DELL_PRIVACY_GUID);
> +
> +=09if (!privacy_capable)

It could just be `if (!wmi_has_guid(...))`.


> +=09=09return -ENODEV;
> +
> +=09privacy_acpi =3D kzalloc(sizeof(struct privacy_acpi_priv), GFP_KERNEL=
);

Please use `sizeof(*privacy_acpi)`.


> +=09if (!privacy_acpi)
> +=09=09return -ENOMEM;
> +
> +=09pdev =3D platform_device_register_simple(
> +=09=09=09PRIVACY_PLATFORM_NAME, -1, NULL, 0);

Please use `PLATFORM_DEVID_NONE` instead of -1.


> +=09if (IS_ERR(pdev)) {
> +=09=09err =3D PTR_ERR(pdev);
> +=09=09goto pdev_err;
> +=09}
> +=09err =3D platform_driver_probe(&dell_privacy_platform_drv,
> +=09=09=09dell_privacy_acpi_probe);

What is the reason for preferring this instead of specifying the probe call=
back
in the platform_driver struct and registering it?


> +=09if (err)
> +=09=09goto pdrv_err;
> +
> +=09dell_privacy_leds_setup(&pdev->dev);

I think you should check if the call succeeds or not.


> +
> +=09return 0;
> +
> +pdrv_err:
> +=09platform_device_unregister(pdev);
> +pdev_err:
> +=09kfree(privacy_acpi);
> +=09return err;
> +}
> +
> +void dell_privacy_acpi_exit(void)

I believe this could be marked __exit.


> +{
> +=09struct platform_device *pdev =3D to_platform_device(privacy_acpi->dev=
);
> +
> +=09platform_device_unregister(pdev);
> +=09platform_driver_unregister(&dell_privacy_platform_drv);
> +=09kfree(privacy_acpi);
> +}
> +
> +MODULE_AUTHOR("Perry Yuan <perry_yuan@dell.com>");
> +MODULE_DESCRIPTION("DELL Privacy ACPI Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/dell-privacy-wmi.c b/drivers/platform/x=
86/dell-privacy-wmi.c
> new file mode 100644
> index 000000000000..80637c7f617c
> --- /dev/null
> +++ b/drivers/platform/x86/dell-privacy-wmi.c
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Dell privacy notification driver
> + *
> + * Copyright (C) 2021 Dell Inc. All Rights Reserved.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +#include "dell-privacy-wmi.h"
> +
> +#define DELL_PRIVACY_GUID "6932965F-1671-4CEB-B988-D3AB0A901919"
> +#define MICROPHONE_STATUS=09=09    BIT(0)
> +#define CAMERA_STATUS=09=09        BIT(1)
> +#define PRIVACY_SCREEN_STATUS=09=09BIT(2)
> +
> +static int privacy_valid =3D -EPROBE_DEFER;

I think it'd be better `privacy_valid` was a `bool` (or maybe an enum):

```
enum dell_privacy_state {
=09DELL_PRIVACY_STATE_OK,
=09DELL_PRIVACY_STATE_NOK,
=09DELL_PRIVACY_STATE_UNKNOWN,
};
```

or something similar.


> +static LIST_HEAD(wmi_list);
> +static DEFINE_MUTEX(list_mutex);
> +
> +struct privacy_wmi_data {
> +=09struct input_dev *input_dev;
> +=09struct wmi_device *wdev;
> +=09struct list_head list;
> +=09u32 features_present;
> +=09u32 last_status;
> +};
> +
> +/*
> + * Keymap for WMI Privacy events of type 0x0012
> + */
> +static const struct key_entry dell_wmi_keymap_type_0012[] =3D {
> +=09/* Privacy MIC Mute */

Any reason for "MIC" being capitalized?


> +=09{ KE_KEY, 0x0001, { KEY_MICMUTE } },
> +=09/* Privacy Camera Mute */
> +=09{ KE_SW,  0x0002, { SW_CAMERA_LENS_COVER } },
> +=09{ KE_END, 0},
> +};
> +
> +int dell_privacy_valid(void)
> +{
> +=09int ret;
> +
> +=09ret =3D wmi_has_guid(DELL_PRIVACY_GUID);
> +=09if (!ret)
> +=09=09return -ENODEV;
> +=09ret =3D privacy_valid;
> +=09return ret;

I find this function really confusing, and too verbose for what it does.


> +}
> +EXPORT_SYMBOL_GPL(dell_privacy_valid);
> +
> +void dell_privacy_process_event(int type, int code, int status)
> +{
> +=09struct privacy_wmi_data *priv;
> +=09const struct key_entry *key;
> +
> +=09mutex_lock(&list_mutex);
> +=09priv =3D list_first_entry_or_null(&wmi_list,
> +=09=09=09struct privacy_wmi_data,
> +=09=09=09list);

Can you please explain why this list is needed if only the first entry will
ever be used?


> +=09if (!priv) {
> +=09=09pr_err("dell privacy priv is NULL\n");
> +=09=09goto error;
> +=09}
> +=09key =3D sparse_keymap_entry_from_scancode(priv->input_dev, (type << 1=
6)|code);
> +=09if (!key) {
> +=09=09dev_dbg(&priv->wdev->dev, "Unknown key with type 0x%04x and code 0=
x%04x pressed\n",
> +=09=09=09=09type, code);
> +=09=09goto error;
> +=09}
> +=09switch (code) {
> +=09case DELL_PRIVACY_TYPE_AUDIO: /* Mic mute */
> +=09=09priv->last_status =3D status;
> +=09=09sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> +=09=09break;
> +=09case DELL_PRIVACY_TYPE_CAMERA: /* Camera mute */
> +=09=09priv->last_status =3D status;
> +=09=09sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> +=09=09break;
> +=09default:
> +=09=09=09dev_dbg(&priv->wdev->dev, "unknown event type 0x%04x 0x%04x",
> +=09=09=09=09=09type, code);
> +=09}

Is this switch needed at all?


> +error:
> +=09mutex_unlock(&list_mutex);
> +}
> +EXPORT_SYMBOL_GPL(dell_privacy_process_event);
> +
> +static ssize_t devices_supported_show(struct device *dev,
> +=09=09struct device_attribute *attr,
> +=09=09char *buf)
> +{
> +=09struct privacy_wmi_data *priv =3D dev_get_drvdata(dev);
> +
> +=09return sprintf(buf, "%d\n", priv->features_present);

Please use `sysfs_emit()`. And I believe printing with %x would be preferab=
le.


> +}
> +
> +static ssize_t current_state_show(struct device *dev,
> +=09=09struct device_attribute *attr,
> +=09=09char *buf)
> +{
> +=09struct privacy_wmi_data *priv =3D dev_get_drvdata(dev);
> +
> +=09return sprintf(buf, "%d\n", priv->last_status);

Same here.


> +}
> +
> +static DEVICE_ATTR_RO(devices_supported);
> +static DEVICE_ATTR_RO(current_state);
> +
> +static struct attribute *platform_attributes[] =3D {

Maybe "privacy_attributes" or something similar would be more expressive?


> +=09&dev_attr_devices_supported.attr,
> +=09&dev_attr_current_state.attr,
> +=09NULL,
> +};
> +
> +static const struct attribute_group privacy_attribute_group =3D {
> +=09.attrs =3D platform_attributes
> +};
> +
> +/*
> + * Describes the Device State class exposed by BIOS which can be consume=
d by
> + * various applications interested in knowing the Privacy feature capabi=
lities.
> + * class DeviceState
> + * {
> + *  [key, read] string InstanceName;
> + *  [read] boolean ReadOnly;
> + *  [WmiDataId(1), read] uint32 DevicesSupported;
> + *   0 =E2=80=93 None, 0x1 =E2=80=93 Microphone, 0x2 =E2=80=93 Camera, 0=
x4 -ePrivacy  Screen
> + *  [WmiDataId(2), read] uint32 CurrentState;
> + *   0:Off; 1:On. Bit0 =E2=80=93 Microphone, Bit1 =E2=80=93 Camera, Bit2=
 - ePrivacyScreen
> + * };
> + */
> +
> +static int get_current_status(struct wmi_device *wdev)
> +{
> +=09struct privacy_wmi_data *priv =3D dev_get_drvdata(&wdev->dev);
> +=09union acpi_object *obj_present =3D NULL;

As far as I see there is not need to initialize `obj_present`.


> +=09u32 *buffer;
> +=09int ret =3D 0;
> +
> +=09if (priv =3D=3D NULL) {

Maybe `if (WARN_ON(!priv))`? But `!priv` is preferred in any case.


> +=09=09pr_err("dell privacy priv is NULL\n");
> +=09=09return -EINVAL;
> +=09}
> +=09/* check privacy support features and device states */
> +=09obj_present =3D wmidev_block_query(wdev, 0);

`wmidev_block_query()` may return `NULL`, so you should check for that as w=
ell.


> +=09if (obj_present->type !=3D ACPI_TYPE_BUFFER) {
> +=09=09dev_err(&wdev->dev, "Dell privacy failed to get device status!\n")=
;

I think a more specific error message ("unexpected type") would be preferab=
le.


> +=09=09ret =3D -EIO;
> +=09=09privacy_valid =3D ret;
> +=09=09goto obj_free;
> +=09}
> +=09/*  Although it's not technically a failure, this would lead to
> +=09 *  unexpected behavior
> +=09 */
> +=09if (obj_present->buffer.length !=3D 8) {
> +=09=09dev_err(&wdev->dev, "Dell privacy buffer has unexpected length (%d=
)!\n",
> +=09=09=09=09obj_present->buffer.length);
> +=09=09ret =3D -ENODEV;

I personally don't think ENODEV is the most suitable error code here. EINVA=
L/EILSEQ
seem more appropriate to me.


> +=09=09privacy_valid =3D ret;
> +=09=09goto obj_free;
> +=09}
> +=09buffer =3D (u32 *)obj_present->buffer.pointer;
> +=09priv->features_present =3D buffer[0];
> +=09priv->last_status =3D buffer[1];

I believe `get_unaligned_{le,be}32()` from `asm/unaligned.h` would be prefe=
rable
here.


> +=09privacy_valid =3D 0;
> +
> +obj_free:
> +=09kfree(obj_present);
> +=09return ret;
> +}
> +
> +static int dell_privacy_wmi_probe(struct wmi_device *wdev, const void *c=
ontext)
> +{
> +=09struct privacy_wmi_data *priv;
> +=09struct key_entry *keymap;
> +=09int ret, i, pos =3D 0;

There is actually no need for the `pos` variable.


> +
> +=09priv =3D devm_kzalloc(&wdev->dev, sizeof(struct privacy_wmi_data),

Please use `sizeof(*priv)`.


> +=09=09=09GFP_KERNEL);
> +=09if (!priv)
> +=09=09return -ENOMEM;
> +
> +=09dev_set_drvdata(&wdev->dev, priv);
> +=09priv->wdev =3D wdev;
> +=09/* create evdev passing interface */
> +=09priv->input_dev =3D devm_input_allocate_device(&wdev->dev);
> +=09if (!priv->input_dev)
> +=09=09return -ENOMEM;
> +=09/* remap the wmi keymap event to new keymap */
> +=09keymap =3D kcalloc(ARRAY_SIZE(dell_wmi_keymap_type_0012) +
> +=09=09=091,

I don't think that `+ 1` is not needed since the KE_END entry is already in=
 the array.


> +=09=09=09sizeof(struct key_entry), GFP_KERNEL);
> +=09if (!keymap) {
> +=09=09ret =3D -ENOMEM;
> +=09=09goto err_free_dev;
> +=09}
> +=09/* remap the keymap code with Dell privacy key type 0x12 as prefix
> +=09 * KEY_MICMUTE scancode will be reported as 0x120001
> +=09 */
> +=09for (i =3D 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
> +=09=09keymap[pos] =3D dell_wmi_keymap_type_0012[i];
> +=09=09keymap[pos].code |=3D (0x0012 << 16);
> +=09=09pos++;
> +=09}
> +=09ret =3D sparse_keymap_setup(priv->input_dev, keymap, NULL);
> +=09if (ret)
> +=09=09return ret;

A copy of the keymap is created by `sparse_keymap_setup()`, so returning
here will leak `keymap`. You could just call `kfree(keymap)` directly after
the `sparse_keymap_setup()` call. But I find it completely unnecessary
to do this allocate-copy-modify thing. Is there any reason why the static a=
rray
(`dell_wmi_keymap_type_0012`) cannot already contain the correct values?


> +=09priv->input_dev->dev.parent =3D &wdev->dev;
> +=09priv->input_dev->name =3D "Dell Privacy Driver";
> +=09priv->input_dev->id.bustype =3D BUS_HOST;
> +=09if (input_register_device(priv->input_dev)) {
> +=09=09pr_debug("input_register_device failed to register!\n");
> +=09=09goto err_free_keymap;
> +=09}
> +=09mutex_lock(&list_mutex);
> +=09list_add_tail(&priv->list, &wmi_list);
> +=09mutex_unlock(&list_mutex);
> +=09if (get_current_status(priv->wdev))
> +=09=09goto err_free_keymap;

The input device is not unregistered in this branch.


> +=09ret =3D sysfs_create_group(&wdev->dev.kobj, &privacy_attribute_group)=
;

I suggest you replace `sysfs_{create,remove}_group()` with
`device_{add,remove}_group()` as it is more expressive in my opinion.


> +=09if (ret)
> +=09=09goto err_free_keymap;

Similarly, the input device is not unregistered in this branch.


> +=09return 0;

`keymap` is again leaked by this return.


> +
> +err_free_keymap:
> +=09privacy_valid =3D -ENODEV;
> +=09kfree(keymap);
> +err_free_dev:
> +=09return ret;
> +}
> +
> +static int dell_privacy_wmi_remove(struct wmi_device *wdev)
> +{
> +=09struct privacy_wmi_data *priv =3D dev_get_drvdata(&wdev->dev);
> +
> +=09mutex_lock(&list_mutex);
> +=09list_del(&priv->list);
> +=09mutex_unlock(&list_mutex);
> +=09privacy_valid =3D -ENODEV;
> +=09sysfs_remove_group(&wdev->dev.kobj, &privacy_attribute_group);
> +

The input device is not unregistered.

> +=09return 0;
> +}
> +
> +static const struct wmi_device_id dell_wmi_privacy_wmi_id_table[] =3D {
> +=09{ .guid_string =3D DELL_PRIVACY_GUID },
> +=09{ },
> +};
> +
> +static struct wmi_driver dell_privacy_wmi_driver =3D {
> +=09.driver =3D {
> +=09=09.name =3D "dell-privacy",
> +=09},
> +=09.probe =3D dell_privacy_wmi_probe,
> +=09.remove =3D dell_privacy_wmi_remove,
> +=09.id_table =3D dell_wmi_privacy_wmi_id_table,
> +};
> +
> +static int __init init_dell_privacy(void)
> +{
> +=09int ret;
> +
> +=09ret =3D wmi_has_guid(DELL_PRIVACY_GUID);
> +=09if (!ret)
> +=09=09return -ENODEV;

The init function of a module that exports symbols must not fail, otherwise
it'll prevent the loading of dependent modules.


> +
> +=09ret =3D dell_privacy_acpi_init();
> +=09if (ret) {
> +=09=09pr_err("failed to initialize privacy acpi driver: %d\n", ret);
> +=09=09goto err_init;
> +=09}
> +
> +=09ret =3D wmi_driver_register(&dell_privacy_wmi_driver);
> +=09if (ret) {
> +=09=09pr_err("failed to initialize privacy wmi driver: %d\n", ret);
> +=09=09return ret;
> +=09}
> +=09return 0;
> +
> +err_init:
> +=09wmi_driver_unregister(&dell_privacy_wmi_driver);

At this point the WMI driver is not registered.


> +=09return ret;
> +}
> +
> +static void dell_privacy_wmi_exit(void)

I believe this function could be marked __exit as well.


> +{
> +=09wmi_driver_unregister(&dell_privacy_wmi_driver);
> +}
> +
> +static void __exit exit_dell_privacy(void)
> +{
> +=09dell_privacy_wmi_exit();
> +=09dell_privacy_acpi_exit();
> +}
> +
> +module_init(init_dell_privacy);
> +module_exit(exit_dell_privacy);
> +
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_privacy_wmi_id_table);
> +MODULE_AUTHOR("Perry Yuan <perry_yuan@dell.com>");
> +MODULE_DESCRIPTION("Dell Privacy WMI Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/dell-privacy-wmi.h b/drivers/platform/x=
86/dell-privacy-wmi.h
> new file mode 100644
> index 000000000000..9fa01d084f7d
> --- /dev/null
> +++ b/drivers/platform/x86/dell-privacy-wmi.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Dell privacy notification driver
> + *
> + * Copyright (C) 2021 Dell Inc. All Rights Reserved.
> + */
> +
> +#ifndef _DELL_PRIVACY_WMI_H_
> +#define _DELL_PRIVACY_WMI_H_
> +
> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
> +int  dell_privacy_valid(void);
> +void dell_privacy_process_event(int type, int code, int status);
> +#else /* CONFIG_DELL_PRIVACY */
> +static inline int dell_privacy_valid(void)
> +{
> +=09return  -ENODEV;
> +}
> +
> +static inline void dell_privacy_process_event(int type, int code, int st=
atus)
> +{}
> +#endif /* CONFIG_DELL_PRIVACY */
> +
> +int  dell_privacy_acpi_init(void);
> +void dell_privacy_acpi_exit(void);
> +
> +/* DELL Privacy Type */
> +enum {
> +=09DELL_PRIVACY_TYPE_UNKNOWN =3D 0x0,
> +=09DELL_PRIVACY_TYPE_AUDIO,
> +=09DELL_PRIVACY_TYPE_CAMERA,
> +};
> +#endif
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-=
wmi.c
> index bbdb3e860892..4b22bd21fc42 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -27,6 +27,7 @@
>  #include <acpi/video.h>
>  #include "dell-smbios.h"
>  #include "dell-wmi-descriptor.h"
> +#include "dell-privacy-wmi.h"
>
>  MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
>  MODULE_AUTHOR("Pali Roh=C3=A1r <pali@kernel.org>");
> @@ -381,6 +382,7 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>  =09u16 *buffer_entry, *buffer_end;
>  =09acpi_size buffer_size;
>  =09int len, i;
> +=09int err;
>
>  =09if (obj->type !=3D ACPI_TYPE_BUFFER) {
>  =09=09pr_warn("bad response type %x\n", obj->type);
> @@ -427,18 +429,30 @@ static void dell_wmi_notify(struct wmi_device *wdev=
,
>
>  =09=09switch (buffer_entry[1]) {
>  =09=09case 0x0000: /* One key pressed or event occurred */
> -=09=09case 0x0012: /* Event with extended data occurred */
> -=09=09=09if (len > 2)
> -=09=09=09=09dell_wmi_process_key(wdev, buffer_entry[1],
> -=09=09=09=09=09=09     buffer_entry[2]);
> -=09=09=09/* Extended data is currently ignored */
> -=09=09=09break;
>  =09=09case 0x0010: /* Sequence of keys pressed */
>  =09=09case 0x0011: /* Sequence of events occurred */
>  =09=09=09for (i =3D 2; i < len; ++i)
>  =09=09=09=09dell_wmi_process_key(wdev, buffer_entry[1],
>  =09=09=09=09=09=09     buffer_entry[i]);
>  =09=09=09break;
> +=09=09case 0x0012:

The comment "Event with extended data occurred" has been deleted.


> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
> +=09=09=09err =3D dell_privacy_valid();
> +=09=09=09if (err =3D=3D 0) {
> +=09=09=09=09dell_privacy_process_event(buffer_entry[1],
> +=09=09=09=09=09=09buffer_entry[3], buffer_entry[4]);

What if `len < 5`?


> +=09=09=09} else {
> +=09=09=09=09if (len > 2)
> +=09=09=09=09=09dell_wmi_process_key(wdev, buffer_entry[1],
> +=09=09=09=09=09=09=09buffer_entry[2]);
> +=09=09=09}
> +#else
> +=09=09=09/* Extended data is currently ignored */
> +=09=09=09if (len > 2)
> +=09=09=09=09dell_wmi_process_key(wdev, buffer_entry[1],
> +=09=09=09=09=09=09buffer_entry[2]);
> +#endif
> +=09=09=09break;
>  =09=09default: /* Unknown event */
>  =09=09=09pr_info("Unknown WMI event type 0x%x\n",
>  =09=09=09=09(int)buffer_entry[1]);
> --
> 2.25.1


Regards,
Barnab=C3=A1s P=C5=91cze
