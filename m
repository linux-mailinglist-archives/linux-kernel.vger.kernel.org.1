Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722872A4FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgKCTOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:14:48 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:47708 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgKCTOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:14:47 -0500
Date:   Tue, 03 Nov 2020 19:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1604430880;
        bh=l/cjlpXMkEkYBaau1T1zaSzewV7fGa0lfZO68wXNBns=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hyWjC4F4WL7OP+bH4LKL/IoMOrCVa993sdFtmAdrkpoH6Pi+KDRT8KgGCvmkd/ooI
         ZOkIduPuWsuCrjg+NfOLVmr7/HkWhtgYll4bgMN7wxWtwx5qQsL7w/lmTrOJmE5tuA
         tzVJGyuVHtFXslyOmjbejkPIKSXqzxTn4/DAG5Xg=
To:     Perry Yuan <Perry.Yuan@dell.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Limonciello Mario <Mario.Limonciello@dell.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH]  platform/x86: dell-privacy: Add support for new privacy driver
Message-ID: <HyOaD6eXLsDlTnnZPyQgvsr60w02MsxxgRqhKOyaFtM6LwKcVfAGkkNsHGOh-ObHKxCwIKCmxQVkRypV_7FfS3f6VZWJ0K8FdjRd8bNxt_c=@protonmail.com>
In-Reply-To: <20201103125542.8572-1-Perry_Yuan@Dell.com>
References: <20201103125542.8572-1-Perry_Yuan@Dell.com>
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

(I really hope Hans and Mark won't get mad at me for writing some thoughts =
about
this patch.)

First of all, indentation should be tabs (=3D 8 spaces), not spaces. If I s=
ee it
correctly, the two are mixed here.

And please make the printed messages consistent (capitalization, etc.),
I believe punctuation at the end is not necessary, and don't leave whitespa=
ces
between the text and newline character. Please always run `checkpatch` on t=
he patch
to see what can/needs to be improved.

There are also parts in the code (variables not actually used, etc.) that m=
ake me
feel like it's somewhat unfinished, or rather, incomplete.

Both `dell-privacy-acpi` and `dell-privacy-wmi` have the same comment:
"Dell privacy notification driver", but surely they are not the same thing?

I have also added a couple comments inline.


> From: perry_yuan <perry_yuan@dell.com>
>
>  add support for dell privacy driver for the dell units equipped
>  hardware privacy design, which protect users privacy
>  of audio and camera from hardware level. once the audio or camera
>  privacy mode enabled, any applications will not get any audio or
>  video stream.
>  when user pressed ctrl+F4 hotkey, audio privacy mode will be enabled
>  and camera mute hotkey is ctrl+F9.
>
> Signed-off-by: Perry Yuan  <perry_yuan@dell.com>
> Signed-off-by: Limonciello Mario <mario_limonciello@dell.com>
> ---
>  drivers/platform/x86/Kconfig             |  12 ++
>  drivers/platform/x86/Makefile            |   4 +-
>  drivers/platform/x86/dell-laptop.c       |  41 ++--
>  drivers/platform/x86/dell-privacy-acpi.c | 139 ++++++++++++
>  drivers/platform/x86/dell-privacy-wmi.c  | 259 +++++++++++++++++++++++
>  drivers/platform/x86/dell-privacy-wmi.h  |  23 ++
>  drivers/platform/x86/dell-wmi.c          |  90 ++++----
>  7 files changed, 513 insertions(+), 55 deletions(-)
>  create mode 100644 drivers/platform/x86/dell-privacy-acpi.c
>  create mode 100644 drivers/platform/x86/dell-privacy-wmi.c
>  create mode 100644 drivers/platform/x86/dell-privacy-wmi.h
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 40219bba6801..0cb6bf5a9565 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -454,6 +454,18 @@ config DELL_WMI_LED
>  =09  This adds support for the Latitude 2100 and similar
>  =09  notebooks that have an external LED.
>
> +config DELL_PRIVACY
> +        tristate "Dell Hardware Privacy Support"
> +        depends on ACPI
> +        depends on ACPI_WMI
> +        depends on INPUT
> +        depends on DELL_LAPTOP
> +        select DELL_WMI
> +        help
> +          This driver provides a driver to support messaging related to =
the

