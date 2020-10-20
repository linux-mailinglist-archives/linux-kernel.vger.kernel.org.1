Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF41F294289
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437779AbgJTSy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:54:29 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:58230 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437740AbgJTSy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:54:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6D6A21802150E;
        Tue, 20 Oct 2020 18:54:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7903:8957:9025:10004:10400:11232:11658:11914:12043:12050:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21939:30012:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shoe55_10129fa27242
X-Filterd-Recvd-Size: 2143
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 20 Oct 2020 18:54:26 +0000 (UTC)
Message-ID: <0cdbe9c56d73402be9e3b36a662c68515abcfae9.camel@perches.com>
Subject: Re: [RFC] treewide: cleanup unreachable breaks
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        George Burgess <gbiv@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>
Date:   Tue, 20 Oct 2020 11:54:25 -0700
In-Reply-To: <CAKwvOdmhqq0DT5csX6W8xDF=nuXgJJ_Rtc2xf++=Q9uA4tZEvw@mail.gmail.com>
References: <20201017160928.12698-1-trix@redhat.com>
         <20201018054332.GB593954@kroah.com>
         <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com>
         <3bc5c2e3b3edc22a4d167ec807ecdaaf8dcda76d.camel@perches.com>
         <CAKwvOdmhqq0DT5csX6W8xDF=nuXgJJ_Rtc2xf++=Q9uA4tZEvw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-20 at 11:51 -0700, Nick Desaulniers wrote:
> On Tue, Oct 20, 2020 at 11:42 AM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2020-10-19 at 12:42 -0700, Nick Desaulniers wrote:
> > > We probably should add all 3 to W=2 builds (wrapped in cc-option).
> > > I've filed https://github.com/ClangBuiltLinux/linux/issues/1180 to
> > > follow up on.
> > 
> > I suggest using W=1 as people that are doing cleanups
> > generally use that and not W=123 or any other style.
> > 
> > Every other use of W= is still quite noisy and these
> > code warnings are relatively trivially to fix up.
> 
> The 0day bot folks have enabled W=1 recently; hence the uptick in
> reports of -Wimplicit-function-declaration.
> 
> If it gets added to W=1, it's effectively "on by default" for new code
> tested by 0day bot.

And that would mean these get fixed faster no?
Isn't that a good thing?

