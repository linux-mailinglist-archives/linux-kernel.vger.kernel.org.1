Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD52AD832
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgKJOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:00:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728478AbgKJOAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605016848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IOgM7RgXhQ/E/d3tDpFY4uvO5WFTJP1L3xlw7pJr/y8=;
        b=D+SB862O0HWtYZcW2J9HGLNQ9hMx3wei5RdDScYq6MTcMWgJBMYXfp4spviyzRRSO0OmuU
        RFF7VrUTJTiA44QS/gWcVAo3S6tLQIKJysGY4XXgyug/ugbZUn9fOnvG/CQmU16LIckWx/
        vT4z2hdRgqoU6bMbco6kbI+CEvxCZ+k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-e2t9a3gtOASBrXmkA8ipBw-1; Tue, 10 Nov 2020 09:00:46 -0500
X-MC-Unique: e2t9a3gtOASBrXmkA8ipBw-1
Received: by mail-ej1-f70.google.com with SMTP id gr9so4734190ejb.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IOgM7RgXhQ/E/d3tDpFY4uvO5WFTJP1L3xlw7pJr/y8=;
        b=CI6qVvUoquYBS9dA/gZykswpQCq5yJtN6DqrM5tex7ZDZXFiOV7PgTu4EOW1z5nx1I
         JGC6NCDzWZ9bsbWKznBIBpMU8fBb+ZpKSKDL0HOVUZIEuV/a7X+zsbW7vTUuZ4fZHHFE
         /VRGBvPsFunsNfnyWY+vxQ0RSCBMh8pZePmdY5P5lNE1NqIR0GZjgtrqMQN7kUZOS2wD
         JLWvax1Vxap9J+9ixVMaEpS4Ojji/iP5L83Dv038YJTDWkE5HcfKNGMyw/CjajejOw8T
         s3go9J5Idg0hJ3c5MHUDvYkmxMyvxpKdhsPJrM3/NSabZndABfDjTj1aZMmFZaL93NpM
         Pc6A==
X-Gm-Message-State: AOAM531RSSVR62ekOuTskWW/SbCwuthijk0/8JHzqR43wiNcRDmgZQlR
        Pfj97YyjYKp9ZgVD9L8T5ZCbfOGsvxJeB8p/wgjD6t3Pzzy3ND7u5uwt6Mq4enwZdJY2JY5FLbx
        xZuk9bFkLgsbOAp0eae4eY+v4
X-Received: by 2002:a17:906:9457:: with SMTP id z23mr19268806ejx.296.1605016845209;
        Tue, 10 Nov 2020 06:00:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ/PIg/3oOfv4KzXXekLryNfAmjW83K2Rsczx5OPtkrfQjKxGaB1ga3K7thuVANnK9kUeO2Q==
X-Received: by 2002:a17:906:9457:: with SMTP id z23mr19268769ejx.296.1605016844830;
        Tue, 10 Nov 2020 06:00:44 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id b12sm11074659edj.12.2020.11.10.06.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 06:00:44 -0800 (PST)
Subject: Re: [PATCH 1/9] add support for optical driver power in Y and W
 series
To:     Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
 <20200821181433.17653-2-kenneth.t.chan@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b9c9a56a-c95b-ad65-2d48-b35160c517f2@redhat.com>
Date:   Tue, 10 Nov 2020 15:00:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200821181433.17653-2-kenneth.t.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Quick self intro: I have take over drivers/platform/x86
maintainership from Andy; and I'm working my way through
the backlog of old patches in patchwork:
https://patchwork.kernel.org/project/platform-driver-x86/list/

On 8/21/20 8:14 PM, Kenneth Chan wrote:
> The physical optical drive switch is present in Y and W series that switches
> on the drive but fails to turn it off. The idea is to be able to toggle the
> drive power by software and/or hardware. This patch merges Martin Lucina
> <mato@kotelna.sk>'s work that took care of the software part.
> 
> Code is also added for the physical switch to power off the drive.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Kenneth, I think that it is great that you are willing to maintain
this driver going forward. I will also go ahead and merge your
patch updating the MAINTAINERS file for this.

I have changed the commit messages for this series a bit while merging this:

