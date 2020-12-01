Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C642CAE55
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgLAVZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:25:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgLAVZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606857819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4uCWjOV/tAjKWDjtB9NnNmOLMDrYhZ2CS7gxRN6P+mY=;
        b=Z6C3s/dambyfc/FS4WCSCZI8MlGv7wPnzoUu9DIMoj3kdFDpiOzWsGzyEqz37hcW/1hYxo
        YG7pGSsIHZESkXLGljJmqcb5qS5yxMm83IX7HjtK6+8Mn+LCEbyce97GzdWbXtIfpF+P/n
        WsaP13fzRDYSbgNXrKupLm02v87ha34=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-lmWIaepFMS20lTXo_6KS1Q-1; Tue, 01 Dec 2020 16:23:38 -0500
X-MC-Unique: lmWIaepFMS20lTXo_6KS1Q-1
Received: by mail-ed1-f70.google.com with SMTP id h5so2100271edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4uCWjOV/tAjKWDjtB9NnNmOLMDrYhZ2CS7gxRN6P+mY=;
        b=hk7pguZ72xNfuvNVhDM6C2CyVHqxjevZy4T5EA1fwjrFopGYr1cblEb6TrUA4DUvMZ
         3TvSebKkNKOp3MuhdlWVSknDCSPJ7PWzcO2H9mo3n8IGOpjw5VjdJ8cGUpu78ztMnr1S
         8r6nhNId5n1c9FPIdv5Ll8UJngU/3Q4PrdjCuKBizEAeF0vG5CDLR9FnAUn5slEwadlD
         KLEbAjxsbo6Uvmbh4HZJ0BwK1mwhXoAVgZQU/MR3272KQiyy+SwXJ1aLBP8/bFzfI5Sr
         bEZ3TgWSRLwv2P5+l3UdUongGktABld6YA2GfhM+duYg16KGcc3a934QCOS5ZSAAfCQO
         gUCA==
X-Gm-Message-State: AOAM532u3Rk/jANa2yYnSf4UokvlOP982fRMZDjapeIz2Ap8OZqasUBp
        TzNmQ3c6f0F6Uf4kZVxTsMhdyyGYT9JBnEhNZNPxzVsYjWw9sP9TpKv435S9EPysVEI+QU1AH6A
        txnd7oEY36QpKNST50Ye95YYa4IiPV3yaj019f2iZEN4iqV+0wEWldDbRr8Ewc9xiR/DytrbqXE
        t6
X-Received: by 2002:a17:906:16da:: with SMTP id t26mr4887278ejd.478.1606857815807;
        Tue, 01 Dec 2020 13:23:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztK4UgFPqptMRMHfuQyWpN/x4JaRUdG8V1a5fFXefiHnJXJqRkNyXSOhsM41768KJkrSEH7g==
X-Received: by 2002:a17:906:16da:: with SMTP id t26mr4887247ejd.478.1606857815503;
        Tue, 01 Dec 2020 13:23:35 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id j7sm479921edp.52.2020.12.01.13.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 13:23:34 -0800 (PST)
Subject: Re: [PATCH 1/3] intel-hid: add support for SW_TABLET_MODE
To:     Elia Devito <eliadevito@gmail.com>
Cc:     mario.limonciello@dell.com, Alex Hung <alex.hung@canonical.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201201195504.22296-1-eliadevito@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <69f340f6-4301-6546-f14a-47d90208d44b@redhat.com>
Date:   Tue, 1 Dec 2020 22:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201195504.22296-1-eliadevito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elia,

Thank you for your patch series.

I'm fraid that always enabling this on devices with a chassis_type of 31 is
not a good idea though.

Many 360 degree hinges (yoga) style 2-in-1s use 2 accelerometers to tell
the angle between the 2 halves; and they rely on a HingleAngleService
process under Windows to read out the 2 accelerometers and then call
back into ACPI (through an ACPI DSM on the accelerometer API node)
to tell the firmware about the angle between the 2 halves.

On some devices this is also where the 0xCC / 0xCD events come from
on the intel-hid device. Here is some example DSDT code doing this:

                Device (KXJ0)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Name (_HID, "KIOX010A")  // _HID: Hardware ID
                    Name (_CID, "KIOX010A")  // _CID: Compatible ID
                    Name (_DDN, "Kionix KXCJ9 Accelerometer Display")  // _DDN: DOS Device Name
