Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4A1FD87C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 00:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgFQWNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 18:13:33 -0400
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:44702 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726835AbgFQWNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:13:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 816CB180905DE;
        Wed, 17 Jun 2020 22:13:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2898:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3872:3873:4321:5007:6119:10004:10400:10848:11026:11232:11658:11914:12048:12297:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14659:14721:21080:21220:21451:21627:21740:21795:21990:30012:30051:30054:30070:30079:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: boys91_3f16e1d26e0b
X-Filterd-Recvd-Size: 2453
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed, 17 Jun 2020 22:13:29 +0000 (UTC)
Message-ID: <dddfef643fc5bef1ff440f18c3dd12f586195a7c.camel@perches.com>
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, akpm@linuxfoundation.org,
        gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org
Date:   Wed, 17 Jun 2020 15:13:28 -0700
In-Reply-To: <20200617162536.611386-23-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
         <20200617162536.611386-23-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-17 at 10:25 -0600, Jim Cromie wrote:
> 1. Add a user-flag [u] which works like the [pfmlt] flags, but has no
> effect on callsite behavior; it allows incremental marking of
> arbitrary sets of callsites.
> 
> 2. Add [PFMLTU] flags, which negate their counterparts; P===!p etc.
> And in ddebug_read_flags():
>    current code does:	[pfmltu_] -> flags
>    copy it to:		[PFMLTU_] -> mask
> 
> also disallow both of a pair: ie no 'pP', no true & false.
> 
> 3. Add filtering ops into ddebug_change(), right after all the
> callsite-property selections are complete.  These filter on the
> callsite's current flagstate before applying modflags.
> 
> Why ?
> 
> The u-flag & filter flags
> 
> The 'u' flag lets the user assemble an arbitary set of callsites.
> Then using filter flags, user can activate the 'u' callsite set.
> 
>   #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
>   #> echo 'u+p' > control
> 
> Of course, you can continue to just activate your set without ever
> marking it 1st, but you could trivially add the markup as you go, then
> be able to use it as a constraint later, to undo or modify your set.

Does this set selection also allow for selection by
increasing decimal level?

Can sites be enabled for a value less than x?


