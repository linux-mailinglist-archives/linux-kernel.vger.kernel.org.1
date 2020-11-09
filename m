Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315052AB654
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgKILQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:16:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727303AbgKILQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604920594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2ceOdscK+mphoqAGGR/vHY2EotMWOaQq+xcv7qhaZE=;
        b=J6UfqGKc/W/T3zsAFju/Sj7maoUw3HUk7DFsFZWoaa9Tl9PfLI6fRcj+L7evFzz6J/fIx4
        uwP2ZZCI07pruIC23PRsZtGE5fwW+n+tBC80DfVgdSYcqD2Q2xL5mk5MSayzNRo2YoLuwK
        wNihFpCDo7mLE9PJe9WoLCyda91RAIw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-vrtf0XPCMk6bYFTHq-cWYw-1; Mon, 09 Nov 2020 06:16:32 -0500
X-MC-Unique: vrtf0XPCMk6bYFTHq-cWYw-1
Received: by mail-ed1-f72.google.com with SMTP id c24so2601202edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T2ceOdscK+mphoqAGGR/vHY2EotMWOaQq+xcv7qhaZE=;
        b=mi4SHMQW0rkPb0HBn8xH/kBMLdSWJyFXJCXhYvGFgE5B5Uta9XcVh0JlxJk5fESbxb
         EvnXZthOIjjrQImqAyMgBgB1LoEBsO0i9BtCMnb9Sef4ZzaUx6lAhnCOabwXr35jf5y0
         YD8RKJQSsU1aVog1LDVfE1q4eUuxBozwz0s6DN9ITWENxI45/Mw2JLYfycl7QN5a7CF8
         1/QXUJMUqyBvOCiPqx25eNQw8rvrkIaOgqQZZ4liLgFE930u5n4ZDyiVBFr4Yhdsu3Pe
         YUVU7fHWltTfEKlYXpjE1yKW6a8zaQQydDQ1mnaXkWDYVRHR8sct7szg1o45rVGEtvaf
         +dvQ==
X-Gm-Message-State: AOAM530DEvhog2GNYxPcBSugCwu3fuwN+NFPmRMnNDfMN7eJ01+viMm6
        DKjXsl5KaHgsj2XXEVML1QOYPz7aWpTlufeVqBTvIXfKK/r/FXTOFGEGkD9onqp9b3aYmLTD6ON
        Uu/rS9tjAbnnh7f44/NoM2E8u
X-Received: by 2002:aa7:df04:: with SMTP id c4mr14867015edy.25.1604920591212;
        Mon, 09 Nov 2020 03:16:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxifgyYG0sRl0UC7UVkXzgYYw/45LlvWcsF+n7UqPjLshDCZIIxA6x0os3HU0tBh6KD+UiCXQ==
X-Received: by 2002:aa7:df04:: with SMTP id c4mr14866994edy.25.1604920590942;
        Mon, 09 Nov 2020 03:16:30 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id c3sm8857618edl.60.2020.11.09.03.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:16:30 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell-privacy: Add support for new privacy
 driver
To:     Perry Yuan <Perry.Yuan@dell.com>, mgross@linux.intel.com,
        mjg59@srcf.ucam.org, pali@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Limonciello Mario <Mario.Limonciello@dell.com>
References: <20201103125542.8572-1-Perry_Yuan@Dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <22075fea-5d51-6fdd-ecb2-7e8960825914@redhat.com>
Date:   Mon, 9 Nov 2020 12:16:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103125542.8572-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/3/20 1:55 PM, Perry Yuan wrote:
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

Perry, you have had multiple comments and kernel-test-robot
reports about this patch. Please prepare a new version addressing
these.

Once you have send out a new version I will try to make some time
to do a full review soon(ish).

Regards,

