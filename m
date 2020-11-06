Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60E2A8C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgKFCPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:15:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgKFCPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604628931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nMiau+jB2NAVadVlE4lIKx50BpAJxCRzjB9cxthbDzE=;
        b=fORDaRHW33bh4BgAjdK48BRdtrUCfocm+OLZxCKKs1FHePo6q0wgvsqK8tmKqg+TLzvO5Y
        lKkaqSmNvxzyuw9L+MfGTVgpG/hUhNqPjdm3dimpJwv/vKJi03U45U/PRPUtthWZTtd0x7
        IMHQgPfn6mrxldH9NiOwsd696aLLe50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-mjNetBekP4qbiEIJBGsy_A-1; Thu, 05 Nov 2020 21:15:27 -0500
X-MC-Unique: mjNetBekP4qbiEIJBGsy_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 638308030B8;
        Fri,  6 Nov 2020 02:15:26 +0000 (UTC)
Received: from ovpn-114-171.rdu2.redhat.com (ovpn-114-171.rdu2.redhat.com [10.10.114.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BEA355794;
        Fri,  6 Nov 2020 02:15:25 +0000 (UTC)
Message-ID: <ec2de23c04e400266fcf98dfd282da0b173a68c3.camel@redhat.com>
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
From:   Qian Cai <cai@redhat.com>
To:     paulmck@kernel.org
Cc:     Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 05 Nov 2020 21:15:24 -0500
In-Reply-To: <20201105232813.GR3249@paulmck-ThinkPad-P72>
References: <20201028182614.13655-1-cai@redhat.com>
         <160404559895.1777248.8248643695413627642.b4-ty@kernel.org>
         <20201105222242.GA8842@willie-the-truck>
         <3b4c324abdabd12d7bd5346c18411e667afe6a55.camel@redhat.com>
         <20201105232813.GR3249@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-05 at 15:28 -0800, Paul E. McKenney wrote:
> On Thu, Nov 05, 2020 at 06:02:49PM -0500, Qian Cai wrote:
> > On Thu, 2020-11-05 at 22:22 +0000, Will Deacon wrote:
> > > On Fri, Oct 30, 2020 at 04:33:25PM +0000, Will Deacon wrote:
> > > > On Wed, 28 Oct 2020 14:26:14 -0400, Qian Cai wrote:
> > > > > The call to rcu_cpu_starting() in secondary_start_kernel() is not
> > > > > early
> > > > > enough in the CPU-hotplug onlining process, which results in lockdep
> > > > > splats as follows:
> > > > > 
> > > > >  WARNING: suspicious RCU usage
> > > > >  -----------------------------
> > > > >  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader
> > > > > section!!
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied to arm64 (for-next/fixes), thanks!
> > > > 
> > > > [1/1] arm64/smp: Move rcu_cpu_starting() earlier
> > > >       https://git.kernel.org/arm64/c/ce3d31ad3cac
> > > 
> > > Hmm, this patch has caused a regression in the case that we fail to
> > > online a CPU because it has incompatible CPU features and so we park it
> > > in cpu_die_early(). We now get an endless spew of RCU stalls because the
> > > core will never come online, but is being tracked by RCU. So I'm tempted
> > > to revert this and live with the lockdep warning while we figure out a
> > > proper fix.
> > > 
> > > What's the correct say to undo rcu_cpu_starting(), given that we cannot
> > > invoke the full hotplug machinery here? Is it correct to call
> > > rcutree_dying_cpu() on the bad CPU and then rcutree_dead_cpu() from the
> > > CPU doing cpu_up(), or should we do something else?
> > It looks to me that rcu_report_dead() does the opposite of
> > rcu_cpu_starting(),
> > so lift rcu_report_dead() out of CONFIG_HOTPLUG_CPU and use it there to
> > rewind,
> > Paul?
> 
> Yes, rcu_report_dead() should do the trick.  Presumably the earlier
> online-time CPU-hotplug notifiers are also unwound?
I don't think that is an issue here. cpu_die_early() set CPU_STUCK_IN_KERNEL,
and then __cpu_up() will see a timeout waiting for the AP online and then deal
with CPU_STUCK_IN_KERNEL according. Thus, something like this? I don't see
anything in rcu_report_dead() depends on CONFIG_HOTPLUG_CPU=y.

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 09c96f57818c..10729d2d6084 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -421,6 +421,8 @@ void cpu_die_early(void)
 
 	update_cpu_boot_status(CPU_STUCK_IN_KERNEL);
 
+	rcu_report_dead(cpu);
+
 	cpu_park_loop();
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2a52f42f64b6..bd04b09b84b3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4077,7 +4077,6 @@ void rcu_cpu_starting(unsigned int cpu)
 	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 /*
  * The outgoing function has no further need of RCU, so remove it from
  * the rcu_node tree's ->qsmaskinitnext bit masks.
@@ -4117,6 +4116,7 @@ void rcu_report_dead(unsigned int cpu)
 	rdp->cpu_started = false;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 /*
  * The outgoing CPU has just passed through the dying-idle state, and we
  * are being invoked from the CPU that was IPIed to continue the offline

