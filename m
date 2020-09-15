Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0D226A708
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgIOO2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgIOOPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:15:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A76C061353
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:14:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so3554662wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iCaVZIoES6nQdU1krWtYyw9RTOkMnShVAEcHdPRqonk=;
        b=H8nL+xfrR2mxbyn6DykwhrinOuCc43Bq4GG55o7PhvzL/oEb4JvN2r+q0D4w1iWRtl
         lTJAjeZmPRtqYiYVtDygNalJ/7YqIw8vqyGIevdY0rw1S8KfrDsIpCtIIrSm5Xqlws91
         Mp0LGWsmmJdSf6Ep6I9VCMqe6bbK6bW5/LBQnS9KzDlAXh31DCfatqZhF3U8z0EmToMC
         y1WZ9qFx9VFHG0c5pQmxkBSaOltW+XnpfLWx+2Zf3i4S5ZLlS230y5ngbyQ9p1qAAK8G
         vckmdCk2DKTmA/KB82xol2azsXFCizK+AYwBKx3WB+OEn4fX3paGBgKtFWda+aF8c5xc
         eouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iCaVZIoES6nQdU1krWtYyw9RTOkMnShVAEcHdPRqonk=;
        b=CxnJbiJFK4jd9rU4/xG5SQE5ZbSFL9ufOzvB6itVtn8wbIFvP0sY3Udb27Gt3irKyU
         yOky7AxOX+AJ0rBxbYXbCHBjmyzhfHMOn6V92aOup58Hb8NO8/8XwWL1qWX5qq9pi7ts
         JMcHOgTyuSlPZAWHjTPjAkXIZkvcDx+2R1IvsyIU2S8/vgupmYJRE60F4HJn/eeAq7vE
         oSnfmbiujt9xGglF9/xkMElw38PBonNjwwpUQEN9IFVyLHXla89DvsFnYhmHO0+z8yyT
         gBPlFGPRn4NCpGwj5GRgDi4hYYdLHh/WsqIXeUWCcDxgUo71sxjWi2WaUg+scznkKjqR
         sWog==
X-Gm-Message-State: AOAM532HPnKPm7pk+fQCt8UjLJrkBmC4V5p/iXxzeL27Qa30e0g/NjKV
        bFGRDv13wOzYG7fF0RORo5IMOw==
X-Google-Smtp-Source: ABdhPJzTlxzBO4PMSx2ou+2vNV31AQcDM7exolub2p9hQpxlJ95llypdH0s2jTtZ0UyJtFiT/tEhZg==
X-Received: by 2002:adf:df05:: with SMTP id y5mr23640721wrl.39.1600179295984;
        Tue, 15 Sep 2020 07:14:55 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id k6sm23222807wmi.1.2020.09.15.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 07:14:55 -0700 (PDT)
Date:   Tue, 15 Sep 2020 16:14:49 +0200
From:   Marco Elver <elver@google.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     glider@google.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, mark.rutland@arm.com, penberg@kernel.org,
        linux-doc@vger.kernel.org, peterz@infradead.org,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        edumazet@google.com, hpa@zytor.com, will@kernel.org,
        corbet@lwn.net, x86@kernel.org, kasan-dev@googlegroups.com,
        mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
        aryabinin@virtuozzo.com, keescook@chromium.org, paulmck@kernel.org,
        jannh@google.com, andreyknvl@google.com, cai@lca.pw,
        luto@kernel.org, tglx@linutronix.de, dvyukov@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        bp@alien8.de
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
Message-ID: <20200915141449.GA3367763@elver.google.com>
References: <20200907134055.2878499-2-elver@google.com>
 <20200915135754.24329-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915135754.24329-1-sjpark@amazon.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 03:57PM +0200, SeongJae Park wrote:
[...]
> 
> So interesting feature!  I left some tirvial comments below.

Thank you!