<snip>
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If ((Arg0 == ToUUID ("1f339696-d475-4e26-8cad-2e9f8e6d7a91")))
                        {
                            If ((Arg2 == Zero))
                            {
                                Return (Buffer (One)
                                {
                                     0x05                                             // .
                                })
                            }

                            If ((Arg2 == One))
                            {
                                IDX1 = 0x10
                                DTA1 = One
                                SPC0 (0x00C509C0, 0x44000201)
                                Notify (HIDD, 0xCD) // Hardware-Specific
                                Return (Buffer (One)
                                {
                                     0x01                                             // .
                                })
                            }

                            If ((Arg2 == 0x02))
                            {
                                IDX1 = 0x10
                                DTA1 = Zero
                                SPC0 (0x00C509C0, 0x44000200)
                                Notify (HIDD, 0xCC) // Hardware-Specific
                                Return (Buffer (One)
                                {
                                     0x00                                             // .
                                })
                            }

Notice the "Notify (HIDD, 0xC?)" calls here, resulting from something
(the HingeAngleService under Windows) calling the DSM. As you can see there
is more happening when this DSM gets called. I actually recently added support
for this to the kxcjk-1013.c accelerometer driver, because sometimes some
devices would come up with their kbd and touchpad events silenced by the
embedded controller of the device and this DSM needs to be called telling
the EC the device is in laptop mode to get the kbd/mouse to work (*).

See here for the patch which I wrote for this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5b1032a656e9aa4c7a4df77cb9156a2a651a5f9

Since there is nothing on Linux calling this DSM whenever the mode
changes, SW_TABLET_MODE reporting from the intel-hid driver will be
unreliable on these devices.

Also there is going to be a ton of devices which do use intel-hid for
reporting some buttons and which do have a chassis-type of 31, but which
do not use intel-hid for reporting SW_TABLET_MODE, but use something else,
either something manufacturer specific or e.g. intel-vbtn.

Even when we end up reporting SW_TABLET_MODE=0 all the time this
still causes issues. E.g. GNOME-3.38 and newer will disable
accelerometer based display rotation and will not auto-popup the
onscreen keyboard on focussing a text-field by touch, when
SW_TABLET_MODE==0

So we really must only advertise SW_TABLET_MODE support if it actually
works. As such I believe that it would be better to use a vendor + product
DMI string based allow-list for this now and only add SW_TABLET_MODE support
to intel-hid for devices on the allow-list.

Do you know if the HP and Dell from the bug also have an intel-vbtn
device? I think we need to gather some more info on devices which need
this and see if we can come up with a better way to detect support then
we could go with that + checking chassis_type + a
if (!acpi_dev_present("KIOX010A", NULL, -1)) check to catch the
2-accelerometers needing some equivalent of HingeAngleService case.

I guess a third option would be to create a second input_dev on
the fly when the first 0xcc / 0xcd events is generated (and hard
code those events for the 2nd inputdev rather then using the
sparse keymap). This also deals with VGBS not always being reliable,
but it would mean that the advantages of advertising SW_TABLET_MODE=0
when in laptopmode (the new GNOME-3.38 behavior) go away until such
events are first send. Then again I have the feeling that at least
some devices will send these with some interval even when not changing
modes which might make the idea of creating a 2nd input-dev on the
fly when receiving the first event work reasonably well.

If you can see if the HP model from the bug does indeed sends
out events without needing a mode change to happen then this might
actually be a viable idea.

Or maybe combine the 2, an allow-list for devices where VGBS works
and on those create the 2nd input device immediately with the
initial state coming from VGBS + dynamic creation on the rest.

Hmm, I must say that I do actually like this combined idea...

Regards,

Hans










*) Note in this case the events are actually suppressed by the
embedded-controller, unlike similar cases where this happens when
libinput sees SW_TABLET_MODE=1



