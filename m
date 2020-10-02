Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FE7280FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgJBJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:16:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AEAC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 02:16:42 -0700 (PDT)
Received: from [2a0a:edc0:0:900:6245:cbff:fea0:1793] (helo=kresse.office.stw.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kOHB9-000716-8g; Fri, 02 Oct 2020 11:16:40 +0200
Message-ID: <6a37f1a67b4ed15abf0f2b93b8425ee77532a755.camel@pengutronix.de>
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@pengutronix.de
Date:   Fri, 02 Oct 2020 11:16:37 +0200
In-Reply-To: <CAHUa44EB4ee-+_arR6epGVGjo6woRfSj0LJ2P7fW5wq0HdiS+g@mail.gmail.com>
References: <20200918174543.13108-1-r.czerwinski@pengutronix.de>
         <CAHUa44EB4ee-+_arR6epGVGjo6woRfSj0LJ2P7fW5wq0HdiS+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:6245:cbff:fea0:1793
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=4.0 tests=AWL,BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH] tee: optee: replace might_sleep with cond_resched
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2020-09-25 at 08:59 +0200, Jens Wiklander wrote:
> On Fri, Sep 18, 2020 at 7:45 PM Rouven Czerwinski
> <r.czerwinski@pengutronix.de> wrote:
> > On Kernels with CONFIG_PREEMPT_NONE might_sleep() is not enough to force
> > rescheduling, replace it with a resched check and cond_resched. Fixes
> > the following stall:
> > 
> >   [  572.945146] rcu: INFO: rcu_sched self-detected stall on CPU
> >   [  572.949275] rcu:     0-....: (2099 ticks this GP) idle=572/1/0x40000002 softirq=7412/7412 fqs=974
> >   [  572.957964]  (t=2100 jiffies g=10393 q=21)
> >   [  572.962054] NMI backtrace for cpu 0
> >   [  572.965540] CPU: 0 PID: 165 Comm: xtest Not tainted 5.8.7 #1
> >   [  572.971188] Hardware name: STM32 (Device Tree Support)
> >   [  572.976354] [<c011163c>] (unwind_backtrace) from [<c010b7f8>] (show_stack+0x10/0x14)
> >   [  572.984080] [<c010b7f8>] (show_stack) from [<c0511e4c>] (dump_stack+0xc4/0xd8)
> >   [  572.991300] [<c0511e4c>] (dump_stack) from [<c0519abc>] (nmi_cpu_backtrace+0x90/0xc4)
> >   [  572.999130] [<c0519abc>] (nmi_cpu_backtrace) from [<c0519bdc>] (nmi_trigger_cpumask_backtrace+0xec/0x130)
> >   [  573.008706] [<c0519bdc>] (nmi_trigger_cpumask_backtrace) from [<c01a5184>] (rcu_dump_cpu_stacks+0xe8/0x110)
> >   [  573.018453] [<c01a5184>] (rcu_dump_cpu_stacks) from [<c01a4234>] (rcu_sched_clock_irq+0x7fc/0xa88)
> >   [  573.027416] [<c01a4234>] (rcu_sched_clock_irq) from [<c01acdd0>] (update_process_times+0x30/0x8c)
> >   [  573.036291] [<c01acdd0>] (update_process_times) from [<c01bfb90>] (tick_sched_timer+0x4c/0xa8)
> >   [  573.044905] [<c01bfb90>] (tick_sched_timer) from [<c01adcc8>] (__hrtimer_run_queues+0x174/0x358)
> >   [  573.053696] [<c01adcc8>] (__hrtimer_run_queues) from [<c01aea2c>] (hrtimer_interrupt+0x118/0x2bc)
> >   [  573.062573] [<c01aea2c>] (hrtimer_interrupt) from [<c09ad664>] (arch_timer_handler_virt+0x28/0x30)
> >   [  573.071536] [<c09ad664>] (arch_timer_handler_virt) from [<c0190f50>] (handle_percpu_devid_irq+0x8c/0x240)
> >   [  573.081109] [<c0190f50>] (handle_percpu_devid_irq) from [<c018ab8c>] (generic_handle_irq+0x34/0x44)
> >   [  573.090156] [<c018ab8c>] (generic_handle_irq) from [<c018b194>] (__handle_domain_irq+0x5c/0xb0)
> >   [  573.098857] [<c018b194>] (__handle_domain_irq) from [<c052ac50>] (gic_handle_irq+0x4c/0x90)
> >   [  573.107209] [<c052ac50>] (gic_handle_irq) from [<c0100b0c>] (__irq_svc+0x6c/0x90)
> >   [  573.114682] Exception stack(0xd90dfcf8 to 0xd90dfd40)
> >   [  573.119732] fce0:                                                       ffff0004 00000000
> >   [  573.127917] fd00: 00000000 00000000 00000000 00000000 00000000 00000000 d93493cc ffff0000
> >   [  573.136098] fd20: d2bc39c0 be926998 d90dfd58 d90dfd48 c09f3384 c01151f0 400d0013 ffffffff
> >   [  573.144281] [<c0100b0c>] (__irq_svc) from [<c01151f0>] (__arm_smccc_smc+0x10/0x20)
> >   [  573.151854] [<c01151f0>] (__arm_smccc_smc) from [<c09f3384>] (optee_smccc_smc+0x3c/0x44)
> >   [  573.159948] [<c09f3384>] (optee_smccc_smc) from [<c09f4170>] (optee_do_call_with_arg+0xb8/0x154)
> >   [  573.168735] [<c09f4170>] (optee_do_call_with_arg) from [<c09f4638>] (optee_invoke_func+0x110/0x190)
> >   [  573.177786] [<c09f4638>] (optee_invoke_func) from [<c09f1ebc>] (tee_ioctl+0x10b8/0x11c0)
> >   [  573.185879] [<c09f1ebc>] (tee_ioctl) from [<c029f62c>] (ksys_ioctl+0xe0/0xa4c)
> >   [  573.193101] [<c029f62c>] (ksys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x54)
> >   [  573.200750] Exception stack(0xd90dffa8 to 0xd90dfff0)
> >   [  573.205803] ffa0:                   be926bf4 be926a78 00000003 8010a403 be926908 004e3cf8
> >   [  573.213987] ffc0: be926bf4 be926a78 00000000 00000036 be926908 be926918 be9269b0 bffdf0f8
> >   [  573.222162] ffe0: b6d76fb0 be9268fc b6d66621 b6c7e0d8
> > 
> > seen on STM32 DK2.
> > 
> > Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > ---
> >  drivers/tee/optee/call.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 20b6fd7383c5..83b73b1d52f0 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/mm.h>
> >  #include <linux/slab.h>
> > +#include <linux/sched.h>
> >  #include <linux/tee_drv.h>
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> > @@ -148,7 +149,8 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
> >                          */
> >                         optee_cq_wait_for_completion(&optee->call_queue, &w);
> >                 } else if (OPTEE_SMC_RETURN_IS_RPC(res.a0)) {
> > -                       might_sleep();
> > +                       if(need_resched())

Missing space after if.

> > +                               cond_resched();
> 
> This looks OK to me. But I'd prefer if someone else could confirm this too.

The previous might_sleep() is wrong, as it is a debug annotation to
more easily find sleep while atomic bugs and will only ever have any
effect when CONFIG_DEBUG_ATOMIC_SLEEP is enabled. So I guess the commit
message here is also not fully right, as the now added cond_resched()
is the proper way to yield the CPU for both PREEMPT_VOLUNTARY and
PREEMPT_NONE configs.

Regards,
Lucas

