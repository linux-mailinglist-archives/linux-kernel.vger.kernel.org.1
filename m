Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272832A89A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbgKEWWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732465AbgKEWWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:22:47 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA7F5206D4;
        Thu,  5 Nov 2020 22:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604614967;
        bh=W6P9EGgk/Hz7hh/sGeR/yi9cL4CFrlMuo539zWXNLAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFoRiM8fecMwx2zSlddYSlFtmVnCn8plHcajnHLgL3IxujVlIFjylh9Q43uRZtL1E
         4fvGJge39AuH0uPW3d3zCEnvp7D+bRNAt6ELh+9hSUiPfNJDpeHJCziSc7l9XKQSKC
         vsJsqH1nFcrlIyynG9G0PrwYcsx0Z+QdNYVaSWxw=
Date:   Thu, 5 Nov 2020 22:22:42 +0000
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>, Qian Cai <cai@redhat.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201105222242.GA8842@willie-the-truck>
References: <20201028182614.13655-1-cai@redhat.com>
 <160404559895.1777248.8248643695413627642.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160404559895.1777248.8248643695413627642.b4-ty@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 04:33:25PM +0000, Will Deacon wrote:
> On Wed, 28 Oct 2020 14:26:14 -0400, Qian Cai wrote:
> > The call to rcu_cpu_starting() in secondary_start_kernel() is not early
> > enough in the CPU-hotplug onlining process, which results in lockdep
> > splats as follows:
> > 
> >  WARNING: suspicious RCU usage
> >  -----------------------------
> >  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> > 
> > [...]
> 
> Applied to arm64 (for-next/fixes), thanks!
> 
> [1/1] arm64/smp: Move rcu_cpu_starting() earlier
>       https://git.kernel.org/arm64/c/ce3d31ad3cac

Hmm, this patch has caused a regression in the case that we fail to
online a CPU because it has incompatible CPU features and so we park it
in cpu_die_early(). We now get an endless spew of RCU stalls because the
core will never come online, but is being tracked by RCU. So I'm tempted
to revert this and live with the lockdep warning while we figure out a
proper fix.

What's the correct say to undo rcu_cpu_starting(), given that we cannot
invoke the full hotplug machinery here? Is it correct to call
rcutree_dying_cpu() on the bad CPU and then rcutree_dead_cpu() from the
CPU doing cpu_up(), or should we do something else?

Will
