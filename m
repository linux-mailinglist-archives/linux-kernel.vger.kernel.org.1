Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B920924EE0E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHWQE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 12:04:56 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:55286 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726502AbgHWQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 12:04:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id AD30118224D9C;
        Sun, 23 Aug 2020 16:04:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4384:5007:6119:7903:7904:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:21740:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: dirt18_190ae292704b
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Aug 2020 16:04:52 +0000 (UTC)
Message-ID: <a6fb2b6dcabb7cfd59b16a6fa1b4c49bbc73bb8f.camel@perches.com>
Subject: Re: [PATCH] hugetlb_cgroup: convert comma to semicolon
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xu Wang <vulab@iscas.ac.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Date:   Sun, 23 Aug 2020 09:04:51 -0700
In-Reply-To: <20200823152130.GA17456@casper.infradead.org>
References: <20200818064333.21759-1-vulab@iscas.ac.cn>
         <20200818184036.d6c479446b2c3b231d1e3bff@linux-foundation.org>
         <87eeo32gto.fsf@redhat.com> <20200823152130.GA17456@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-23 at 16:21 +0100, Matthew Wilcox wrote:
> On Wed, Aug 19, 2020 at 10:14:11AM +0200, Giuseppe Scrivano wrote:
> > > > -	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]),
> > > > +	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]);
> > > >  	cft->flags = CFTYPE_NOT_ON_ROOT;
> > 
> > I think in this case having two expressions as part of the same
> > statement is equivalent to having two separate statements.  Both
> > cft->file_offset and cft->flags get the expected value.
> 
> That's not how the comma operator works.
> 
> It will evaluate offsetof(struct hugetlb_cgroup, events_file[idx]) and
> then discard the result.  Since it has no side-effects, this is effectively
> doing:
> 
> 	cft->file_offset = cft->flags = CFTYPE_NOT_ON_ROOT;

$ gcc -x c -
#include <stdio.h>
#include <stdlib.h>

struct foo {
	int a;
	char b[50];
};

int main(int argc, char **argv)
{
	int a;
	int b;

	a = sizeof(struct foo), b = 1;

	printf("a: %d, b: %d\n", a, b);

	return 0;
}
$ ./a.out
a: 56, b: 1


