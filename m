Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D986E2F523B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbhAMSea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:34:30 -0500
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:57348 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728441AbhAMSe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:34:29 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B373F100E7B46;
        Wed, 13 Jan 2021 18:33:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2561:2564:2682:2685:2693:2828:2859:2902:2904:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6117:6119:6120:6742:7652:7901:7903:8985:9025:9040:10004:10400:10848:10967:11232:11658:11783:11914:12043:12295:12297:12740:12895:13069:13141:13230:13311:13357:13439:13894:14181:14659:14721:21080:21611:21627:21939:21987:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: move37_071180b27520
X-Filterd-Recvd-Size: 2521
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 Jan 2021 18:33:45 +0000 (UTC)
Message-ID: <4d985bb8b1b9b382cf8e818a8761aa6268d7bc62.camel@perches.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for
 arm64
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Florian Weimer <fweimer@redhat.com>
Date:   Wed, 13 Jan 2021 10:33:43 -0800
In-Reply-To: <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
References: <20210112224832.10980-1-will@kernel.org>
         <161055398865.21762.12236232732054213928.b4-ty@arm.com>
         <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-14 at 02:57 +0900, Masahiro Yamada wrote:
> On Thu, Jan 14, 2021 at 1:08 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > On Tue, 12 Jan 2021 22:48:32 +0000, Will Deacon wrote:
> > > GCC versions >= 4.9 and < 5.1 have been shown to emit memory references
> > > beyond the stack pointer, resulting in memory corruption if an interrupt
> > > is taken after the stack pointer has been adjusted but before the
> > > reference has been executed. This leads to subtle, infrequent data
> > > corruption such as the EXT4 problems reported by Russell King at the
> > > link below.
> > > 
> > > [...]
> > 
> > Applied to arm64 (for-next/fixes), thanks!
> > 
> > [1/1] compiler.h: Raise minimum version of GCC to 5.1 for arm64
> >       https://git.kernel.org/arm64/c/1f1244a5ddb7
[]
> Maybe, we can raise the minimal version to gcc 5.1
> for all architectures.

If really raising the required minimum, maybe use 7.1 so kasan v5
and fallthrough are always enabled too.

https://gcc.gnu.org/releases.html

GCC 7.1 	May 2, 2017
GCC 5.1 	April 22, 2015
GCC 4.9.0 	April 22, 2014

