Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6831A2F6F82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbhAOAbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:31:31 -0500
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:34532 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731129AbhAOAba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:31:30 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 136D7182CF665;
        Fri, 15 Jan 2021 00:30:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3872:4321:5007:6119:6120:6742:7652:7901:7903:10004:10400:10848:11232:11658:11914:12297:12660:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: grip76_15176d22752b
X-Filterd-Recvd-Size: 2538
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Jan 2021 00:30:46 +0000 (UTC)
Message-ID: <eabb211c3ba394845ec3258d86406137f4c23b33.camel@perches.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for
 arm64
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 14 Jan 2021 16:30:45 -0800
In-Reply-To: <CAHk-=wjgvt1Ei72BTrEH5fgfqykVH-AYt56-7yBT8Lcprj7bEg@mail.gmail.com>
References: <20210112224832.10980-1-will@kernel.org>
         <161055398865.21762.12236232732054213928.b4-ty@arm.com>
         <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
         <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com>
         <20210113214436.GL1551@shell.armlinux.org.uk>
         <CAHk-=wjqGRXUp6KOdx-eHYEotGvY=a5tSY1mF-BkAcX2YAuBYw@mail.gmail.com>
         <CAMj1kXFaDNRbDvr43VLEHFRHHS0sGGcF=iTfES4sxPg-rZ34NA@mail.gmail.com>
         <CAHk-=wjHTpG+gMx9vqrZgo8Uw0NqA2kNjS87o63Zv3=WG2K3zA@mail.gmail.com>
         <fd3f26b7a70d3b90f1368c55532e463ef2fb9fa4.camel@perches.com>
         <CAHk-=wjgvt1Ei72BTrEH5fgfqykVH-AYt56-7yBT8Lcprj7bEg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-14 at 13:18 -0800, Linus Torvalds wrote:
> On Thu, Jan 14, 2021 at 11:52 AM Joe Perches <joe@perches.com> wrote:
> > 
> > Given the upgrade requirement, and how clang version requirements
> > constantly change, how much more difficult would it be for others
> > to use gcc 7.1 or higher now instead of later?
> 
> What was the argument for jumping all the way to gcc-7.1?
> 
> I do think we want to have real reasons we can point to, rather than a
> "just because".

KASAN v5 instead of all the old versions
gcc 7.1 supports fallthrough.

Probably more, but those might be sufficient.