On 12/1/20 8:55 PM, Elia Devito wrote:
> Add support for SW_TABLET_MODE for convertibles notebook.
> 
> Exactly as intel-vbtn driver, the event code 0xcc is emitted by
> convertibles when entering tablet mode and 0xcd when return to
> laptop mode.
> 
> Signed-off-by: Elia Devito <eliadevito@gmail.com>
> ---
> more info: https://bugzilla.kernel.org/show_bug.cgi?id=207433
>  
>  drivers/platform/x86/intel-hid.c | 84 ++++++++++++++++++++++++++++++--
>  1 file changed, 80 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
> index 86261970bd8f..5093c57102cf 100644
> --- a/drivers/platform/x86/intel-hid.c
> +++ b/drivers/platform/x86/intel-hid.c
> @@ -15,6 +15,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/suspend.h>
>  
> +/* When NOT in tablet mode, VGBS returns with the flag 0x40 */
> +#define TABLET_MODE_FLAG 0x40
> +
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Alex Hung");
>  
> @@ -61,7 +64,11 @@ static const struct key_entry intel_array_keymap[] = {
>  	{ KE_IGNORE, 0xC9, { KEY_ROTATE_LOCK_TOGGLE } },      /* Release */
>  	{ KE_KEY,    0xCE, { KEY_POWER } },                   /* Press */
>  	{ KE_IGNORE, 0xCF, { KEY_POWER } },                   /* Release */
> -	{ KE_END },
> +};
> +
> +static const struct key_entry intel_array_switches[] = {
> +	{ KE_SW, 0xCC, { .sw = { SW_TABLET_MODE, 1 } } },  /* Tablet */
> +	{ KE_SW, 0xCD, { .sw = { SW_TABLET_MODE, 0 } } },  /* Laptop */
>  };
>  
>  static const struct dmi_system_id button_array_table[] = {
> @@ -89,9 +96,23 @@ static const struct dmi_system_id button_array_table[] = {
>  	{ }
>  };
>  
> +static const struct dmi_system_id button_array_switches_table[] = {
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "31" /* Convertible */),
> +		},
> +	},
> +	{ }
> +};
> +
> +#define KEYMAP_LEN \
> +	(ARRAY_SIZE(intel_array_keymap) + ARRAY_SIZE(intel_array_switches) + 1)
> +
>  struct intel_hid_priv {
> +	struct key_entry keymap[KEYMAP_LEN];
>  	struct input_dev *input_dev;
>  	struct input_dev *array;
> +	bool has_switches;
>  	bool wakeup_mode;
>  };
>  
> @@ -327,23 +348,54 @@ static int intel_hid_input_setup(struct platform_device *device)
>  	return input_register_device(priv->input_dev);
>  }
>  
> +static void detect_tablet_mode(struct platform_device *device)
> +{
> +	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
> +	acpi_handle handle = ACPI_HANDLE(&device->dev);
> +	unsigned long long vgbs;
> +	int m;
> +
> +	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_VGBS_FN, &vgbs))
> +		return;
> +
> +	m = !(vgbs & TABLET_MODE_FLAG);
> +	input_report_switch(priv->array, SW_TABLET_MODE, m);
> +}
> +
>  static int intel_button_array_input_setup(struct platform_device *device)
>  {
>  	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
> -	int ret;
> +	int ret, keymap_len = 0;
>  
>  	/* Setup input device for 5 button array */
>  	priv->array = devm_input_allocate_device(&device->dev);
>  	if (!priv->array)
>  		return -ENOMEM;
>  
> -	ret = sparse_keymap_setup(priv->array, intel_array_keymap, NULL);
> +	memcpy(&priv->keymap[keymap_len], intel_array_keymap,
> +		       ARRAY_SIZE(intel_array_keymap) *
> +		       sizeof(struct key_entry));
> +	keymap_len += ARRAY_SIZE(intel_array_keymap);
> +
> +	if (priv->has_switches) {
> +		memcpy(&priv->keymap[keymap_len], intel_array_switches,
> +		       ARRAY_SIZE(intel_array_switches) *
> +		       sizeof(struct key_entry));
> +		keymap_len += ARRAY_SIZE(intel_array_switches);
> +	}
> +
> +	priv->keymap[keymap_len].type = KE_END;
> +
> +	ret = sparse_keymap_setup(priv->array, priv->keymap, NULL);
>  	if (ret)
>  		return ret;
>  
>  	priv->array->name = "Intel HID 5 button array";
>  	priv->array->id.bustype = BUS_HOST;
>  
> +	if (priv->has_switches)
> +		detect_tablet_mode(device);
> +
>  	return input_register_device(priv->array);
>  }
>  
> @@ -352,7 +404,10 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  	struct platform_device *device = context;
>  	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
>  	unsigned long long ev_index;
> +	unsigned int val = !(event & 1); /* Even=press, Odd=release */
> +	const struct key_entry *ke;
>  
> +	dev_info(&device->dev, "event 0x%x\n", event);
>  	if (priv->wakeup_mode) {
>  		/*
>  		 * Needed for wakeup from suspend-to-idle to work on some
> @@ -367,13 +422,19 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  		if (event == 0xc0 || !priv->array)
>  			return;
>  
> -		if (!sparse_keymap_entry_from_scancode(priv->array, event)) {
> +		ke = sparse_keymap_entry_from_scancode(priv->array, event);
> +		if (!ke) {
>  			dev_info(&device->dev, "unknown event 0x%x\n", event);
>  			return;
>  		}
>  
>  wakeup:
>  		pm_wakeup_hard_event(&device->dev);
> +
> +		/* report the new switch position to the input subsystem. */
> +		if (ke && ke->type == KE_SW)
> +			sparse_keymap_report_event(priv->array, event, val, 0);
> +
>  		return;
>  	}
>  
> @@ -441,6 +502,20 @@ static bool button_array_present(struct platform_device *device)
>  	return false;
>  }
>  
> +static bool intel_button_array_has_switches(struct platform_device *device)
> +{
> +	acpi_handle handle = ACPI_HANDLE(&device->dev);
> +	unsigned long long vgbs;
> +
> +	if (!dmi_check_system(button_array_switches_table))
> +		return false;
> +
> +	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_VGBS_FN, &vgbs))
> +		return false;
> +
> +	return true;
> +}
> +
>  static int intel_hid_probe(struct platform_device *device)
>  {
>  	acpi_handle handle = ACPI_HANDLE(&device->dev);
> @@ -479,6 +554,7 @@ static int intel_hid_probe(struct platform_device *device)
>  
>  	/* Setup 5 button array */
>  	if (button_array_present(device)) {
> +		priv->has_switches = intel_button_array_has_switches(device);
>  		dev_info(&device->dev, "platform supports 5 button array\n");
>  		err = intel_button_array_input_setup(device);
>  		if (err)
> 

