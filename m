Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740101AE78B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 23:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgDQV1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 17:27:20 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:40672 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbgDQV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:27:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7C2DF100E7B43;
        Fri, 17 Apr 2020 21:27:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3871:3872:4321:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13160:13229:13311:13357:13439:14181:14659:21080:21433:21627:21660:21990:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cloth96_79c5a18faf91b
X-Filterd-Recvd-Size: 1404
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Apr 2020 21:27:16 +0000 (UTC)
Message-ID: <b2c2f344419156c75c6f58258cab6e7a60c2d4a9.camel@perches.com>
Subject: Re: checkpatch.pl warning for "return" with value
From:   Joe Perches <joe@perches.com>
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Apr 2020 14:25:04 -0700
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
> Also checking and returning from a function, doesn't
> always have to be binary. It could be,
> 
> 	if (A) {
> 		...;
> 		return X;
> 	} else if (B) {
> 		...;
> 		return Y;
> 	} else {
> 		...;
> 		return Z;
> 	}
> }
> 
> And interestingly, checkpatch.pl doesn't complain for
> the triplet above. But if I remove condition B, above,
> it does complain.

My recollection is false positives existed so the
else if case was not wanted.


