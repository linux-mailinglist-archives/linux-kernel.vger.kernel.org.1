Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8EF2453CB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 00:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgHOWFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 18:05:54 -0400
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:45948 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729955AbgHOWFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:05:50 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id B2B4A80118C0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 03:17:28 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 80CFF100E7B6F;
        Sat, 15 Aug 2020 03:17:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3867:3868:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:9025:10004:10400:10848:11232:11657:11658:11914:12043:12297:12346:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21347:21365:21433:21627:30029:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bath02_460df3327002
X-Filterd-Recvd-Size: 1566
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 15 Aug 2020 03:17:27 +0000 (UTC)
Message-ID: <bc2ca9785cb7cf86c59c8922269d2dfc077ec3cc.camel@perches.com>
Subject: Re: [PATCH] genksyms: keywords: Use __restrict not _restrict
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Aug 2020 20:17:26 -0700
In-Reply-To: <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
References: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com>
         <CAKwvOd=8C94K-9VCqdCn9FXiyfDhKxMu=4AGem1bGgp8m6z0fw@mail.gmail.com>
         <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-14 at 20:05 -0700, Linus Torvalds wrote:
> On Fri, Aug 14, 2020 at 7:14 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > What's KAO? Urban dictionary has no entry. :^P
> 
> It goes back to 2003 and the original keywords.gperf file, see
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=46bd1da672d66ccd8a639d3c1f8a166048cca608
> 
> from the BK history conversion.
> 
> It might be Kai Germaschewski's tagger name?

I think it was Keith Owens.


