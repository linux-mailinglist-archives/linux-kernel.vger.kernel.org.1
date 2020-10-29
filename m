Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300E429EBB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgJ2MR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbgJ2MR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603973874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lB2c4MtlrXCuIdf9zq4VDJpB3FDpWBCyeSMN5PWwd28=;
        b=HCneTaK9HrGlpKuwuuFq9B/d+jQWOmCU16xLUG8eAy/JepaTFMQQnnRvBjmnEIYbWafKMw
        nW8lVWVNURI2uUvFKNgvvA3/jnJFkjC7SLYKsMsRnBf7iiHrXBQAdXWCColUHPYEwIP28N
        u/YHrbV6uVh1B1+wXgdrPLnrVElo/TI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-mBOwWrecNRmI0Qryrx8kiA-1; Thu, 29 Oct 2020 08:17:50 -0400
X-MC-Unique: mBOwWrecNRmI0Qryrx8kiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFD279CC00;
        Thu, 29 Oct 2020 12:17:48 +0000 (UTC)
Received: from ovpn-66-212.rdu2.redhat.com (ovpn-66-212.rdu2.redhat.com [10.10.66.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B38985B4A4;
        Thu, 29 Oct 2020 12:17:47 +0000 (UTC)
Message-ID: <15839584467d8f5e0715e377d9dd8c9d889dfd70.camel@redhat.com>
Subject: Re: [PATCH] powerpc/smp: Move rcu_cpu_starting() earlier
From:   Qian Cai <cai@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Oct 2020 08:17:47 -0400
In-Reply-To: <87lffpx598.fsf@mpe.ellerman.id.au>
References: <20201028182334.13466-1-cai@redhat.com>
         <87lffpx598.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-29 at 11:09 +1100, Michael Ellerman wrote:
> Qian Cai <cai@redhat.com> writes:
> > The call to rcu_cpu_starting() in start_secondary() is not early enough
> > in the CPU-hotplug onlining process, which results in lockdep splats as
> > follows:
> 
> Since when?

For me, it is since the commit in the link which looks now merged into
v5.10-rc1. Then, it needs CONFIG_PROVE_RCU_LIST=y.

> What kernel version?
> 
> I haven't seen this running CPU hotplug tests with PROVE_LOCKING=y on
> v5.10-rc1. Am I missing a CONFIG?
> 
> cheers
> 
> 
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
> >  Call Trace:
> >  dump_stack+0xec/0x144 (unreliable)
> >  lockdep_rcu_suspicious+0x128/0x14c
> >  __lock_acquire+0x1060/0x1c60
> >  lock_acquire+0x140/0x5f0
> >  _raw_spin_lock_irqsave+0x64/0xb0
> >  clockevents_register_device+0x74/0x270
> >  register_decrementer_clockevent+0x94/0x110
> >  start_secondary+0x134/0x800
> >  start_secondary_prolog+0x10/0x14
> > 
> > This is avoided by moving the call to rcu_cpu_starting up near the
> > beginning of the start_secondary() function. Note that the
> > raw_smp_processor_id() is required in order to avoid calling into
> > lockdep before RCU has declared the CPU to be watched for readers.
> > 
> > Link: 
> > https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> > Signed-off-by: Qian Cai <cai@redhat.com>
> > ---
> >  arch/powerpc/kernel/smp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 3c6b9822f978..8c2857cbd960 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -1393,13 +1393,14 @@ static void add_cpu_to_masks(int cpu)
> >  /* Activate a secondary processor. */
> >  void start_secondary(void *unused)
> >  {
> > -	unsigned int cpu = smp_processor_id();
> > +	unsigned int cpu = raw_smp_processor_id();
> >  
> >  	mmgrab(&init_mm);
> >  	current->active_mm = &init_mm;
> >  
> >  	smp_store_cpu_info(cpu);
> >  	set_dec(tb_ticks_per_jiffy);
> > +	rcu_cpu_starting(cpu);
> >  	preempt_disable();
> >  	cpu_callin_map[cpu] = 1;
> >  
> > -- 
> > 2.28.0

