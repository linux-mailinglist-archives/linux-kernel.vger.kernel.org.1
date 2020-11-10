Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23F02ADB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbgKJQKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbgKJQKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:10:02 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB4C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:10:02 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id u127so14928286oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mcGphvAE68zTC3ZPvA+ls3myso6C8YzuscBhmUqnc/I=;
        b=P8tUOaQ+GauRT2j5i1UUKOlbTT2a6TOXHUBj4OT+fjNfasFfj7OBOF4PtBT+UYQ45r
         kOeJIXu3qj3ZC99IZuH3QizpsWTVhgvbe9iRNVWxM3a3rTDVkI5XfAwrcuGIJOiDWqTo
         9ATPlsKmSrw2TdBhqIC/vFVzviz0ZQaY55OmMHlFnYJGuSRAJFOQO9x8W/EaPa+fMxGr
         rBL+VlkNonFAUlwPXD9Xj4IvGC9dvxMWa2DF79vMXQAaLtBxuzpokqvHX51RYcI0/zEu
         FKruZiDwafB9zjfD/2sW5F4EccWS/X1nKANm93irRg3pwObrUbuUJmyPqU40bTkzNaW/
         xiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mcGphvAE68zTC3ZPvA+ls3myso6C8YzuscBhmUqnc/I=;
        b=Ylbhb1QESiRjkwL7JzVY3np+4ktP9S661tkElXF8o4+prX+7HeKhFJWk9Hn3Y79830
         TgnrygFs0Nf4QeonVrcKuNJ3BaBzpuFRH/Qkcx/iin770o21rHahpOC+ced/9iKLL6S8
         pHZTbf5rh6Qg0KzIPdJefal1VBqyN+rQJm8HMIayuREc2GvrQF/W7oLYa7YTd/Lf71uS
         X1K2Qi6ANDoTiWrRgEyvrDYg3hcZ70HhbJ1EdMdl8Yrw3gbXBQiNNLLqjgg3ag0f+Vry
         mo+M3Hfqbr2CMt/wuCd9UEYYc7FA9nsml8ermh00b3LfDTKKlRWROMmMTl6EMCe9YBJH
         kt/w==
X-Gm-Message-State: AOAM532ciNIg/6P0+d8d3q0526E0VDWFdFHbp/xu40y2v+mF6LwJt1Xm
        eYqmWrgVHIocMGp0bloN4fA=
X-Google-Smtp-Source: ABdhPJz6PKQy3Ws54regd6ikbaLM00rPknXRop06qTh0gfXDuM9D4WRI/YaKlKHctrFTSNqtDEJhfw==
X-Received: by 2002:aca:ea84:: with SMTP id i126mr3391604oih.98.1605024602248;
        Tue, 10 Nov 2020 08:10:02 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x24sm1857353otq.68.2020.11.10.08.10.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 08:10:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Nov 2020 08:10:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: Re: [PATCH] mfd: kempld-core: Check for DMI definition before ACPI
Message-ID: <20201110161000.GD17288@roeck-us.net>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
 <28a160ac-df8c-0fcb-8814-03125d753be3@roeck-us.net>
 <b9a01e2c8b54fbadfaff8d3a5888802ce4859ed4.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a01e2c8b54fbadfaff8d3a5888802ce4859ed4.camel@kontron.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:41:47PM +0000, Michael Brunner wrote:
> Hi Guenter,
> 
> thank you for the feedback! checkpatch didn't catch this.
> I sent v2 of the patch.
> 

It may have been "demoted" to --strict for whatever reason.

Guenter

> Best regards,
>   Michael
> 
> On Tue, 2020-11-10 at 06:39 -0800, Guenter Roeck wrote:
> > On 11/9/20 11:46 PM, Michael Brunner wrote:
> > > Change the detection order to priorize DMI table entries over
> > > available
> > > ACPI entries.
> > > 
> > > This makes it more easy for product developers to patch product
> > > specific
> > > handling into the driver.
> > > Furthermore it allows to simplify the implementation a bit and
> > > especially to remove the need to force synchronous probing.
> > > 
> > > Based on the following commit introduced with v5.10-rc1:
> > > commit e8299c7313af ("mfd: Add ACPI support to Kontron PLD driver")
> > > 
> > > Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> > > ---
> > >  drivers/mfd/kempld-core.c | 23 ++---------------------
> > >  1 file changed, 2 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> > > index 2c9295953c11..aa7f386646a1 100644
> > > --- a/drivers/mfd/kempld-core.c
> > > +++ b/drivers/mfd/kempld-core.c
> > > @@ -125,7 +125,6 @@ static const struct kempld_platform_data
> > > kempld_platform_data_generic = {
> > >  };
> > >  
> > >  static struct platform_device *kempld_pdev;
> > > -static bool kempld_acpi_mode;
> > >  
> > >  static int kempld_create_platform_device(const struct
> > > dmi_system_id *id)
> > >  {
> > > @@ -501,8 +500,6 @@ static int kempld_probe(struct platform_device
> > > *pdev)
> > >  		ret = kempld_get_acpi_data(pdev);
> > >  		if (ret)
> > >  			return ret;
> > > -
> > > -		kempld_acpi_mode = true;
> > >  	} else if (kempld_pdev != pdev) {
> > >  		/*
> > >  		 * The platform device we are probing is not the one we
> > > @@ -565,7 +562,6 @@ static struct platform_driver kempld_driver = {
> > >  	.driver		= {
> > >  		.name	= "kempld",
> > >  		.acpi_match_table = ACPI_PTR(kempld_acpi_table),
> > > -		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> > >  	},
> > >  	.probe		= kempld_probe,
> > >  	.remove		= kempld_remove,
> > > @@ -884,7 +880,6 @@ MODULE_DEVICE_TABLE(dmi, kempld_dmi_table);
> > >  static int __init kempld_init(void)
> > >  {
> > >  	const struct dmi_system_id *id;
> > > -	int ret;
> > >  
> > >  	if (force_device_id[0]) {
> > >  		for (id = kempld_dmi_table;
> > > @@ -894,24 +889,10 @@ static int __init kempld_init(void)
> > >  					break;
> > >  		if (id->matches[0].slot == DMI_NONE)
> > >  			return -ENODEV;
> > > -	}
> > > -
> > > -	ret = platform_driver_register(&kempld_driver);
> > > -	if (ret)
> > > -		return ret;
> > > -
> > > -	/*
> > > -	 * With synchronous probing the device should already be probed
> > > now.
> > > -	 * If no device id is forced and also no ACPI definition for
> > > the
> > > -	 * device was found, scan DMI table as fallback.
> > > -	 *
> > > -	 * If drivers_autoprobing is disabled and the device is found
> > > here,
> > > -	 * only that device can be bound manually later.
> > > -	 */
> > > -	if (!kempld_pdev && !kempld_acpi_mode)
> > > +	} else
> > 
> > 	} else {
> > >  		dmi_check_system(kempld_dmi_table);
> > 	}
> > 
> > Guenter
> > 
> > >  
> > > -	return 0;
> > > +	return platform_driver_register(&kempld_driver);
> > >  }
> > >  
> > >  static void __exit kempld_exit(void)
> > > 
