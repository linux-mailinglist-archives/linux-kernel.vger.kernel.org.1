Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3C26B7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgIPA2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:28:40 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:12844 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgIOOGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600178769; x=1631714769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=BO4ndBw+g1PHfsj/egBJNcqOkjImxZMPDQmMhjVPiy4=;
  b=n0f+71cQsLYKhLAxWKHQzUVo9lc+nRW4XzbuvJGG4jUJmk5YyAZyJi8v
   I8zFOfOsxbV3lBJLixsAxOxRtTFO+hbEUPc/Xe8R3JOT4xJRVaHxIAXGR
   ttkeN9ZOKJJHj4mSRAhvbcopi/v885S+j4Cd+tChICZe/7m936q2FVoiL
   g=;
X-IronPort-AV: E=Sophos;i="5.76,430,1592870400"; 
   d="scan'208";a="76317152"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 15 Sep 2020 13:58:55 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id C6C36A18E3;
        Tue, 15 Sep 2020 13:58:51 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.244) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 15 Sep 2020 13:58:38 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Marco Elver <elver@google.com>
CC:     <glider@google.com>, <akpm@linux-foundation.org>,
        <catalin.marinas@arm.com>, <cl@linux.com>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <mark.rutland@arm.com>,
        <penberg@kernel.org>, <linux-doc@vger.kernel.org>,
        <peterz@infradead.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <edumazet@google.com>, <hpa@zytor.com>,
        <will@kernel.org>, <corbet@lwn.net>, <x86@kernel.org>,
        <kasan-dev@googlegroups.com>, <mingo@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <aryabinin@virtuozzo.com>,
        <keescook@chromium.org>, <paulmck@kernel.org>, <jannh@google.com>,
        <andreyknvl@google.com>, <cai@lca.pw>, <luto@kernel.org>,
        <tglx@linutronix.de>, <dvyukov@google.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <bp@alien8.de>
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
Date:   Tue, 15 Sep 2020 15:57:54 +0200
Message-ID: <20200915135754.24329-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907134055.2878499-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.244]
X-ClientProxiedBy: EX13D23UWA004.ant.amazon.com (10.43.160.72) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Sep 2020 15:40:46 +0200 Marco Elver <elver@google.com> wrote:

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
> gracefully by reporting a memory access error.
> 
> Guarded allocations are set up based on a sample interval (can be set
> via kfence.sample_interval). After expiration of the sample interval, a
> guarded allocation from the KFENCE object pool is returned to the main
> allocator (SLAB or SLUB). At this point, the timer is reset, and the
> next allocation is set up after the expiration of the interval.
> 
> To enable/disable a KFENCE allocation through the main allocator's
> fast-path without overhead, KFENCE relies on static branches via the
> static keys infrastructure. The static branch is toggled to redirect the
> allocation to KFENCE. To date, we have verified by running synthetic
> benchmarks (sysbench I/O workloads) that a kernel compiled with KFENCE
> is performance-neutral compared to the non-KFENCE baseline.
> 
> For more details, see Documentation/dev-tools/kfence.rst (added later in
> the series).

So interesting feature!  I left some tirvial comments below.

> 
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  MAINTAINERS            |  11 +
>  include/linux/kfence.h | 174 ++++++++++
>  init/main.c            |   2 +
>  lib/Kconfig.debug      |   1 +
>  lib/Kconfig.kfence     |  58 ++++
>  mm/Makefile            |   1 +
>  mm/kfence/Makefile     |   3 +
>  mm/kfence/core.c       | 730 +++++++++++++++++++++++++++++++++++++++++
>  mm/kfence/kfence.h     | 104 ++++++
>  mm/kfence/report.c     | 201 ++++++++++++
>  10 files changed, 1285 insertions(+)
>  create mode 100644 include/linux/kfence.h
>  create mode 100644 lib/Kconfig.kfence
>  create mode 100644 mm/kfence/Makefile
>  create mode 100644 mm/kfence/core.c
>  create mode 100644 mm/kfence/kfence.h
>  create mode 100644 mm/kfence/report.c
[...]
> diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
> new file mode 100644
> index 000000000000..7ac91162edb0
> --- /dev/null
> +++ b/lib/Kconfig.kfence
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config HAVE_ARCH_KFENCE
> +	bool
> +
> +config HAVE_ARCH_KFENCE_STATIC_POOL
> +	bool
> +	help
> +	  If the architecture supports using the static pool.
> +
> +menuconfig KFENCE
> +	bool "KFENCE: low-overhead sampling-based memory safety error detector"
> +	depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
> +	depends on JUMP_LABEL # To ensure performance, require jump labels
> +	select STACKTRACE
> +	help
> +	  KFENCE is low-overhead sampling-based detector for heap out-of-bounds
> +	  access, use-after-free, and invalid-free errors. KFENCE is designed
> +	  to have negligible cost to permit enabling it in production
> +	  environments.
> +
> +	  See <file:Documentation/dev-tools/kfence.rst> for more details.

This patch doesn't provide the file yet.  Why don't you add the reference with
the patch introducing the file?

