Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450F926F764
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgIRHwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:52:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38081 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgIRHwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:52:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id y11so5113882lfl.5;
        Fri, 18 Sep 2020 00:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JIGXHwKfHfCJXixJmE7+Do7NXGtiGDBK+l84obZPw4Y=;
        b=c5Q7V1J7jpxMDo2CT62lRouTNkUBIb2I/cmDSPblrdmRy8TDTcpCALXYfkGd53XLzC
         5/iw21xj0BNR230JRPWq2I1qFXgiiUo2L4PKeoKKqNqrrTaMYF+2OinREU+K2q/r3ZpF
         GjuJpihe/qKKo1V8Z4KEiVyMe7+Gg0raxXWyWg4bkbyl2HCE0SX8hqiZoVzMTFXNTxn2
         1Tj68HZzPsahhpJDxqwMJZycR5gPo3mKVUdywXa7SvLI5gs9iK+hwnt4zhfePr2GjLXl
         i0wB04tfpNgpkFRFFB2Pvx/fub0O+M1xK/ObOoUzIzpicJk+ojt/45S4t8LKLAs8UoHo
         UGTw==
X-Gm-Message-State: AOAM532Hp2LF0CmzYXbgrOo8a55tB83UYlNBwROr7txehJljPwUZQ0re
        qG91HqHzwAuG5U4SDZZtKb8=
X-Google-Smtp-Source: ABdhPJwJCsAoQ3MFjL1Z0xIWLLw9TkqspVnlHNYY63eULIqs9sMIrBry02mqFMLggU+exItWxYIh+g==
X-Received: by 2002:a05:6512:32b1:: with SMTP id q17mr11767958lfe.329.1600415525972;
        Fri, 18 Sep 2020 00:52:05 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id q11sm431542lfc.309.2020.09.18.00.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 00:52:05 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kJBBY-00076W-Sd; Fri, 18 Sep 2020 09:52:00 +0200
Date:   Fri, 18 Sep 2020 09:52:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     William Sung <william.sung@advantech.com.tw>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Campion Kang <campion.kang@advantech.com.tw>
Subject: Re: [PATCH 1/2] usb: serial: option: Fix the lackage for Quectel
 EG95 LTE modem support
Message-ID: <20200918075200.GO24441@localhost>
References: <20200901050022.3319-1-william.sung@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901050022.3319-1-william.sung@advantech.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 01:00:21PM +0800, William Sung wrote:
> * Add reset-resume callback for resetting USB devices after MCU exits
> from suspend/sleep mode.

Please split this in it's own patch and argue for why it's needed.

> * Because Quectel EG95 uses USB interface 4 as a USB network device, so
> return from option_startup() to prevent being used as a USB serial
> device.
>
> Fixes: da6902e5b6db ("USB: serial: option: add Quectel EG95 LTE modem"
> 
> Signed-off-by: William Sung <william.sung@advantech.com.tw>
> ---
>  drivers/usb/serial/option.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 89b3192af326..9de8aec47e5e 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2069,6 +2069,7 @@ static struct usb_serial_driver option_1port_device = {
>  #ifdef CONFIG_PM
>  	.suspend           = usb_wwan_suspend,
>  	.resume            = usb_wwan_resume,
> +	.reset_resume      = usb_wwan_resume,
>  #endif
>  };
>  
> @@ -2104,6 +2105,11 @@ static int option_probe(struct usb_serial *serial,
>  	if (device_flags & NUMEP2 && iface_desc->bNumEndpoints != 2)
>  		return -ENODEV;
>  
> +	/* Quectel EC25 & EC21 & EG91 & EG95 ... interface 4 can be used as USB network device */
> +	if (serial->dev->descriptor.idVendor == cpu_to_le16(0x2c7c) &&
> +		serial->interface->cur_altsetting->desc.bInterfaceNumber >= 4)
> +		return -ENODEV;

And please use the normal mechanisms for blacklisting interfaces (e.g.
the RSVD() macro).

> +
>  	/* Store the device flags so we can use them during attach. */
>  	usb_set_serial_data(serial, (void *)device_flags);

Also make sure your patches have distinct and descriptive summaries
(Subject lines).

Johan
