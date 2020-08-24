Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE48250897
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHXS4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 14:56:50 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:37484 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgHXS4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:56:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A9BF7180A7FDC;
        Mon, 24 Aug 2020 18:56:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2691:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3868:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8985:9025:10004:10400:10848:11232:11658:11914:12043:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21627:21811:30054:30060:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: unit14_481660627055
X-Filterd-Recvd-Size: 1562
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Aug 2020 18:56:47 +0000 (UTC)
Message-ID: <1365f4ab2a833d2cdb089064b10570dcc6e8b985.camel@perches.com>
Subject: Re: [GIT PULL] fallthrough pseudo-keyword macro conversions for
 5.9-rc3
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Aug 2020 11:56:46 -0700
In-Reply-To: <CAHk-=wh8a8crLw5Lbs7C2Mz34fAUQn1tTHWqqOXCxbXF1bc_WA@mail.gmail.com>
References: <20200824034841.GA29995@embeddedor>
         <CAHk-=wh8a8crLw5Lbs7C2Mz34fAUQn1tTHWqqOXCxbXF1bc_WA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 11:46 -0700, Linus Torvalds wrote:
> I think I'd have preferred to get this as a couple of scripts that do
> the obvious 1:1 direct conversion of the simple cases that cover 90%
> of it all, so then the manual fixups separately.

I created a script and sent it directly to you last year.

https://lore.kernel.org/lkml/9fe980f7e28242c2835ffae34914c5f68e8268a7.camel@perches.com/

I believe that Gustavo uses a different script and some
manual fixups.

It would be good if Gustavo's script was public somewhere.

