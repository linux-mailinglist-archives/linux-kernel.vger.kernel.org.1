Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB142280587
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbgJARgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:36:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0ECC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:36:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so3751385wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NY/d8Sdt044dx+t00rd3tTBrvBSb2aAmC1WWztjcgb8=;
        b=LzQn1QpilAXC6jk8ltTT8vSMmc/KILcnB4GylD5bDfBfqT5kHec4A/iL5a6wwGrXtV
         L1PSFzWhRLGogjYB1Q1hNlvYC/np3nfs66PKuSX4YfS+j+g2YEY9xpbRn4WT1JLRY+Dt
         6S5gc7RLjxm4wFj5Z/phcKmafb/HRlXZtVP/2X0uN9yjH/QEOl7e+jEIA3+RJ2gmAckz
         J4Cmk7mx8R+Q9mp7kA8I349scql1YhCwVWSfc4Oej2FFzcEcaJPQNbOAoIYnCLIZKkPW
         +jOY8J7gZan5MZN7lOhqzNFvbA+U8rPqUGI+YH5+aJ/Ml1Jj6rR/0rBjMAxC8UpWfnhz
         xvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NY/d8Sdt044dx+t00rd3tTBrvBSb2aAmC1WWztjcgb8=;
        b=FVkdYXJp9vp3upwdwuW2zROeytu6HS6l0qYarFtrDUEZICr5wRsSP93y1okkIcBLaP
         jxrfwB39vTw8/SSGoxQHZ66XvuG2H+EDTRTXJUegrSlTQBN2XbFEGAR7kbUlDMNAeG57
         7gi+8qjgraqa/F+UOAVtM5SnALERnWgwxuaQ8ZHa4jK7OMFF8OcTErbApq1iZ89FZdf2
         tlpitri82LhLJdH6ssfuuK/rqMpRcDY44WVx2deg8Kfvl1wb5Z77A9LbIjF0nLC+ZjSu
         1WWeAAreLmPoEulduSiF/m+5d8cIOweTU63DYoxz7HNSODKstNVlrsWhamT8w1U/2o2W
         Qqrg==
X-Gm-Message-State: AOAM5335n8r49dd4TVvq3U8r7ghxNZJrKf+tF+4qy/lydWTRkPeBXAfk
        Ip0n+Knp0DRI7mnW9kFJvvj+Gw==
X-Google-Smtp-Source: ABdhPJwoYdOfoipfiJNFKeUJCI8q2L41SWWUFSlJ1KnAPxo2kuy7YzbPEywCte8hxC51CAfcPBZWJg==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr1144534wmb.22.1601573800505;
        Thu, 01 Oct 2020 10:36:40 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id b126sm1015691wmd.16.2020.10.01.10.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:36:39 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:36:34 +0200
From:   elver@google.com
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
Subject: Re: [PATCH v3 10/39] kasan: rename report and tags files
Message-ID: <20201001173634.GH4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <da4fc136c8cb6a44200dbe5bff4908f8c3835ceb.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da4fc136c8cb6a44200dbe5bff4908f8c3835ceb.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> Rename generic_report.c to report_generic.c and tags_report.c to
> report_sw_tags.c, as their content is more relevant to report.c file.
> Also rename tags.c to sw_tags.c to better reflect that this file contains
> code for software tag-based mode.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: If77d21f655d52ef3e58c4c37fd6621a07f505f18
> ---
>  mm/kasan/Makefile                               | 16 ++++++++--------
>  mm/kasan/report.c                               |  2 +-
>  mm/kasan/{generic_report.c => report_generic.c} |  0
>  mm/kasan/{tags_report.c => report_sw_tags.c}    |  0
>  mm/kasan/{tags.c => sw_tags.c}                  |  0
>  5 files changed, 9 insertions(+), 9 deletions(-)
>  rename mm/kasan/{generic_report.c => report_generic.c} (100%)
>  rename mm/kasan/{tags_report.c => report_sw_tags.c} (100%)
>  rename mm/kasan/{tags.c => sw_tags.c} (100%)
> 
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 7cc1031e1ef8..f1d68a34f3c9 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -6,13 +6,13 @@ KCOV_INSTRUMENT := n
>  # Disable ftrace to avoid recursion.
>  CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_generic.o = $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_generic_report.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_quarantine.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_report_generic.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_report_sw_tags.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_shadow.o = $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_sw_tags.o = $(CC_FLAGS_FTRACE)
>  
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
>  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
> @@ -23,14 +23,14 @@ CC_FLAGS_KASAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
>  
>  CFLAGS_common.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
> -CFLAGS_generic_report.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_init.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_report_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_report_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
> -CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
> -CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  
>  obj-$(CONFIG_KASAN) := common.o report.o
> -obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o generic_report.o shadow.o quarantine.o
> -obj-$(CONFIG_KASAN_SW_TAGS) += init.o shadow.o tags.o tags_report.o
> +obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
> +obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index fc487ba83931..5961dbfba080 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * This file contains common generic and tag-based KASAN error reporting code.
> + * This file contains common KASAN error reporting code.
>   *
>   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>   * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> diff --git a/mm/kasan/generic_report.c b/mm/kasan/report_generic.c
> similarity index 100%
> rename from mm/kasan/generic_report.c
> rename to mm/kasan/report_generic.c
> diff --git a/mm/kasan/tags_report.c b/mm/kasan/report_sw_tags.c
> similarity index 100%
> rename from mm/kasan/tags_report.c
> rename to mm/kasan/report_sw_tags.c
> diff --git a/mm/kasan/tags.c b/mm/kasan/sw_tags.c
> similarity index 100%
> rename from mm/kasan/tags.c
> rename to mm/kasan/sw_tags.c
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
