Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898072A77BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgKEHIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:08:23 -0500
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:58944 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726428AbgKEHIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:08:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 142CC180A8450;
        Thu,  5 Nov 2020 07:08:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2693:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6117:6119:6120:7875:7903:8957:9025:10004:10400:10848:11232:11658:11783:11914:12043:12297:12438:12679:12740:12895:13069:13149:13161:13229:13230:13311:13357:13439:13845:13894:14181:14659:14721:21080:21627:21740:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bean75_200cdb0272c8
X-Filterd-Recvd-Size: 2929
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Nov 2020 07:08:19 +0000 (UTC)
Message-ID: <1418629172bac8fe75fee59f13e1192dd1ae5e4e.camel@perches.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 04 Nov 2020 23:08:18 -0800
In-Reply-To: <CANiq72m0Rwu78AVjt71Ym55E_xvk6SSC5ZpMoS+WEt=ri2MgNQ@mail.gmail.com>
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
         <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
         <CAKwvOdmnz-DJ-hG5FKJZYF7W-ujPrgfMkrb2hMLhmzhk8Hx6dA@mail.gmail.com>
         <ba3126e1424c578f5040c7a6f04cdd6a334b2db4.camel@perches.com>
         <CAKwvOdmoR9xph_TK5zaKdh1qHX4Sh9MW9xYcxLJf6wZfxSkv2Q@mail.gmail.com>
         <CANiq72m0Rwu78AVjt71Ym55E_xvk6SSC5ZpMoS+WEt=ri2MgNQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-05 at 07:44 +0100, Miguel Ojeda wrote:
> There are a few important new features:

https://clang.llvm.org/docs/ClangFormatStyleOptions.html

>   - AlignConsecutiveMacros is probably one of the biggest one for the
> kernel that we were missing so far.

There's no control as to effective column nor sensible mechanism to
avoid extremely long indents with a single exceptional entry.

>   - IndentPPDirectives and

Some yes, mostly no.

AlignEscapedNewlines:

Generally the kernel uses column 72 but there's not real consistency.
clang-format doesn't have that option as far as I can tell.

> Then there are a few others that pertain to us too:
>   - SpaceBeforeSquareBrackets

no

>   - SpacesInConditionalStatement

no
 
>   - SpaceAfterLogicalNot

no

>   - SpaceInEmptyBlock

no

>   - IndentGotoLabels

no

> 
> Others are also worth checking to see if we can take advantage of them:
>   - IncludeBlocks (and configuring IncludeCategories etc.)

Might be worthwhile.  It's different by maintainer preference though.
Reverse Xmas tree is somewhat common in networking, (which I think is
silly, but DaveM likes it).  Some like alphabetic ordering, others
by order of include.

>   - StatementMacros

Kernel is not c++ so this is irrelevant for gcc macro statement expressions.

> Then there are others that are not related to us, but to be consistent
> we would explicitly set them in the file. Finally, for extra points,
> we could already document the new ones in LLVM 11 if any, for the
> future, but that is optional.
> 
> If no one is up for the task, I will eventually do it... :-)

Enjoy...

