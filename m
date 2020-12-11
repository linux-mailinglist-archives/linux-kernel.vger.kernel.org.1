Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09CF2D7BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgLKQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:56:30 -0500
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:44428 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392006AbgLKQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:55:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 98932100E7B4A;
        Fri, 11 Dec 2020 16:55:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:3874:4321:5007:7576:7903:8531:10004:10400:10848:11026:11232:11658:11914:12048:12297:12740:12760:12895:13019:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21433:21627:30054:30064:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: way72_3403e2027402
X-Filterd-Recvd-Size: 2030
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Dec 2020 16:55:14 +0000 (UTC)
Message-ID: <c42cdf7d51ec880b4941a8e1b7ec855c9bc746e8.camel@perches.com>
Subject: Re: [PATCH -next] fs/xfs: convert comma to semicolon
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Eric Sandeen' <sandeen@sandeen.net>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 11 Dec 2020 08:55:12 -0800
In-Reply-To: <5f4ee9cf48a445cea25ba01bc9ffdf13@AcuMS.aculab.com>
References: <20201211084112.1931-1-zhengyongjun3@huawei.com>
         <fd372b27-983d-00ff-5218-4082fe2f08df@sandeen.net>
         <5f4ee9cf48a445cea25ba01bc9ffdf13@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-11 at 16:17 +0000, David Laight wrote:
> From: Eric Sandeen
> > Sent: 11 December 2020 15:51
> > 
> > On 12/11/20 2:41 AM, Zheng Yongjun wrote:
> > > Replace a comma between expression statements by a semicolon.
> > > 
> > > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> > 
> > hah, that's an old one.  Harmless though, AFAICT.
> > 
> > this fixes 91cca5df9bc8 ("[XFS] implement generic xfs_btree_delete/delrec")
> > if we dare add that tag ;)
> 
> It doesn't 'fix' anything, it is just stylistic.
> Completely harmless in every sense.

True, so it's not necessary to add a fixes tag here.

The only time a comma->semicolon conversion could 'fix'
something is when it's unintentionally used after something
like an if statement

	if (foo)
		bar(),
	baz();

where now baz() is performed only when the if condition is true
but the indentation indicates that it should always be performed.



