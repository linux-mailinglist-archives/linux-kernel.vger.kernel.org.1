Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01492CF91B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 03:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbgLEC5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 21:57:21 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:26517 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEC5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 21:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1607137040; x=1638673040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qabLAuFSOM3fI0pF/kMA9dDbku312aICBDwTCbQ69vo=;
  b=HC959jnvm+0zBjngdjSQO8lFPEVDpf7+RebXlCxIWqQqA3v8sVVN78id
   hA4ni1ZRpl9HOfrEurvc5/LLjBsky4ezoWaI25MW4UGIWZWpyaEMUHqWc
   lvVbu7WXFesZS4omz98H0CMfNTXm3yyMGsgyIPBjP+GCrVayL8cNTYk9v
   w=;
X-IronPort-AV: E=Sophos;i="5.78,394,1599523200"; 
   d="scan'208";a="67453842"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 05 Dec 2020 02:56:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 7F87CA0601;
        Sat,  5 Dec 2020 02:56:29 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 5 Dec 2020 02:56:28 +0000
Received: from uc18d6cc16d755e.ant.amazon.com (10.43.162.53) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 5 Dec 2020 02:56:26 +0000
Date:   Sat, 5 Dec 2020 13:56:23 +1100
From:   Balbir Singh <sblbir@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <keescook@chromium.org>,
        <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <benh@kernel.crashing.org>, <x86@kernel.org>,
        <dave.hansen@intel.com>, <thomas.lendacky@amd.com>,
        <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 4/5] prctl: Hook L1D flushing in via prctl
Message-ID: <20201205025622.GA31680@uc18d6cc16d755e.ant.amazon.com>
References: <20201127065938.8200-1-sblbir@amazon.com>
 <20201127065938.8200-5-sblbir@amazon.com>
 <87eek59pui.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87eek59pui.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D33UWC002.ant.amazon.com (10.43.162.11) To
 EX13d01UWB002.ant.amazon.com (10.43.161.136)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:19:17PM +0100, Thomas Gleixner wrote:
> 
> Balbir,
> 
> On Fri, Nov 27 2020 at 17:59, Balbir Singh wrote:
> > +enum l1d_flush_out_mitigations {
> > +     L1D_FLUSH_OUT_OFF,
> > +     L1D_FLUSH_OUT_ON,
> > +};
> > +
> > +static enum l1d_flush_out_mitigations l1d_flush_out_mitigation __ro_after_init = L1D_FLUSH_OUT_ON;
> 
> Why default on and why stays it on when the CPU is not affected by L1TF ...
> 

Because we don't set the PRCTL is the processor is not affected by the
bug

