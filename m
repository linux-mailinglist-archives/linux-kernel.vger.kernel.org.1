Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2C72AFC62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgKLBf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgKKX1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:27:21 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E5EC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 15:27:21 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k2so4169504wrx.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 15:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WFixHAIkrgBx9SA97GwMYqSCYai8tNFPN/kssmEk0o0=;
        b=A/0yIMdiNF8p93t02fcd4+t9Grr2gNxUpyKTbL1FB8LsS8bGALDkBNJcBvtKaA5yOG
         Zd6UuuPqMX0BWJJ4+PQOHgfOAqkL81HJWHCXWWWGEUkSHARoZq5hpW3qMorjA0kGVhk2
         bWiyNPORqejVX+FQd76EZblljwTmq9WaLMMorN/PkGMyl4TCCSNwxA+MeOw+Oq4BZyrU
         zsk74XvCoLTUHukaVgES3BpVCsaqpQRrkzY/6XQwV/10Yg9aJAlwKs7XtrxfkFSgQa58
         nWYExiygmnqwhf4MKbDfhSAmEEQhcHTk6MXT7f9PWXpeBM/orvfuC1wSIjBxKuGx1TzV
         /pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WFixHAIkrgBx9SA97GwMYqSCYai8tNFPN/kssmEk0o0=;
        b=i4UAIGfLG/gfOlNVxyp3ZcdDqZilWt5jieX+n7D3xrcYX/8t+ofngQa1DkkqLQrD/v
         e3IH4mokIOWXVnEXi8fJL+piuPjbVktJgRcgPHES1WzY151z7LOcmK49QvbUsyRVyqQ0
         1wnhudhdrPffwP4z98L1H3g2jlWuAeBwIHCG1i4GiKwzI9DVmdr5UNgCSkZbYs/Mqm54
         mMrosao23wTR6oHiNF9TyF+xqaXlL0iMqn8bWf5y3rn4v/MoNa1NrOZqWnUe1+5Sk0b/
         cIj3/OrD7B4n2XyhYXw11zq5gqg+GIHew2idMAV5+tXg6nXV2oazRRz+BdUt4JIJoOL0
         yMJw==
X-Gm-Message-State: AOAM532c+z5WUJGtcU3EnkHiX0yKxIhS4X28jcTLHLc2qxoF0tejmOk3
        TNCgINQPusHAO25ZinoiI7X10w==
X-Google-Smtp-Source: ABdhPJw6ksV/O2t8hl1ZAOb71lGfaA2WesPVswzx3IZTWdGrdDHO3revgaUrYCtvpuo6ZzKmqov2ow==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr1269889wrn.212.1605137239653;
        Wed, 11 Nov 2020 15:27:19 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id n123sm4187814wmn.38.2020.11.11.15.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:27:18 -0800 (PST)
Date:   Thu, 12 Nov 2020 00:27:13 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/20] kasan, mm: allow cache merging with no metadata
Message-ID: <20201111232713.GA1244863@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <936c0c198145b663e031527c49a6895bd21ac3a0.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <936c0c198145b663e031527c49a6895bd21ac3a0.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> The reason cache merging is disabled with KASAN is because KASAN puts its
> metadata right after the allocated object. When the merged caches have
> slightly different sizes, the metadata ends up in different places, which
> KASAN doesn't support.
> 
> It might be possible to adjust the metadata allocation algorithm and make
> it friendly to the cache merging code. Instead this change takes a simpler
> approach and allows merging caches when no metadata is present. Which is
> the case for hardware tag-based KASAN with kasan.mode=prod.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia114847dfb2244f297d2cb82d592bf6a07455dba
> ---
>  include/linux/kasan.h | 26 ++++++++++++++++++++++++--
>  mm/kasan/common.c     | 11 +++++++++++
>  mm/slab_common.c      | 11 ++++++++---
>  3 files changed, 43 insertions(+), 5 deletions(-)
> 
[...]
>  
> +/*
> + * Only allow cache merging when stack collection is disabled and no metadata
> + * is present.
> + */
> +slab_flags_t __kasan_never_merge(slab_flags_t flags)

I'm getting 

	mm/kasan/common.c:88:14: warning: no previous prototype for ‘__kasan_never_merge’ [-Wmissing-prototypes] 

for a KASAN x86 build with W=1. Presumably because if !KASAN_HW_TAGS
then this is never needed and defined static inline in the header.

> +{
> +	if (kasan_stack_collection_enabled())
> +		return flags;
> +	return flags & ~SLAB_KASAN;
> +}

Thanks,
-- Marco
