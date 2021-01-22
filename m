Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67D22FF974
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbhAVA0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbhAVA0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:26:24 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B2AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:25:43 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b8so2278661plx.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5feskpk9GlzD7Krs5v/HKhRDKnwIPDPivS/lanzBAu8=;
        b=hl6Jw4vmpQjaXAX/JGgeAWIcC5xSkAe4iH8/Oq28KL9jWUt/n37wxuZxYDDpPTA+eW
         PsWIcvFoP6Un8KVQtQ9UD/pkF0GPrUMhfpQ4ULGeiETqIElv+plirQRWA0g5trgEGHrX
         NTyzbH09c3KzViq5XkX0YDghgqBZOSUDow3+ZH7HS7k9OaKmM0ifJ9oLGmYpZ4bpsvlm
         ys3GeSuXziChU5mbXifVCmw+SQ5qOke4X+ESS31YjXHS4g59vcvkDdDM5mBvEAl+qMka
         VjmvmNmOtlYo7mIIchEKuy/j5lt+H54n/OY8VUtUGA2m14J2Ps+JR8v8WftjIUUzUi89
         3tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5feskpk9GlzD7Krs5v/HKhRDKnwIPDPivS/lanzBAu8=;
        b=D82cDztHDFWKDdPMqj73VDfh0kqKKotXf4ogs8l1R8l+ezZyn5l9j3an1qoVClM4kn
         BoW4CyOjc+rS9vFMTEMxoPR9FervSGzEH8dViB0NA91aeSyRX9+PFvTQ5Q4buIqrGjwc
         Ml7diKvH0iMB2ScSO/mMrqDPFPIgcB31D5OSpzF8XRsRiJiubby9/H80sC3UCe+QgNld
         LoTiZCY/boIvQi6H8OdwxPr1BOtOV740IVYw1jg3pj++YiSBPOvUCC1kqHBAIontbjNe
         UoAj6XOBs3Zy7mqbtzE1WPIfLsCUGFQ/PByS+GpiprNQalPAZDzRUWsgKHgn2owrh6nI
         D8/A==
X-Gm-Message-State: AOAM533ede5Lp7omGdU+FI8vVOBrau36t3B14nwtv3gsHAZyRvCIh1vB
        lv5oyNAZPOBYM0NbTaWNyKA=
X-Google-Smtp-Source: ABdhPJyQpkaTg2NUQKEh3ir6tqEkIVpk64iPS4Wy12YP3fR7uOZTTp0aLxHKc4M7LwM+Do28dqd09Q==
X-Received: by 2002:a17:902:14f:b029:de:c703:3045 with SMTP id 73-20020a170902014fb02900dec7033045mr2362002plb.14.1611275143384;
        Thu, 21 Jan 2021 16:25:43 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2144:1799:e940:1da6])
        by smtp.gmail.com with ESMTPSA id c23sm7103668pgc.72.2021.01.21.16.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 16:25:42 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 21 Jan 2021 16:25:40 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     vjitta@codeaurora.org
Cc:     glider@google.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, broonie@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, ylal@codeaurora.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH v5 2/2] lib: stackdepot: Add support to disable stack
 depot
Message-ID: <YAobhDFEJKa26OwH@google.com>
References: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
 <1610963802-11042-2-git-send-email-vjitta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610963802-11042-2-git-send-email-vjitta@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:26:42PM +0530, vjitta@codeaurora.org wrote:
> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> Add a kernel parameter stack_depot_disable to disable
> stack depot. So that stack hash table doesn't consume
> any memory when stack depot is disabled.

The usecase is CONFIG_PAGE_OWNER without page_owner=on.
Without this patch, stackdepot will consume the memory
for the hashtable. By default, it's 8M which is never trivial.

With this option, in CONFIG_PAGE_OWNER configured system,
page_owner=off, stack_depot_disable in kernel command line,
we could save the wasted memory for the hashtable.

> 
> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>

Please also update kernel-parameters.txt.

> ---
>  include/linux/stackdepot.h |  1 +
>  init/main.c                |  2 ++
>  lib/stackdepot.c           | 33 +++++++++++++++++++++++++++++----
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 24d49c7..eafd9aa 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -21,4 +21,5 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  
>  unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
>  
> +int stack_depot_init(void);
>  #endif
> diff --git a/init/main.c b/init/main.c
> index 32b2a8a..8fcf9bb 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -98,6 +98,7 @@
>  #include <linux/mem_encrypt.h>
>  #include <linux/kcsan.h>
>  #include <linux/init_syscalls.h>
> +#include <linux/stackdepot.h>
>  
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -827,6 +828,7 @@ static void __init mm_init(void)
>  	page_ext_init_flatmem();
>  	init_debug_pagealloc();
>  	report_meminit();
> +	stack_depot_init();
>  	mem_init();
>  	kmem_cache_init();
>  	kmemleak_init();
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index dff8521..d20e6fd 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -31,6 +31,8 @@
>  #include <linux/stackdepot.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> +#include <linux/vmalloc.h>

Why do we need vmalloc?

Otherwise, looks good to me.
Thank you!
