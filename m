Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DFF1D9DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgESRVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 13:21:12 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:37354 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729421AbgESRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:21:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BB0F318224D70;
        Tue, 19 May 2020 17:21:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4384:5007:8603:8985:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21627:21811:21990,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: bath79_4410d9c26d0e
X-Filterd-Recvd-Size: 2853
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 17:21:08 +0000 (UTC)
Message-ID: <ccdab3adb4c1fe9f814f55bc069f8ad2e4fe111b.camel@perches.com>
Subject: Re: lockdep tracing and using of printk return value ?
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Date:   Tue, 19 May 2020 10:21:07 -0700
In-Reply-To: <20200519144539.GB317569@hirez.programming.kicks-ass.net>
References: <335067f871a85db5f24650a3dff96f19727bed50.camel@perches.com>
         <20200519144539.GB317569@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-19 at 16:45 +0200, Peter Zijlstra wrote:
> On Tue, May 19, 2020 at 05:41:47AM -0700, Joe Perches wrote:
> > Except for some ancient code in drivers/scsi, this code
> > may be the only kernel use of the printk return value.
> 
> Is using the printk() return value a problem?

Maybe.  The printk code isn't obviously correct.

https://lore.kernel.org/lkml/20200518204415.d1a3adaba597ce5b232b4b2a@linux-foundation.org/

> > Code that uses the printk return value in
> > kernel/locking/lockdep.c is odd because the printk
> > return length includes both the length of a KERN_<LEVEL>
> > prefix and the newline.  depth also seems double counted.
> 
> Yeah, it seems dodgy. OTOH printk() really ought to discard the
> KERN_<level> crud from the return size.

Or change it to the actual output of '<' level '>'
instead of the internal KERN_SOH level.

> > Perhaps there's a better way to calculate this?
> > 
> > Maybe:
> > ---
> >  kernel/locking/lockdep.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 2fadc2635946..265227edc550 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -1960,11 +1960,9 @@ static void print_lock_class_header(struct lock_class *class, int depth)
> >  
> >  	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
> >  		if (class->usage_mask & (1 << bit)) {
> > -			int len = depth;
> > -
> > -			len += printk("%*s   %s", depth, "", usage_str[bit]);
> > -			len += printk(KERN_CONT " at:\n");
> > -			print_lock_trace(class->usage_traces[bit], len);
> > +			printk("%*s   %s at:\n", depth, "", usage_str[bit]);
> > +			print_lock_trace(class->usage_traces[bit],
> > +					 depth + 3 + strlen(usage_str[bit]);
> >  		}
> >  	}
> >  	printk("%*s }\n", depth, "");
> 
> Doesn't seem crazy...

