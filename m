Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563982DB4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgLOT4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgLOT4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:56:37 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05DC06179C;
        Tue, 15 Dec 2020 11:55:56 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id n26so29458972eju.6;
        Tue, 15 Dec 2020 11:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hgbpczhIgWcJ9kOmJE2lzKhI3+pU/J6Ah3rCJFwnT/Y=;
        b=IqwmJpwZ5jYDClMOQqOWIPApxnNEK2fsdac6O5WqsZx8sFJU1gwBYMHKPrzInF7drE
         jfQPwixTKwA1kyv2nBnj6h9LZ4kEdQlCfw1BEsgMV0pbc1o/DUNbcS0zSk2EdZWLf6Gk
         NOvu+0/KycCPMjPf4hyZOdKNw7TK3c8HH+HQIIx/IJlXjQerv+3cX9/s7qW/qxxl232b
         U/encgjr3nvds77wreBOHfdmmHoTMmuUGI1JeliaGzArTloFrp0QMX4YYhtzTSZxnUhA
         Pv0O4m3DMy7IdQMAUcUwaC8ZEwuLEEZrSHm81yRGN+t6nC/1cBZZXYBUjiWtbEtWoqmD
         LgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hgbpczhIgWcJ9kOmJE2lzKhI3+pU/J6Ah3rCJFwnT/Y=;
        b=Hrmy+C/8h3mOX+hFzdqbn4raWKloITFVckkCd+Kq2/wbByPCBpHYQMeVC1Du1zNTN1
         liJ6i8YX3kP8V+GfMDhj0V/A1iOM4to9X8qbEHW5YxQlojhXzBa8sQWV1v+epIZRFI+P
         pm6fXFl+7eK/XKCDPyRIyAayOrm32LAGbQhj3vy82a1r7Xgg5lzztSz9FhBmWg3XxkTA
         uLvuSls0AZdCg0keVix0Rrh1X+48OWZKybtHGrZxEZQNjQJ0Zh59800d6jh20yIPflrY
         E92NGT+vVzt9nGJTCjYa0SpjFk920awxd++jS0lN7rEHgsUp6tFUaKGwr3vxbuhFRXd7
         9j3A==
X-Gm-Message-State: AOAM5329UAH1FlOzmm/jiqU0xM1bN5UHRy7lOsctg5DTTaKtkRlyolN2
        CDj2YkW/GOvC6LAT2jPFUp7SDxlPESkXVw==
X-Google-Smtp-Source: ABdhPJxtMaw1aQXNeyC3jAQyljCTgGN2KiTagUSIRKg0rzT0SCXxyJXclp9JCDz8X23CnrmupFScYQ==
X-Received: by 2002:a17:906:7b8d:: with SMTP id s13mr28093936ejo.479.1608062154895;
        Tue, 15 Dec 2020 11:55:54 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a7aa.dip0.t-ipconnect.de. [217.229.167.170])
        by smtp.gmail.com with ESMTPSA id a6sm19209575edv.74.2020.12.15.11.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 11:55:53 -0800 (PST)
Subject: Re: [PATCH v2 -next] platform: surface: fix non-PM_SLEEP build
 warnings
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
References: <20201214233336.19782-1-rdunlap@infradead.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <5fd70f29-2795-5b46-4bc9-e60a26efee88@gmail.com>
Date:   Tue, 15 Dec 2020 20:55:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201214233336.19782-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/20 12:33 AM, Randy Dunlap wrote:
> Fix build warnings when CONFIG_PM_SLEEP is not enabled and these
> functions are not used:
> 
> ../drivers/platform/surface/surface_gpe.c:189:12: warning: ‘surface_gpe_resume’ defined but not used [-Wunused-function]
>   static int surface_gpe_resume(struct device *dev)
>              ^~~~~~~~~~~~~~~~~~
> ../drivers/platform/surface/surface_gpe.c:184:12: warning: ‘surface_gpe_suspend’ defined but not used [-Wunused-function]
>   static int surface_gpe_suspend(struct device *dev)
>              ^~~~~~~~~~~~~~~~~~~
> 
> Fixes: 274335f1c557 ("platform/surface: Add Driver to set up lid GPEs on MS Surface device")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: platform-driver-x86@vger.kernel.org
> ---
> v2: dropped Maximilian's RVB tag since the patch changed
>      use preferred __maybe_unused instead of ifdeffery:
>        https://lore.kernel.org/patchwork/patch/732981/
> 
>   drivers/platform/surface/surface_gpe.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20201214.orig/drivers/platform/surface/surface_gpe.c
> +++ linux-next-20201214/drivers/platform/surface/surface_gpe.c
> @@ -181,12 +181,12 @@ static int surface_lid_enable_wakeup(str
>   	return 0;
>   }
>   
> -static int surface_gpe_suspend(struct device *dev)
> +static int __maybe_unused surface_gpe_suspend(struct device *dev)
>   {
>   	return surface_lid_enable_wakeup(dev, true);
>   }
>   
> -static int surface_gpe_resume(struct device *dev)
> +static int __maybe_unused surface_gpe_resume(struct device *dev)
>   {
>   	return surface_lid_enable_wakeup(dev, false);
>   }
> 

Code looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

As already mentioned before, I'd prefer the subject line to be
"platform/surface: gpe: ...", or at least "platform/surface: ..." for
consistency with other commits. May just be a personal preference
though, so nothing that should prevent it from being applied.

Thanks,
Max
