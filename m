Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCCF27D102
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgI2OYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:24:20 -0400
Received: from foss.arm.com ([217.140.110.172]:46102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgI2OYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:24:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3E5331B;
        Tue, 29 Sep 2020 07:24:18 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D59CA3F6CF;
        Tue, 29 Sep 2020 07:24:13 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:24:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, hpa@zytor.com,
        paulmck@kernel.org, andreyknvl@google.com, aryabinin@virtuozzo.com,
        luto@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        cl@linux.com, dave.hansen@linux.intel.com, rientjes@google.com,
        dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org, penberg@kernel.org,
        peterz@infradead.org, sjpark@amazon.com, tglx@linutronix.de,
        vbabka@suse.cz, will@kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 01/10] mm: add Kernel Electric-Fence infrastructure
Message-ID: <20200929142411.GC53442@C02TD0UTHF1T.local>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921132611.1700350-2-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 03:26:02PM +0200, Marco Elver wrote:
> From: Alexander Potapenko <glider@google.com>
> 
> This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> low-overhead sampling-based memory safety error detector of heap
> use-after-free, invalid-free, and out-of-bounds access errors.
> 
> KFENCE is designed to be enabled in production kernels, and has near
> zero performance overhead. Compared to KASAN, KFENCE trades performance
> for precision. The main motivation behind KFENCE's design, is that with
> enough total uptime KFENCE will detect bugs in code paths not typically
> exercised by non-production test workloads. One way to quickly achieve a
> large enough total uptime is when the tool is deployed across a large
> fleet of machines.
> 
> KFENCE objects each reside on a dedicated page, at either the left or
> right page boundaries. The pages to the left and right of the object
> page are "guard pages", whose attributes are changed to a protected
> state, and cause page faults on any attempted access to them. Such page
> faults are then intercepted by KFENCE, which handles the fault
> gracefully by reporting a memory access error. To detect out-of-bounds
> writes to memory within the object's page itself, KFENCE also uses
> pattern-based redzones. The following figure illustrates the page
> layout:
> 
>   ---+-----------+-----------+-----------+-----------+-----------+---
>      | xxxxxxxxx | O :       | xxxxxxxxx |       : O | xxxxxxxxx |
>      | xxxxxxxxx | B :       | xxxxxxxxx |       : B | xxxxxxxxx |
>      | x GUARD x | J : RED-  | x GUARD x | RED-  : J | x GUARD x |
>      | xxxxxxxxx | E :  ZONE | xxxxxxxxx |  ZONE : E | xxxxxxxxx |
>      | xxxxxxxxx | C :       | xxxxxxxxx |       : C | xxxxxxxxx |
>      | xxxxxxxxx | T :       | xxxxxxxxx |       : T | xxxxxxxxx |
>   ---+-----------+-----------+-----------+-----------+-----------+---
> 
> Guarded allocations are set up based on a sample interval (can be set
> via kfence.sample_interval). After expiration of the sample interval, a
> guarded allocation from the KFENCE object pool is returned to the main
> allocator (SLAB or SLUB). At this point, the timer is reset, and the
> next allocation is set up after the expiration of the interval.

From other sub-threads it sounds like these addresses are not part of
the linear/direct map. Having kmalloc return addresses outside of the
linear map is going to break anything that relies on virt<->phys
conversions, and is liable to make DMA corrupt memory. There were
problems of that sort with VMAP_STACK, and this is why kvmalloc() is
separate from kmalloc().

Have you tested with CONFIG_DEBUG_VIRTUAL? I'd expect that to scream.

I strongly suspect this isn't going to be safe unless you always use an
in-place carevout from the linear map (which could be the linear alias
of a static carevout).

[...]

> +static __always_inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
> +{
> +	return static_branch_unlikely(&kfence_allocation_key) ? __kfence_alloc(s, size, flags) :
> +								      NULL;
> +}

Minor (unrelated) nit, but this would be easier to read as:

static __always_inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
{
	if (static_branch_unlikely(&kfence_allocation_key))
		return __kfence_alloc(s, size, flags);
	return NULL;
}

Thanks,
Mark.
