Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C98296AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372243AbgJWIDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:03:23 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:49598 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2898418AbgJWIDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:03:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 76F86182CED2A;
        Fri, 23 Oct 2020 08:03:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4362:5007:6119:7903:7974:8700:10004:10400:10848:11026:11232:11658:11914:12043:12050:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21325:21627:21939:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: sort57_5a0f0a927258
X-Filterd-Recvd-Size: 2339
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 23 Oct 2020 08:03:20 +0000 (UTC)
Message-ID: <64b49cd3680f45808dad286b408e7b196c31ec79.camel@perches.com>
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to
 __section("foo")
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org
Date:   Fri, 23 Oct 2020 01:03:18 -0700
In-Reply-To: <CANiq72nfHjXkN65jy+unz0k66qvAALNhhhDZsxqPRLdtLKOW_Q@mail.gmail.com>
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
         <CANiq72nfHjXkN65jy+unz0k66qvAALNhhhDZsxqPRLdtLKOW_Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-23 at 08:08 +0200, Miguel Ojeda wrote:
> On Thu, Oct 22, 2020 at 4:36 AM Joe Perches <joe@perches.com> wrote:
> > 
> > Use a more generic form for __section that requires quotes to avoid
> > complications with clang and gcc differences.
> 
> I performed visual inspection (one by one...) and the only thing I saw
> is that sometimes the `__attribute__` has a whitespace afterwards and
> sometimes it doesn't, same for the commas inside, e.g.:
> 
> -  __used __attribute__((section(".modinfo"), unused, aligned(1)))  \
> +  __used __section(".modinfo") __attribute__((unused, aligned(1)))  \
> 
> and:
> 
> -    __attribute__ ((unused,__section__ ("__param"),aligned(sizeof(void *)))) \
> +    __section("__param") __attribute__ ((unused, aligned(sizeof(void *)))) \
> 
> I think the patch tries to follow the style of the replaced line, but
> for the commas in this last case it didn't. Anyway, it is not
> important.

Here the change follows the kernel style of space after comma.

> I can pick it up in my queue along with the __alias one and keep it
> for a few weeks in -next.

Thanks Miguel, but IMO it doesn't need time in next.

Applying it just before an rc1 minimizes conflicts.