> +
> +	  Note that, KFENCE is not a substitute for explicit testing with tools
> +	  such as KASAN. KFENCE can detect a subset of bugs that KASAN can
> +	  detect (therefore enabling KFENCE together with KASAN does not make
> +	  sense), albeit at very different performance profiles.
[...]
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> new file mode 100644
> index 000000000000..e638d1f64a32
> --- /dev/null
> +++ b/mm/kfence/core.c
> @@ -0,0 +1,730 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt) "kfence: " fmt
[...]
> +
> +static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
> +{
> +	long index;
> +
> +	/* The checks do not affect performance; only called from slow-paths. */
> +
> +	if (!is_kfence_address((void *)addr))
> +		return NULL;
> +
> +	/*
> +	 * May be an invalid index if called with an address at the edge of
> +	 * __kfence_pool, in which case we would report an "invalid access"
> +	 * error.
> +	 */
> +	index = ((addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2)) - 1;

Seems the outermost parentheses unnecessary.

> +	if (index < 0 || index >= CONFIG_KFENCE_NUM_OBJECTS)
> +		return NULL;
> +
> +	return &kfence_metadata[index];
> +}
> +
> +static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
> +{
> +	unsigned long offset = ((meta - kfence_metadata) + 1) * PAGE_SIZE * 2;

Seems the innermost parentheses unnecessary.

> +	unsigned long pageaddr = (unsigned long)&__kfence_pool[offset];
> +
> +	/* The checks do not affect performance; only called from slow-paths. */
> +
> +	/* Only call with a pointer into kfence_metadata. */
> +	if (KFENCE_WARN_ON(meta < kfence_metadata ||
> +			   meta >= kfence_metadata + ARRAY_SIZE(kfence_metadata)))

Is there a reason to use ARRAY_SIZE(kfence_metadata) instead of
CONFIG_KFENCE_NUM_OBJECTS?

> +		return 0;
> +
> +	/*
> +	 * This metadata object only ever maps to 1 page; verify the calculation
> +	 * happens and that the stored address was not corrupted.
> +	 */
> +	if (KFENCE_WARN_ON(ALIGN_DOWN(meta->addr, PAGE_SIZE) != pageaddr))
> +		return 0;
> +
> +	return pageaddr;
> +}
[...]
> +void __init kfence_init(void)
> +{
> +	/* Setting kfence_sample_interval to 0 on boot disables KFENCE. */
> +	if (!kfence_sample_interval)
> +		return;
> +
> +	if (!kfence_initialize_pool()) {
> +		pr_err("%s failed\n", __func__);
> +		return;
> +	}
> +
> +	schedule_delayed_work(&kfence_timer, 0);
> +	WRITE_ONCE(kfence_enabled, true);
> +	pr_info("initialized - using %zu bytes for %d objects", KFENCE_POOL_SIZE,
> +		CONFIG_KFENCE_NUM_OBJECTS);
> +	if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> +		pr_cont(" at 0x%px-0x%px\n", (void *)__kfence_pool,
> +			(void *)(__kfence_pool + KFENCE_POOL_SIZE));

Why don't you use PTR_FMT that defined in 'kfence.h'?

> +	else
> +		pr_cont("\n");
> +}
[...]
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> new file mode 100644
> index 000000000000..25ce2c0dc092
> --- /dev/null
> +++ b/mm/kfence/kfence.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef MM_KFENCE_KFENCE_H
> +#define MM_KFENCE_KFENCE_H
> +
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include "../slab.h" /* for struct kmem_cache */
> +
> +/* For non-debug builds, avoid leaking kernel pointers into dmesg. */
> +#ifdef CONFIG_DEBUG_KERNEL
> +#define PTR_FMT "%px"
> +#else
> +#define PTR_FMT "%p"
> +#endif
> +
> +/*
> + * Get the canary byte pattern for @addr. Use a pattern that varies based on the
> + * lower 3 bits of the address, to detect memory corruptions with higher
> + * probability, where similar constants are used.
> + */
> +#define KFENCE_CANARY_PATTERN(addr) ((u8)0xaa ^ (u8)((unsigned long)addr & 0x7))
> +
> +/* Maximum stack depth for reports. */
> +#define KFENCE_STACK_DEPTH 64
> +
> +/* KFENCE object states. */
> +enum kfence_object_state {
> +	KFENCE_OBJECT_UNUSED, /* Object is unused. */
> +	KFENCE_OBJECT_ALLOCATED, /* Object is currently allocated. */
> +	KFENCE_OBJECT_FREED, /* Object was allocated, and then freed. */

Aligning the comments would look better (same to below comments).

> +};
[...]
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> new file mode 100644
> index 000000000000..8c28200e7433
> --- /dev/null
> +++ b/mm/kfence/report.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
[...]
> +/* Get the number of stack entries to skip get out of MM internals. */
> +static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries,
> +			    enum kfence_error_type type)
> +{
> +	char buf[64];
> +	int skipnr, fallback = 0;
> +
> +	for (skipnr = 0; skipnr < num_entries; skipnr++) {
> +		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
> +
> +		/* Depending on error type, find different stack entries. */
> +		switch (type) {
> +		case KFENCE_ERROR_UAF:
> +		case KFENCE_ERROR_OOB:
> +		case KFENCE_ERROR_INVALID:
> +			if (!strncmp(buf, KFENCE_SKIP_ARCH_FAULT_HANDLER, len))

Seems KFENCE_SKIP_ARCH_FAULT_HANDLER not defined yet?

> +				goto found;
> +			break;
[...]


Thanks,
SeongJae Park
