Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068DA1DBD82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgETTB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 15:01:28 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:59746 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbgETTB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:01:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 37B57100E7B40;
        Wed, 20 May 2020 19:01:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1.013,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:105:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3743:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6691:7996:8531:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:14777:21080:21324:21627:21939:21972:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: rest11_400c16426d18
X-Filterd-Recvd-Size: 2981
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 May 2020 19:01:25 +0000 (UTC)
Message-ID: <5725ba0a9efe2db07ff8c38ff673be172958d7ce.camel@perches.com>
Subject: Re: [PATCH] x86/uv/time: Replace one-element array and save heap
 space
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Wed, 20 May 2020 12:01:24 -0700
In-Reply-To: <202005201017.72D1B3A@keescook>
References: <20200518190114.GA7757@embeddedor>
         <b03d196cdbbbc6e9e8456910c6c6673ab67f76cb.camel@perches.com>
         <202005201017.72D1B3A@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-20 at 10:19 -0700, Kees Cook wrote:
> On Mon, May 18, 2020 at 12:09:16PM -0700, Joe Perches wrote:
> > On Mon, 2020-05-18 at 14:01 -0500, Gustavo A. R. Silva wrote:
> > > The current codebase makes use of one-element arrays in the following
> > > form:
> > > 
> > > struct something {
> > >     int length;
> > >     u8 data[1];
> > > };
> > []
> > > This issue has been out there since 2009.
> > > This issue was found with the help of Coccinelle and fixed _manually_.
> > []
> > > diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
[]
> > > @@ -156,9 +156,8 @@ static __init int uv_rtc_allocate_timers(void)
> > >  		struct uv_rtc_timer_head *head = blade_info[bid];
> > >  
> > >  		if (!head) {
> > > -			head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
> > > -				(uv_blade_nr_possible_cpus(bid) *
> > > -					2 * sizeof(u64)),
> > > +			head = kmalloc_node(struct_size(head, cpu,
> > > +				uv_blade_nr_possible_cpus(bid)),
> > 
> > It's probably safer to use kzalloc_node here as well.
> 
> Hm, I think it's not actually needed here.

Right. Turns out it's not needed.

> All three members are
> immediately initialized and it doesn't look to ever be copied to
> userspace.

It's more that the reader doesn't have to lookup the
struct to know all the members are initialized.

It's also not a fast path so any extra time to zero
is not significant.

> > >  				GFP_KERNEL, nid);
> > >  			if (!head) {
> > >  				uv_rtc_deallocate_timers();
> 
> FWIW, I think this change is good as-is. Always nice to get back a
> little memory. ;)

Saving space, 0 to 4 bytes at a time,
depending on the heap sizes...

Using the struct_size is clearer though, so that's good too.

cheers, Joe

