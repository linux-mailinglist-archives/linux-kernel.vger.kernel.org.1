Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1921A280543
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbgJARbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbgJARbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:31:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C407BC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:31:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so6733161wrn.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9y69t8F5YRXIJmWOKtKIVuW0N+iZ5Wjjkop2pJOmrWw=;
        b=S2VPvy+yfX7lCSe6hY72G+aYpAZ71nHXTRZOCRdmOwXH1Y4rJ0qu6iEq438XvChkkF
         ZP1bBV+mymfkBLckANuLFCz1fAf3BfuChLnTX+EvoYY6PBuXKc+fN/YEU7dmSfsefK6z
         ADZoH3mIJyXye3U53R4dfkTthLEIxEEbtOMyMKTBusTmWLuo9PQlO0D83jQ9tKnqsiCZ
         jVFZlElWPHdM59CSMPox6HBlTkBHQK3M3bONDVDxxVoYDVqpQhnJ4LxoaLdYgdb9md0N
         vLW7e0UcqlKmfoMUWOIjJgpqetZcjIKrlUpRuhu4doLx9xLQv8DePZYqt6Hnv4bOvQjp
         W1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9y69t8F5YRXIJmWOKtKIVuW0N+iZ5Wjjkop2pJOmrWw=;
        b=KkxiDnlpBSAn1Zv2G5Ip7owAg7/bGFl8OsPrE37XJNoJIKoCuD6FlEbj02ycXntnNN
         yREaHIqM7EOWyzPMEgMx6Tj0TCP9pVk+D9VXKX5Pq3E6RJj+m/5B2J1fiqB7NpxO6m6f
         Uogw5dMa7CwtMaRAKjbzDFp9Xnt83NZ1GpPQONrD8SeEHvmu4rPLyPQz7o5iWb4kR4qc
         7RW1QXFOR0eTr1XboR3MvOfjZsIaKWdezLmq86P7llLXIfMqKI2o2h8Jvi7TrorUThFi
         WdJhMltbvT7AVGUtlCblysL9Y/UTY9dlJ+HufzIjJie5rhe/IlwzwWCSXr8e9/e2mspx
         Z5xQ==
X-Gm-Message-State: AOAM530yBYlD8LV8gmnh69fd2iVLHhj/AGi590YxcSuODeOvKqkgUMbL
        +DMIh81SJakg7cn3UHCq8CHV1Q==
X-Google-Smtp-Source: ABdhPJzkxPq4EcGJtwVIc6ITsszbvZgR21dP/f/x0nsDSirU1V+SInvO6OVxupSKTyKdt9Ygm/qIBw==
X-Received: by 2002:adf:de11:: with SMTP id b17mr10148567wrm.82.1601573494286;
        Thu, 01 Oct 2020 10:31:34 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id j14sm10670513wrr.66.2020.10.01.10.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:31:33 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:31:27 +0200
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
Subject: Re: [PATCH v3 07/39] kasan: only build init.c for software modes
Message-ID: <20201001173127.GE4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <3ecf44f226dac37eb35409dc78568a99343fbf9e.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ecf44f226dac37eb35409dc78568a99343fbf9e.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> The new mode won't be using shadow memory, so only build init.c that
> contains shadow initialization code for software modes.
> 
> No functional changes for software modes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I8d68c47345afc1dbedadde738f34a874dcae5080
> ---
>  mm/kasan/Makefile | 6 +++---
>  mm/kasan/init.c   | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 370d970e5ab5..7cf685bb51bd 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -29,6 +29,6 @@ CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
>  
> -obj-$(CONFIG_KASAN) := common.o init.o report.o
> -obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
> -obj-$(CONFIG_KASAN_SW_TAGS) += tags.o tags_report.o
> +obj-$(CONFIG_KASAN) := common.o report.o
> +obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o generic_report.o quarantine.o
> +obj-$(CONFIG_KASAN_SW_TAGS) += init.o tags.o tags_report.o
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index dfddd6c39fe6..1a71eaa8c5f9 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * This file contains some kasan initialization code.
> + * This file contains KASAN shadow initialization code.
>   *
>   * Copyright (c) 2015 Samsung Electronics Co., Ltd.
>   * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
