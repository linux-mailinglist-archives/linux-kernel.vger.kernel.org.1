Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DC8293F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgJTP21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731319AbgJTP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:28:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23958C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 08:28:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a72so2222524wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Uni4zU2UKq83r3GssjKIzqKjG0Dp20lSmVCKXMSU8kM=;
        b=nozQxSm8nIYAYkI27iZ/rdaOTggYEMik8PvvYYJ8mB2YwC3yotFQs6IvxosEXi5rkG
         hQzJQDdkzwQIQ5G411496IXZ6k0kCnUPOg4kGPDy29+RvsogwkrQfekFEH4tSX7VEfky
         aZZZS0vdg87DzaSG11NYZoxPz2iho6R3M/UW/iROR4cmE+9FXdaQj4ArDFY5yjQcL84s
         Wj2xFOSUVhWWChyb3G/lwt0aY97YpFY7qJ3Z4vCB2Odm+W0vhLu/fiZOt1CIeoRgOYBQ
         TyX3yPYBD8CteAmiChWok1jlWeXxjYUOUlHeKYg44u+oTS+7ogJOBn8IfnSFPcT1cJOt
         FOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Uni4zU2UKq83r3GssjKIzqKjG0Dp20lSmVCKXMSU8kM=;
        b=HcuRfYTZVf84wADQhmezF/JxdGQYK9qqFy9xjFsnTP3yLzmbIO4dh12o85DAHTWrvr
         +CXy0l+SbkhFV//QVwNW4MJ5qsuUkDG5Did8/mCmO1Rz3SPaBPOWUmD0RGPlQgTuHsgL
         C52g5H3dp02XC0gVGjqYp7AJxvjtGfb5A9YTtX61rIM4cZftA5XRCUD/ETE81xB5ljdN
         YiZL6gAcUhquZz920lF28rgXtbIPesnFC+iDidbUPTq+aXo28+YcyIFCj0Tzct82WC65
         bzuN67UIZgxZR9aId6wOtwjUD/luVU1Ul2fPqNSebvnRDHKGHqN2z0183LuA+lS2kexm
         raWw==
X-Gm-Message-State: AOAM532FBtSFwz1Cezicler2aSMpkYgz3c0v5Ptv7PAwq888oJLH/Vsa
        IsmWdmYQc/DCnXMKyN8ppMok3g==
X-Google-Smtp-Source: ABdhPJwogFQKebYSRpB5PhLi5QRgWT6BJZxuYP49ltOyGEszk0WxYbYVl7uKMV8tweFiKjYhTLJIFg==
X-Received: by 2002:a1c:cc:: with SMTP id 195mr2068187wma.52.1603207703778;
        Tue, 20 Oct 2020 08:28:23 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id s1sm2943781wmh.22.2020.10.20.08.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:28:23 -0700 (PDT)
References: <20201020075034.172825-1-jbrunet@baylibre.com> <7hblgxkki3.fsf@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: meson: ship only the necessary clock controllers
In-reply-to: <7hblgxkki3.fsf@baylibre.com>
Date:   Tue, 20 Oct 2020 17:28:22 +0200
Message-ID: <1jimb4nch5.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 20 Oct 2020 at 17:03, Kevin Hilman <khilman@baylibre.com> wrote:

> Jerome Brunet <jbrunet@baylibre.com> writes:
>
>> There now the menu entries for the amlogic clock controllers.
>> Do not select these when ARM64 is enabled so it possible to ship only the
>> required.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm64/Kconfig.platforms | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index cd58f8495c45..b22d1bdd6eb6 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -154,9 +154,6 @@ config ARCH_MESON
>>  	bool "Amlogic Platforms"
>>  	select PINCTRL
>>  	select PINCTRL_MESON
>> -	select COMMON_CLK_GXBB
>> -	select COMMON_CLK_AXG
>> -	select COMMON_CLK_G12A
>
> This patch alone will break boot when using the default, upstream
> defconfig because these options will all now be disabled and we'll have
> no clock providers.
>
> I think you also need a default value (e.g. `default y`) in
> drivers/clk/meson/Kconfig for each of these entries to keep the same
> defaults.   But these defaults could be overridden by SoC-specific
> defconfigs leading to more flexibilty.
>
> So, assuming you queue up a drivers/clk patch to go in when this
> lands...

Indeed.
Please wait till the clock PR lands during the merge window, you'll see
that it is already taken care of.

I was not expecting you to look at it so soon ;)

>
> Acked-by: Kevin Hilman <khilman@baylibre.com>

