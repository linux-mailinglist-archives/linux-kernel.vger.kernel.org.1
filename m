Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F78621EF50
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgGNLcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 07:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgGNLcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:32:16 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7E622203;
        Tue, 14 Jul 2020 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594726335;
        bh=TtYXJCaAfVAvmXpndjUmq8mNbDnr+kPGfgYNHKOGZfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K9OxxVXF0L5Tjod5E1qIyBeJa5zwBm4VZFHIxJUcNK2+Gu0v0neorOgsLghlxU5XY
         URaH5+u4Sz2oza/Acl3WTQ47DDv7ccQ1D6TA44pgArxCcjzH3E7g2hJIohyyOwRvhB
         BWbYBouIxFi4uOYS+4p1f8P7YxXfwPMztvQAITgk=
Date:   Tue, 14 Jul 2020 20:32:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Patrick =?UTF-8?B?U3TDpGhsaW4=?= <me@packi.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Atish Patra <atish.patra@wdc.com>, penberg@kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH v2 6/6] riscv: Add KPROBES_ON_FTRACE supported
Message-Id: <20200714203209.29d3a3b967238f0cf04c4c6e@kernel.org>
In-Reply-To: <CAJF2gTQcRYHPmyM_T9g2rYRDN2DPedO0+s5X-MOiEzaFX+xxmA@mail.gmail.com>
References: <1594261154-69745-1-git-send-email-guoren@kernel.org>
        <1594261154-69745-7-git-send-email-guoren@kernel.org>
        <20200710225017.5ce329485e911f99e17cd483@kernel.org>
        <CAJF2gTSfFY6qf7gZ9t80P-3cACWi3oEe4X8ek+_1nQZZT3Uk5w@mail.gmail.com>
        <20200712223748.9cb00fdf7938fbf7353c11cc@kernel.org>
        <CAJF2gTQcRYHPmyM_T9g2rYRDN2DPedO0+s5X-MOiEzaFX+xxmA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Tue, 14 Jul 2020 07:47:20 +0800
Guo Ren <guoren@kernel.org> wrote:

