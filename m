Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D781C4628
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 20:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgEDSmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 14:42:09 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:52672 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEDSmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:42:08 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 2B96C18029DB6;
        Mon,  4 May 2020 18:35:11 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 00F7818020C3A;
        Mon,  4 May 2020 18:35:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2110:2393:2559:2562:2693:2828:2902:3138:3139:3140:3141:3142:3165:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6119:7514:8957:9040:10004:10400:10848:11026:11232:11473:11658:11914:12043:12295:12296:12297:12438:12555:12740:12760:12895:12986:13071:13095:13439:14093:14097:14180:14181:14659:14721:21060:21080:21365:21433:21451:21627:21889:21939:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: land94_2d10a22964a4d
X-Filterd-Recvd-Size: 3664
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 May 2020 18:35:09 +0000 (UTC)
Message-ID: <720cb674ce945c847c26c81e9cc6df56c743223e.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: allow commit description spans across
 three lines
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Date:   Mon, 04 May 2020 11:35:08 -0700
In-Reply-To: <20200504083706.GA30290@udknight>
References: <20200504083706.GA30290@udknight>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-04 at 16:37 +0800, Wang YanQing wrote:
> The current GIT_COMMIT_ID will report error when the commit description
> spans across three lines, for examples:
> "...
> To rehash a previous explanation given in commit 1c44ce560b4d ("net:
> mscc: ocelot: fix vlan_filtering when enslaving to bridge before link is
> up"), the switch driver operates the in a mode where a single VLAN can
> be transmitted as untagged on a particular egress port. That is the
> "native VLAN on trunk port" use case.
> ..."
> 
> The above changelog comes from commit 87b0f983f66f ("net: mscc: ocelot:
> fix untagged packet drops when enslaving to vlan aware bridge").
> 
> "...
> With the optimizations for TLB invalidation from commit 0cef77c7798a
> ("powerpc/64s/radix: flush remote CPUs out of single-threaded
> mm_cpumask"), the scope of a TLBI (global vs. local) can now be
> ..."
> 
> The above changelog comes from commit cca19f0b684f ("powerpc/64s/radix: Fix
> missing global invalidations when removing copro").
> 
> The total length of commit description ("commit"+"12+ SHA1"+("title line"))
> exceeds 85 isn't uncommon thing, and it isn't uncommon thing that the ~85
> characters span across three lines, see above examples.
> 
> This patch adds support to recognize commit description which spans across
> three lines, then it will not emit error message for such situation.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  Hi! Joe
>  
>  I have tested with below command:
>  git log -10000 --format=%H -i --grep=" commit " | \
>  while read commit ; do \
>     echo $commit; \
>     ./scripts/checkpatch.pl --git $commit --types=GIT_COMMIT_ID --quiet --nosummary --color=never; \
>     done

trivial note here and actual notes below that:

I generally ignore the --merges commits.

It might be better to add --no-merges to the initial
command like:

$ git log <large_number> --no-merges ...

>  There are ~50 properly formed commit descriptions belong to this class, and I haven't check for
>  the non-standard commit descriptions, for examples:
>  3403e56b41c176f6531a2a6d77d85b46fa34169c
>  a78945c357f58665d6a5da8a69e085898e831c70
>  87b0f983f66f23762921129fd35966eddc3f2dae
>  ac8517440344dbe598f7c1c23e686c800b563061
>  cca19f0b684f4ed6aabf6ad07ae3e15e77bfd78a
>  53406ed1bcfdabe4b5bc35e6d17946c6f9f563e2
> 
>  This number isn't big, but they are all in properly formed format, so I think we should support them
>  and avoid emitting false positive error report.

Hi again.  Thanks for checking, seems reasonable.

This patch depends on the [V6] patch and I still have
some comments on that one to come so this can not be
applied at the moment.

cheers, Joe

