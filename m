Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D23A2DC1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgLPOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgLPOD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608127321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sIT/U1zUcAUrkDXkv6VWKg26my/iL2ARrpTxUVfDaBY=;
        b=aVvtPF6pslDACg2vLTTIA8v/5k3XaojwsvqPml+v2IGFf4Y23teAfnA4spUzdDqKm7iYVR
        HP0nABIPvrmA2aXEBdzyuCMePm9a3Sp31Kb80EDZURpTBvvQ8I1rQw1qKKPijGDRGkhTzK
        7jUc2BGTObGn1/Xxf5Vo+zq0tP4llhU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-HxUpXYxVPR2XCfuOtyjs7w-1; Wed, 16 Dec 2020 09:01:58 -0500
X-MC-Unique: HxUpXYxVPR2XCfuOtyjs7w-1
Received: by mail-ed1-f71.google.com with SMTP id y19so10122151edw.16
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIT/U1zUcAUrkDXkv6VWKg26my/iL2ARrpTxUVfDaBY=;
        b=L0phnOQdVc17bV6XefysN/Cr6gEjxFoQv6TIxyru+SZlU9gWPWnRXSK8z7OWVB/3M+
         uJaNqvmSvpG4hy4cHpGLeNWMr/vJuEQpxWyUpBYHLbRLeAmqpPSkoVBpdWMchjY8y3Cg
         eMwZEENwaLUGMM50rPVZDcWRm35mrMVFEIyBQY8dnAGKtRwPkXysByTanRqmJJT5rpY5
         oHGv4MW48Fx4DlZaT9KZR1O+Q8WXcv/8EEjDwBmlOZYCHEGcfIpTRT+hV/UaS4NY3jN6
         vnKBNLAN0jYPxQ2Tr7ebc96oZDbVyEYjPYHZeVviiKCHwrtpgl3S5pEaGuB3HgrbmuTE
         +LKQ==
X-Gm-Message-State: AOAM531AM+CEL0lPvtC1DEdzqYBADydGSOabbDKOn2yVNExcRcOR7bZd
        MIKiexkDnnyiPKDCXkmr+CaCi4uAv/6DdFVQ9WkRFASm83dhV+tWf+LlnbILaAhizplOtGtokFG
        C1eM/ry8FKG5ag62LT5H6n/tB6V+n7hvrXDqPzLb8MOTQE45sXQg2LZWXNc5TKCuB4BTgSNbRLt
        7/
X-Received: by 2002:a17:906:f8d4:: with SMTP id lh20mr31195346ejb.442.1608127316826;
        Wed, 16 Dec 2020 06:01:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0Axzb73vQVIPuNbLIMIUfjTGEA8B8FRAq8n/DMjmv0ieDm2eccR281AAMjRXzok73L6ofkg==
X-Received: by 2002:a17:906:f8d4:: with SMTP id lh20mr31195324ejb.442.1608127316575;
        Wed, 16 Dec 2020 06:01:56 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id g18sm20649849edt.2.2020.12.16.06.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 06:01:55 -0800 (PST)
Subject: Re: [PATCH] platform/surface: SURFACE_PLATFORMS should depend on ACPI
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201216133752.1321978-1-geert@linux-m68k.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aa101c72-2d15-efa8-5b44-479315e24a93@redhat.com>
Date:   Wed, 16 Dec 2020 15:01:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201216133752.1321978-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/16/20 2:37 PM, Geert Uytterhoeven wrote:
> All Microsoft Surface platform-specific device drivers depend on ACPI,
> but the gatekeeper symbol SURFACE_PLATFORMS does not.  Hence when the
> user is configuring a kernel without ACPI support, he is still asked
> about Microsoft Surface drivers, even though this question is
> irrelevant.
> 
> Fix this by moving the dependency on ACPI from the individual driver
> symbols to SURFACE_PLATFORMS.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Maximilian, can I have your ack or reviewed-by for this
(assuming you agree with this change) ?

Regards,

Hans

> ---


>  drivers/platform/surface/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
> index 33040b0b3b799c2d..2c941cdac9eedc6f 100644
> --- a/drivers/platform/surface/Kconfig
> +++ b/drivers/platform/surface/Kconfig
> @@ -5,6 +5,7 @@
>  
>  menuconfig SURFACE_PLATFORMS
>  	bool "Microsoft Surface Platform-Specific Device Drivers"
> +	depends on ACPI
>  	default y
>  	help
>  	  Say Y here to get to see options for platform-specific device drivers
> @@ -29,20 +30,19 @@ config SURFACE3_WMI
>  
>  config SURFACE_3_BUTTON
>  	tristate "Power/home/volume buttons driver for Microsoft Surface 3 tablet"
> -	depends on ACPI && KEYBOARD_GPIO && I2C
> +	depends on KEYBOARD_GPIO && I2C
>  	help
>  	  This driver handles the power/home/volume buttons on the Microsoft Surface 3 tablet.
>  
>  config SURFACE_3_POWER_OPREGION
>  	tristate "Surface 3 battery platform operation region support"
> -	depends on ACPI && I2C
> +	depends on I2C
>  	help
>  	  This driver provides support for ACPI operation
>  	  region of the Surface 3 battery platform driver.
>  
>  config SURFACE_GPE
>  	tristate "Surface GPE/Lid Support Driver"
> -	depends on ACPI
>  	depends on DMI
>  	help
>  	  This driver marks the GPEs related to the ACPI lid device found on
> @@ -52,7 +52,7 @@ config SURFACE_GPE
>  
>  config SURFACE_PRO3_BUTTON
>  	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
> -	depends on ACPI && INPUT
> +	depends on INPUT
>  	help
>  	  This driver handles the power/home/volume buttons on the Microsoft Surface Pro 3/4 tablet.
>  
> 