I'm not a native English speaker, but "messaging" seems a strange choice of
words to me here.


> +          privacy button presses on applicable Dell laptops from 2021 an=
d
> +          newer.

I have the same feeling about "from 2021 and newer".


> +
>  config AMILO_RFKILL
>  =09tristate "Fujitsu-Siemens Amilo rfkill support"
>  =09depends on RFKILL
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index 5f823f7eff45..111f7215db2f 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -47,7 +47,9 @@ obj-$(CONFIG_DELL_WMI)=09=09=09+=3D dell-wmi.o
>  obj-$(CONFIG_DELL_WMI_DESCRIPTOR)=09+=3D dell-wmi-descriptor.o
>  obj-$(CONFIG_DELL_WMI_AIO)=09=09+=3D dell-wmi-aio.o
>  obj-$(CONFIG_DELL_WMI_LED)=09=09+=3D dell-wmi-led.o
> -
> +obj-$(CONFIG_DELL_PRIVACY)              +=3D dell-privacy.o
> +dell-privacy-objs                       :=3D dell-privacy-wmi.o \
> +=09                                   dell-privacy-acpi.o
>  # Fujitsu
>  obj-$(CONFIG_AMILO_RFKILL)=09+=3D amilo-rfkill.o
>  obj-$(CONFIG_FUJITSU_LAPTOP)=09+=3D fujitsu-laptop.o
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/de=
ll-laptop.c
> index 5e9c2296931c..12b91de09356 100644
> -- a/drivers/platform/x86/dell-laptop.c
> ++ b/drivers/platform/x86/dell-laptop.c
> @@ -30,6 +30,7 @@
> #include <acpi/video.h>
> #include "dell-rbtn.h"
> #include "dell-smbios.h"
> #include "dell-privacy-wmi.h"
>
> struct quirk_entry {
> =09bool touchpad_led;
> @@ -90,6 +91,7 @@ static struct rfkill *wifi_rfkill;
> static struct rfkill *bluetooth_rfkill;
> static struct rfkill *wwan_rfkill;
> static bool force_rfkill;
> static bool privacy_valid;
>
> module_param(force_rfkill, bool, 0444);
> MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models")=
;
> @@ -2202,20 +2204,25 @@ static int __init dell_init(void)
> =09debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> =09=09=09    &dell_debugfs_fops);
>
> =09dell_laptop_register_notifier(&dell_laptop_notifier);
>
> =09if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
> =09    dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> =09=09micmute_led_cdev.brightness =3D ledtrig_audio_get(LED_AUDIO_MICMUTE=
);
> =09=09ret =3D led_classdev_register(&platform_device->dev, &micmute_led_c=
dev);
> =09=09if (ret < 0)
> =09=09=09goto fail_led;
> =09}
>
> =09if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
> =09=09return 0;
>
> =09token =3D dell_smbios_find_token(BRIGHTNESS_TOKEN);
>     dell_laptop_register_notifier(&dell_laptop_notifier);
>
>     if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
>             dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> #if IS_ENABLED(CONFIG_DELL_PRIVACY)
>         privacy_valid =3D dell_privacy_valid() =3D=3D -ENODEV;

`dell_privacy_valid()` returns `bool`.


