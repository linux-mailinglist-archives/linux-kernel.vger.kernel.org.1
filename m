Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2B2D7FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404738AbgLKUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391314AbgLKUYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:24:05 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76AC0613CF;
        Fri, 11 Dec 2020 12:23:25 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d3so8557438wmb.4;
        Fri, 11 Dec 2020 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9nnnWY6Cv1HMP5rItObgN0uMtCD8ZN5Mm5DFgwbY0m8=;
        b=d4blJ14dKzGvpdne61L4L3j5c8V29B/Eay1MN8TFIbJ/tu1cINAqdVrhHyAt1Sb7+O
         fT/nKJheUPwLlyG6O5fblU/joCKchKjoF1RKcsq5eXBn3TqcHa/dcHNv657lzX4i1GFm
         cIgI0s2krlK0QHbuj6fyE+FMyJQH7R7xyUYdkcetCC5I8GJ9Mlr8bonIhXKx7MTJAFr5
         VUQ5ZIA60PwjjiI5KVhtiRLTW8MVj4nefP6ohusqt1UobVBTJU3gQRIQvXW2OpWiiSCM
         UBdSjYZ8Ru7au4poS6Al/0ao9HJCwHGSuUx6XpzM04GG8eOdEM9YJIO0fPRlXh4g+7nO
         hOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9nnnWY6Cv1HMP5rItObgN0uMtCD8ZN5Mm5DFgwbY0m8=;
        b=g+qgl7On0KHrSdN0XXpYjFEei2q6zcLlXDbJ4vm4eLetkh+Uc0MyKN3BZGE5G1mTbC
         Qksa8DdwiAwQ+R0tb8OXPNnMKc2a8BMAl1Gv9HdbW5BFtM+SbGWDVoNGsvFu34twQSfj
         Zn/qT+8qGQfKxCIBxRllymIvt+G4fba70jCf4er/P0/LDiCr0UXUuWbjUJjz/xugWQEh
         85LgaODQ84NS+OFnC9nGz7ncUt8dxgO/b7tyzg4PzxiksjtuYthZgVLdkjy+HkqyUjQn
         H0o+VtLIF8wRCU3f72TD8/NHhHpG69CXLyUJjM3IeSrQAZesjroinek+V9oOPc8t3frb
         kJqw==
X-Gm-Message-State: AOAM532td2VIf7rW5vRbInIwQdC725fmxA+UW4ctNtQovjs+ofyr2ajP
        iFQGbPIhipP54dGnkhUuYuPfvtOqdXo=
X-Google-Smtp-Source: ABdhPJyWY27SrDWF63KiE/7gZ1K0CX5oa+VZAp+79eWVc/0LL3tsZ1rbtqaN0mKuU3ELXYFaWQ/grg==
X-Received: by 2002:a1c:7217:: with SMTP id n23mr14926639wmc.167.1607718203903;
        Fri, 11 Dec 2020 12:23:23 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a2a8.dip0.t-ipconnect.de. [217.229.162.168])
        by smtp.gmail.com with ESMTPSA id a62sm17251743wmh.40.2020.12.11.12.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 12:23:22 -0800 (PST)
Subject: Re: [PATCH -next] platform: surface: fix non-PM_SLEEP build warnings
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
References: <20201211190335.16501-1-rdunlap@infradead.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <3705938f-6f82-88ef-455b-e0f7459989e3@gmail.com>
Date:   Fri, 11 Dec 2020 21:23:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201211190335.16501-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 8:03 PM, Randy Dunlap wrote:
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
>   drivers/platform/surface/surface_gpe.c |    2 ++
>   1 file changed, 2 insertions(+)
> 
> --- linux-next-20201210.orig/drivers/platform/surface/surface_gpe.c
> +++ linux-next-20201210/drivers/platform/surface/surface_gpe.c
> @@ -181,6 +181,7 @@ static int surface_lid_enable_wakeup(str
>   	return 0;
>   }
>   
> +#ifdef CONFIG_PM_SLEEP
>   static int surface_gpe_suspend(struct device *dev)
>   {
>   	return surface_lid_enable_wakeup(dev, true);
> @@ -190,6 +191,7 @@ static int surface_gpe_resume(struct dev
>   {
>   	return surface_lid_enable_wakeup(dev, false);
>   }
> +#endif
>   
>   static SIMPLE_DEV_PM_OPS(surface_gpe_pm, surface_gpe_suspend, surface_gpe_resume);
>   
> 

Right, thanks.

I assume this covers all instances of this warning in platform/surface?
Otherwise, a "platform: surface: gpe: ..." subject would make more sense.

As for the rest:

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

Regards,
Max
