Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4496829CB53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374179AbgJ0Ve7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:34:59 -0400
Received: from smtprelay0249.hostedemail.com ([216.40.44.249]:43808 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S374164AbgJ0Vez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:34:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 25582100E7B44;
        Tue, 27 Oct 2020 21:34:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:4321:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13141:13230:13311:13357:13439:14659:21080:21433:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bite12_160bff42727f
X-Filterd-Recvd-Size: 1984
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Oct 2020 21:34:52 +0000 (UTC)
Message-ID: <df5ec26c2d219d204eaac445571bc92de3f18e21.camel@perches.com>
Subject: Re: Subject: [RFC] clang tooling cleanups
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-toolchains@vger.kernel.org, Julia.Lawall@lip6.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
Date:   Tue, 27 Oct 2020 14:34:51 -0700
In-Reply-To: <cfad533d-1a9e-cf01-cefe-47c23de27a33@redhat.com>
References: <20201027164255.1573301-1-trix@redhat.com>
         <CAKwvOd=83v0Sv-NhQ5xgqdNSRm2b=pOJDziX8axZ9t2YyYwz-A@mail.gmail.com>
         <8abd1e5a-511a-e4f6-6f2c-a045d33fa2aa@redhat.com>
         <a4c58c21f0361f844588f5479f6fee33dc1a1dae.camel@perches.com>
         <cfad533d-1a9e-cf01-cefe-47c23de27a33@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-27 at 14:09 -0700, Tom Rix wrote:
> On 10/27/20 12:51 PM, Joe Perches wrote:
[]
> > I hope a scripted patches mechanism will be established.
> 
> I would be interested in this as well.
> I already have a repo tracking next.
> I can code up a script to do the commits.
> Then we can poke at it with sticks and see if hooking it into next is worthwhile.

I presume it will be worthwhile.

I hope the robot will run compilation and integration tests against
this -next plus additional scripted patches repo.

I also hope the time required before integration it into -next itself
is short as running the robot for all arches seems relatively expensive.


