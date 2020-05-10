Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919B71CCCBD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 19:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgEJRp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 13:45:28 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:38952 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726744AbgEJRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 13:45:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 298BC40FE;
        Sun, 10 May 2020 17:45:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6117:6120:7576:7901:7904:10004:10400:10848:11232:11658:11914:12114:12297:12663:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21627:21740:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: talk80_699fde1aeca31
X-Filterd-Recvd-Size: 1977
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 May 2020 17:45:25 +0000 (UTC)
Message-ID: <c78e00a05d19a6823e48c7bd50144f0563908a1a.camel@perches.com>
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Sun, 10 May 2020 10:45:24 -0700
In-Reply-To: <9590a4674863448e8b13fee5086fcf73@AcuMS.aculab.com>
References: <20200507224530.2993316-1-Jason@zx2c4.com>
         <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
         <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
         <20200508113336.2vdfdnc6tqyx4pu6@butterfly.localdomain>
         <CAK8P3a0dJ0vNnktcoWFiPKB4NJbeyf7nvwWf0YLyeUyxT5pvQg@mail.gmail.com>
         <c774d7371a9599526090e63e85f61e69bddf4795.camel@perches.com>
         <9590a4674863448e8b13fee5086fcf73@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-10 at 12:47 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 08 May 2020 16:06
> > On Fri, 2020-05-08 at 13:49 +0200, Arnd Bergmann wrote:
> > > Personally, I'm more interested in improving compile speed of the kernel
> > 
> > Any opinion on precompiled header support?
> 
> When ever I've been anywhere near it it is always a disaster.

A disaster? Why?

For a large commercial c only project, it worked well
by reducing a combined multi-include file, similar to
kernel.h here, to a single file.

That was before SSDs though and the file open times
might have been rather larger then.


