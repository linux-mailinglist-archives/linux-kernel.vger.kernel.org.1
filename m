Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E282804FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbgJARSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:18:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79ABC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:18:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t17so3959585wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AMM+i1pr6nkLHNqAVkSTj1TPYNn/WMfQYxPOkfPrgTg=;
        b=EJ6ylxnq7uuKTHBre72m1k8m5q+Wvs0aF3mB7xzpCyDDFmfElkUuE08xbVmo19l90g
         mq7EnALRp3Hpq867ahM8+emMvpPl4vmjzvsRXff6s/RN+Av4+CaRnBrTjb1mQLIRu8JW
         +TLtR119dKVOJwXs2Y1Q+ojskn1QHEC/14B1aPJtOPQ9XMe7ieOdrYxW/kWOTXU5pDST
         8D7Fx0epswtgP7y/AbAtUmpDkXLRX/bRooLRkbpvnBWTutj6KbFC5eIZwJ14LfYoYTuT
         Yq2p04AkTbFyPHzjJoR6TM30RxHjezjMN/wln/JVBWayI2QTUgqN0l698qgF3SVEmuzP
         KFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AMM+i1pr6nkLHNqAVkSTj1TPYNn/WMfQYxPOkfPrgTg=;
        b=YBeyrbJ1ZNxp+9Ians9HOIJfaiq9QFMTC0A2+osvXXC5i6tMUFBHuZA2QHBsOOWL4f
         tsTJhHpDcM52YIapkHdcIn5av/POdnyPBO5pcgqtRVLTijj2lDGDIuIzoPEnI9RODEoS
         mEqII9vwPlLZgdKa5ek0QK6q1OL/UqpF543uaZhEQT7MqSc/GdvkzHA8cDv8oW/iWn0S
         4a7HZzJ+xySqt/IIzA90GlylMPKnWEGOnjztkgIAjxJYwaWnt6+Q76JmFUulWpiZmGoL
         uQhJChrD66ixFSe0Po7GhuT2v3RL4AyyeIhFmy4sEzggUNGX3it70EHNJPKBZbVgkzBi
         oFXg==
X-Gm-Message-State: AOAM532HFCQiDHUWqqm6ze+9fpOyLyIbFJ2R+VKgwZdqlqcMyrcOk6N3
        Fz5Zr+Jd5SMooZFwW/2Gbaks2g==
X-Google-Smtp-Source: ABdhPJy0jR9bw4XhpbxddirNhhWvtaqG1IfvuGxxf+VbG28DC3MfehN2u54brbv5Pq1JA3Vs0tUKuQ==
X-Received: by 2002:a1c:e48b:: with SMTP id b133mr1068332wmh.0.1601572724362;
        Thu, 01 Oct 2020 10:18:44 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id x2sm10076139wrl.13.2020.10.01.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:18:43 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:18:36 +0200
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
Subject: Re: [PATCH v3 01/39] kasan: drop unnecessary GPL text from comment
 headers
Message-ID: <20201001171836.GA4156371@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <56eae03b7b8112b5456632f0c00bd42e7337966c.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56eae03b7b8112b5456632f0c00bd42e7337966c.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> Don't mention "GNU General Public License version 2" text explicitly,
> as it's already covered by the SPDX-License-Identifier.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: If0a2690042a2aa0fca70cea601ae9aabe72fa233
> ---
>  mm/kasan/common.c         |  5 -----
>  mm/kasan/generic.c        |  5 -----
>  mm/kasan/generic_report.c |  5 -----
>  mm/kasan/init.c           |  5 -----
>  mm/kasan/quarantine.c     | 10 ----------
>  mm/kasan/report.c         |  5 -----
>  mm/kasan/tags.c           |  5 -----
>  mm/kasan/tags_report.c    |  5 -----
>  8 files changed, 45 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 950fd372a07e..33d863f55db1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -7,11 +7,6 @@
>   *
>   * Some code borrowed from https://github.com/xairy/kasan-prototype by
>   *        Andrey Konovalov <andreyknvl@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>  
>  #include <linux/export.h>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 248264b9cb76..37ccfadd3263 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -7,11 +7,6 @@
>   *
>   * Some code borrowed from https://github.com/xairy/kasan-prototype by
>   *        Andrey Konovalov <andreyknvl@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> index a38c7a9e192a..6bb3f66992df 100644
> --- a/mm/kasan/generic_report.c
> +++ b/mm/kasan/generic_report.c
> @@ -7,11 +7,6 @@
>   *
>   * Some code borrowed from https://github.com/xairy/kasan-prototype by
>   *        Andrey Konovalov <andreyknvl@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>  
>  #include <linux/bitops.h>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index fe6be0be1f76..9ce8cc5b8621 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -4,11 +4,6 @@
>   *
>   * Copyright (c) 2015 Samsung Electronics Co., Ltd.
>   * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>  
>  #include <linux/memblock.h>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 4c5375810449..580ff5610fc1 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -6,16 +6,6 @@
>   * Copyright (C) 2016 Google, Inc.
>   *
>   * Based on code by Dmitry Chernenkov.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
>   */
>  
>  #include <linux/gfp.h>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 4f49fa6cd1aa..c3031b4b4591 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -7,11 +7,6 @@
>   *
>   * Some code borrowed from https://github.com/xairy/kasan-prototype by
>   *        Andrey Konovalov <andreyknvl@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>  
>  #include <linux/bitops.h>
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index e02a36a51f42..5c8b08a25715 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -4,11 +4,6 @@
>   *
>   * Copyright (c) 2018 Google, Inc.
>   * Author: Andrey Konovalov <andreyknvl@google.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
> index bee43717d6f0..5f183501b871 100644
> --- a/mm/kasan/tags_report.c
> +++ b/mm/kasan/tags_report.c
> @@ -7,11 +7,6 @@
>   *
>   * Some code borrowed from https://github.com/xairy/kasan-prototype by
>   *        Andrey Konovalov <andreyknvl@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>  
>  #include <linux/bitops.h>
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
