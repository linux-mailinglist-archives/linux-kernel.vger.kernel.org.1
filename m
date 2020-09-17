Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A97626DB51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgIQMSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbgIQMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600344981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoisXRLqWddF3VDGVnR2urzq3JASfg0vD91MUOUDVZc=;
        b=FiBaSlUxqJXoYHziPUN2GfufGwTCkXAovg3ofxWvZQPxMwAdjD76owyPsHMwSv7sok+xu9
        gM4LN6xETnJfwPkqavwNSn44kolnnzXgbEBHirNckqVWTQmzbujkGF191e1cryXUjQB/IB
        lCtEb0rmuval67s/PUP+bl8M4Za8xvs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-TM6yvxTdNuyfYgVq1SXh-g-1; Thu, 17 Sep 2020 08:16:19 -0400
X-MC-Unique: TM6yvxTdNuyfYgVq1SXh-g-1
Received: by mail-ed1-f71.google.com with SMTP id c3so820834edm.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SoisXRLqWddF3VDGVnR2urzq3JASfg0vD91MUOUDVZc=;
        b=uXZPBWaCBG1+C8VS+1DRZ9HjfrWv1EGRv3XmGwlGRgYz3rDwLO2Eqg/g0uDPXpazp9
         2sCzRu4GI1j5Am/OgxzttWN/tyqKKBHxFaRbOI9IJm7wlv1cR2uOHqktDVFAMQxj0Llm
         Y5SVKbXESELc+EMaBw3UUiOtBp2hwGQ2TVtxqTVAVjltuO6rwz0mpQyM5npedbJ4fsoS
         rFihx7H6EnvhHEQ5Dj+hE8sUr+Y5o48bRumTl0dSHDsN6goMQdKICXchEWadZynv4FwJ
         +bQ3QvLQklWZdJCP7bG3x/BQ21M+dubg2rrjMrN2j1gy6QloYqZN4Dkx+SX84nan/863
         JerA==
X-Gm-Message-State: AOAM532otm6N3KHwwBIX7VWKbsc8b+kxwwO90SVpHO7VSTl2Ejx4nPDl
        Tma7mWSZvYRmWH1l89LkAoHEj2SdDQkakkTtNut7X1fN1vSHHpXo65ZfnqYc7qs6WbmkJbgr7un
        ZFnZH6kvksrh6AUHhXTimN7wQ
X-Received: by 2002:a17:906:5495:: with SMTP id r21mr29373385ejo.33.1600344978798;
        Thu, 17 Sep 2020 05:16:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwlxdseiRtGLbuvARReNI+oSg+5sWhq9w5x49k3FnbysMpp0+VSrVTqyupzwkRn/+IBhxQHQ==
X-Received: by 2002:a17:906:5495:: with SMTP id r21mr29373368ejo.33.1600344978632;
        Thu, 17 Sep 2020 05:16:18 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id n7sm14912134eji.13.2020.09.17.05.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 05:16:17 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: fix kconfig dependency warning for
 LG_LAPTOP
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>, andy@infradead.org
Cc:     matan@svgalib.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu
References: <20200915090922.16423-1-fazilyildiran@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ddb882a5-99f6-b726-d017-3d4c6a695e76@redhat.com>
Date:   Thu, 17 Sep 2020 14:16:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915090922.16423-1-fazilyildiran@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/20 11:09 AM, Necip Fazil Yildiran wrote:
> When LG_LAPTOP is enabled and NEW_LEDS is disabled, it results in the
> following Kbuild warning:
> 
> WARNING: unmet direct dependencies detected for LEDS_CLASS
>    Depends on [n]: NEW_LEDS [=n]
>    Selected by [y]:
>    - LG_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && ACPI_WMI [=y] && INPUT [=y]
> 
> The reason is that LG_LAPTOP selects LEDS_CLASS without depending on or
> selecting NEW_LEDS while LEDS_CLASS is subordinate to NEW_LEDS.
> 
> Honor the kconfig menu hierarchy to remove kconfig dependency warnings.
> 
> Fixes: dbf0c5a6b1f8 ("platform/x86: Add LG Gram laptop special features driver")
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>

Thnak you, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Note it seems that the FUJITSU_LAPTOP Kconfig symbol has the same
issue, can you submit a patch for that one too?

Regards,

Hans

> ---
>   drivers/platform/x86/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 40219bba6801..81f6079d08e6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1112,6 +1112,7 @@ config LG_LAPTOP
>   	depends on ACPI_WMI
>   	depends on INPUT
>   	select INPUT_SPARSEKMAP
> +	select NEW_LEDS
>   	select LEDS_CLASS
>   	help
>   	 This driver adds support for hotkeys as well as control of keyboard
> 

