Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE91AE54D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 20:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgDQS54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 14:57:56 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:39608 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726432AbgDQS5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:57:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B4F0018043D11;
        Fri, 17 Apr 2020 18:57:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7974:10004:10400:10450:10455:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:19904:19999:21080:21627:21660:21740:21990:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:5,LUA_SUMMARY:none
X-HE-Tag: thing18_7f31ad0390b26
X-Filterd-Recvd-Size: 2149
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Apr 2020 18:57:53 +0000 (UTC)
Message-ID: <74934d9a6a53af38eb44e9062784ef720dac2a60.camel@perches.com>
Subject: Re: checkpatch.pl warning for "return" with value
From:   Joe Perches <joe@perches.com>
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Apr 2020 11:55:41 -0700
In-Reply-To: <8859753b-c7c9-78ec-20cc-ce424b436b13@amd.com>
References: <a1eea414-2422-3a9f-b9bb-1ab7d6113dd6@amd.com>
         <1a47c5c428968a0e1d0ac5b92ce7ebdd4014fd38.camel@perches.com>
         <8859753b-c7c9-78ec-20cc-ce424b436b13@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 14:52 -0400, Luben Tuikov wrote:
> On 2020-04-17 1:32 p.m., Joe Perches wrote:
[]
> > 	if (<atypical_condition>) {
> > 		...;
> > 		return <atypical_result>;
> > 	}
> > 
> > 	...;
> > 	return <typical_result>;
> > }
> > 
> > If you want to code it, and it works, go ahead, but I
> > won't attempt it because I think it's not appropriate.
> 
> For error checking, when the 2nd ellipsis is
> a long, long body of the function, so that the error
> checking is done at the top, then long body,
> then at the bottom we return some computed value.
> But in the case I have above, it's a compact if-else
> at the bottom of the function.

which could not be differentiated from a function like

{
	...;
	err = func(...);
	if (err) {
		report("err: %d\n", err);
		return err;
	}

	...;
	return 0;

> In the example I gave above, there is no "typical" or
> "atypical" condition--it's just checking a condition
> and deciding what to do, all at the bottom of
> a function. (And that condition, samples
> an external stimuli, which cannot be predicted.)
[]
> Since we're returning a different result and since
> it works fine with a triplet, could you fix the binary
> case above to not complain?

No.


