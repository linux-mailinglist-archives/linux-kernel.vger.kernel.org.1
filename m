Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076822A0A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgJ3QAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:00:15 -0400
Received: from foss.arm.com ([217.140.110.172]:38494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3QAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:00:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C38911435;
        Fri, 30 Oct 2020 09:00:13 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.53.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2B453F719;
        Fri, 30 Oct 2020 09:00:06 -0700 (PDT)
Date:   Fri, 30 Oct 2020 16:00:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jann Horn <jannh@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, joern@purestorage.com,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v6 3/9] arm64, kfence: enable KFENCE for ARM64
Message-ID: <20201030160004.GE50718@C02TD0UTHF1T.local>
References: <20201029131649.182037-1-elver@google.com>
 <20201029131649.182037-4-elver@google.com>
 <CAG48ez11T4gXHkhgnM7eWc1EJQ5u7NQup4ADy75c1uUVPeWGSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez11T4gXHkhgnM7eWc1EJQ5u7NQup4ADy75c1uUVPeWGSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 03:49:26AM +0100, Jann Horn wrote:
> On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> > @@ -312,6 +313,9 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
> >             "Ignoring spurious kernel translation fault at virtual address %016lx\n", addr))
> >                 return;
> >
> > +       if (kfence_handle_page_fault(addr))
> > +               return;
> 
> As in the X86 case, we may want to ensure that this doesn't run for
> permission faults, only for non-present pages. Maybe move this down
> into the third branch of the "if" block below (neither permission
> fault nor NULL deref)?

I think that'd make sense. Those cases *should* be mutually exclusive,
but it'd be more robust to do the KFENCE checks in that last block so
that if something goes wrong wrong within KFENCE we can't get stuck in a
loop failing to service an instruction abort or similar.

Either that, or factor out an is_el1_translation_fault() and only do the
KFENCE check and is_spurious_el1_translation_fault() check under that.

Thanks,
Mark.
