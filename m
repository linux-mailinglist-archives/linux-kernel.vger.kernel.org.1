Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74419251475
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 10:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgHYIk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 04:40:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45137 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgHYIk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:40:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so5091194wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 01:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/RmhTrzQhsx9UuRlKnp8VuEp85WKAQJEEwz6HVaYMiY=;
        b=TJ/YZhO1yDH2g+0hk3J4KESi8lf6oeHVipMGFaHkXH1nUrcrQGPp07tOB/i5CsisZi
         uj6bbbpgM3CXH0PkFmpdDn2kxUzZCvrhQfN8KskLs/mZLqUKc4NE2T1oosZ+XuTve4mC
         c/fdOFk3iRBlbxmp6N+UCs0UeHSLVMO78TLWxjEq5feeuK80r/wtT6nkB3ZWI2Z7fxAK
         xQH+/sAvYtXc2R9sZEIZezNAqZjBJQTVjqIBmZayUE+xgJ3ybF/UGw483Mb2belhG6kQ
         KlZPi6iKVUF0GXKHyfKmz7kMRXj0NHSc2E/d8NSbiNxnBTG531OoBQBu7nEXs9s8TvhH
         2cSA==
X-Gm-Message-State: AOAM5307PR3SQcKiDodEPDjqMv9/8ikOAh95q080tHvDuK8QskjUwcYT
        YXq8R42e6xN6nL50uiftRzw=
X-Google-Smtp-Source: ABdhPJz0N71dJW5Cc3V7acCh4nLgH4zXbpqgfubGs8lf8Xf9uEwSG3QqcisIAZj/7+ZFSx31kCsXlw==
X-Received: by 2002:adf:b442:: with SMTP id v2mr1233395wrd.213.1598344856282;
        Tue, 25 Aug 2020 01:40:56 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id x4sm325840wmi.0.2020.08.25.01.40.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 01:40:55 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:40:53 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
        vijaikumar.kanagarajan@gmail.com, myungjoo.ham@samsung.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v1 1/1] extcon: ptn5150: Add usb-typec support for Intel
 LGM SoC
Message-ID: <20200825084053.GA13905@kozik-lap>
References: <20200825083147.25270-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200825083147.25270-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825083147.25270-2-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 04:31:47PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add usb-typec detection support for Intel LGM SoC based
> boards.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/extcon/extcon-ptn5150.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 8ba706fad887..60355a1b5cb2 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -300,6 +300,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>  		return ret;
>  	}
>  
> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);

Hi,

I think you need the same for EXTCON_USB.

Although extcon_set_property_capability() error should not be fatal, but
printing a warn message would be useful.

Best regards,
Krzysztof


>  	/* Initialize PTN5150 device and print vendor id and version id */
>  	ret = ptn5150_init_dev_type(info);
>  	if (ret)
> -- 
> 2.11.0
> 
