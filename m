Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208C32C9710
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 06:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgLAFds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 00:33:48 -0500
Received: from exmail.andestech.com ([60.248.187.195]:47242 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLAFdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 00:33:47 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0B15XHn0081932;
        Tue, 1 Dec 2020 13:33:17 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcfdc88 (10.0.15.120) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Dec 2020 13:32:56 +0800
Date:   Tue, 1 Dec 2020 13:32:57 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     Pekka Enberg <penberg@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "dslin1010@gmail.com" <dslin1010@gmail.com>,
        "Alan Quey-Liang Kao(?????????)" <alankao@andestech.com>
Subject: Re: [PATCH] riscv/mm: Prevent kernel module access user-space memory
 without uaccess routines
Message-ID: <20201201053257.GB7647@atcfdc88>
References: <20201130053037.27006-1-tesheng@andestech.com>
 <CAOJsxLH-tCyvydX_+djXNMpOAxW2Zr7rAZizLUwQVNyU8YreBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOJsxLH-tCyvydX_+djXNMpOAxW2Zr7rAZizLUwQVNyU8YreBg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0B15XHn0081932
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 04:07:03PM +0800, Pekka Enberg wrote:

Hi Pekka,
> On Mon, Nov 30, 2020 at 7:33 AM Eric Lin <tesheng@andestech.com> wrote:
> >
> > In the page fault handler, an access to user-space memory
> > without get/put_user() or copy_from/to_user() routines is
> > not resolved properly. Like arm and other architectures,
> > we need to let it die earlier in page fault handler.
> 
> Fix looks good to me. Can you elaborate on how you found the issue and
> how the bug manifests itself?

OK, I'll elaborate more on the commit message.

> 
> >
> > Signed-off-by: Eric Lin <tesheng@andestech.com>
> > Cc: Alan Kao <alankao@andestech.com>
> > ---
> >  arch/riscv/mm/fault.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index 3c8b9e433c67..a452cfa266a2 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -232,6 +232,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
> >         if (user_mode(regs))
> >                 flags |= FAULT_FLAG_USER;
> >
> > +       if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM)))
> > +               die(regs, "Accessing user space memory without uaccess routines\n");
> 
> Let's introduce a die_kernel_fault() helper (similar to arm64, for
> example) to ensure same semantics for the different kernel faults. You
> can extract the helper from no_context().

OK, I'll add a die_kernel_fault() helper function in v2.

Thanks for your review.

> 
> > +
> >         perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> >
> >         if (cause == EXC_STORE_PAGE_FAULT)
> > --
> > 2.17.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
