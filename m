Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F3D2F4AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhAMLt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbhAMLt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610538481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2mGVAXmmuCyiV+feJTxZf77on2VBeLOqAu/nLNbYGs=;
        b=ZqvQOCOyemvY9j3DXD9ZvedMpk5p4uLjki4B8a9H+vbuK68zCGaepWDBd4samJU16ypCrF
        VRkgHK3g7LrfC44nQXoaVxfbwn0kHZi6iqYapxR3FQt0CUTyVCD5qqKLL1xxkt+KeTsGtL
        9rUCmP517BdoAdaLgADfnOjrgOCdZBg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-LPKTpflwMuysL7tCjS2PUw-1; Wed, 13 Jan 2021 06:47:59 -0500
X-MC-Unique: LPKTpflwMuysL7tCjS2PUw-1
Received: by mail-ed1-f69.google.com with SMTP id f19so731615edq.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i2mGVAXmmuCyiV+feJTxZf77on2VBeLOqAu/nLNbYGs=;
        b=SDxCNc7Ntb3I+7dwXJ+5AU3f3xSiid7g6CK9X3MITt6uQUgZspFFRz8WEnVqy5A7pA
         jRa/Tz2uUKkhNdYaR5oq5mPL88j6e9tya2oGcXgvur3jIDqIHgkUUq7jRHq2MharhUKM
         8lq30LB70r8pd6i1mDtCcmzxefLElN+zDtAoLCxO5cOIzp/VuttRO0rUaasRJ/We2Cvf
         2FLSXttIOnBNsMvYIJFquNNDLzdbrB3Q/zU7cBL2U49xO4gXFfcg9/QWb8lVtvV0p8tB
         REM/rkKvG8oTZ37rDBwcpsl7ZbpFgiG59TUggKV+f8XvCQ/VrwfnCsPHaZuWgnfQoA2F
         YQrQ==
X-Gm-Message-State: AOAM532K522dJ0+qnmxH7ZIoarowHGXDjTiEVtnP+TugBfZqBl/yscWw
        5yJN3dEuGL29QeyyQdUWEb4JE06iZdZJu1fl7pDpXg8QBjVLnff3vwphLCJfaR7YUkVniIzXmKT
        THCaOoQS13Oo2zmipWZ4bmVgC
X-Received: by 2002:a17:906:c45:: with SMTP id t5mr1254233ejf.370.1610538477979;
        Wed, 13 Jan 2021 03:47:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhr6rsU9m0eJMDY9xCPWxPgDeSJFc++vS1ovILcCU9t9JgoWVquU6yqXeFxgxPF6DJjyYWVw==
X-Received: by 2002:a17:906:c45:: with SMTP id t5mr1254220ejf.370.1610538477780;
        Wed, 13 Jan 2021 03:47:57 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id d18sm746039edz.14.2021.01.13.03.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 03:47:57 -0800 (PST)
Subject: Re: [PATCH] genirq: Fix [devm_]irq_alloc_desc returning irq 0
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20201221185647.226146-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <32292fd9-e135-115b-e550-1a66efb12f84@redhat.com>
Date:   Wed, 13 Jan 2021 12:47:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201221185647.226146-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/21/20 7:56 PM, Hans de Goede wrote:
> Since commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0
> is invalid"), having a linux-irq with number 0 will trigger a WARN
> when calling platform_get_irq*() to retrieve that linux-irq.
> 
> Since [devm_]irq_alloc_desc allocs 1 single irq and since irq 0 is
> normally not used, it would return 0 before this commit, triggering
> that WARN. This happens e.g. on Intel Bay Trail and Cherry Trail
> devices using the LPE audio engine for HDMI audio:
> 
> [   22.761392] ------------[ cut here ]------------
> [   22.761405] 0 is an invalid IRQ number
> [   22.761462] WARNING: CPU: 3 PID: 472 at drivers/base/platform.c:238 platform_get_irq_optional+0x108/0x180
> [   22.761470] Modules linked in: snd_hdmi_lpe_audio(+) ...
> ...
> [   22.762133] Call Trace:
> [   22.762158]  platform_get_irq+0x17/0x30
> [   22.762182]  hdmi_lpe_audio_probe+0x4a/0x6c0 [snd_hdmi_lpe_audio]
> ...
> [   22.762726] ---[ end trace ceece38854223a0b ]---
> 
> Change the 'from' parameter passed to __[devm_]irq_alloc_descs() by the
> [devm_]irq_alloc_desc macros from 0 to 1, so that these macros
> will no longer return 0.


Can someone please take a look at this patch?

(I guess sending this out during the hollidays may not have been the
best of ideas.)

Regards,

Hans




> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> A quick grep for 'irq_alloc_desc\(' shows only 2 users of irq_alloc_desc():
> 1. drivers/gpu/drm/i915/display/intel_lpe_audio.c
> 2. drivers/sh/intc/virq.c
> But that might very well be an incomplete list.
> ---
>  include/linux/irq.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index c54365309e97..a36d35c25996 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -922,7 +922,7 @@ int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
>  	__irq_alloc_descs(irq, from, cnt, node, THIS_MODULE, NULL)
>  
>  #define irq_alloc_desc(node)			\
> -	irq_alloc_descs(-1, 0, 1, node)
> +	irq_alloc_descs(-1, 1, 1, node)
>  
>  #define irq_alloc_desc_at(at, node)		\
>  	irq_alloc_descs(at, at, 1, node)
> @@ -937,7 +937,7 @@ int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
>  	__devm_irq_alloc_descs(dev, irq, from, cnt, node, THIS_MODULE, NULL)
>  
>  #define devm_irq_alloc_desc(dev, node)				\
> -	devm_irq_alloc_descs(dev, -1, 0, 1, node)
> +	devm_irq_alloc_descs(dev, -1, 1, 1, node)
>  
>  #define devm_irq_alloc_desc_at(dev, at, node)			\
>  	devm_irq_alloc_descs(dev, at, at, 1, node)
> 

