Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D154296624
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371924AbgJVUpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:45:23 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:60532 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S371841AbgJVUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:45:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 9E644181D304D;
        Thu, 22 Oct 2020 20:45:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3874:4321:5007:6119:7903:10004:10400:10848:11658:11914:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tree02_40096f527253
X-Filterd-Recvd-Size: 1501
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 22 Oct 2020 20:45:20 +0000 (UTC)
Message-ID: <cdd73bbd6360a72b1fd41ee5fefc6a3b4a4e7688.camel@perches.com>
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to
 __section("foo")
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Thu, 22 Oct 2020 13:45:19 -0700
In-Reply-To: <CAKwvOdmUPA9XupXwYHy_qT7P+LrUc+wseT79K_oqw=3y6bwLfg@mail.gmail.com>
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
         <CAKwvOdmUPA9XupXwYHy_qT7P+LrUc+wseT79K_oqw=3y6bwLfg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-22 at 13:42 -0700, Nick Desaulniers wrote:
> .On Wed, Oct 21, 2020 at 7:36 PM Joe Perches <joe@perches.com> wrote:
> > Use a more generic form for __section that requires quotes to avoid
> > complications with clang and gcc differences.
[]
> >  a quick test of x86_64 and s390 would be good.

x86_64 was compiled here.
I believe the robot tested the others.

