Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179ED28A971
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 20:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgJKSrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 14:47:37 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:36828 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727610AbgJKSrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:47:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0A703180A7FE4;
        Sun, 11 Oct 2020 18:47:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2689:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6117:6119:7903:7904:10004:10400:10848:11232:11658:11914:12043:12114:12297:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: moon91_6002c68271f4
X-Filterd-Recvd-Size: 1953
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 11 Oct 2020 18:47:35 +0000 (UTC)
Message-ID: <c99fef41f3cd28784c79dc8cee11e5e8409e7b40.camel@perches.com>
Subject: Re: git grep/sed to standardize "/* SPDX-License-Identifier:
 <license>"
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Date:   Sun, 11 Oct 2020 11:47:34 -0700
In-Reply-To: <CAHk-=wiKT9j821qfbb7cs10RPcoaWTtHCjuQzgmaMLk+zZeOOA@mail.gmail.com>
References: <307a7581abe24135ac243c3080d4ab9e7c044cbf.camel@perches.com>
         <CAHk-=wiKT9j821qfbb7cs10RPcoaWTtHCjuQzgmaMLk+zZeOOA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-11 at 11:42 -0700, Linus Torvalds wrote:
> On Tue, Oct 6, 2020 at 4:13 PM Joe Perches <joe@perches.com> wrote:
> > Almost all source files in the kernel use a standardized SPDX header
> > at line 1 with a comment /* initiator and terminator */:
> > 
> > /* SPDX-License-Identifier: <license> */
> > 
> > $ git grep -PHn '^/\* SPDX-License-Identifier:.*\*/\s*$' | \
> >   wc -l
> > 17847
> 
> That grep pattern makes zero sense.
> 
> Why would */ be special at all? It isn't.
> 
>   $ git grep SPDX-License-Identifier: | wc -l
>   52418
> 
> and a *LOT* of those are shell scripts and use "#", or are C sources
> and use "//" etc.
> 
> So your "standardization" is completely pointless. Anybody who expects
> that pattern just doing something fundamentally wrong, because the
> pattern you want to standardize around is simply not valid.

It's just a trivial grep pattern to determine if the c90 style
SPDX-License-Identifier is in an individual single line comment.

Almost all are.


