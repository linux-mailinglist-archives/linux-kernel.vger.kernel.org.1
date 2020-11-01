Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC22A21AE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 22:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgKAVEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 16:04:40 -0500
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:52056 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727004AbgKAVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 16:04:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2B96E837F24A;
        Sun,  1 Nov 2020 21:04:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3874:4321:5007:6119:7903:9389:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12895:13069:13161:13229:13311:13357:13439:13894:14659:14721:21080:21627:30012:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fork10_3615e0f272aa
X-Filterd-Recvd-Size: 2699
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Nov 2020 21:04:37 +0000 (UTC)
Message-ID: <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 01 Nov 2020 13:04:35 -0800
In-Reply-To: <20201101204834.GF27442@casper.infradead.org>
References: <cover.1604261483.git.joe@perches.com>
         <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
         <20201101204834.GF27442@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-01 at 20:48 +0000, Matthew Wilcox wrote:
> On Sun, Nov 01, 2020 at 12:12:51PM -0800, Joe Perches wrote:
> > @@ -4024,7 +4024,7 @@ int __init shmem_init(void)
> >  
> > 
> >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
> >  static ssize_t shmem_enabled_show(struct kobject *kobj,
> > -		struct kobj_attribute *attr, char *buf)
> > +				  struct kobj_attribute *attr, char *buf)
> >  {
> >  	static const int values[] = {
> >  		SHMEM_HUGE_ALWAYS,
> 
> Why?

why what?
 
> > @@ -4034,16 +4034,19 @@ static ssize_t shmem_enabled_show(struct kobject *kobj,
> >  		SHMEM_HUGE_DENY,
> >  		SHMEM_HUGE_FORCE,
> >  	};
> > -	int i, count;
> > -
> > -	for (i = 0, count = 0; i < ARRAY_SIZE(values); i++) {
> > -		const char *fmt = shmem_huge == values[i] ? "[%s] " : "%s ";
> > +	int len = 0;
> > +	int i;
> 
> Better:
> 	int i, len = 0;

I generally disagree as I think it better to have each declaration on an
individual line.

> > -		count += sprintf(buf + count, fmt,
> > -				shmem_format_huge(values[i]));
> > +	for (i = 0; i < ARRAY_SIZE(values); i++) {
> > +		len += sysfs_emit_at(buf, len,
> > +				     shmem_huge == values[i] ? "%s[%s]" : "%s%s",
> > +				     i ? " " : "",
> > +				     shmem_format_huge(values[i]));
> 
> This is ... complicated.  I thought the point of doing all the sysfs_emit
> stuff was to simplify things.

The removal of fmt allows the format and argument to be __printf verified.
Indirected formats do not generally allow that.

And using sysfs_emit is not really intended to simplify output code, it's
used to make sure there isn't a overflow of the PAGE_SIZE output buf when
using sprintf/snprintf.


