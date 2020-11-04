Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F472A64DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgKDNGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:06:52 -0500
Received: from foss.arm.com ([217.140.110.172]:36860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbgKDNGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:06:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F721139F;
        Wed,  4 Nov 2020 05:06:51 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29D1D3F719;
        Wed,  4 Nov 2020 05:06:46 -0800 (PST)
Date:   Wed, 4 Nov 2020 13:06:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, hpa@zytor.com,
        paulmck@kernel.org, andreyknvl@google.com, aryabinin@virtuozzo.com,
        luto@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        cl@linux.com, dave.hansen@linux.intel.com, rientjes@google.com,
        dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, joern@purestorage.com,
        keescook@chromium.org, penberg@kernel.org, peterz@infradead.org,
        sjpark@amazon.com, tglx@linutronix.de, vbabka@suse.cz,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 3/9] arm64, kfence: enable KFENCE for ARM64
Message-ID: <20201104130111.GA7577@C02TD0UTHF1T.local>
References: <20201103175841.3495947-1-elver@google.com>
 <20201103175841.3495947-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103175841.3495947-4-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 06:58:35PM +0100, Marco Elver wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the arm64 architecture. In particular, this implements the
> required interface in <asm/kfence.h>.
> 
> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the entire linear map to be mapped
> at page granularity. Doing so may result in extra memory allocated for
> page tables in case rodata=full is not set; however, currently
> CONFIG_RODATA_FULL_DEFAULT_ENABLED=y is the default, and the common case
> is therefore not affected by this change.
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Thanks for dilligently handling all the review feedback. This looks good
to me now, so FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

There is one thing that I thing we should improve as a subsequent
cleanup, but I don't think that should block this as-is.

> +#define KFENCE_SKIP_ARCH_FAULT_HANDLER "el1_sync"

IIUC, the core kfence code is using this to figure out where to trace
from when there's a fault taken on an access to a protected page.

It would be better if the arch code passed the exception's pt_regs into
the kfence fault handler, and the kfence began the trace began from
there. That would also allow for dumping the exception registers which
can help with debugging (e.g. figuring out how the address was derived
when it's calculated from multiple source registers). That would also be
a bit more robust to changes in an architectures' exception handling
code.

Thanks,
Mark.
