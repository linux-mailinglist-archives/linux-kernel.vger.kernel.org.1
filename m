Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DED2F370B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389039AbhALR0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732012AbhALR0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:26:49 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF264C061575;
        Tue, 12 Jan 2021 09:26:09 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so1798236pfk.1;
        Tue, 12 Jan 2021 09:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=nrd33H/PkbLEiSm/IPd7kidSsCMzymFvnNayItFQSec=;
        b=avqexGYFYibxjZitTJvws6jOocWlY9ceP2knbyVSE/jElbZf4PNoYK701SotjAFd4Z
         nYoXi+TXQV91Tz9Vo0C3Z6VoZRvHGFYezycoLpwO5g6mru/Zn6v+FAAuRjroLoq6HiQB
         CoOcPh/i+PGqLqTHLlZdexW7/5na043jBk4VUJtf8vApqIgOvh7DDH931/hT8wGlOUgj
         KAEQyRTNztophf3qLw3dyAoAFNDAO3famBtzGqH2rvknjZViDC2KzvRyWVzQwqENv+fH
         HjuOGKwZPvauTbHMhSNDk5DlHRC1i7mh/OCXG9wGwmbRE0/IbK7up3tipycq8OoDkd1c
         SwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=nrd33H/PkbLEiSm/IPd7kidSsCMzymFvnNayItFQSec=;
        b=ntLsc5dRpTcUUQ/6skwZ532BrUfjO5wRw7zJ77BkybtNGcrx5/0dlu52+WQRcew1xB
         w0vNyT4liQ1tjsbrBYcFtrGF/kYT6YjbUHQblqEcEmOincK7bx9YIAsr1vS93M8DDaZD
         KjiO8azdURhyhTnBwk0qQRpo4Sjo1yOypG5oXni67fnV4XY99mjyNVKPVAvyvslgPCGc
         /40b19jU+nKc3qS1ZgYjW0wttqDDJuHGaaO4uORgME6h8+OfUNA1As4I6p//8JxvJv9N
         X09LhI37C3Saj537VMD1FNwtWSjqq/CycB/fjJVd54aWq+u3rLQJFyBAFAZNKUdY6wnq
         5wkQ==
X-Gm-Message-State: AOAM530//Cpfl835Ke3YOXoQ3ySZqcSOborxBa4mozXlgvGoahWl2Q8i
        bgHNhDbdOFv9ygTJx16Ty4xsXjM6enPBZKI6jFc=
X-Google-Smtp-Source: ABdhPJxFNCPG/gZHg/sNCs1viaEXDTOGK4kJ7khHML/ReLdEYHUaTErMrmPfG5aaPUqY7GvMGYs/AA==
X-Received: by 2002:a63:e151:: with SMTP id h17mr131920pgk.120.1610472368970;
        Tue, 12 Jan 2021 09:26:08 -0800 (PST)
Received: from [0.0.0.0] ([2605:52c0:2:4a5::])
        by smtp.gmail.com with ESMTPSA id gm18sm3816934pjb.55.2021.01.12.09.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 09:26:08 -0800 (PST)
Subject: Re: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     Perry Yuan <Perry.Yuan@dell.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Limonciello Mario <Mario.Limonciello@dell.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com>
 <mXtNUreCVsPKizG-fnNKPId9_lQGit0S6pYEpk-aNT1hGQjVwblZDiO4E-YX3hxnrbbNN1-6hSntiv13wz66RxbhXjPJhpAVOIlZmmwUI7w=@protonmail.com>
 <7def1cdc-e275-9ae6-4941-55517359bb1e@gmail.com>
 <EL8a5P1IHqrP-OKgLuz_WhokTdCV5J5wjSDLxpDFgFcvbeK-CuBwZeTTtVXQe-uermqgam418I468i9gNnNykmSuPrCC2M1biKyK44wVfkA=@protonmail.com>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <cb015d48-7c6c-9b21-d79e-d7ca4f410e86@gmail.com>