> >  /* Default mitigation for TAA-affected CPUs */
> >  static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
> >  static bool taa_nosmt __ro_after_init;
> > @@ -379,6 +386,18 @@ static void __init taa_select_mitigation(void)
> >       pr_info("%s\n", taa_strings[taa_mitigation]);
> >  }
> >
> > +static int __init l1d_flush_out_parse_cmdline(char *str)
> > +{
> > +     if (!boot_cpu_has_bug(X86_BUG_L1TF))
> > +             return 0;
> 
> ... while here you check for L1TF.
> 
> Also shouldn't it be default off and enabled via command line?
> 

I chose the other way because the prctl is an opt-in as well

> > +static int l1d_flush_out_prctl_get(struct task_struct *task)
> > +{
> > +     int ret;
> > +
> > +     if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
> > +             return PR_SPEC_FORCE_DISABLE;
> > +
> > +     ret = test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
> 
> That ret indirection is pointless. Just make it if (test_....)

Sure, will do

> 
> > +static int l1d_flush_out_prctl_set(struct task_struct *task, unsigned long ctrl)
> > +{
> > +
> > +     if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
> > +             return -EPERM;
> 
> So here you check for off and then...
> 

Yes

> >  int enable_l1d_flush_for_task(struct task_struct *tsk)
> >  {
> > +     /*
> > +      * Do not enable L1D_FLUSH_OUT if
> > +      * b. The CPU is not affected by the L1TF bug
> > +      * c. The CPU does not have L1D FLUSH feature support
> > +      */
> > +
> > +     if (!boot_cpu_has_bug(X86_BUG_L1TF) ||
> > +                     !boot_cpu_has(X86_FEATURE_FLUSH_L1D))
> > +             return -EINVAL;
> 
> ... you check for the feature bits with a malformatted condition at some
> other place. It's not supported when these conditions are not there. So
> why having this check here?
> 
> > +
> >       set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
> >       return 0;
> >  }
> 
> Aside of that, why is this in tlb.c and not in bugs.c? There is nothing
> tlb specific in these enable/disable functions. They just fiddle with
> the TIF bit.
> 

I can move them over.

> > +/*
> > + * Sent to a task that opts into L1D flushing via the prctl interface
> > + * but ends up running on an SMT enabled core.
> > + */
> > +static void l1d_flush_kill(struct callback_head *ch)
> > +{
> > +     force_sig(SIGBUS);
> > +}
> > +
> >  static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
> >  {
> >       unsigned long next_tif = task_thread_info(next)->flags;
> >       unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
> > +     unsigned long next_mm;
> >
> >       BUILD_BUG_ON(TIF_SPEC_L1D_FLUSH != TIF_SPEC_IB + 1);
> > -     return (unsigned long)next->mm | spec_bits;
> > +     next_mm = (unsigned long)next->mm | spec_bits;
> > +
> > +     if ((next_mm & LAST_USER_MM_L1D_FLUSH) && this_cpu_read(cpu_info.smt_active)) {
> 
> Wheeee. Yet more unconditional checks on every context switch.

A task can only get here if it is affected by the bug (processor has
L1TF and L1D_FLUSH support) and the task opted in, I think what your
suggesting is that we avoid the check for all tasks (the signgle next_mm
& LAST_USER_MM_L1D_FLUSH) check as well?

> 
> > +             clear_ti_thread_flag(&next->thread_info, TIF_SPEC_L1D_FLUSH);
> > +             next->l1d_flush_kill.func = l1d_flush_kill;
> > +             task_work_add(next, &next->l1d_flush_kill, true);
> 
> int task_work_add(struct task_struct *task, struct callback_head *twork,
>                   enum task_work_notify_mode mode);
> 
> true is truly not a valid enum constant ....

:) I might really have added it when we were transitioning from true to
TWA_RESUME, I am surprised the compiler did not catch it, I'll move it
over.

> 
> > +     }
> 
> So you really want to have:
> 
> DEFINE_STATIC_KEY_FALSE(l1dflush_enabled);
> static bool l1dflush_mitigation __init_data;
> 
> and then with the command line option you set l1dflush_mitigation and in
> check_bugs() you invoke l1dflush_select_mitigation() which does:
> 
>        if (!l1dflush_mitigation || !boot_cpu_has_bug(X86_BUG_L1TF) ||
>            !boot_cpu_has(X86_FEATURE_FLUSH_L1D))
>                 return;
> 
>        static_branch_enable(&l1dflush_enabled);
> 
> and then in l1d_flush_out_prctl_set()
> 
>        if (!static_branch_unlikely(&l1dflush_enabled))
>                 return -ENOTSUPP;
> 
> Then make the whole switch machinery do:
> 
>       if (static_branch_unlikely(&l1dflush_enabled)) {
>             if (unlikely((next_mm | prev_mm) & LAST_USER_MM_L1D_FLUSH))
>                  l1dflush_evaluate(next_mm, prev_mm);
>       }
> 
> and l1dflush_evaluate()
> 
>      if (prev_mm & LAST_USER_MM_L1D_FLUSH)
>           l1d_flush();
> 
>      if ((next_mm & LAST_USER_MM_L1D_FLUSH) &&
>          this_cpu_read(cpu_info.smt_active)) {
> 
>           clear_ti_thread_flag(&next->thread_info, TIF_SPEC_L1D_FLUSH);
>           next->l1d_flush_kill.func = l1d_flush_kill;
>           task_work_add(next, &next->l1d_flush_kill, TWA_RESUME);
>      }
> 
> That way the overhead is on systems where the admin decides to enable it
> and if enabled the evaluation of prev_mm and next_mm is pushed out of
> line.
>

OK, I'll rewrite it and see how it looks

Thanks for the review,
Balbir Singh
