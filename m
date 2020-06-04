Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28021EDE3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 09:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgFDHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 03:30:22 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:50026 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728149AbgFDH3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:29:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 73A8E7FD8D;
        Thu,  4 Jun 2020 07:29:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2393:2525:2553:2561:2564:2682:2685:2736:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:8985:9025:10004:10400:10848:11232:11658:11854:11914:12043:12295:12297:12740:12760:12895:13069:13071:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21324:21451:21627:30025:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wren59_311223326d95
X-Filterd-Recvd-Size: 2163
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jun 2020 07:29:39 +0000 (UTC)
Message-ID: <97eb5b4e4db4b50462032b1da0788dd61ed0a30e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Avoid missing typo suggestions
From:   Joe Perches <joe@perches.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 04 Jun 2020 00:29:36 -0700
In-Reply-To: <CAD8XO3bezWoM7Pc0VoiFgoDWTLMN6VwV1vEFL7PR=_iohV82Ag@mail.gmail.com>
References: <202006031618.DA25142@keescook>
         <a3c22bbd360d2148bf097d3c55a89ea13e07b719.camel@perches.com>
         <CAD8XO3bezWoM7Pc0VoiFgoDWTLMN6VwV1vEFL7PR=_iohV82Ag@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-04 at 09:55 +0300, Maxim Uvarov wrote:
> On Thu, 4 Jun 2020 at 03:39, Joe Perches <joe@perches.com> wrote:

Hi Maxim.

> > btw: My codespell dictionary file moved to
> > /usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt
> > 
> > and I had to use --codespell --codespellfile=(above) so
> > maybe there should be multiple lookups for this file
> > like the array below.
> > 
> > Are there other standard codespell dictionary locations?
> 
> It might be better to support standard and non standard locations.

It already does with the --codespellfile=<location> opti.

> I think it's better to request from codespell where his dictionary is.

Maybe a good idea, but looking at the codespell git, for
versions 1.17 on there are several standard dictionaries.
https://github.com/codespell-project/codespell/tree/v1.17.1/codespell_lib/data

> I created ticket for this:
> https://github.com/codespell-project/codespell/issues/1540

Even if codespell is updated, the script would have to deal
with older versions that don't support requesting that option.

cheers, Joe


