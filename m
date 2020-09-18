Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D875A26FAD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIRKrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRKq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:46:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CE6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:46:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so5059087wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QHJwfG6F4o4CDJIq3QihHGujfsirLPtmR49z41IlzGM=;
        b=GCp5nQJsngEU7CqhOSgeVeimfPACWUqBt1LffHhGAhS/1zxnqeAVa4HyswDnKVafjc
         LcOsFs75LdO+ayoBH4Cqlnez9CdpfLecVbqD3pYkANMG1cMxdHTsby2uZGVXIoeaDEAR
         UKBLLX5PxKq4MDMK7Pb5LqCTmkDbQq0O+DFCJLod0K9Pgj8Hx0/SeGS/gsZEMYghV8mL
         WjmHa2CguvnM78D7wz6RaDxOV4leyY4jtiNB4qrTNsermGjvXFBXEZlUaqzuFnsD2BTd
         4pZnPDJuKvk409QUo110TgepQoGFwW76wa5Ox2yAPwKlzdhnKEIp74z0oga2K1h4+3w2
         yMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QHJwfG6F4o4CDJIq3QihHGujfsirLPtmR49z41IlzGM=;
        b=sX7/G/BNjIH7GNya4qDwuVE7yYh6j8oRJPOkCwHzmtOy/JwcI5eU5rtW5hHBK30P1T
         i/T/jU23dCjLDxJJ8Mq8mON5naFnOl2NwMAPuRVlCS3ZRMYmwP+lx+MRixMs939hzGAf
         6HGvFiDv9L8NF3Me4Qg712l8CzEGja0G60Kj+wuoDHP+V2E/XFl6snjFFJqDcgQDAmsJ
         MyfdTyQV+wiTvW+aNTd+KUDRLUu6lpyG79ySuqrIKHXg8H8cTrf915SoZxvRNDE6q7WU
         dr2hAokqj3pWPoS7ABUKOmSv9LL89Cn/QfAuejmqWctyq78j5vfX6MenjCXfh/rOYN80
         uQzQ==
X-Gm-Message-State: AOAM531zcqI3Qtt6G1ucTyQ3DM+YsleePaYaI8mdmezHCOrS450EKEDY
        yg1VYEyEWJ5Vmb6oVogXuJvghQ==
X-Google-Smtp-Source: ABdhPJyAec62/MhHDgU9436e4r2tCBgX1RyhPIH/sMguzyT2/d+Y8t/P8XtIMeWU0KmORGk45uH90w==
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr14738241wmc.21.1600426016909;
        Fri, 18 Sep 2020 03:46:56 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id u17sm4317615wmm.4.2020.09.18.03.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:46:56 -0700 (PDT)
Date:   Fri, 18 Sep 2020 12:46:50 +0200
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 33/37] kasan, arm64: implement HW_TAGS runtime
Message-ID: <20200918104650.GA2384246@elver.google.com>
References: <cover.1600204505.git.andreyknvl@google.com>
 <74133d1a57c47cb8fec791dd5d1e6417b0579fc3.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74133d1a57c47cb8fec791dd5d1e6417b0579fc3.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
[...]
>  arch/arm64/include/asm/memory.h   |  4 +-
>  arch/arm64/kernel/setup.c         |  1 -
>  include/linux/kasan.h             |  6 +--
>  include/linux/mm.h                |  2 +-
>  include/linux/page-flags-layout.h |  2 +-
>  mm/kasan/Makefile                 |  5 ++
>  mm/kasan/common.c                 | 14 +++---
>  mm/kasan/kasan.h                  | 17 +++++--
>  mm/kasan/report_tags_hw.c         | 47 +++++++++++++++++++
>  mm/kasan/report_tags_sw.c         |  2 +-
>  mm/kasan/shadow.c                 |  2 +-
>  mm/kasan/tags_hw.c                | 78 +++++++++++++++++++++++++++++++
>  mm/kasan/tags_sw.c                |  2 +-
>  13 files changed, 162 insertions(+), 20 deletions(-)
>  create mode 100644 mm/kasan/report_tags_hw.c
>  create mode 100644 mm/kasan/tags_hw.c
[...]
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 77c4c9bad1b8..5985be8af2c6 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -358,7 +358,6 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	smp_init_cpus();
>  	smp_build_mpidr_hash();
>  
> -	/* Init percpu seeds for random tags after cpus are set up. */

Why was the comment removed and not updated?

>  	kasan_init_tags();
>  
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
