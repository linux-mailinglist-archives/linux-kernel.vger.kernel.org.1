Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46002620E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgIHURU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgIHPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:10:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60BBC061A1C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yLRn39Afrdj+Ne8GAyMtKL8Y0JA13SEQt+AfAa1rXaw=; b=nDBz80KvfiVjxRsEPIF7SX1Frj
        ZFbTcxq30u1Z8LaFy58OseFcRMBFhPFGCOpYrPlro9QCccDQ7WMJszzfA+KUmqojvyIu4yqeWfZKq
        mbRMkfCKYucXiiZOSq3s3yC4kcVKVEAb2BeOtuTuRlTe9W2sJfqj/rblA6OUdroJClEv7/ySYqf3p
        xYsKXHp2VVdVVnDHTIeC2fixoCHwQ10XI4NSbDcMvurlUVy0YaSWyNfr6WaGLQsPWA6iacim41Rgy
        hSPbqjnjShB+eG8wb8mNouFVVwVsS2MJhj26YtZfFUspzh8rm/jfpWPAH3usZy/Rz4f+NAo+JFYu0
        O7N6VAVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFeVm-0001Kt-PN; Tue, 08 Sep 2020 14:22:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B2F2301A27;
        Tue,  8 Sep 2020 16:22:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3BA72B5FC944; Tue,  8 Sep 2020 16:22:15 +0200 (CEST)
Date:   Tue, 8 Sep 2020 16:22:15 +0200
From:   peterz@infradead.org
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        davem@davemloft.net
Subject: Re: [PATCH v2 10/11] lockdep: Only trace IRQ edges
Message-ID: <20200908142215.GU1362448@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.723775490@infradead.org>
 <20200902042137.GA163925@roeck-us.net>
 <20200902090935.GW1362448@hirez.programming.kicks-ass.net>
 <20200902091247.GX35926@hirez.programming.kicks-ass.net>
 <559ff09a-275b-21bf-15f1-daa0d02d1c76@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559ff09a-275b-21bf-15f1-daa0d02d1c76@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:48:30AM -0700, Guenter Roeck wrote:
> On 9/2/20 2:12 AM, peterz@infradead.org wrote:
> > On Wed, Sep 02, 2020 at 11:09:35AM +0200, peterz@infradead.org wrote:
> >> On Tue, Sep 01, 2020 at 09:21:37PM -0700, Guenter Roeck wrote:
> >>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4875 check_flags.part.39+0x280/0x2a0
> >>> [    0.000000] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> >>
> >>> [    0.000000] [<00000000004cff18>] lock_acquire+0x218/0x4e0
> >>> [    0.000000] [<0000000000d740c8>] _raw_spin_lock+0x28/0x40
> >>> [    0.000000] [<00000000009870f4>] p1275_cmd_direct+0x14/0x60
> >>
> >> Lol! yes, I can see that going side-ways... let me poke at that.
> > 
> > I suspect this will do.
> > 
> > diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
> > index 889aa602f8d8..7cfe88e30b52 100644
> > --- a/arch/sparc/prom/p1275.c
> > +++ b/arch/sparc/prom/p1275.c
> > @@ -38,7 +38,7 @@ void p1275_cmd_direct(unsigned long *args)
> >  	unsigned long flags;
> > 
> >  	local_save_flags(flags);
> > -	local_irq_restore((unsigned long)PIL_NMI);
> > +	arch_local_irq_restore((unsigned long)PIL_NMI);
> >  	raw_spin_lock(&prom_entry_lock);
> > 
> >  	prom_world(1);
> > 
> No, that doesn't help. Even removing that line entirely doesn't help.
> The problem seems to be that interrupts are not enabled in the first
> place. But why wasn't this a problem before ?

Previously every interrupt opt would disable/enable things, now we only
update state when something actually changes.

Anyway, I'm struggling with qemu-system-sparc64, I've got a sparc64
cross booting to mount, but I'm not seeing this, could you get me your
specific qemu cmdline please?
