Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19782E9444
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbhADLpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:45:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbhADLpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609760663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pPiMxxoNkQ6ZHTSM1btO2xUPHHtV2xXd0B6j0p3+I7w=;
        b=hHxtKWnaqXTBxa+zi22DwnyaLF3oCoiXLQr1ZxXbzAG20ahd27gqtT/NdGhL8uV+iGO8Ap
        Kn+RmTDpMDb0d1+PzV4A9gVWMBh4iTE4Hck4Ijq1qTc+hCgTbTUzHnGGpgQBZxDwNo3ZGA
        B4En24Sk4MS8WyhWLYQ1L4UQ8pGmErM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-sc5XHAxtN_Ok0xSCmIWLbg-1; Mon, 04 Jan 2021 06:44:21 -0500
X-MC-Unique: sc5XHAxtN_Ok0xSCmIWLbg-1
Received: by mail-ed1-f69.google.com with SMTP id f19so12040876edq.20
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 03:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pPiMxxoNkQ6ZHTSM1btO2xUPHHtV2xXd0B6j0p3+I7w=;
        b=o9xK2DT5P2MDpQlw7ugyqULCqLwID8XJO1QD16aHg2Cm0xGalAQN2ksIoyDSUtYMv/
         aDo4YVemipizko+3G5d93kdM1ewrW8sOunf0WkUZn32UpChqmlqKvNPwjKpctWjIsqli
         GeBCw6cQ2nK7dqGnfBAko9xH14MpewL0bYw4qS2NjpxYk9oGRMWiAQfUdhXpsGjwtC4s
         ayNHxyFLPB8AOlaygrtVJEe1/HMvnq4nFHPAd9mp5mMJ4cLlskrHT6oQtHYOM8Xs0Wur
         rbGDpk7ufrrmromHbE8tMLT+sSZm6HbyxSDsD80i3iEds4eWplS92dVEZ7RHrIx4UdEu
         PBKQ==
X-Gm-Message-State: AOAM532/Zn/Jnizm3BMXSYS4o20ipEHG4HGfWnvYQbFC3Idue7Bl98hL
        EpjkudmlQ6HqEm2YBnql7B8ALeOkuFwswn5aRO1kp2UauWL8ItyG9CaCz3hFgOrAZ3LUmNlgGKI
        IvlkHx0PO5pGYwzxYcpcvddQb
X-Received: by 2002:a17:906:17d5:: with SMTP id u21mr50809905eje.109.1609760660572;
        Mon, 04 Jan 2021 03:44:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwS5cFYXDS2dnZf/FPMSarPHzP6kT1MrfLii3KZrmVND8GnmkwWpEQnJCsg3HblC8jkUnrzgQ==
X-Received: by 2002:a17:906:17d5:: with SMTP id u21mr50809891eje.109.1609760660434;
        Mon, 04 Jan 2021 03:44:20 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id ho34sm23097652ejc.13.2021.01.04.03.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 03:44:19 -0800 (PST)
Subject: Re: [PATCH v2 -next] platform: surface: fix non-PM_SLEEP build
 warnings
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org
References: <20201214233336.19782-1-rdunlap@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e85b0067-6128-b078-d9b4-843f5b2c1a54@redhat.com>
Date:   Mon, 4 Jan 2021 12:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201214233336.19782-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/15/20 12:33 AM, Randy Dunlap wrote:
> Fix build warnings when CONFIG_PM_SLEEP is not enabled and these
> functions are not used:
> 
> ../drivers/platform/surface/surface_gpe.c:189:12: warning: ‘surface_gpe_resume’ defined but not used [-Wunused-function]
>  static int surface_gpe_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~
> ../drivers/platform/surface/surface_gpe.c:184:12: warning: ‘surface_gpe_suspend’ defined but not used [-Wunused-function]
>  static int surface_gpe_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~
> 
> Fixes: 274335f1c557 ("platform/surface: Add Driver to set up lid GPEs on MS Surface device")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: platform-driver-x86@vger.kernel.org
> ---
> v2: dropped Maximilian's RVB tag since the patch changed
>     use preferred __maybe_unused instead of ifdeffery:
>       https://lore.kernel.org/patchwork/patch/732981/


Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> 
>  drivers/platform/surface/surface_gpe.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20201214.orig/drivers/platform/surface/surface_gpe.c
> +++ linux-next-20201214/drivers/platform/surface/surface_gpe.c
> @@ -181,12 +181,12 @@ static int surface_lid_enable_wakeup(str
>  	return 0;
>  }
>  
> -static int surface_gpe_suspend(struct device *dev)
> +static int __maybe_unused surface_gpe_suspend(struct device *dev)
>  {
>  	return surface_lid_enable_wakeup(dev, true);
>  }
>  
> -static int surface_gpe_resume(struct device *dev)
> +static int __maybe_unused surface_gpe_resume(struct device *dev)
>  {
>  	return surface_lid_enable_wakeup(dev, false);
>  }
> 