Hans


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
>  	  This adds support for the Latitude 2100 and similar
>  	  notebooks that have an external LED.
>  
> +config DELL_PRIVACY
> +        tristate "Dell Hardware Privacy Support"
> +        depends on ACPI
> +        depends on ACPI_WMI
> +        depends on INPUT
> +        depends on DELL_LAPTOP
> +        select DELL_WMI
> +        help
> +          This driver provides a driver to support messaging related to the
> +          privacy button presses on applicable Dell laptops from 2021 and
> +          newer.
> +
>  config AMILO_RFKILL
>  	tristate "Fujitsu-Siemens Amilo rfkill support"
>  	depends on RFKILL
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 5f823f7eff45..111f7215db2f 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -47,7 +47,9 @@ obj-$(CONFIG_DELL_WMI)			+= dell-wmi.o
>  obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+= dell-wmi-descriptor.o
>  obj-$(CONFIG_DELL_WMI_AIO)		+= dell-wmi-aio.o
>  obj-$(CONFIG_DELL_WMI_LED)		+= dell-wmi-led.o
> -
> +obj-$(CONFIG_DELL_PRIVACY)              += dell-privacy.o
> +dell-privacy-objs                       := dell-privacy-wmi.o \
> +	                                   dell-privacy-acpi.o
>  # Fujitsu
>  obj-$(CONFIG_AMILO_RFKILL)	+= amilo-rfkill.o
>  obj-$(CONFIG_FUJITSU_LAPTOP)	+= fujitsu-laptop.o
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index 5e9c2296931c..12b91de09356 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -30,6 +30,7 @@
>  #include <acpi/video.h>
>  #include "dell-rbtn.h"
>  #include "dell-smbios.h"
> +#include "dell-privacy-wmi.h"
>  
>  struct quirk_entry {
>  	bool touchpad_led;
> @@ -90,6 +91,7 @@ static struct rfkill *wifi_rfkill;
>  static struct rfkill *bluetooth_rfkill;
>  static struct rfkill *wwan_rfkill;
>  static bool force_rfkill;
> +static bool privacy_valid;
>  
>  module_param(force_rfkill, bool, 0444);
>  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
> @@ -2202,20 +2204,25 @@ static int __init dell_init(void)
>  	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
>  			    &dell_debugfs_fops);
>  
> -	dell_laptop_register_notifier(&dell_laptop_notifier);
> -
> -	if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
> -	    dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> -		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> -		ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
> -		if (ret < 0)
> -			goto fail_led;
> -	}
> -
> -	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
> -		return 0;
> -
> -	token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
> +    dell_laptop_register_notifier(&dell_laptop_notifier);
> +
> +    if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
> +            dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
> +        privacy_valid = dell_privacy_valid() == -ENODEV;
> +#endif
> +        if (!privacy_valid) {
> +            micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> +            ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
> +            if (ret < 0)
> +                goto fail_led;
> +        }
> +    }
> +
> +    if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
> +        return 0;
> +
> +    token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
>  	if (token) {
>  		struct calling_interface_buffer buffer;
>  
> @@ -2257,7 +2264,8 @@ static int __init dell_init(void)
>  fail_get_brightness:
>  	backlight_device_unregister(dell_backlight_device);
>  fail_backlight:
> -	led_classdev_unregister(&micmute_led_cdev);
> +    if (!privacy_valid)
> +        led_classdev_unregister(&micmute_led_cdev);
>  fail_led:
>  	dell_cleanup_rfkill();
>  fail_rfkill:
> @@ -2278,7 +2286,8 @@ static void __exit dell_exit(void)
>  		touchpad_led_exit();
>  	kbd_led_exit();
>  	backlight_device_unregister(dell_backlight_device);
> -	led_classdev_unregister(&micmute_led_cdev);
> +    if (!privacy_valid)
> +        led_classdev_unregister(&micmute_led_cdev);
>  	dell_cleanup_rfkill();
>  	if (platform_device) {
>  		platform_device_unregister(platform_device);
> diff --git a/drivers/platform/x86/dell-privacy-acpi.c b/drivers/platform/x86/dell-privacy-acpi.c
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
> +#define ACPI_PRIVACY_DEVICE	"\\_SB.PC00.LPCB.ECDV"
> +#define ACPI_PRIVACY_EC_ACK	ACPI_PRIVACY_DEVICE ".ECAK"
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
> +    status = acpi_evaluate_object(NULL, ACPI_PRIVACY_EC_ACK, NULL, NULL);
> +    if (ACPI_FAILURE(status)) {
> +        dev_err(led_cdev->dev, "Error setting privacy audio EC ack value: %d\n",status);
> +        return -EIO;
> +    }
> +    return 0;
> +}
> +
> +static struct led_classdev micmute_led_cdev = {
> +    .name = "platform::micmute",
> +    .max_brightness = 1,
> +    .brightness_set_blocking = micmute_led_set,
> +    .default_trigger = "audio-micmute",
> +};
> +
> +static int privacy_acpi_remove(struct platform_device *pdev)
> +{
> +    dev_set_drvdata(&pdev->dev, NULL);
> +    return 0;
> +}
> +
> +static int privacy_acpi_probe(struct platform_device *pdev)
> +{
> +    struct privacy_acpi_priv *privacy;
> +    acpi_handle handle;
> +    acpi_status status;
> +    int err;
> +
> +    privacy = kzalloc(sizeof(struct privacy_acpi_priv), GFP_KERNEL);
> +    if (!privacy)
> +        return -ENOMEM;
> +
> +    privacy->dev = &pdev->dev;
> +    privacy->platform_device = pdev;
> +    platform_set_drvdata(pdev, privacy);
> +    /* Look for software micmute complete notification device */
> +    status = acpi_get_handle(ACPI_ROOT_OBJECT,
> +            ACPI_PRIVACY_DEVICE,
> +            &handle);
> +    if (ACPI_FAILURE(status)) {
> +        dev_err(privacy->dev, "Unable to find Dell`s EC device %s: %d\n",
> +                ACPI_PRIVACY_DEVICE, status);
> +        return -ENXIO;
> +    }
> +
> +    micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> +    err = led_classdev_register(&privacy_acpi_pdev->dev, &micmute_led_cdev);
> +    if (err < 0)
> +        return -EIO;
> +
> +    return 0;
> +}
> +
> +static const struct acpi_device_id privacy_acpi_device_ids[] = {
> +    {"PNP0C09", 0},
> +    {"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, privacy_acpi_device_ids);
> +
> +static struct platform_driver privacy_platform_driver = {
> +    .driver     = {
> +        .name   = PRIVACY_PlATFORM_NAME,
> +        .acpi_match_table = ACPI_PTR(privacy_acpi_device_ids),
> +    },
> +    .probe      = privacy_acpi_probe,
> +    .remove     = privacy_acpi_remove,
> +};
> +
> +int privacy_acpi_init(void)
> +{
> +    int err;
> +
> +    err = platform_driver_register(&privacy_platform_driver);
> +    if (err)
> +        return err;
> +
> +    privacy_acpi_pdev = platform_device_register_simple(
> +            PRIVACY_PlATFORM_NAME, -1, NULL, 0);
> +    if (IS_ERR(privacy_acpi_pdev)) {
> +        err = PTR_ERR(privacy_acpi_pdev);
> +        goto err_platform;
> +    }
> +    return 0;
> +
> +err_platform:
> +    platform_driver_unregister(&privacy_platform_driver);
> +    return err;
> +}
> +
> +void privacy_acpi_cleanup(void)
> +{
> +    platform_driver_unregister(&privacy_platform_driver);
> +}
> +
> +MODULE_AUTHOR("Perry Yuan <perry_yuan@dell.com>");
> +MODULE_DESCRIPTION("DELL Privacy ACPI Driver");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/drivers/platform/x86/dell-privacy-wmi.c b/drivers/platform/x86/dell-privacy-wmi.c
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
> +#define MICROPHONE_STATUS		    BIT(0)
> +#define CAMERA_STATUS		        BIT(1)
> +#define PRIVACY_SCREEN_STATUS		BIT(2)
> +
> +static int privacy_valid = -EPROBE_DEFER;
> +static LIST_HEAD(wmi_list);
> +static DEFINE_MUTEX(list_mutex);
> +
> +struct privacy_wmi_data {
> +    struct input_dev *input_dev;
> +    struct wmi_device *wdev;
> +    struct list_head list;
> +    u32 features_present;
> +    u32 last_status;
> +};
> +
> +/*
> + * Keymap for WMI Privacy events of type 0x0012
> + */
> +static const struct key_entry dell_wmi_keymap_type_0012[] = {
> +    /* Privacy MIC Mute */
> +    { KE_KEY, 0x0001, { KEY_MICMUTE } },
> +    /* Privacy Camera Mute */
> +    { KE_SW,  0x0002, { SW_CAMERA_LENS_COVER } },
> +};
> +
> +bool dell_privacy_valid(void)
> +{
> +    bool ret;
> +
> +    mutex_lock(&list_mutex);
> +    ret = wmi_has_guid(DELL_PRIVACY_GUID);
> +    if (!ret){
> +        return -ENODEV;
> +    }
> +    ret = privacy_valid;
> +    mutex_unlock(&list_mutex);
> +
> +    return ret;
> +}
> +EXPORT_SYMBOL_GPL(dell_privacy_valid);
> +
> +void dell_privacy_process_event(int type, int code, int status)
> +{
> +    struct privacy_wmi_data *priv;
> +    const struct key_entry *key;
> +
> +    mutex_lock(&list_mutex);
> +    priv = list_first_entry_or_null(&wmi_list,
> +            struct privacy_wmi_data,
> +            list);
> +    if (priv == NULL) {
> +        pr_err("dell privacy priv is NULL\n");
> +        goto error;
> +    }
> +
> +    key = sparse_keymap_entry_from_scancode(priv->input_dev, (type << 16)|code);
> +    if (!key) {
> +        dev_dbg(&priv->wdev->dev, "Unknown key with type 0x%04x and code 0x%04x pressed\n",
> +                type, code);
> +        goto error;
> +    }
> +
> +    switch (code) {
> +        case DELL_PRIVACY_TYPE_AUDIO: /* Mic mute */
> +            priv->last_status = status;
> +            sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> +            break;
> +        case DELL_PRIVACY_TYPE_CAMERA: /* Camera mute */
> +            priv->last_status = status;
> +            sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> +            break;
> +        default:
> +            dev_dbg(&priv->wdev->dev, "unknown event type %u /%u",
> +                    type, code);
> +    }
> +error:
> +    mutex_unlock(&list_mutex);
> +    return;
> +}
> +EXPORT_SYMBOL_GPL(dell_privacy_process_event);
> +
> +static int get_current_status(struct wmi_device *wdev)
> +{
> +    struct privacy_wmi_data *priv = dev_get_drvdata(&wdev->dev);
> +    union acpi_object *obj_present;
> +    union acpi_object *obj_current;
> +    int ret = 0;
> +
> +    if (priv == NULL) {
> +        pr_err("dell privacy priv is NULL\n");
> +        return -EINVAL;
> +    }
> +    /* get devices supported */
> +    obj_present = wmidev_block_query(wdev, 0);
> +    if (obj_present->type != ACPI_TYPE_INTEGER) {
> +        ret = -EIO;
> +        goto present_free;
> +    }
> +    priv->features_present = obj_present->integer.value;
> +
> +    /* get current state */
> +    obj_current = wmidev_block_query(wdev, 1);
> +    if (obj_current->type != ACPI_TYPE_INTEGER) {
> +        ret = -EIO;
> +        goto current_free;
> +    }
> +    priv->last_status = obj_current->integer.value;
> +current_free:
> +    kfree(obj_current);
> +present_free:
> +    kfree(obj_present);
> +    return ret;
> +}
> +
> +static int dell_privacy_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +    struct privacy_wmi_data *priv;
> +    struct key_entry *keymap;
> +    int ret, i, pos = 0;
> +
> +    priv = devm_kzalloc(&wdev->dev, sizeof(struct privacy_wmi_data),
> +            GFP_KERNEL);
> +    if (!priv)
> +        return -ENOMEM;
> +
> +    /* create evdev passing interface */
> +    priv->input_dev = devm_input_allocate_device(&wdev->dev);
> +    if (!priv->input_dev)
> +        return -ENOMEM;
> +
> +    __set_bit(EV_KEY, priv->input_dev->evbit);
> +    __set_bit(KEY_MICMUTE, priv->input_dev->keybit);
> +    __set_bit(EV_MSC, priv->input_dev->evbit);
> +    __set_bit(MSC_SCAN, priv->input_dev->mscbit);
> +    keymap = kcalloc(
> +            ARRAY_SIZE(dell_wmi_keymap_type_0012) +
> +            1,
> +            sizeof(struct key_entry), GFP_KERNEL);
> +    if (!keymap) {
> +        ret = -ENOMEM;
> +        goto err_free_dev;
> +    }
> +    for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
> +        keymap[pos] = dell_wmi_keymap_type_0012[i];
> +        keymap[pos].code |= (0x0012 << 16);
> +        pos++;
> +    }
> +    ret = sparse_keymap_setup(priv->input_dev, keymap, NULL);
> +    if (ret)
> +        return ret;
> +
> +    priv->input_dev->dev.parent = &wdev->dev;
> +    priv->input_dev->name = "Dell Privacy Driver";
> +    priv->input_dev->id.bustype = BUS_HOST;
> +
> +    if (input_register_device(priv->input_dev)) {
> +        pr_debug("input_register_device failed to register! \n");
> +        return -ENODEV;
> +    }
> +
> +    priv->wdev = wdev;
> +    dev_set_drvdata(&wdev->dev, priv);
> +    mutex_lock(&list_mutex);
> +    list_add_tail(&priv->list, &wmi_list);
> +    privacy_valid = true;
> +    if (get_current_status(wdev)) {
> +        goto err_free_dev;
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
> +    struct privacy_wmi_data *priv = dev_get_drvdata(&wdev->dev);
> +
> +    mutex_lock(&list_mutex);
> +    list_del(&priv->list);
> +    privacy_valid = -ENODEV;
> +    mutex_unlock(&list_mutex);
> +    return 0;
> +}
> +
> +static const struct wmi_device_id dell_wmi_privacy_wmi_id_table[] = {
> +    { .guid_string = DELL_PRIVACY_GUID },
> +    { },
> +};
> +
> +static struct wmi_driver dell_privacy_wmi_driver = {
> +    .driver = {
> +        .name = "dell-privacy",
> +    },
> +    .probe = dell_privacy_wmi_probe,
> +    .remove = dell_privacy_wmi_remove,
> +    .id_table = dell_wmi_privacy_wmi_id_table,
> +};
> +
> +static int __init init_dell_privacy(void)
> +{
> +    int ret, wmi, acpi;
> +
> +    wmi = wmi_driver_register(&dell_privacy_wmi_driver);
> +    if (wmi) {
> +        pr_debug("Failed to initialize privacy wmi driver: %d\n", wmi);
> +        return wmi;
> +    }
> +
> +    acpi = privacy_acpi_init();
> +    if (acpi) {
> +        pr_debug("failed to initialize privacy wmi acpi driver: %d\n", acpi);
> +        return acpi;
> +    }
> +
> +    return 0;
> +}
> +
> +void exit_dell_privacy_wmi(void)
> +{
> +    wmi_driver_unregister(&dell_privacy_wmi_driver);
> +}
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
> +MODULE_AUTHOR("Perry Yuan <perry_yuan@dell.com>");
> +MODULE_DESCRIPTION("Dell Privacy WMI Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/dell-privacy-wmi.h b/drivers/platform/x86/dell-privacy-wmi.h
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
> +
> +bool dell_privacy_valid(void);
> +void dell_privacy_process_event(int type, int code, int status);
> +int  privacy_acpi_init(void);
> +void privacy_acpi_cleanup(void);
> +
> +/* DELL Privacy Type */
> +enum {
> +	DELL_PRIVACY_TYPE_UNKNOWN = 0x0,
> +	DELL_PRIVACY_TYPE_AUDIO,
> +	DELL_PRIVACY_TYPE_CAMERA,
> +};
> +#endif
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
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
>  MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
> @@ -410,44 +411,57 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>  		if (buffer_end > buffer_entry + buffer_entry[0] + 1)
>  			buffer_end = buffer_entry + buffer_entry[0] + 1;
>  
> -	while (buffer_entry < buffer_end) {
> -
> -		len = buffer_entry[0];
> -		if (len == 0)
> -			break;
> -
> -		len++;
> -
> -		if (buffer_entry + len > buffer_end) {
> -			pr_warn("Invalid length of WMI event\n");
> -			break;
> -		}
> -
> -		pr_debug("Process buffer (%*ph)\n", len*2, buffer_entry);
> -
> -		switch (buffer_entry[1]) {
> -		case 0x0000: /* One key pressed or event occurred */
> -		case 0x0012: /* Event with extended data occurred */
> -			if (len > 2)
> -				dell_wmi_process_key(wdev, buffer_entry[1],
> -						     buffer_entry[2]);
> -			/* Extended data is currently ignored */
> -			break;
> -		case 0x0010: /* Sequence of keys pressed */
> -		case 0x0011: /* Sequence of events occurred */
> -			for (i = 2; i < len; ++i)
> -				dell_wmi_process_key(wdev, buffer_entry[1],
> -						     buffer_entry[i]);
> -			break;
> -		default: /* Unknown event */
> -			pr_info("Unknown WMI event type 0x%x\n",
> -				(int)buffer_entry[1]);
> -			break;
> -		}
> -
> -		buffer_entry += len;
> -
> -	}
> +    while (buffer_entry < buffer_end) {
> +
> +        len = buffer_entry[0];
> +        if (len == 0)
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
> +                for (i = 2; i < len; ++i)
> +                    dell_wmi_process_key(wdev, buffer_entry[1],
> +                            buffer_entry[i]);
> +                break;
> +            case 0x0012:
> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
> +                if (dell_privacy_valid()) {
> +                    dell_privacy_process_event(buffer_entry[1], buffer_entry[3], 
> +                            buffer_entry[4]);
> +                } else {
> +                    if (len > 2)
> +                        dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2]);
> +                }
> +#else
> +                /* Extended data is currently ignored */
> +                if (len > 2)
> +                    dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2]);
> +#endif
> +                break;
> +            default: /* Unknown event */
> +                pr_info("Unknown WMI event type 0x%x\n",
> +                        (int)buffer_entry[1]);
> +                break;
> +        }
> +
> +        buffer_entry += len;
> +
> +    }
>  
>  }
>  
> 

