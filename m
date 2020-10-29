Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203C029ECB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgJ2NRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727037AbgJ2NRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603977461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XEpaEIxpTWb49xKr1k4jbQjU8TmDa6BwAWlhnfXaxBA=;
        b=e5UPcbY+SuvZFW6NSKLcgo7ml/vJmI/axU8z5z24WLYigpn4xDzF3iGS0xXDYvU98NkP6q
        DfX9cisjXhskXKJ/wZ5r5gag8TTRE06DzMZ8pPPvb5vhtiVOoYB2yQnYc0ZPdIG9i92M6f
        2nhhIEtUPpvrntWtbiGNzlIYuK3Ji/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-ThWAVCziP1OYqrWuhMmiOw-1; Thu, 29 Oct 2020 09:17:38 -0400
X-MC-Unique: ThWAVCziP1OYqrWuhMmiOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A7DACE669;
        Thu, 29 Oct 2020 13:17:37 +0000 (UTC)
Received: from ovpn-66-212.rdu2.redhat.com (ovpn-66-212.rdu2.redhat.com [10.10.66.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 844201002397;
        Thu, 29 Oct 2020 13:17:36 +0000 (UTC)
Message-ID: <4375b3c87d91af36509291ec18e98ed41420ec41.camel@redhat.com>
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
From:   Qian Cai <cai@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Oct 2020 09:17:35 -0400
In-Reply-To: <20201029091045.GA29890@willie-the-truck>
References: <20201028182614.13655-1-cai@redhat.com>
         <20201029091045.GA29890@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-29 at 09:10 +0000, Will Deacon wrote:
> On Wed, Oct 28, 2020 at 02:26:14PM -0400, Qian Cai wrote:
> > The call to rcu_cpu_starting() in secondary_start_kernel() is not early
> > enough in the CPU-hotplug onlining process, which results in lockdep
> > splats as follows:
> > 
> >  WARNING: suspicious RCU usage
> >  -----------------------------
> >  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> > 
> >  other info that might help us debug this:
> > 
> >  RCU used illegally from offline CPU!
> >  rcu_scheduler_active = 1, debug_locks = 1
> >  no locks held by swapper/1/0.
> > 
> >  Call trace:
> >   dump_backtrace+0x0/0x3c8
> >   show_stack+0x14/0x60
> >   dump_stack+0x14c/0x1c4
> >   lockdep_rcu_suspicious+0x134/0x14c
> >   __lock_acquire+0x1c30/0x2600
> >   lock_acquire+0x274/0xc48
> >   _raw_spin_lock+0xc8/0x140
> >   vprintk_emit+0x90/0x3d0
> >   vprintk_default+0x34/0x40
> >   vprintk_func+0x378/0x590
> >   printk+0xa8/0xd4
> >   __cpuinfo_store_cpu+0x71c/0x868
> >   cpuinfo_store_cpu+0x2c/0xc8
> >   secondary_start_kernel+0x244/0x318
> > 
> > This is avoided by moving the call to rcu_cpu_starting up near the
> > beginning of the secondary_start_kernel() function.
> 
> Hmm, it's not really a move though -- we'll end up calling this thing twice
> afaict. It would be better to make sure we've called notify_cpu_starting()
> early enough. Can we do that instead?

Paul mentioned that it is fine to call rcu_cpu_starting() multiple times, and
Peter mentioned that CPU bringup is complicated. Thus, I thought about doing
something safe here.

I tested a bit of patch below which seems fine, but I can't tell for sure if it
is safe. Any suggestion?

--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -224,6 +224,7 @@ asmlinkage notrace void secondary_start_kernel(void)
 
        preempt_disable();
        trace_hardirqs_off();
+       notify_cpu_starting(cpu);
 
        /*
         * If the system has established the capabilities, make sure
@@ -244,7 +245,6 @@ asmlinkage notrace void secondary_start_kernel(void)
        /*
         * Enable GIC and timers.
         */
-       notify_cpu_starting(cpu);
 
        ipi_setup(cpu);