Date:   Wed, 13 Jan 2021 01:26:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <EL8a5P1IHqrP-OKgLuz_WhokTdCV5J5wjSDLxpDFgFcvbeK-CuBwZeTTtVXQe-uermqgam418I468i9gNnNykmSuPrCC2M1biKyK44wVfkA=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barnabás,

On 2021/1/12 0:07, Barnabás Pőcze wrote:
> Hi
>
>
> 2021. január 11., hétfő 14:42 keltezéssel, Perry Yuan írta:
>
>> [...]
>>>> +#define PRIVACY_PLATFORM_NAME	"dell-privacy-acpi"
>>>> +#define DELL_PRIVACY_GUID	"6932965F-1671-4CEB-B988-D3AB0A901919"
>>>> +
>>>> +struct privacy_acpi_priv {
>>>> +	struct device *dev;
>>>> +	struct platform_device *platform_device;
>>>> +	struct led_classdev cdev;
>>>> +};
>>>> +static struct privacy_acpi_priv *privacy_acpi;
>>> Any reason it needs to be dynamically allocated?
>> I need to set one static struct to let some function to get the priv pointer.
>>
>> It is more simple if i add some function and get the priv easily.
>>
>> If you have better suggestion, i would be glad to optimize it.
>>
>> for example.
>>
>> static int dell_privacy_micmute_led_set(struct led_classdev *led_cdev,
>>                  enum led_brightness brightness)
>> {
>>          struct privacy_acpi_priv *priv = privacy_acpi;
>>
>>          ..........................
>>
>> }
>>
> My comment was referring to the fact that you could've used
> ```
> static struct privacy_acpi_priv privacy_acpi;
> ```
> to achieve the same result without the dynamic memory allocation.
>
>
>>>
>>>> +
>>>> +static int dell_privacy_micmute_led_set(struct led_classdev *led_cdev,
>>>> +		enum led_brightness brightness)
>>>> +{
>>>> +	struct privacy_acpi_priv *priv = privacy_acpi;
>>>> +	acpi_status status;
>>>> +	acpi_handle handle;
>>>> +	char *acpi_method;
>>>> +
>>>> +	handle = ec_get_handle();
>>>> +	if (!handle)
>>>> +		return -EIO;
>>>> +	if (acpi_has_method(handle, "ECAK"))
>>>> +		acpi_method = "ECAK";
>>>> +	else
>>>> +		return -ENODEV;
>>> I find this if-else a bit cumbersome. Any reason why
>>>
>>> if (!acpi_has_method(handle, "ECAK"))
>>>    return ...;
>>>
>>> would not work? I believe you could also easily do away with the `acpi_method`
>>> variable.
>> Just want to make sure the BIOS has the correct  method to call.
>>
>> normally it will not be failed, just keep it safe to call BIOS, not to cause any panic.
>>
>> I changed it as below .
>>
>>          handle = ec_get_handle();
>>          if (!handle)
>>                  return -EIO;
>>          acpi_method = "ECAK";
>>
> You could keep the method name in a static variable:
> ```
> static char *acpi_method = (char *)"ECAK"; // this is inside the function
>
> handle = ...;
> if (!handle)
>    return ...
>
> if (!acpi_has_method(handle, acpi_method))
>    return ...
>
> ... acpi_evaluate_object(handle, acpi_method, ...
> ```
>
> Another thing is that I believe you could do these checks only once,
> before registering the LED device.
>
>
>>>
>>>> +
>>>> +	status = acpi_evaluate_object(handle, acpi_method, NULL, NULL);
>>>> +	if (ACPI_FAILURE(status)) {
>>>> +		dev_err(priv->dev, "Error setting privacy EC ack value: %s\n",
>>>> +				acpi_format_exception(status));
>>>> +		return -EIO;
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +
>> [...]
>>>> +static const struct acpi_device_id privacy_acpi_device_ids[] = {
>>>> +	{"PNP0C09", 0},
>>>> +	{ },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, privacy_acpi_device_ids);
>>>> +
>>>> +static struct platform_driver dell_privacy_platform_drv = {
>>>> +	.driver = {
>>>> +		.name = PRIVACY_PLATFORM_NAME,
>>>> +		.acpi_match_table = ACPI_PTR(privacy_acpi_device_ids),
>>>> +	},
>>>> +	.remove = dell_privacy_acpi_remove,
>>>> +};
>>> I think using a platform driver here just complicates things for no reason.
>>> Furthermore, I'm not sure if there's actually any need for the ACPI match table.
>> there will be some more privacy devices need to add some acpi interface function here.
>>
>> including  elctronic privacy screen and privacy camera.
>>
>> the platform driver can provide more flexible framework to extend.
>>
> I see. I'm wondering if the ACPI match table is needed at the moment. If I'm not
> mistaken the platform driver already binds the platform device the module creates.
> And there is no real need to bind to the ACPI EC devices.
>
>
>> [...]
>>>> diff --git a/drivers/platform/x86/dell-privacy-wmi.c b/drivers/platform/x86/dell-privacy-wmi.c
>>>> new file mode 100644
>>>> index 000000000000..80637c7f617c
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/dell-privacy-wmi.c
>> [...]
>>>> +int dell_privacy_valid(void)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = wmi_has_guid(DELL_PRIVACY_GUID);
>>>> +	if (!ret)
>>>> +		return -ENODEV;
>>>> +	ret = privacy_valid;
>>>> +	return ret;
>>> I find this function really confusing, and too verbose for what it does.
>>>
>> 1. when the DELL_PRIVACY_GUID not found, it will return  ENODEV showing no privacy devices.
>>
>> 2. when DELL_PRIVACY_GUID found,and wmi privacy driver is registered, it will return "0"
>>
>> 3.when DELL_PRIVACY_GUID found,and wmi privacy driver is NOT registered yet, it will return "EPROBE_DEFE"
>>
>>    the  EPROBE_DEFER is defined in "include/linux/errno.h"
>>
>> #define EPROBE_DEFER    517     /* Driver requests probe retry */
>>
>> when caller get this returned , it will defer the caller  1s ~ 7s to probe again.
>>
>> This will make sure dell-laptop can get the correct privacy status to register its micmute led trigger driver or not.
>>
>> ----dell-laptoo.c-------------------
>>
>> #if IS_ENABLED(CONFIG_DELL_PRIVACY)
>>                  ret = dell_privacy_valid();
>>                  if (!ret)
>>                          privacy_valid = true;
>> #endif
>>                  if (!privacy_valid) {
>>                          micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
>>                          ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
>>                          if (ret < 0)
>>                                  goto fail_led;
>>                  }
>>          }
>>
> My problem is that those three states are never used.
> The only thing that's ever checked is if the return value of dell_privacy_valid()
> is zero or not. No part of the code distinguishes between -ENODEV and -EPROBE_DEFER.
> (As far as I see, I may be missing something.)
>
> My initial point was that - if I'm not missing anything significant - the whole
> function could just be:
> ```
> int dell_privacy_valid(void)
> {
>    return privacy_valid;
> }
> ```
> given that you manipulate the value of `privacy_valid` appropriately. And assuming
> the current form is needed, this would be enough:
> ```
> int dell_privacy_valid(void)
> {
>    if (!wmi_has_guid(...))
>      return -ENODEV;
>
>    return privacy_valid;
> }
> ```
>
> But I'd personally prefer the first one.
>
>
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(dell_privacy_valid);
>>>> +
>>>> +void dell_privacy_process_event(int type, int code, int status)
>>>> +{
>>>> +	struct privacy_wmi_data *priv;
>>>> +	const struct key_entry *key;
>>>> +
>>>> +	mutex_lock(&list_mutex);
>>>> +	priv = list_first_entry_or_null(&wmi_list,
>>>> +			struct privacy_wmi_data,
>>>> +			list);
>>> Can you please explain why this list is needed if only the first entry will
>>> ever be used?
>>          mutex_lock(&list_mutex);
>>          list_add_tail(&priv->list, &wmi_list);
>>          mutex_unlock(&list_mutex);
>>
>> only one priv struct is added to the list with list mutex protecting.
>>
>> So it will not have two more entry data added to the list .
>>
> I'm not sure I fully get it.
>
>
>>>
>>>> +	if (!priv) {
>>>> +		pr_err("dell privacy priv is NULL\n");
>>>> +		goto error;
>>>> +	}
>>>> +	key = sparse_keymap_entry_from_scancode(priv->input_dev, (type << 16)|code);
>>>> +	if (!key) {
>>>> +		dev_dbg(&priv->wdev->dev, "Unknown key with type 0x%04x and code 0x%04x pressed\n",
>>>> +				type, code);
>>>> +		goto error;
>>>> +	}
>>>> +	switch (code) {
>>>> +	case DELL_PRIVACY_TYPE_AUDIO: /* Mic mute */
>>>> +		priv->last_status = status;
>>>> +		sparse_keymap_report_entry(priv->input_dev, key, 1, true);
>>>> +		break;
>>>> +	case DELL_PRIVACY_TYPE_CAMERA: /* Camera mute */
>>>> +		priv->last_status = status;
>>>> +		sparse_keymap_report_entry(priv->input_dev, key, 1, true);
>>>> +		break;
>>>> +	default:
>>>> +			dev_dbg(&priv->wdev->dev, "unknown event type 0x%04x 0x%04x",
>>>> +					type, code);
>>>> +	}
>>> Is this switch needed at all?
>> It is needed here, camra mute and privacy screen will add more codes here.
>>
>> It want to keep the switch for further extention.
>>
> My point here is that the two cases of the switch do the exact same thing. The
> whole switch could be replaced with:
> ```
> sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> ```
>
> I would go as far as use this:
> ```
> if (!sparse_keymap_report_event(priv->input_dev, (type << 16) | code, 1, true))
>    dev_dbg(&priv->wdev->dev, "unknown event type=0x%04x code=0x%04x\n", type, code)
> ```
>
> This would elliminate the need for the `key` variable, the call to
> `sparse_keymap_entry_from_scancode()`, and the whole switch.
>
>
>> [...]
>>> There is actually no need for the `pos` variable.
>> It is used in this keymap codes.
>>
>>         for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
>>                  keymap[pos] = dell_wmi_keymap_type_0012[i];
>>                  keymap[pos].code |= (0x0012 << 16);
>>                  pos++;
>>          }
>>
> You can use `i` as the index, so no need for `pos`.
>
>
>>>
>>>> +
>>>> +	priv = devm_kzalloc(&wdev->dev, sizeof(struct privacy_wmi_data),
>>> Please use `sizeof(*priv)`.
>> fixed.
>>
>>
>>>
>>>> +			GFP_KERNEL);
>>>> +	if (!priv)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	dev_set_drvdata(&wdev->dev, priv);
>>>> +	priv->wdev = wdev;
>>>> +	/* create evdev passing interface */
>>>> +	priv->input_dev = devm_input_allocate_device(&wdev->dev);
>>>> +	if (!priv->input_dev)
>>>> +		return -ENOMEM;
>>>> +	/* remap the wmi keymap event to new keymap */
>>>> +	keymap = kcalloc(ARRAY_SIZE(dell_wmi_keymap_type_0012) +
>>>> +			1,
>>> I don't think that `+ 1` is not needed since the KE_END entry is already in the array.
>>>
>>>
>>>> +			sizeof(struct key_entry), GFP_KERNEL);
>>>> +	if (!keymap) {
>>>> +		ret = -ENOMEM;
>>>> +		goto err_free_dev;
>>>> +	}
>>>> +	/* remap the keymap code with Dell privacy key type 0x12 as prefix
>>>> +	 * KEY_MICMUTE scancode will be reported as 0x120001
>>>> +	 */
>>>> +	for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
>>>> +		keymap[pos] = dell_wmi_keymap_type_0012[i];
>>>> +		keymap[pos].code |= (0x0012 << 16);
>>>> +		pos++;
>>>> +	}
>>>> +	ret = sparse_keymap_setup(priv->input_dev, keymap, NULL);
>>>> +	if (ret)
>>>> +		return ret;
>>> A copy of the keymap is created by `sparse_keymap_setup()`, so returning
>>> here will leak `keymap`. You could just call `kfree(keymap)` directly after
>>> the `sparse_keymap_setup()` call. But I find it completely unnecessary
>>> to do this allocate-copy-modify thing. Is there any reason why the static array
>>> (`dell_wmi_keymap_type_0012`) cannot already contain the correct values?
>> I don`t quite undestand what you meant
>>
>> what "correct values" should be contained by the dell_wmi_keymap_type_0012?
>>
> My point is that if you had:
> ```
> static const struct key_entry dell_wmi_keymap_type_0012[] = {
> 	{ KE_KEY, 0x00120001, { KEY_MICMUTE } },
> 	{ KE_SW,  0x00120002, { SW_CAMERA_LENS_COVER } },
> 	{ KE_END, 0},
> };
> ```
> then there would be no need to create a copy and the code would be simpler.
>
>
>> [...]
>>>> +static int __init init_dell_privacy(void)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = wmi_has_guid(DELL_PRIVACY_GUID);
>>>> +	if (!ret)
>>>> +		return -ENODEV;
>>> The init function of a module that exports symbols must not fail, otherwise
>>> it'll prevent the loading of dependent modules.
>> Yes, the wmi driver is the entry for whole privacy driver.
>>
>> if wmi guid query failed, the privacy driver will not be registered.
>>
>> dell-laptop driver will get "-ENOVDE" from dell_privacy_valid().
>>
>> it will register its micmute led trigger driver from dell laptop driver.
>>
> My point is that if dell-privacy is a dependency of dell-laptop, and dell-privacy
> fails to load, then dell-laptop cannot be loaded. Effectively, the lack of
> the DELL_PRIVACY_GUID WMI interface will cause the dell-laptop module not be
> able to be loaded.
>
>
>> [...]
>>>> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
>>>> +			err = dell_privacy_valid();
>>>> +			if (err == 0) {
>>>> +				dell_privacy_process_event(buffer_entry[1],
>>>> +						buffer_entry[3], buffer_entry[4]);
>>> What if `len < 5`?
>> when CONFIG_DELL_PRIVACY is enabled, and dell_privacy_valid return zero which means privacy driver loaded as expected.
>>
>> for example ,the micmute report wmi event data len is "5", it will not be less than 5 words.
> I'm wondering if there are such guarantees, why is the length checked just a
> couple lines below?
>
>
>> Process buffer (04 00 12 00 0e 00 01 00 03 00)
>>
>>
>> #if IS_ENABLED(CONFIG_DELL_PRIVACY)
> One thing I might have forgotten to point out initially, is that there is no need
> for this #if as dell-privacy-wmi.h provides stub definitions for
> `dell_privacy_valid()` and `dell_privacy_process_event()`.
>
>
>>                          err = dell_privacy_valid();
>>                          if (err == 0) {
>>                                  dell_privacy_process_event(buffer_entry[1],
>>                                                  buffer_entry[3], buffer_entry[4]);
>>                          } else {
>>                                  if (len > 2)
>>                                          dell_wmi_process_key(wdev, buffer_entry[1],
>>                                                          buffer_entry[2]);
>>                                  /* Extended data is currently ignored */
>>                          }
>> [...]
> Another thing I may have forgotten to say: the name `dell_privacy_valid()` is
> misleading in my opinion, as it gives the impression of being a predicate, even
> though it is not. `dell_privacy_state()` or something like that would be better,
> I think.
>
>
> Regards,
> Barnabás Pőcze
>
>
> p.s. please send text emails.

Barnabás, i will need to make above review codes changes to v4 soon 
,most of the review feedback has been made by V3 patch.

Thanks so much for your time and review effort.

BR.

Perry Yuan

