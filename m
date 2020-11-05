Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B282A8A5A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbgKEXC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:02:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731899AbgKEXC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604617376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JnHZYUF/teL6IX1yin+oJWg9fIjSJKlhuSAPesf84sw=;
        b=Yh0a9Cgk7GeqyaoauE9JBGwjf588Nr4lkRlr/t/pEymITO7ed0nEz2RueY3vd6vhmsmcTC
        0u/cT95zTjJP6CPR4EThR8sl2frt+NSk0gukkiwrq0YOmY9XGD3RgHxmCNTbUIkkLiY56R
        o3Gwm0eLc6HvF8NFfBpjv0dNX+R4UIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-IDS3vivjNVanTsHcHtjzIg-1; Thu, 05 Nov 2020 18:02:52 -0500
X-MC-Unique: IDS3vivjNVanTsHcHtjzIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09DFD6D242;
        Thu,  5 Nov 2020 23:02:51 +0000 (UTC)
Received: from ovpn-114-171.rdu2.redhat.com (ovpn-114-171.rdu2.redhat.com [10.10.114.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46A0C6198D;
        Thu,  5 Nov 2020 23:02:50 +0000 (UTC)
Message-ID: <3b4c324abdabd12d7bd5346c18411e667afe6a55.camel@redhat.com>
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
From:   Qian Cai <cai@redhat.com>
To:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 05 Nov 2020 18:02:49 -0500
In-Reply-To: <20201105222242.GA8842@willie-the-truck>
References: <20201028182614.13655-1-cai@redhat.com>
         <160404559895.1777248.8248643695413627642.b4-ty@kernel.org>
         <20201105222242.GA8842@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-05 at 22:22 +0000, Will Deacon wrote:
> On Fri, Oct 30, 2020 at 04:33:25PM +0000, Will Deacon wrote:
> > On Wed, 28 Oct 2020 14:26:14 -0400, Qian Cai wrote:
> > > The call to rcu_cpu_starting() in secondary_start_kernel() is not early
> > > enough in the CPU-hotplug onlining process, which results in lockdep
> > > splats as follows:
> > > 
> > >  WARNING: suspicious RCU usage
> > >  -----------------------------
> > >  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> > > 
> > > [...]
> > 
> > Applied to arm64 (for-next/fixes), thanks!
> > 
> > [1/1] arm64/smp: Move rcu_cpu_starting() earlier
> >       https://git.kernel.org/arm64/c/ce3d31ad3cac
> 
> Hmm, this patch has caused a regression in the case that we fail to
> online a CPU because it has incompatible CPU features and so we park it
> in cpu_die_early(). We now get an endless spew of RCU stalls because the
> core will never come online, but is being tracked by RCU. So I'm tempted
> to revert this and live with the lockdep warning while we figure out a
> proper fix.
> 
> What's the correct say to undo rcu_cpu_starting(), given that we cannot
> invoke the full hotplug machinery here? Is it correct to call
> rcutree_dying_cpu() on the bad CPU and then rcutree_dead_cpu() from the
> CPU doing cpu_up(), or should we do something else?
It looks to me that rcu_report_dead() does the opposite of rcu_cpu_starting(),
so lift rcu_report_dead() out of CONFIG_HOTPLUG_CPU and use it there to rewind,
Paul?

