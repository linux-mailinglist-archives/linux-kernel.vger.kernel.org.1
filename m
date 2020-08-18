Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D14248C07
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgHRQwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:52:24 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:51764 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726840AbgHRQwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:52:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2A3AF18029210;
        Tue, 18 Aug 2020 16:52:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:421:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3870:3871:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8957:9025:10004:10400:10848:11232:11658:11914:12043:12048:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:13845:14181:14659:14721:21080:21451:21627:21811:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: join51_5b0c31127020
X-Filterd-Recvd-Size: 1694
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Aug 2020 16:52:21 +0000 (UTC)
Message-ID: <15980e07c369b2cbfc7b06f58f3a521a5495bdf6.camel@perches.com>
Subject: Re: [PATCH] clang-format: Fix: Maximum line length is now 100
From:   Joe Perches <joe@perches.com>
To:     Alex Dewar <alex.dewar90@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Tue, 18 Aug 2020 09:52:20 -0700
In-Reply-To: <20200818162431.696423-1-alex.dewar90@gmail.com>
References: <20200818162431.696423-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 17:24 +0100, Alex Dewar wrote:
> Since commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
> warning") the kernel style is now for lines to be a maximum of 100 rather
> than 80 columns. Update .clang-format accordingly.
[]
> diff --git a/.clang-format b/.clang-format
[]
> @@ -52,7 +52,7 @@ BreakConstructorInitializersBeforeComma: false
>  #BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
>  BreakAfterJavaFieldAnnotations: false
>  BreakStringLiterals: false
> -ColumnLimit: 80
> +ColumnLimit: 100

No thank you.

100 is used for exceptional line length, not
for reformatting all lines up to 100 chars.

See the previous discussion about the same patch
submitted earlier in June:

https://lore.kernel.org/lkml/20200610125147.2782142-1-christian.brauner@ubuntu.com/


