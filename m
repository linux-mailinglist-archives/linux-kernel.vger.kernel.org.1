Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1612F2E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbhALLjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbhALLjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:39:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:38:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t16so2163952wra.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDpfESbYxGF6Trv+/Pck55IrVLlVuQoy2fDX+R3JzHs=;
        b=lTj2eZ0DptoNXlhXwRR5h7+wYAQ7o37MGF02nPramm3x/YM9nVgJhGn8jJv2jmZyv4
         kmaIEelTV23V817at6dh8ahtVwTVxSYyUfFnerkbisZotkwb3jxfPUoGxPvXDPAybgkW
         BahdhTkMI14s0CtrZUEiy7RZoAA5ay58wksKBkU7qhhCJtS1lyx/lGZsHHVSLDpsTkiN
         ESIOecg2QJwQIfun7fGdKf+iglO0SvElsh9JCuFEgVaZ4IEQfzyPhSrznKyw5/dNpbYE
         UulwAPcgAUaT3MHBAceViOsC6wh0vVIogFTIZJMwKGl3XahEjQe3t2dAUAvs2OzireaB
         SQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDpfESbYxGF6Trv+/Pck55IrVLlVuQoy2fDX+R3JzHs=;
        b=Fl9GZCXKPQiG4yxyupw5qBabjF2qS9Us6PyNA6Xn/Rw0haus2ysSjpvLXhyUL/IuPB
         Mfl/QSYXF7EI/kGk6anNnjQ6SUSp9VJt/PtbADuWrvrCTY7f/og8ISBk+XD8YIqbhol4
         7epZcj/nyMFjbXjsMKWzgyqgksy3mvqKcwOijYjTN93E3wQSCHa++o44k/AmJdzQUVL/
         7tsvXxsZzHGJP/xhBE6csx86vzpPe7ZmYbXjnt8ZYFjaSDDcKrQHcfC4lYg3uKzLBnQA
         oZQqqDkeKsOoVRrIixdFM9x5PBdNGDKmS8Hb5mdTqDHUj9saE3M/vkeCCfq1Pk+EpcYh
         GfhQ==
X-Gm-Message-State: AOAM5304RZu/CYJKel4QMXoRDS+1cu6m5zl8F7h/p46wPUeLh/t83uZU
        iblRxWbVTdvfKFGft9Vd3n7osA==
X-Google-Smtp-Source: ABdhPJyLzef9n7OBMWDe4KNRiKBdnjf0DtXgvotb9wvOQP0nz95VMJGs4kAznFJQxjUXvpC2zDMsag==
X-Received: by 2002:adf:db51:: with SMTP id f17mr3957788wrj.83.1610451500054;
        Tue, 12 Jan 2021 03:38:20 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id o74sm3825348wme.36.2021.01.12.03.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 03:38:19 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:38:13 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] kasan: clarify HW_TAGS impact on TBI
Message-ID: <X/2KJb5SN5DUq1C+@elver.google.com>
References: <cover.1609871239.git.andreyknvl@google.com>
 <a5dfc703ddd7eacda0ee0da083c7afad44afff8c.1609871239.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5dfc703ddd7eacda0ee0da083c7afad44afff8c.1609871239.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> Mention in the documentation that enabling CONFIG_KASAN_HW_TAGS
> always results in in-kernel TBI (Top Byte Ignore) being enabled.
> 
> Also do a few minor documentation cleanups.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Iba2a6697e3c6304cb53f89ec61dedc77fa29e3ae

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 0fc3fb1860c4..26c99852a852 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -147,15 +147,14 @@ negative values to distinguish between different kinds of inaccessible memory
>  like redzones or freed memory (see mm/kasan/kasan.h).
>  
>  In the report above the arrows point to the shadow byte 03, which means that
> -the accessed address is partially accessible.
> -
> -For tag-based KASAN this last report section shows the memory tags around the
> -accessed address (see `Implementation details`_ section).
> +the accessed address is partially accessible. For tag-based KASAN modes this
> +last report section shows the memory tags around the accessed address
> +(see the `Implementation details`_ section).
>  
>  Boot parameters
>  ~~~~~~~~~~~~~~~
>  
> -Hardware tag-based KASAN mode (see the section about different mode below) is
> +Hardware tag-based KASAN mode (see the section about various modes below) is
>  intended for use in production as a security mitigation. Therefore it supports
>  boot parameters that allow to disable KASAN competely or otherwise control
>  particular KASAN features.
> @@ -305,6 +304,13 @@ reserved to tag freed memory regions.
>  Hardware tag-based KASAN currently only supports tagging of
>  kmem_cache_alloc/kmalloc and page_alloc memory.
>  
> +If the hardware doesn't support MTE (pre ARMv8.5), hardware tag-based KASAN
> +won't be enabled. In this case all boot parameters are ignored.
> +
> +Note, that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
> +enabled. Even when kasan.mode=off is provided, or when the hardware doesn't
> +support MTE (but supports TBI).
> +
>  What memory accesses are sanitised by KASAN?
>  --------------------------------------------
>  
> -- 
> 2.29.2.729.g45daf8777d-goog
> 