> Hi Masami,
> 
> On Sun, Jul 12, 2020 at 9:37 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Sat, 11 Jul 2020 09:32:01 +0800
> > Guo Ren <guoren@kernel.org> wrote:
> >
> > > Thx Masami,
> > >
> > > On Fri, Jul 10, 2020 at 9:50 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > Hi Guo,
> > > >
> > > > On Thu,  9 Jul 2020 02:19:14 +0000
> > > > guoren@kernel.org wrote:
> > > >
> > > > > +/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> > > > > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > > > > +                        struct ftrace_ops *ops, struct pt_regs *regs)
> > > > > +{
> > > > > +     struct kprobe *p;
> > > > > +     struct kprobe_ctlblk *kcb;
> > > > > +
> > > > > +     p = get_kprobe((kprobe_opcode_t *)ip);
> > > > > +     if (unlikely(!p) || kprobe_disabled(p))
> > > > > +             return;
> > > > > +
> > > > > +     kcb = get_kprobe_ctlblk();
> > > > > +     if (kprobe_running()) {
> > > > > +             kprobes_inc_nmissed_count(p);
> > > > > +     } else {
> > > > > +             /*
> > > > > +              * The regs->epc hasn't been saved by SAVE_ALL in mcount-dyn.S
> > > > > +              * So no need to resume it, just for kprobe handler.
> > > > > +              */
> > > > > +             instruction_pointer_set(regs, ip);
> > > > > +             __this_cpu_write(current_kprobe, p);
> > > > > +             kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > > > > +             if (!p->pre_handler || !p->pre_handler(p, regs)) {
> > > > > +                     /*
> > > > > +                      * Emulate singlestep (and also recover regs->pc)
> > > > > +                      * as if there is a nop
> > > > > +                      */
> > > > > +                     instruction_pointer_set(regs,
> > > > > +                             (unsigned long)p->addr + MCOUNT_INSN_SIZE);
> > > > > +                     if (unlikely(p->post_handler)) {
> > > > > +                             kcb->kprobe_status = KPROBE_HIT_SSDONE;
> > > > > +                             p->post_handler(p, regs, 0);
> > > > > +                     }
> > > >
> > > > Hmm, don't you need restoring the previous instruction pointer here?
> > > look at  riscv mcount-dyn.S SAVE_ALL function, sp frame lay out like this:
> > > -----------------------
> > > | return address |
> > > -----------------------
> > > | frame pointer   |
> > > -----------------------
> > > | pt_regs x1-x31|
> > > -----------------------
> > > It's not a complete pt_regs for the handler, so modifing regs->ip is no use.
> >
> > Yes, that is same on x86. But ftrace regs_caller on x86-64 modifies the
> > return address on the stack by regs->ip.
> >
> > See arch/x86/kernel/ftrace_64.S:
> >
> > -----
> > SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
> >         call ftrace_stub
> >
> >         /* Copy flags back to SS, to restore them */
> >         movq EFLAGS(%rsp), %rax
> >         movq %rax, MCOUNT_REG_SIZE(%rsp)
> >
> >         /* Handlers can change the RIP */
> >         movq RIP(%rsp), %rax
> >         movq %rax, MCOUNT_REG_SIZE+8(%rsp)
> > -----
> Yes, and in save_mcount_regs, it prepare the origin pt_regs RIP.
> 
>          /* Move RIP to its proper location */
>         movq MCOUNT_REG_SIZE+\added(%rsp), %rdi
>         movq %rdi, RIP(%rsp)
> 
> I've fixed up riscv's: [1]
> [1]: https://lore.kernel.org/linux-riscv/1594683562-68149-4-git-send-email-guoren@kernel.org/T/#u

OK, looks good :)

> >
> > The last part update the return address on the stack.
> >
> > > > If you don't support modifying the instruction pointer in the handler,
> > > We can modify ip like this if necessary:
> > > *(unsigned long *)((unsigned long)regs + sizeof(struct pt_regs) + 8) = xxx;
> > >
> > > > it must not be compatible with kprobes.
> > > Why, can you show related codes? thank you very much.
> >
> > The "Changing Execution Path" section in the Documentation/kprobes.txt said
> >
> > -----
> > Since kprobes can probe into a running kernel code, it can change the
> > register set, including instruction pointer.
> > -----
> Got it, thx for correct me.
> 
> >
> > As you can see, this is the expected behavior on kprobes.
> > Since user will not know the kprobes is working on a breakpoint or
> > ftrace, we have to support this behavior transparently. So, could you
> > enable this feature at first on ftrace@RISCV?
> Ditto
> 
> >
> > >
> > > >
> > > > Now BPF function override and function error injection depends on
> > > > this behevior, so could you consider to support it in the "ftrace"
> > > > implementation at first? (And if it is enabled, you can enable the
> > > > livepatch on RISCV too)
> > > Great message!
> > >
> > > But can you show me codes that bpf and err-jnject using the behavior? Thx
> >
> > In kernel/fail_function.c
> Nice tip, thx. And I've tested err-jnject: [2]
> [2]: https://lore.kernel.org/linux-riscv/1594683562-68149-4-git-send-email-guoren@kernel.org/T/#md66e4e58f3463c1369e11ab9e5d646343f7d250d

Good! Thanks for porting it!


> 
> >
> > -----
> > static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
> > {
> >         struct fei_attr *attr = container_of(kp, struct fei_attr, kp);
> >
> >         if (should_fail(&fei_fault_attr, 1)) {
> >                 regs_set_return_value(regs, attr->retval);
> >                 override_function_with_return(regs);
> >                 return 1;
> >         }
> >
> >         return 0;
> > }
> > -----
> >
> > And follow the code related to CONFIG_BPF_KPROBE_OVERRIDE in
> > kernel/trace/bpf_trace.c. (doing similar thing, but fail_function.c
> > is simpler.)
> Nice tip, thx
> 
> --
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/


-- 
Masami Hiramatsu <mhiramat@kernel.org>
