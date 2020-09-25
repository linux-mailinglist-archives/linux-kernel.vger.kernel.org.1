Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DF2785B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgIYLYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:24:09 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:32737 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgIYLYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601033046; x=1632569046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=5NMENrUjSNjCsQoUiDftw7mzxLQdx0hBB98A7KX4Fnk=;
  b=KFvhSpXNm5IbcTk8dlvJnaxDn5I8iSSXu6iOytltrSfYmExKAyjd7sIn
   /NJvTZtQMOUZRHCL2lweJ1L/JDh/2y2zSgsUTOfjKYja5TBRd8551p875
   fzuGYeiN8rWTG5ePzTotDidkI9IZbSIEvE9uOzc/Cnp3VLgD744RpBKva
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,301,1596499200"; 
   d="scan'208";a="57674777"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 25 Sep 2020 11:24:02 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 73A44A0334;
        Fri, 25 Sep 2020 11:23:59 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.229) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 25 Sep 2020 11:23:44 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Marco Elver <elver@google.com>
CC:     <akpm@linux-foundation.org>, <glider@google.com>,
        <mark.rutland@arm.com>, <hdanton@sina.com>,
        <linux-doc@vger.kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <edumazet@google.com>, <hpa@zytor.com>,
        <cl@linux.com>, <will@kernel.org>, <sjpark@amazon.com>,
        <corbet@lwn.net>, <x86@kernel.org>, <kasan-dev@googlegroups.com>,
        <mingo@redhat.com>, <vbabka@suse.cz>, <rientjes@google.com>,
        <aryabinin@virtuozzo.com>, <keescook@chromium.org>,
        <paulmck@kernel.org>, <jannh@google.com>, <andreyknvl@google.com>,
        <bp@alien8.de>, <luto@kernel.org>, <Jonathan.Cameron@huawei.com>,
        <tglx@linutronix.de>, <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <penberg@kernel.org>, <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 01/10] mm: add Kernel Electric-Fence infrastructure
Date:   Fri, 25 Sep 2020 13:23:28 +0200
Message-ID: <20200925112328.10057-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921132611.1700350-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.229]
X-ClientProxiedBy: EX13D29UWA004.ant.amazon.com (10.43.160.33) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 15:26:02 +0200 Marco Elver <elver@google.com> wrote:

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
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> v3:
> * Reports by SeongJae Park:
>   * Remove reference to Documentation/dev-tools/kfence.rst.
>   * Remove redundant braces.
>   * Use CONFIG_KFENCE_NUM_OBJECTS instead of ARRAY_SIZE(...).
>   * Align some comments.
> * Add figure from Documentation/dev-tools/kfence.rst added later in
>   series to patch description.
> 
> v2:
> * Add missing __printf attribute to seq_con_printf, and fix new warning.
>   [reported by kernel test robot <lkp@intel.com>]
> * Fix up some comments [reported by Jonathan Cameron].
> * Remove 2 cases of redundant stack variable initialization
>   [reported by Jonathan Cameron].
> * Fix printf format [reported by kernel test robot <lkp@intel.com>].
> * Print (in kfence-#nn) after address, to more clearly establish link
>   between first and second stacktrace [reported by Andrey Konovalov].
> * Make choice between KASAN and KFENCE clearer in Kconfig help text
>   [suggested by Dave Hansen].
> * Document CONFIG_KFENCE_SAMPLE_INTERVAL=0.
> * Shorten memory corruption report line length.
> * Make /sys/module/kfence/parameters/sample_interval root-writable for
>   all builds (to enable debugging, automatic dynamic tweaking).
> * Reports by Dmitry Vyukov:
>   * Do not store negative size for right-located objects
>   * Only cache-align addresses of right-located objects.
>   * Run toggle_allocation_gate() after KFENCE is enabled.
>   * Add empty line between allocation and free stacks.
>   * Add comment about SLAB_TYPESAFE_BY_RCU.
>   * Also skip internals for allocation/free stacks.
>   * s/KFENCE_FAULT_INJECTION/KFENCE_STRESS_TEST_FAULTS/ as FAULT_INJECTION
>     is already overloaded in different contexts.
>   * Parenthesis for macro variable.
>   * Lower max of KFENCE_NUM_OBJECTS config variable.
> ---
>  MAINTAINERS            |  11 +
>  include/linux/kfence.h | 174 ++++++++++
>  init/main.c            |   2 +
>  lib/Kconfig.debug      |   1 +
>  lib/Kconfig.kfence     |  63 ++++
>  mm/Makefile            |   1 +
>  mm/kfence/Makefile     |   3 +
>  mm/kfence/core.c       | 733 +++++++++++++++++++++++++++++++++++++++++
>  mm/kfence/kfence.h     | 102 ++++++
>  mm/kfence/report.c     | 219 ++++++++++++
>  10 files changed, 1309 insertions(+)
>  create mode 100644 include/linux/kfence.h
>  create mode 100644 lib/Kconfig.kfence
>  create mode 100644 mm/kfence/Makefile
>  create mode 100644 mm/kfence/core.c
>  create mode 100644 mm/kfence/kfence.h
>  create mode 100644 mm/kfence/report.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5cfab015bd6..863899ed9a29 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9673,6 +9673,17 @@ F:	include/linux/keyctl.h
>  F:	include/uapi/linux/keyctl.h
>  F:	security/keys/
>  
> +KFENCE
> +M:	Alexander Potapenko <glider@google.com>
> +M:	Marco Elver <elver@google.com>
> +R:	Dmitry Vyukov <dvyukov@google.com>
> +L:	kasan-dev@googlegroups.com
> +S:	Maintained
> +F:	Documentation/dev-tools/kfence.rst

This patch doesn't introduce this file yet, right?  How about using a separate
final patch for MAINTAINERS update?

Other than that,

Reviewed-by: SeongJae Park <sjpark@amazon.de>


Thanks,
SeongJae Park