> [...]
> > diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
> > new file mode 100644
> > index 000000000000..7ac91162edb0
> > --- /dev/null
> > +++ b/lib/Kconfig.kfence
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config HAVE_ARCH_KFENCE
> > +	bool
> > +
> > +config HAVE_ARCH_KFENCE_STATIC_POOL
> > +	bool
> > +	help
> > +	  If the architecture supports using the static pool.
> > +
> > +menuconfig KFENCE
> > +	bool "KFENCE: low-overhead sampling-based memory safety error detector"
> > +	depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
> > +	depends on JUMP_LABEL # To ensure performance, require jump labels
> > +	select STACKTRACE
> > +	help
> > +	  KFENCE is low-overhead sampling-based detector for heap out-of-bounds
> > +	  access, use-after-free, and invalid-free errors. KFENCE is designed
> > +	  to have negligible cost to permit enabling it in production
> > +	  environments.
> > +
> > +	  See <file:Documentation/dev-tools/kfence.rst> for more details.
> 
> This patch doesn't provide the file yet.  Why don't you add the reference with
> the patch introducing the file?

Sure, will fix for v3.

> > +
> > +	  Note that, KFENCE is not a substitute for explicit testing with tools
> > +	  such as KASAN. KFENCE can detect a subset of bugs that KASAN can
> > +	  detect (therefore enabling KFENCE together with KASAN does not make
> > +	  sense), albeit at very different performance profiles.
> [...]
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > new file mode 100644
> > index 000000000000..e638d1f64a32
> > --- /dev/null
> > +++ b/mm/kfence/core.c
> > @@ -0,0 +1,730 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define pr_fmt(fmt) "kfence: " fmt
> [...]
> > +
> > +static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
> > +{
> > +	long index;
> > +
> > +	/* The checks do not affect performance; only called from slow-paths. */
> > +
> > +	if (!is_kfence_address((void *)addr))
> > +		return NULL;
> > +
> > +	/*
> > +	 * May be an invalid index if called with an address at the edge of
> > +	 * __kfence_pool, in which case we would report an "invalid access"
> > +	 * error.
> > +	 */
> > +	index = ((addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2)) - 1;
> 
> Seems the outermost parentheses unnecessary.

Will fix.

> > +	if (index < 0 || index >= CONFIG_KFENCE_NUM_OBJECTS)
> > +		return NULL;
> > +
> > +	return &kfence_metadata[index];
> > +}
> > +
> > +static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
> > +{
> > +	unsigned long offset = ((meta - kfence_metadata) + 1) * PAGE_SIZE * 2;
> 
> Seems the innermost parentheses unnecessary.

Will fix.

> > +	unsigned long pageaddr = (unsigned long)&__kfence_pool[offset];
> > +
> > +	/* The checks do not affect performance; only called from slow-paths. */
> > +
> > +	/* Only call with a pointer into kfence_metadata. */
> > +	if (KFENCE_WARN_ON(meta < kfence_metadata ||
> > +			   meta >= kfence_metadata + ARRAY_SIZE(kfence_metadata)))
> 
> Is there a reason to use ARRAY_SIZE(kfence_metadata) instead of
> CONFIG_KFENCE_NUM_OBJECTS?

They're equivalent. We can switch it. (Although I don't see one being
superior to the other.. maybe we save on compile-time?)

