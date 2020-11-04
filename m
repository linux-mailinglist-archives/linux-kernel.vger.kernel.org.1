Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9DB2A66E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgKDO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:56:28 -0500
Received: from foss.arm.com ([217.140.110.172]:38406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730485AbgKDO4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:56:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1F0E139F;
        Wed,  4 Nov 2020 06:56:09 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBD8C3F719;
        Wed,  4 Nov 2020 06:56:03 -0800 (PST)
Date:   Wed, 4 Nov 2020 14:56:01 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        =?utf-8?B?SsO2cm4=?= Engel <joern@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v7 3/9] arm64, kfence: enable KFENCE for ARM64
Message-ID: <20201104145601.GB7577@C02TD0UTHF1T.local>
References: <20201103175841.3495947-1-elver@google.com>
 <20201103175841.3495947-4-elver@google.com>
 <20201104130111.GA7577@C02TD0UTHF1T.local>
 <CANpmjNNyY+Myv12P-iou80LhQ0aG5UFudLbVWmRBcM3V=G540A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNyY+Myv12P-iou80LhQ0aG5UFudLbVWmRBcM3V=G540A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 03:23:48PM +0100, Marco Elver wrote:
> On Wed, 4 Nov 2020 at 14:06, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Nov 03, 2020 at 06:58:35PM +0100, Marco Elver wrote:
> > There is one thing that I thing we should improve as a subsequent
> > cleanup, but I don't think that should block this as-is.
> >
> > > +#define KFENCE_SKIP_ARCH_FAULT_HANDLER "el1_sync"
> >
> > IIUC, the core kfence code is using this to figure out where to trace
> > from when there's a fault taken on an access to a protected page.
> 
> Correct.
> 
> > It would be better if the arch code passed the exception's pt_regs into
> > the kfence fault handler, and the kfence began the trace began from
> > there. That would also allow for dumping the exception registers which
> > can help with debugging (e.g. figuring out how the address was derived
> > when it's calculated from multiple source registers). That would also be
> > a bit more robust to changes in an architectures' exception handling
> > code.
> 
> Good idea, thanks. I guess there's no reason to not want to always
> skip to instruction_pointer(regs)?

I don't think we need the exception handling gunk in the trace, but note
that you'd need to use stack_trace_save_regs(regs, ...) directly, rather
than using stack_trace_save() and skipping based on
instruction_pointer(regs). Otherwise, if the fault was somewhere in an
exception handler, and we invoked the same function on the path to the
kfence fault handler we might cut the trace at the wrong point.

> In which case I can prepare a patch to make this change. If this
> should go into a v8, please let me know. But it'd be easier as a
> subsequent patch as you say, given it'll be easier to review and these
> patches are in -mm now.

I think it'd make more sense as a subsequent change, since it's liable
to need a cycle or two of review, and I don't think it should block the
rest of the series.

Thanks,
Mark.
