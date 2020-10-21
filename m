Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF68294F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444098AbgJUPMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443877AbgJUPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:12:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5A2C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iSoFOvDlIVqg+iDRJQH/i23SM8RP8IS427tENd0HYBY=; b=maa8g6ikUW8D4cABNj3Hz5NDM+
        v3K9gPktpt3FD17B9smtwikJARJaMtjt07rNFPpNmOKI8G7VIGuVNHWLpco9EomoXyheYT1YjHDV4
        Z/TrPIPhF7Sd6+MGCImgex4+V5BPNJ2jEnXR/kvrn1PtgjkuxDUfHsIZccBKa0N3VFdgDWbr3rF6P
        Nib1dSealW4PmapB3s3Nc4bUzXTMhY7lBABJ1ka/ZxVQU6XQFs+f0/2z/3i96qCw18K9pzfMwyL3r
        N9A40hiuXJ7NIPLotXwljkMgayzcZHrvAsb929Ti2Sf4j0AR2MaF4HBXHPPiT56qe0F4Okd7/QdEk
        R6WWEIZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVFn6-0001ca-PJ; Wed, 21 Oct 2020 15:12:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C7E13035D4;
        Wed, 21 Oct 2020 17:12:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D022B2BAC4B0D; Wed, 21 Oct 2020 17:12:37 +0200 (CEST)
Date:   Wed, 21 Oct 2020 17:12:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: using __this_cpu_read() in preemptible code in
 trace_hardirqs_on
Message-ID: <20201021151237.GK2628@hirez.programming.kicks-ass.net>
References: <000000000000e921b305b18ba0a7@google.com>
 <20201013091743.12c371a8@gandalf.local.home>
 <20201021131733.GH2628@hirez.programming.kicks-ass.net>
 <20201021103433.38fed220@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021103433.38fed220@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 10:34:33AM -0400, Steven Rostedt wrote:
> On Wed, 21 Oct 2020 15:17:33 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > And I'm also guessing that we can call this with interrupts enabled (based
> > > on the comment).
> > > 
> > > And we have this:
> > > 
> > >    local_irq_enable()
> > >       trace_hardirqs_on()
> > >          lockdep_hardirqs_on()
> > >              __this_cpu_read()  
> > 
> > Moo, two threads..
> > 
> > 20201019183355.GS2611@hirez.programming.kicks-ass.net
> 
> But this one's much older ;-)

Yeah, my mailbox is a trainwreck :/

> > 
> > ---
> > 
> > On Tue, Oct 20, 2020 at 12:55:46AM +0800, kernel test robot wrote:
> > > [   92.898145] BUG: using __this_cpu_read() in preemptible [00000000] code: trinity-c6/526  
> > 
> > > [   92.903305] Call Trace:
> > > [   92.905182]  __this_cpu_preempt_check+0xf/0x11
> > > [   92.905968]  lockdep_hardirqs_on_prepare+0x2c/0x18f
> > > [   92.906853]  trace_hardirqs_on+0x49/0x53
> > > [   92.907578]  __bad_area_nosemaphore+0x3a/0x134  
> > 
> > Hurph, that's a spurious local_irq_enable(). I suppose this'll fix it.
> > 
> > ---
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 3e99dfef8408..9f818145ef7d 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -4057,9 +4057,6 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
> >  	if (unlikely(in_nmi()))
> >  		return;
> >  
> > -	if (unlikely(__this_cpu_read(lockdep_recursion)))
> > -		return;
> > -
> >  	if (unlikely(lockdep_hardirqs_enabled())) {
> 
> Hmm, would moving the recursion check below the check of the
> lockdep_hardirqs_enable() cause a large skew in the spurious enable stats?
> May not be an issue, but something we should check to make sure that
> there's not a path that constantly hits this.

Anything that sets recursion will have interrupts disabled.
