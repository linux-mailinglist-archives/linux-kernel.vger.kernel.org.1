Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162E92A5D0B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgKDDPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:15:24 -0500
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:56270 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729693AbgKDDPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:15:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 02CB4181D330D;
        Wed,  4 Nov 2020 03:15:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3871:3873:3874:4321:5007:6120:6691:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:21972:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: nail62_3a095bc272bd
X-Filterd-Recvd-Size: 1641
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Nov 2020 03:15:22 +0000 (UTC)
Message-ID: <8d02497f4565c3154d3f7bcf2968b56ccd945ab4.camel@perches.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Nov 2020 19:15:20 -0800
In-Reply-To: <CANiq72nnpdPSngjoOf=imLxZ2g0A7ZXe5nRjF0qf5AG1UCfXyw@mail.gmail.com>
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
         <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
         <f474396f8f47c303e3a3ac90a582c116e38e50e4.camel@perches.com>
         <CANiq72nnpdPSngjoOf=imLxZ2g0A7ZXe5nRjF0qf5AG1UCfXyw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-11-04 at 04:10 +0100, Miguel Ojeda wrote:
> On Wed, Nov 4, 2020 at 1:56 AM Joe Perches <joe@perches.com> wrote:
> > 
> > Do remember that this patch is for the current kernel and
> > not any old version that someone might be compiling.
> > 
> > The current kernel _requires_ clang 10.0+ and that would
> > obviously provide clang-format 10+ as well.
> 
> You can use clang-format without having ever built a kernel with Clang.

No one ever will use clang-format on the current kernel sources
without having a recent version of clang and clang-format.


