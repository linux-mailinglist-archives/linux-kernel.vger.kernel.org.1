Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0553526F77A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgIRHxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:53:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45857 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgIRHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:53:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id c2so4269729ljj.12;
        Fri, 18 Sep 2020 00:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GyOHKL1/jyD90zbgDyT56Y9yMNaAOcbKzuPFJ2ymZ/M=;
        b=AXy+vQUTfSEPcbuNU68Kz6GyzLQAHahdF37DMbWFmbQzifMi7SQu6CYoAZuKvzdMvm
         W5lLA2+kmXWO2hdWdyL4w3+RsLK+Pi7ndEIswlqxEA5Jfyr0ZK3EBZ5UAmw21C8JSf0X
         nAX+2ZT6m2KDGCYXQqS8wF0jKC2nq5fRD14wO54hr1B+c0ITPdVWs7U/0H9+NQMOt5UD
         eYuCcv1QYyr2bFAwf0adpybLM2MHs58xE0+NRb/vj57vZBVCZeQfT/MXYZ/EMCYmxJBc
         8pPlROytXNVmNCaI5MAdpCRrmokvXW4w8RCialg2gL5yD9xSx5vP6dAFikYFLE9jWJ4q
         o2kw==
X-Gm-Message-State: AOAM531+UyI9VvKP3edtsBXa171HtjMc7mMROR3fZUjX1A2jdGu8Ft2o
        f3SZGmt0Wdc6lrwFlPiqtHpZvPg4tyM=
X-Google-Smtp-Source: ABdhPJyFnEapePUeKcYZkPJpfZwutD7tNn9yHm6yz7nMDkc/xACMKQoUncnwG/o2QcVABiAddQ5BhA==
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr10808141ljp.140.1600415617830;
        Fri, 18 Sep 2020 00:53:37 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id u11sm435025ljh.17.2020.09.18.00.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 00:53:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kJBD2-00077J-HH; Fri, 18 Sep 2020 09:53:32 +0200
Date:   Fri, 18 Sep 2020 09:53:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     William Sung <william.sung@advantech.com.tw>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>,
        Campion Kang <campion.kang@advantech.com.tw>
Subject: Re: [PATCH v2] usb: serial: option: Fix the lackage for Quectel EG95
 LTE modem support
Message-ID: <20200918075332.GP24441@localhost>
References: <20200902110301.21936-1-william.sung@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902110301.21936-1-william.sung@advantech.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 07:03:01PM +0800, William Sung wrote:
> * Add reset-resume callback for resetting USB devices after MCU exits
> from suspend/sleep mode.

Looks like both your patches try to do this. Again, one logical change
per patch, please.

> * Add zero packet support
> 
> Fixes: da6902e5b6db ("USB: serial: option: add Quectel EG95 LTE modem"
> 
> Signed-off-by: William Sung <william.sung@advantech.com.tw>
> ---
> 
>  v2: * Add ZLP support
>      * Remove redundant code for reserving interface number 4
> 
>  drivers/usb/serial/option.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 89b3192af326..ba4dc67dab2f 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -1099,7 +1099,7 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC25),
>  	  .driver_info = RSVD(4) },
>  	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG95),
> -	  .driver_info = RSVD(4) },
> +	  .driver_info = RSVD(4) | ZLP },
>  	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
>  	  .driver_info = RSVD(4) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
> @@ -2069,6 +2069,7 @@ static struct usb_serial_driver option_1port_device = {
>  #ifdef CONFIG_PM
>  	.suspend           = usb_wwan_suspend,
>  	.resume            = usb_wwan_resume,
> +	.reset_resume      = usb_wwan_resume,
>  #endif
>  };

Johan
