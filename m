Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C9626FB40
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIRLRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbgIRLRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600427840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZQ2aUpYbOfI0OBbojrEaiyX2uk+A76utcy0JxZ4CmM=;
        b=VYV+5DnkKsLqcJVNlA1slnzrgvuqPZVhp74WmBwwwdhx6+/HP4wNgxlC0e7uQ5krO1+FOb
        zJfPnNMUwuT5KRJncdpVs31zmenqmPKgpuD99OaS/yYrF6XhdtXi/NyY9vnufD5YIFbjMA
        MwIdr/OXJ1sqXfpvSqtGy/ZKqw3Ih1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-qLTXgoXWNA2FodMSDim9VQ-1; Fri, 18 Sep 2020 07:17:15 -0400
X-MC-Unique: qLTXgoXWNA2FodMSDim9VQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BC5D186DD41;
        Fri, 18 Sep 2020 11:17:12 +0000 (UTC)
Received: from ovpn-113-208.rdu2.redhat.com (ovpn-113-208.rdu2.redhat.com [10.10.113.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C09C55DEBF;
        Fri, 18 Sep 2020 11:17:06 +0000 (UTC)
Message-ID: <115e74b249417340b5c411f286768dbdb916fd12.camel@redhat.com>
Subject: Re: [PATCH v2 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
From:   Qian Cai <cai@redhat.com>
To:     Marco Elver <elver@google.com>, akpm@linux-foundation.org,
        glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, mingo@redhat.com, jannh@google.com,
        Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, vbabka@suse.cz, will@kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Date:   Fri, 18 Sep 2020 07:17:06 -0400
In-Reply-To: <20200915132046.3332537-1-elver@google.com>
References: <20200915132046.3332537-1-elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-15 at 15:20 +0200, Marco Elver wrote:
> This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> low-overhead sampling-based memory safety error detector of heap
> use-after-free, invalid-free, and out-of-bounds access errors.  This
> series enables KFENCE for the x86 and arm64 architectures, and adds
> KFENCE hooks to the SLAB and SLUB allocators.
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
> gracefully by reporting a memory access error.
> 
> Guarded allocations are set up based on a sample interval (can be set
> via kfence.sample_interval). After expiration of the sample interval,
> the next allocation through the main allocator (SLAB or SLUB) returns a
> guarded allocation from the KFENCE object pool. At this point, the timer
> is reset, and the next allocation is set up after the expiration of the
> interval.
> 
> To enable/disable a KFENCE allocation through the main allocator's
> fast-path without overhead, KFENCE relies on static branches via the
> static keys infrastructure. The static branch is toggled to redirect the
> allocation to KFENCE.
> 
> The KFENCE memory pool is of fixed size, and if the pool is exhausted no
> further KFENCE allocations occur. The default config is conservative
> with only 255 objects, resulting in a pool size of 2 MiB (with 4 KiB
> pages).
> 
> We have verified by running synthetic benchmarks (sysbench I/O,
> hackbench) that a kernel with KFENCE is performance-neutral compared to
> a non-KFENCE baseline kernel.
> 
> KFENCE is inspired by GWP-ASan [1], a userspace tool with similar
> properties. The name "KFENCE" is a homage to the Electric Fence Malloc
> Debugger [2].
> 
> For more details, see Documentation/dev-tools/kfence.rst added in the
> series -- also viewable here:

Does anybody else grow tried of all those different *imperfect* versions of in-
kernel memory safety error detectors? KASAN-generic, KFENCE, KASAN-tag-based
etc. Then, we have old things like page_poison, SLUB debugging, debug_pagealloc
etc which are pretty much inefficient to detect bugs those days compared to
KASAN. Can't we work towards having a single implementation and clean up all
those mess?

