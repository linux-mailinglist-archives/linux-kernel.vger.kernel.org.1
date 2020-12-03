Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164262CDB81
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501902AbgLCQqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:46:21 -0500
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:59498 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728092AbgLCQqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:46:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2D823182CED28;
        Thu,  3 Dec 2020 16:45:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:2892:3138:3139:3140:3141:3142:3622:3866:3867:3870:3871:3872:3874:4321:5007:9108:10004:10400:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30054:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shock56_120e5e2273bd
X-Filterd-Recvd-Size: 1871
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu,  3 Dec 2020 16:45:36 +0000 (UTC)
Message-ID: <e9edd473b8bfc576b8b274c64fd74d021bc4f4d0.camel@perches.com>
Subject: Re: [PATCH] netfilter: conntrack: fix -Wformat
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 03 Dec 2020 08:45:34 -0800
In-Reply-To: <844b0184-a74b-4d0a-8470-69d58323391a@redhat.com>
References: <20201107075550.2244055-1-ndesaulniers@google.com>
         <4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com>
         <CAKwvOdn50VP4h7tidMnnFeMA1M-FevykP+Y0ozieisS7Nn4yoQ@mail.gmail.com>
         <26052c5a0a098aa7d9c0c8a1d39cc4a8f7915dd2.camel@perches.com>
         <CAKwvOdkv6W_dTLVowEBu0uV6oSxwW8F+U__qAsmk7vop6U8tpw@mail.gmail.com>
         <7ca84085-f8e1-6792-7d1c-455815986572@redhat.com>
         <CAKXUXMx0nSZqFfOF63J+awCpkPkgr-kuchUxd2-tuMbA2piD5A@mail.gmail.com>
         <844b0184-a74b-4d0a-8470-69d58323391a@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 06:39 -0800, Tom Rix wrote:
> I agree if it can be done in checkpatch it should.
> It is good to have multiple passes on cleaning.

true
 
> checkpatch is best at fixing new problems,
> clang-tidy-fix is best at fixing old problems.

checkpatch is a set of brainless regexes that operates on
incomplete information.  It's not a real parser nor compiler.

It's really only useful as a way to avoid trivial style issues.