> #endif
>         if (!privacy_valid) {
>             micmute_led_cdev.brightness =3D ledtrig_audio_get(LED_AUDIO_M=
ICMUTE);
>             ret =3D led_classdev_register(&platform_device->dev, &micmute=
_led_cdev);
>             if (ret < 0)
>                 goto fail_led;
>         }
>     }
>
>     if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
>         return 0;
>
>     token =3D dell_smbios_find_token(BRIGHTNESS_TOKEN);
> =09if (token) {
> =09=09struct calling_interface_buffer buffer;
>
> @@ -2257,7 +2264,8 @@ static int __init dell_init(void)
> fail_get_brightness:
> =09backlight_device_unregister(dell_backlight_device);
> fail_backlight:
> =09led_classdev_unregister(&micmute_led_cdev);
>     if (!privacy_valid)
>         led_classdev_unregister(&micmute_led_cdev);
> fail_led:
> =09dell_cleanup_rfkill();
> fail_rfkill:
> @@ -2278,7 +2286,8 @@ static void __exit dell_exit(void)
> =09=09touchpad_led_exit();
> =09kbd_led_exit();
> =09backlight_device_unregister(dell_backlight_device);
> =09led_classdev_unregister(&micmute_led_cdev);
>     if (!privacy_valid)
>         led_classdev_unregister(&micmute_led_cdev);
> =09dell_cleanup_rfkill();
> =09if (platform_device) {
> =09=09platform_device_unregister(platform_device);
> diff --git a/drivers/platform/x86/dell-privacy-acpi.c b/drivers/platform/=
x86/dell-privacy-acpi.c
> new file mode 100644
> index 000000000000..516cd99167c3
> --- /dev/null
> +++ b/drivers/platform/x86/dell-privacy-acpi.c
> @@ -0,0 +1,139 @@
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
> +#include <linux/platform_device.h>
> +#include "dell-privacy-wmi.h"
> +
> +#define PRIVACY_PlATFORM_NAME  "dell-privacy-acpi"
                    ^
should be upper case


> +#define ACPI_PRIVACY_DEVICE=09"\\_SB.PC00.LPCB.ECDV"
> +#define ACPI_PRIVACY_EC_ACK=09ACPI_PRIVACY_DEVICE ".ECAK"
> +
> +static struct platform_device *privacy_acpi_pdev;
> +
> +struct privacy_acpi_priv {
> +    struct device *dev;
> +    struct acpi_device *acpi_dev;
> +    struct input_dev *input_dev;
> +    struct platform_device *platform_device;
> +};
> +
> +static int micmute_led_set(struct led_classdev *led_cdev,
> +               enum led_brightness brightness)
> +{
> +    acpi_status status;
> +
> +    status =3D acpi_evaluate_object(NULL, ACPI_PRIVACY_EC_ACK, NULL, NUL=
L);

The handle of "ACPI_PRIVACY_DEVICE" is queried in `privacy_acpi_probe()`. W=
hy
is that not used here?


> +    if (ACPI_FAILURE(status)) {
> +        dev_err(led_cdev->dev, "Error setting privacy audio EC ack value=
: %d\n",status);
                                                                           =
        ^
                                                                   missing =
space -/

I think `acpi_format_exception()` could be used here.

I don't quite see why brightness is completely ignored? Does this just togg=
le
the LED state? Even in that case I think something should be done to avoid =
the
sysfs attribute showing brightness=3D1 while the LED is actually off.

Does the `ACPI_PRIVACY_EC_ACK` method (?) acknowledge something? If so, wha=
t? And
why is it called in the brightness setting method of a LED class device?


> +        return -EIO;
> +    }
> +    return 0;
> +}
> +
> +static struct led_classdev micmute_led_cdev =3D {
> +    .name =3D "platform::micmute",
> +    .max_brightness =3D 1,
> +    .brightness_set_blocking =3D micmute_led_set,
> +    .default_trigger =3D "audio-micmute",
> +};

There is also the exact same `micmute_led_cdev` is in dell-laptop.c. Both a=
re
valid? What's the difference? Why can't the LED be handled in just a single=
 place?


> [...]
> +static const struct acpi_device_id privacy_acpi_device_ids[] =3D {
> +    {"PNP0C09", 0},
> +    {"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, privacy_acpi_device_ids);
> +
> +static struct platform_driver privacy_platform_driver =3D {
> +    .driver     =3D {
> +        .name   =3D PRIVACY_PlATFORM_NAME,
> +        .acpi_match_table =3D ACPI_PTR(privacy_acpi_device_ids),
> +    },
> +    .probe      =3D privacy_acpi_probe,
> +    .remove     =3D privacy_acpi_remove,
> +};
> +
> +int privacy_acpi_init(void)
> +{
> +    int err;
> +
> +    err =3D platform_driver_register(&privacy_platform_driver);
> +    if (err)
> +        return err;
> +
> +    privacy_acpi_pdev =3D platform_device_register_simple(
> +            PRIVACY_PlATFORM_NAME, -1, NULL, 0);
> +    if (IS_ERR(privacy_acpi_pdev)) {
> +        err =3D PTR_ERR(privacy_acpi_pdev);
> +        goto err_platform;
> +    }
> +    return 0;
> +
> +err_platform:
> +    platform_driver_unregister(&privacy_platform_driver);
> +    return err;
> +}

Maybe I'm missing something obvious, but I do believe this is overly compli=
cated.
I don't see why you cannot check the ACPI path, if it exists, register
a platform device, and then register the led to that device? The whole plat=
form driver
part could've been avoided as far as I see.

I'm also wondering if the ACPI path is enough to decide undoubtedly that th=
is
is indeed a compatible device.


> +
> +void privacy_acpi_cleanup(void)
> +{
> +    platform_driver_unregister(&privacy_platform_driver);
> +}

The platform device is not cleaned up.


> +
> +MODULE_AUTHOR("Perry Yuan <perry_yuan@dell.com>");
> +MODULE_DESCRIPTION("DELL Privacy ACPI Driver");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/drivers/platform/x86/dell-privacy-wmi.c b/drivers/platform/x=
86/dell-privacy-wmi.c
> new file mode 100644
> index 000000000000..6c36b7ec44c6
> --- /dev/null
> +++ b/drivers/platform/x86/dell-privacy-wmi.c
> @@ -0,0 +1,259 @@
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

`#include <linux/bits.h>`?


> +
> +static int privacy_valid =3D -EPROBE_DEFER;
> +static LIST_HEAD(wmi_list);
> +static DEFINE_MUTEX(list_mutex);

What is the purpose of this list? At the moment I can't really see it.


> +
> +struct privacy_wmi_data {
> +    struct input_dev *input_dev;
> +    struct wmi_device *wdev;
> +    struct list_head list;
> +    u32 features_present;
> +    u32 last_status;

`last_status` and `features_present` are there for no actual benefit.


> +};
> +
> +/*
> + * Keymap for WMI Privacy events of type 0x0012
> + */
> +static const struct key_entry dell_wmi_keymap_type_0012[] =3D {
> +    /* Privacy MIC Mute */
> +    { KE_KEY, 0x0001, { KEY_MICMUTE } },
> +    /* Privacy Camera Mute */
> +    { KE_SW,  0x0002, { SW_CAMERA_LENS_COVER } },

I see the calloc trick later to avoid writing KE_END, but I still think it'=
d be
better if there was an explicit KE_END entry.


> +};
> +
> +bool dell_privacy_valid(void)
> +{
> +    bool ret;
> +
> +    mutex_lock(&list_mutex);
> +    ret =3D wmi_has_guid(DELL_PRIVACY_GUID);
> +    if (!ret){
> +        return -ENODEV;

The functions returns `bool`.


> +    }
> +    ret =3D privacy_valid;

I'm not sure if it's a good idea to just plainly assign an `int` to a `bool=
`.


> +    mutex_unlock(&list_mutex);
> +
> +    return ret;
> +}
> +EXPORT_SYMBOL_GPL(dell_privacy_valid);

Instead of always querying for the presence of the WMI GUID, wouldn't a sin=
gle
atomic_t or similar be sufficient?


> +
> +void dell_privacy_process_event(int type, int code, int status)
> +{
> +    struct privacy_wmi_data *priv;
> +    const struct key_entry *key;
> +
> +    mutex_lock(&list_mutex);
> +    priv =3D list_first_entry_or_null(&wmi_list,
> +            struct privacy_wmi_data,
> +            list);
> +    if (priv =3D=3D NULL) {

`if (!priv)`


> +        pr_err("dell privacy priv is NULL\n");
> +        goto error;
> +    }
> +
> +    key =3D sparse_keymap_entry_from_scancode(priv->input_dev, (type << =
16)|code);
> +    if (!key) {
> +        dev_dbg(&priv->wdev->dev, "Unknown key with type 0x%04x and code=
 0x%04x pressed\n",
> +                type, code);
> +        goto error;
> +    }
> +
> +    switch (code) {
> +        case DELL_PRIVACY_TYPE_AUDIO: /* Mic mute */
> +            priv->last_status =3D status;
> +            sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> +            break;
> +        case DELL_PRIVACY_TYPE_CAMERA: /* Camera mute */
> +            priv->last_status =3D status;
> +            sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> +            break;
> +        default:
> +            dev_dbg(&priv->wdev->dev, "unknown event type %u /%u",

A couple lines above hexadecimal format and capitalization is used.


> +                    type, code);
> +    }
> +error:
> +    mutex_unlock(&list_mutex);
> +    return;
> +}
> +EXPORT_SYMBOL_GPL(dell_privacy_process_event);
> [...]
> +static int dell_privacy_wmi_probe(struct wmi_device *wdev, const void *c=
ontext)
> +{
> +    struct privacy_wmi_data *priv;
> +    struct key_entry *keymap;
> +    int ret, i, pos =3D 0;
> +
> +    priv =3D devm_kzalloc(&wdev->dev, sizeof(struct privacy_wmi_data),
> +            GFP_KERNEL);

`sizeof(*priv)`


> +    if (!priv)
> +        return -ENOMEM;
> +
> +    /* create evdev passing interface */
> +    priv->input_dev =3D devm_input_allocate_device(&wdev->dev);
> +    if (!priv->input_dev)
> +        return -ENOMEM;
> +
> +    __set_bit(EV_KEY, priv->input_dev->evbit);
> +    __set_bit(KEY_MICMUTE, priv->input_dev->keybit);
> +    __set_bit(EV_MSC, priv->input_dev->evbit);
> +    __set_bit(MSC_SCAN, priv->input_dev->mscbit);

`sparse_keymap_setup()` takes care of this.


> +    keymap =3D kcalloc(
> +            ARRAY_SIZE(dell_wmi_keymap_type_0012) +
> +            1,
> +            sizeof(struct key_entry), GFP_KERNEL);
> +    if (!keymap) {
> +        ret =3D -ENOMEM;
> +        goto err_free_dev;
> +    }
> +    for (i =3D 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
> +        keymap[pos] =3D dell_wmi_keymap_type_0012[i];
> +        keymap[pos].code |=3D (0x0012 << 16);
> +        pos++;
> +    }

I can't quite see why you need a copy of the entries. If the key codes are =
initialized
to the "correct" values, this can be avoided altogether.


> +    ret =3D sparse_keymap_setup(priv->input_dev, keymap, NULL);
> +    if (ret)
> +        return ret;
> +
> +    priv->input_dev->dev.parent =3D &wdev->dev;
> +    priv->input_dev->name =3D "Dell Privacy Driver";
> +    priv->input_dev->id.bustype =3D BUS_HOST;
> +
> +    if (input_register_device(priv->input_dev)) {
> +        pr_debug("input_register_device failed to register! \n");
> +        return -ENODEV;

`keymap` is leaked here.


> +    }
> +
> +    priv->wdev =3D wdev;
> +    dev_set_drvdata(&wdev->dev, priv);
> +    mutex_lock(&list_mutex);
> +    list_add_tail(&priv->list, &wmi_list);
> +    privacy_valid =3D true;
> +    if (get_current_status(wdev)) {
> +        goto err_free_dev;

Mutex is not unlocked. And some steps are not undone.


> +    }
> +    mutex_unlock(&list_mutex);
> +    kfree(keymap);
> +    return 0;
> +
> +err_free_dev:
> +    input_free_device(priv->input_dev);
> +    kfree(keymap);
> +    return ret;
> +}
> +
> +static int dell_privacy_wmi_remove(struct wmi_device *wdev)
> +{
> +    struct privacy_wmi_data *priv =3D dev_get_drvdata(&wdev->dev);
> +
> +    mutex_lock(&list_mutex);
> +    list_del(&priv->list);
> +    privacy_valid =3D -ENODEV;
> +    mutex_unlock(&list_mutex);
> +    return 0;
> +}
> +
> +static const struct wmi_device_id dell_wmi_privacy_wmi_id_table[] =3D {
> +    { .guid_string =3D DELL_PRIVACY_GUID },
> +    { },
> +};
> +
> +static struct wmi_driver dell_privacy_wmi_driver =3D {
> +    .driver =3D {
> +        .name =3D "dell-privacy",
> +    },
> +    .probe =3D dell_privacy_wmi_probe,
> +    .remove =3D dell_privacy_wmi_remove,
> +    .id_table =3D dell_wmi_privacy_wmi_id_table,
> +};
> +
> +static int __init init_dell_privacy(void)
> +{
> +    int ret, wmi, acpi;

`int ret;` would've been enough. The preferred and prevalent style is:

```
int ret;

ret =3D step_1();
if (ret) {
  pr_err(...);
  goto undo_step_1;
}

ret =3D step_2();
if (ret) {
  pr_err(...);
  goto undo_step_2;
}

...

return 0;


undo_step_2:
  ...
undo_step_1:
  ....

return ret;
```


> +
> +    wmi =3D wmi_driver_register(&dell_privacy_wmi_driver);
> +    if (wmi) {
> +        pr_debug("Failed to initialize privacy wmi driver: %d\n", wmi);
> +        return wmi;
> +    }
> +
> +    acpi =3D privacy_acpi_init();
> +    if (acpi) {
> +        pr_debug("failed to initialize privacy wmi acpi driver: %d\n", a=
cpi);
> +        return acpi;
> +    }
> +
> +    return 0;
> +}

Even ignoring stylistic questions, the WMI driver is not unregistered if
`privacy_acpi_init()` fails, which is a bigger problem.

Even ignoring that, I'm not sure it's a good idea that a module that export=
s
symbols for others to use can fail to load.


> +
> +void exit_dell_privacy_wmi(void)
> +{
> +    wmi_driver_unregister(&dell_privacy_wmi_driver);
> +}

At the moment I can't quite see the purpose of this function.


> +
> +static void __exit exit_dell_privacy(void)
> +{
> +    privacy_acpi_cleanup();
> +    exit_dell_privacy_wmi();
> +}
> +
> +module_init(init_dell_privacy);
> +module_exit(exit_dell_privacy);
> +
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_privacy_wmi_id_table);

A couple lines above the `MODULE_DEVICE_TABLE` macro was invoked right afte=
r
the device table.


> +MODULE_AUTHOR("Perry Yuan <perry_yuan@dell.com>");
> +MODULE_DESCRIPTION("Dell Privacy WMI Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/dell-privacy-wmi.h b/drivers/platform/x=
86/dell-privacy-wmi.h
> new file mode 100644
> index 000000000000..94af81d76e44
> --- /dev/null
> +++ b/drivers/platform/x86/dell-privacy-wmi.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Dell privacy notification driver
> + *
> + * Copyright (C) 2021 Dell Inc. All Rights Reserved.
> + */
> +
> +#ifndef _DELL_PRIVACY_WMI_H_
> +#define _DELL_PRIVACY_WMI_H_
> +#include <linux/wmi.h>

This include is not needed.


> +
> +bool dell_privacy_valid(void);
> +void dell_privacy_process_event(int type, int code, int status);
> +int  privacy_acpi_init(void);
> +void privacy_acpi_cleanup(void);

These aren't prefixed by `dell_`?


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
> index bbdb3e860892..44bb74e4df86 100644
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
> @@ -410,44 +411,57 @@ static void dell_wmi_notify(struct wmi_device *wdev=
,
>  =09=09if (buffer_end > buffer_entry + buffer_entry[0] + 1)
>  =09=09=09buffer_end =3D buffer_entry + buffer_entry[0] + 1;
>
> -=09while (buffer_entry < buffer_end) {
> -
> -=09=09len =3D buffer_entry[0];
> -=09=09if (len =3D=3D 0)
> -=09=09=09break;
> -
> -=09=09len++;
> -
> -=09=09if (buffer_entry + len > buffer_end) {
> -=09=09=09pr_warn("Invalid length of WMI event\n");
> -=09=09=09break;
> -=09=09}
> -
> -=09=09pr_debug("Process buffer (%*ph)\n", len*2, buffer_entry);
> -
> -=09=09switch (buffer_entry[1]) {
> -=09=09case 0x0000: /* One key pressed or event occurred */
> -=09=09case 0x0012: /* Event with extended data occurred */
> -=09=09=09if (len > 2)
> -=09=09=09=09dell_wmi_process_key(wdev, buffer_entry[1],
> -=09=09=09=09=09=09     buffer_entry[2]);
> -=09=09=09/* Extended data is currently ignored */
> -=09=09=09break;
> -=09=09case 0x0010: /* Sequence of keys pressed */
> -=09=09case 0x0011: /* Sequence of events occurred */
> -=09=09=09for (i =3D 2; i < len; ++i)
> -=09=09=09=09dell_wmi_process_key(wdev, buffer_entry[1],
> -=09=09=09=09=09=09     buffer_entry[i]);
> -=09=09=09break;
> -=09=09default: /* Unknown event */
> -=09=09=09pr_info("Unknown WMI event type 0x%x\n",
> -=09=09=09=09(int)buffer_entry[1]);
> -=09=09=09break;
> -=09=09}
> -
> -=09=09buffer_entry +=3D len;
> -
> -=09}
> +    while (buffer_entry < buffer_end) {
> +
> +        len =3D buffer_entry[0];
> +        if (len =3D=3D 0)
> +            break;
> +
> +        len++;
> +
> +        if (buffer_entry + len > buffer_end) {
> +            pr_warn("Invalid length of WMI event\n");
> +            break;
> +        }
> +
> +        pr_debug("Process buffer (%*ph)\n", len*2, buffer_entry);
> +
> +        switch (buffer_entry[1]) {
> +            case 0x0000: /* One key pressed or event occurred */
> +                if (len > 2)
> +                    dell_wmi_process_key(wdev, buffer_entry[1],
> +                            buffer_entry[2]);
> +                break;
> +            case 0x0010: /* Sequence of keys pressed */
> +            case 0x0011: /* Sequence of events occurred */
> +                for (i =3D 2; i < len; ++i)
> +                    dell_wmi_process_key(wdev, buffer_entry[1],
> +                            buffer_entry[i]);
> +                break;
> +            case 0x0012:
> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
> +                if (dell_privacy_valid()) {
> +                    dell_privacy_process_event(buffer_entry[1], buffer_e=
ntry[3],
> +                            buffer_entry[4]);
> +                } else {
> +                    if (len > 2)
> +                        dell_wmi_process_key(wdev, buffer_entry[1], buff=
er_entry[2]);
> +                }
> +#else
> +                /* Extended data is currently ignored */
> +                if (len > 2)
> +                    dell_wmi_process_key(wdev, buffer_entry[1], buffer_e=
ntry[2]);
> +#endif

Wouldn't it be better if the header file provided a static inline definitio=
ns
for `dell_privacy_valid()` and `dell_privacy_process_event()` - if CONFIG_D=
ELL_PRIVACY
is not enabled - that return false and do nothing, respectively? The same w=
ay
it's done in dell-smbios.h.


> +                break;
> +            default: /* Unknown event */
> +                pr_info("Unknown WMI event type 0x%x\n",
> +                        (int)buffer_entry[1]);
> +                break;
> +        }
> +
> +        buffer_entry +=3D len;
> +
> +    }
>
>  }
> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
