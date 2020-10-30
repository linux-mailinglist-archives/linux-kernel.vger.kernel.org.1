Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B529FF74
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgJ3IPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3IPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:15:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD2E22210;
        Fri, 30 Oct 2020 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604045710;
        bh=cL84aTK/24ewPnTFSjlH1fNL1pJ9MsG620CFfJNX3hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=puxtbR9uUjZdyiWmr+4ZjxFAl5O73WsfJab2/kLDNZ+sfSxEzyodJct4Nl5f3Lgki
         jdSjgsmj/W02Zmw9YROYXNke9y2R3lRYKmV6/Mnvg3p0PVRAypCt2PxkNY/eQ3zm3Z
         bX886FXedwZ3u007WJI2ZQKvsQQlQ+39Po1kXIik=
Date:   Fri, 30 Oct 2020 08:15:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201030081505.GA32066@willie-the-truck>
References: <20201028182614.13655-1-cai@redhat.com>
 <20201029091045.GA29890@willie-the-truck>
 <4375b3c87d91af36509291ec18e98ed41420ec41.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4375b3c87d91af36509291ec18e98ed41420ec41.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 09:17:35AM -0400, Qian Cai wrote:
> On Thu, 2020-10-29 at 09:10 +0000, Will Deacon wrote:
> > On Wed, Oct 28, 2020 at 02:26:14PM -0400, Qian Cai wrote:
> > > The call to rcu_cpu_starting() in secondary_start_kernel() is not early
> > > enough in the CPU-hotplug onlining process, which results in lockdep
> > > splats as follows:
> > > 
> > >  WARNING: suspicious RCU usage
> > >  -----------------------------
> > >  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> > > 
> > >  other info that might help us debug this:
> > > 
> > >  RCU used illegally from offline CPU!
> > >  rcu_scheduler_active = 1, debug_locks = 1
> > >  no locks held by swapper/1/0.
> > > 
> > >  Call trace:
> > >   dump_backtrace+0x0/0x3c8
> > >   show_stack+0x14/0x60
> > >   dump_stack+0x14c/0x1c4
> > >   lockdep_rcu_suspicious+0x134/0x14c
> > >   __lock_acquire+0x1c30/0x2600
> > >   lock_acquire+0x274/0xc48
> > >   _raw_spin_lock+0xc8/0x140
> > >   vprintk_emit+0x90/0x3d0
> > >   vprintk_default+0x34/0x40
> > >   vprintk_func+0x378/0x590
> > >   printk+0xa8/0xd4
> > >   __cpuinfo_store_cpu+0x71c/0x868
> > >   cpuinfo_store_cpu+0x2c/0xc8
> > >   secondary_start_kernel+0x244/0x318
> > > 
> > > This is avoided by moving the call to rcu_cpu_starting up near the
> > > beginning of the secondary_start_kernel() function.
> > 
> > Hmm, it's not really a move though -- we'll end up calling this thing twice
> > afaict. It would be better to make sure we've called notify_cpu_starting()
> > early enough. Can we do that instead?
> 
> Paul mentioned that it is fine to call rcu_cpu_starting() multiple times, and
> Peter mentioned that CPU bringup is complicated. Thus, I thought about doing
> something safe here.
> 
> I tested a bit of patch below which seems fine, but I can't tell for sure if it
> is safe. Any suggestion?

No, you're right -- this does look dodgy as I think we'll end up kicking the
CPU notifiers before things like CPU errata have been figured out. So I'll
pick up your original patch with Paul's ack. Thanks!

Will