1. I added a "platform/x86: panasonic-laptop: " prefix to all
the Subject lines.
2. I re-wordwrapped some paragraphs because there were lines which
were longer then 75 chars.

Please keep this in mind for future patches.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
> 
> Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
> ---
>  drivers/platform/x86/panasonic-laptop.c | 190 ++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
> 
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index 59e38a1d2830..21cdc2149a10 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -12,6 +12,13 @@
>   *---------------------------------------------------------------------------
>   *
>   * ChangeLog:
> + *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
> + *		-v0.97	add support for cdpower hardware switch
> + *		-v0.96	merge Lucina's enhancement
> + *			Jan.13, 2009 Martin Lucina <mato@kotelna.sk>
> + *				- add support for optical driver power in
> + *				  Y and W series
> + *
>   *	Sep.23, 2008	Harald Welte <laforge@gnumonks.org>
>   *		-v0.95	rename driver from drivers/acpi/pcc_acpi.c to
>   *			drivers/misc/panasonic-laptop.c
> @@ -115,6 +122,7 @@
>  #include <linux/acpi.h>
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
> +#include <linux/platform_device.h>
>  
>  #ifndef ACPI_HOTKEY_COMPONENT
>  #define ACPI_HOTKEY_COMPONENT	0x10000000
> @@ -213,6 +221,7 @@ struct pcc_acpi {
>  	struct acpi_device	*device;
>  	struct input_dev	*input_dev;
>  	struct backlight_device	*backlight;
> +	struct platform_device	*platform;
>  };
>  
>  /* method access functions */
> @@ -345,6 +354,98 @@ static const struct backlight_ops pcc_backlight_ops = {
>  };
>  
>  
> +/* returns ACPI_SUCCESS if methods to control optical drive are present */
> +
> +static acpi_status check_optd_present(void)
> +{
> +	acpi_status status = AE_OK;
> +	acpi_handle handle;
> +
> +	status = acpi_get_handle(NULL, "\\_SB.STAT", &handle);
> +	if (ACPI_FAILURE(status))
> +		goto out;
> +	status = acpi_get_handle(NULL, "\\_SB.FBAY", &handle);
> +	if (ACPI_FAILURE(status))
> +		goto out;
> +	status = acpi_get_handle(NULL, "\\_SB.CDDI", &handle);
> +	if (ACPI_FAILURE(status))
> +		goto out;
> +
> +out:
> +	return status;
> +}
> +
> +/* get optical driver power state */
> +
> +static int get_optd_power_state(void)
> +{
> +	acpi_status status;
> +	unsigned long long state;
> +	int result;
> +
> +	status = acpi_evaluate_integer(NULL, "\\_SB.STAT", NULL, &state);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("evaluation error _SB.STAT\n");
> +		result = -EIO;
> +		goto out;
> +	}
> +	switch (state) {
> +	case 0: /* power off */
> +		result = 0;
> +		break;
> +	case 0x0f: /* power on */
> +		result = 1;
> +		break;
> +	default:
> +		result = -EIO;
> +		break;
> +	}
> +
> +out:
> +	return result;
> +}
> +
> +/* set optical drive power state */
> +
> +static int set_optd_power_state(int new_state)
> +{
> +	int result;
> +	acpi_status status;
> +
> +	result = get_optd_power_state();
> +	if (result < 0)
> +		goto out;
> +	if (new_state == result)
> +		goto out;
> +
> +	switch (new_state) {
> +	case 0: /* power off */
> +		/* Call CDDR instead, since they both call the same method
> +		 * while CDDI takes 1 arg and we are not quite sure what it is.
> +		 */
> +		status = acpi_evaluate_object(NULL, "\\_SB.CDDR", NULL, NULL);
> +		if (ACPI_FAILURE(status)) {
> +			pr_err("evaluation error _SB.CDDR\n");
> +			result = -EIO;
> +		}
> +		break;
> +	case 1: /* power on */
> +		status = acpi_evaluate_object(NULL, "\\_SB.FBAY", NULL, NULL);
> +		if (ACPI_FAILURE(status)) {
> +			pr_err("evaluation error _SB.FBAY\n");
> +			result = -EIO;
> +		}
> +		break;
> +	default:
> +		result = -EINVAL;
> +		break;
> +	}
> +
> +out:
> +	return result;
> +}
> +
> +
>  /* sysfs user interface functions */
>  
>  static ssize_t show_numbatt(struct device *dev, struct device_attribute *attr,
> @@ -411,16 +512,36 @@ static ssize_t set_sticky(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
>  
> +static ssize_t cdpower_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "%d\n", get_optd_power_state());
> +}
> +
> +static ssize_t cdpower_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	int err, val;
> +
> +	err = kstrtoint(buf, 10, &val);
> +	if (err)
> +		return err;
> +	set_optd_power_state(val);
> +	return count;
> +}
> +
>  static DEVICE_ATTR(numbatt, S_IRUGO, show_numbatt, NULL);
>  static DEVICE_ATTR(lcdtype, S_IRUGO, show_lcdtype, NULL);
>  static DEVICE_ATTR(mute, S_IRUGO, show_mute, NULL);
>  static DEVICE_ATTR(sticky_key, S_IRUGO | S_IWUSR, show_sticky, set_sticky);
> +static DEVICE_ATTR_RW(cdpower);
>  
>  static struct attribute *pcc_sysfs_entries[] = {
>  	&dev_attr_numbatt.attr,
>  	&dev_attr_lcdtype.attr,
>  	&dev_attr_mute.attr,
>  	&dev_attr_sticky_key.attr,
> +	&dev_attr_cdpower.attr,
>  	NULL,
>  };
>  
> @@ -476,6 +597,50 @@ static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
>  	}
>  }
>  
> +static void pcc_optd_notify(acpi_handle handle, u32 event, void *data)
> +{
> +	if (event != ACPI_NOTIFY_EJECT_REQUEST)
> +		return;
> +
> +	set_optd_power_state(0);
> +}
> +
> +static int pcc_register_optd_notifier(struct pcc_acpi *pcc, char *node)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +
> +	status = acpi_get_handle(NULL, node, &handle);
> +
> +	if (ACPI_SUCCESS(status)) {
> +		status = acpi_install_notify_handler(handle,
> +				ACPI_SYSTEM_NOTIFY,
> +				pcc_optd_notify, pcc);
> +		if (ACPI_FAILURE(status))
> +			pr_err("Failed to register notify on %s\n", node);
> +	} else
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static void pcc_unregister_optd_notifier(struct pcc_acpi *pcc, char *node)
> +{
> +	acpi_status status = AE_OK;
> +	acpi_handle handle;
> +
> +	status = acpi_get_handle(NULL, node, &handle);
> +
> +	if (ACPI_SUCCESS(status)) {
> +		status = acpi_remove_notify_handler(handle,
> +				ACPI_SYSTEM_NOTIFY,
> +				pcc_optd_notify);
> +		if (ACPI_FAILURE(status))
> +			pr_err("Error removing optd notify handler %s\n",
> +					node);
> +	}
> +}
> +
>  static int acpi_pcc_init_input(struct pcc_acpi *pcc)
>  {
>  	struct input_dev *input_dev;
> @@ -606,8 +771,27 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  	if (result)
>  		goto out_backlight;
>  
> +	/* optical drive initialization */
> +	if (ACPI_SUCCESS(check_optd_present())) {
> +		pcc->platform = platform_device_register_simple("panasonic",
> +			-1, NULL, 0);
> +		if (IS_ERR(pcc->platform)) {
> +			result = PTR_ERR(pcc->platform);
> +			goto out_backlight;
> +		}
> +		result = device_create_file(&pcc->platform->dev,
> +			&dev_attr_cdpower);
> +		pcc_register_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
> +		if (result)
> +			goto out_platform;
> +	} else {
> +		pcc->platform = NULL;
> +	}
> +
>  	return 0;
>  
> +out_platform:
> +	platform_device_unregister(pcc->platform);
>  out_backlight:
>  	backlight_device_unregister(pcc->backlight);
>  out_input:
> @@ -627,6 +811,12 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device)
>  	if (!device || !pcc)
>  		return -EINVAL;
>  
> +	if (pcc->platform) {
> +		device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
> +		platform_device_unregister(pcc->platform);
> +	}
> +	pcc_unregister_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
> +
>  	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
>  
>  	backlight_device_unregister(pcc->backlight);
> 

