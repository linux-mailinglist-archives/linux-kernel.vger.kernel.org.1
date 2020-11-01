Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5022A21F0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgKAVnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 16:43:17 -0500
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:45618 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727056AbgKAVnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 16:43:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 77864180078BA;
        Sun,  1 Nov 2020 21:43:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2895:3138:3139:3140:3141:3142:3355:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:7903:7974:8527:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12663:12740:12895:13095:13161:13229:13439:13894:14181:14659:14721:21080:21433:21627:21740:21939:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: car71_170a629272aa
X-Filterd-Recvd-Size: 3553
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Nov 2020 21:43:14 +0000 (UTC)
Message-ID: <bc1a4a2a7ff69eeee131744881e1e8c72444be01.camel@perches.com>
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 01 Nov 2020 13:43:13 -0800
In-Reply-To: <20201101211910.GG27442@casper.infradead.org>
References: <cover.1604261483.git.joe@perches.com>
         <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
         <20201101204834.GF27442@casper.infradead.org>
         <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
         <20201101211910.GG27442@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-01 at 21:19 +0000, Matthew Wilcox wrote:
> On Sun, Nov 01, 2020 at 01:04:35PM -0800, Joe Perches wrote:
> > On Sun, 2020-11-01 at 20:48 +0000, Matthew Wilcox wrote:
> > > On Sun, Nov 01, 2020 at 12:12:51PM -0800, Joe Perches wrote:
> > > > @@ -4024,7 +4024,7 @@ int __init shmem_init(void)
> > > >  
> > > > 
> > > >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
> > > >  static ssize_t shmem_enabled_show(struct kobject *kobj,
> > > > -		struct kobj_attribute *attr, char *buf)
> > > > +				  struct kobj_attribute *attr, char *buf)
> > > >  {
> > > >  	static const int values[] = {
> > > >  		SHMEM_HUGE_ALWAYS,
> > > 
> > > Why?
> > 
> > why what?
> 
> Why did you change this?

Are you asking about the function argument alignment or the commit message?

The function argument alignment because the function is being updated.
The commit itself because sysfs_emit is the documented preferred interface.

> > > > @@ -4034,16 +4034,19 @@ static ssize_t shmem_enabled_show(struct kobject *kobj,
> > > >  		SHMEM_HUGE_DENY,
> > > >  		SHMEM_HUGE_FORCE,
> > > >  	};
> > > > -	int i, count;
> > > > -
> > > > -	for (i = 0, count = 0; i < ARRAY_SIZE(values); i++) {
> > > > -		const char *fmt = shmem_huge == values[i] ? "[%s] " : "%s ";
> > > > +	int len = 0;
> > > > +	int i;
> > > 
> > > Better:
> > > 	int i, len = 0;
> > 
> > I generally disagree as I think it better to have each declaration on an
> > individual line.
> 
> You're wrong.

I'm not wrong.  We just disagree.  Look for yourself at typical
declaration use in the kernel.  The typical style is single line
declarations.

That single declaration per line style is also documented in
coding-style.rst

"To this end, use just one data declaration per line (no commas for
multiple data declarations)"

> Look, this isn't performance sensitive code.  Just do something simple.
> 
> 		if (shmem_huge == values[i])
> 			buf += sysfs_emit(buf, "[%s]",
> 					shmem_format_huge(values[i]));
> 		else
> 			buf += sysfs_emit(buf, "%s",
> 					shmem_format_huge(values[i]));
> 		if (i == ARRAY_SIZE(values) - 1)
> 			buf += sysfs_emit(buf, "\n");
> 		else
> 			buf += sysfs_emit(buf, " ");
> 
> Shame there's no sysfs_emitc, but there you go.

I think what's there is simple.

And your suggested code doesn't work.
sysfs_emit is used for single emits.
sysfs_emit_at is used for multiple emits.


