Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26BD1A3D65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 02:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgDJAcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 20:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgDJAcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:32:04 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9841020730;
        Fri, 10 Apr 2020 00:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586478723;
        bh=LPe85MPlN03SeI2UGqsjTdYexj98OPcXwyMr87lvQQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mYj08lmNPnEPkprSgYslwnr3pfiVFCjNxJZ9iGFg5R6G7lBOpLJHx5Jms92TnPwXq
         3Gllh+LdoXC3TTufcToSyOJNeITncA9AMxSX+0H5tlb50z8I3aSHnrB7kD7WgPd3m2
         mPDkG3KAwWHeQ8cre/W3old5jjksd25ezqUBpTSM=
Date:   Fri, 10 Apr 2020 09:31:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "bibo,mao" <bibo.mao@intel.com>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>
Subject: Re: [RFC] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
Message-Id: <20200410093159.0d7000a08fd76c2eaf1398f8@kernel.org>
In-Reply-To: <20200409201336.GH3309111@krava>
References: <20200408164641.3299633-1-jolsa@kernel.org>
        <20200409234101.8814f3cbead69337ac5a33fa@kernel.org>
        <20200409184451.GG3309111@krava>
        <20200409201336.GH3309111@krava>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, 9 Apr 2020 22:13:36 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> On Thu, Apr 09, 2020 at 08:45:01PM +0200, Jiri Olsa wrote:
> > On Thu, Apr 09, 2020 at 11:41:01PM +0900, Masami Hiramatsu wrote:
> > 
> > SNIP
> > 
> > > > ---
> > > >  kernel/kprobes.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > index 2625c241ac00..b13247cae752 100644
> > > > --- a/kernel/kprobes.c
> > > > +++ b/kernel/kprobes.c
> > > > @@ -1236,6 +1236,10 @@ __releases(hlist_lock)
> > > >  }
> > > >  NOKPROBE_SYMBOL(kretprobe_table_unlock);
> > > >  
> > > > +static struct kprobe kretprobe_dummy = {
> > > > +        .addr = (void *)kretprobe_trampoline,
> > > > +};
> > > > +
> > > >  /*
> > > >   * This function is called from finish_task_switch when task tk becomes dead,
> > > >   * so that we can recycle any function-return probe instances associated
> > > > @@ -1256,12 +1260,14 @@ void kprobe_flush_task(struct task_struct *tk)
> > > >  	INIT_HLIST_HEAD(&empty_rp);
> > > >  	hash = hash_ptr(tk, KPROBE_HASH_BITS);
> > > >  	head = &kretprobe_inst_table[hash];
> > > > +	__this_cpu_write(current_kprobe, &kretprobe_dummy);
> > > 
> > > Can you also set the kcb->kprobe_state = KPROBE_HIT_ACTIVE?
> > > 
> > > BTW, we may be better to introduce a common kprobe_reject_section_start()
> > > and kprobe_reject_section_end() so that the user don't need to prepare
> > > dummy kprobes.
> > 
> > sure, will do
> > 
> > thank you both for review
> 
> ok, found out it's actually arch code..  would you guys be ok with something like below?

Thanks for update!

> 
> jirka
> 
> 
> ---
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 4d7022a740ab..081d0f366c99 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -757,12 +757,33 @@ static struct kprobe kretprobe_kprobe = {
>  	.addr = (void *)kretprobe_trampoline,
>  };
>  
> +void arch_kprobe_reject_section_start(void)
> +{
> +	struct kprobe_ctlblk *kcb;
> +
> +	preempt_disable();
> +
> +	/*
> +	 * Set a dummy kprobe for avoiding kretprobe recursion.
> +	 * Since kretprobe never run in kprobe handler, kprobe must not
> +	 * be running behind this point.
> +	 */
> +	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
> +	kcb = get_kprobe_ctlblk();
> +	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +}

Yeah, the code seems good to me.

BTW, I rather like make it arch independent function so that other
arch can use it. In this case, the dummy kprobe's addr should be
somewhere obviously blacklisted (but it must be accessible.)
I think get_kprobe() will be a candidate.

And (sorry about changing my mind), the naming, I think kprobe_busy_begin()
and kprobe_busy_end() will be better because it doesn't reject registering
kprobes, instead, just make it busy :)

Thank you,

> +
> +void arch_kprobe_reject_section_end(void)
> +{
> +	__this_cpu_write(current_kprobe, NULL);
> +	preempt_enable();
> +}
> +
>  /*
>   * Called from kretprobe_trampoline
>   */
>  __used __visible void *trampoline_handler(struct pt_regs *regs)
>  {
> -	struct kprobe_ctlblk *kcb;
>  	struct kretprobe_instance *ri = NULL;
>  	struct hlist_head *head, empty_rp;
>  	struct hlist_node *tmp;
> @@ -772,16 +793,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
>  	void *frame_pointer;
>  	bool skipped = false;
>  
> -	preempt_disable();
> -
> -	/*
> -	 * Set a dummy kprobe for avoiding kretprobe recursion.
> -	 * Since kretprobe never run in kprobe handler, kprobe must not
> -	 * be running at this point.
> -	 */
> -	kcb = get_kprobe_ctlblk();
> -	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
> -	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +	arch_kprobe_reject_section_start();
>  
>  	INIT_HLIST_HEAD(&empty_rp);
>  	kretprobe_hash_lock(current, &head, &flags);
> @@ -873,8 +885,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
>  
>  	kretprobe_hash_unlock(current, &flags);
>  
> -	__this_cpu_write(current_kprobe, NULL);
> -	preempt_enable();
> +	arch_kprobe_reject_section_end();
>  
>  	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
>  		hlist_del(&ri->hlist);
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2625c241ac00..935dd8c87705 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1236,6 +1236,14 @@ __releases(hlist_lock)
>  }
>  NOKPROBE_SYMBOL(kretprobe_table_unlock);
>  
> +void __weak arch_kprobe_reject_section_start(void)
> +{
> +}
> +
> +void __weak arch_kprobe_reject_section_end(void)
> +{
> +}
> +
>  /*
>   * This function is called from finish_task_switch when task tk becomes dead,
>   * so that we can recycle any function-return probe instances associated
> @@ -1253,6 +1261,8 @@ void kprobe_flush_task(struct task_struct *tk)
>  		/* Early boot.  kretprobe_table_locks not yet initialized. */
>  		return;
>  
> +	arch_kprobe_reject_section_start();
> +
>  	INIT_HLIST_HEAD(&empty_rp);
>  	hash = hash_ptr(tk, KPROBE_HASH_BITS);
>  	head = &kretprobe_inst_table[hash];
> @@ -1266,6 +1276,8 @@ void kprobe_flush_task(struct task_struct *tk)
>  		hlist_del(&ri->hlist);
>  		kfree(ri);
>  	}
> +
> +	arch_kprobe_reject_section_end();
>  }
>  NOKPROBE_SYMBOL(kprobe_flush_task);
>  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