> > +		return 0;
> > +
> > +	/*
> > +	 * This metadata object only ever maps to 1 page; verify the calculation
> > +	 * happens and that the stored address was not corrupted.
> > +	 */
> > +	if (KFENCE_WARN_ON(ALIGN_DOWN(meta->addr, PAGE_SIZE) != pageaddr))
> > +		return 0;
> > +
> > +	return pageaddr;
> > +}
> [...]
> > +void __init kfence_init(void)
> > +{
> > +	/* Setting kfence_sample_interval to 0 on boot disables KFENCE. */
> > +	if (!kfence_sample_interval)
> > +		return;
> > +
> > +	if (!kfence_initialize_pool()) {
> > +		pr_err("%s failed\n", __func__);
> > +		return;
> > +	}
> > +
> > +	schedule_delayed_work(&kfence_timer, 0);
> > +	WRITE_ONCE(kfence_enabled, true);
> > +	pr_info("initialized - using %zu bytes for %d objects", KFENCE_POOL_SIZE,
> > +		CONFIG_KFENCE_NUM_OBJECTS);
> > +	if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> > +		pr_cont(" at 0x%px-0x%px\n", (void *)__kfence_pool,
> > +			(void *)(__kfence_pool + KFENCE_POOL_SIZE));
> 
> Why don't you use PTR_FMT that defined in 'kfence.h'?

It's unnecessary, since all this is conditional on
IS_ENABLED(CONFIG_DEBUG_KERNEL)) and we can just avoid the indirection
through PTR_FMT.

> > +	else
> > +		pr_cont("\n");
> > +}
> [...]
> > diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> > new file mode 100644
> > index 000000000000..25ce2c0dc092
> > --- /dev/null
> > +++ b/mm/kfence/kfence.h
> > @@ -0,0 +1,104 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef MM_KFENCE_KFENCE_H
> > +#define MM_KFENCE_KFENCE_H
> > +
> > +#include <linux/mm.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +
> > +#include "../slab.h" /* for struct kmem_cache */
> > +
> > +/* For non-debug builds, avoid leaking kernel pointers into dmesg. */
> > +#ifdef CONFIG_DEBUG_KERNEL
> > +#define PTR_FMT "%px"
> > +#else
> > +#define PTR_FMT "%p"
> > +#endif
> > +
> > +/*
> > + * Get the canary byte pattern for @addr. Use a pattern that varies based on the
> > + * lower 3 bits of the address, to detect memory corruptions with higher
> > + * probability, where similar constants are used.
> > + */
> > +#define KFENCE_CANARY_PATTERN(addr) ((u8)0xaa ^ (u8)((unsigned long)addr & 0x7))
> > +
> > +/* Maximum stack depth for reports. */
> > +#define KFENCE_STACK_DEPTH 64
> > +
> > +/* KFENCE object states. */
> > +enum kfence_object_state {
> > +	KFENCE_OBJECT_UNUSED, /* Object is unused. */
> > +	KFENCE_OBJECT_ALLOCATED, /* Object is currently allocated. */
> > +	KFENCE_OBJECT_FREED, /* Object was allocated, and then freed. */
> 
> Aligning the comments would look better (same to below comments).

Will fix.

> > +};
> [...]
> > diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> > new file mode 100644
> > index 000000000000..8c28200e7433
> > --- /dev/null
> > +++ b/mm/kfence/report.c
> > @@ -0,0 +1,201 @@
> > +// SPDX-License-Identifier: GPL-2.0
> [...]
> > +/* Get the number of stack entries to skip get out of MM internals. */
> > +static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries,
> > +			    enum kfence_error_type type)
> > +{
> > +	char buf[64];
> > +	int skipnr, fallback = 0;
> > +
> > +	for (skipnr = 0; skipnr < num_entries; skipnr++) {
> > +		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
> > +
> > +		/* Depending on error type, find different stack entries. */
> > +		switch (type) {
> > +		case KFENCE_ERROR_UAF:
> > +		case KFENCE_ERROR_OOB:
> > +		case KFENCE_ERROR_INVALID:
> > +			if (!strncmp(buf, KFENCE_SKIP_ARCH_FAULT_HANDLER, len))
> 
> Seems KFENCE_SKIP_ARCH_FAULT_HANDLER not defined yet?

Correct, it'll be defined in <asm/kfence.h> in the x86 and arm64
patches. Leaving this is fine, since no architecture has selected
HAVE_ARCH_KFENCE in this patch yet; as a result, we also can't break the
build even if this is undefined.

Thanks,
-- Marco
