Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DE1FEB24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 07:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgFRFwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 01:52:22 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:52010 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgFRFwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:52:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1D4131DF8;
        Thu, 18 Jun 2020 05:52:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3874:4321:4605:5007:6119:7576:8957:9545:10004:10400:10471:10848:11232:11658:11914:11984:12043:12048:12114:12297:12683:12740:12760:12895:13069:13255:13311:13357:13439:14110:14181:14659:14721:21080:21451:21627:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: feast20_401413c26e0d
X-Filterd-Recvd-Size: 2106
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Jun 2020 05:52:19 +0000 (UTC)
Message-ID: <5dc6fb7ebfd1d38079d63e54d6fb2b05fa69001a.camel@perches.com>
Subject: Re: +
 scripts-deprecated_terms-recommend-denylist-allowlist-instead-of-blacklist-whitelist.patch
 added to -mm tree
From:   Joe Perches <joe@perches.com>
To:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        sj38.park@gmail.com, mpe@ellerman.id.au, jslaby@suse.cz,
        colin.king@canonical.com, sjpark@amazon.de,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Jun 2020 22:52:18 -0700
In-Reply-To: <20200617213222.OcDiV%akpm@linux-foundation.org>
References: <20200617213222.OcDiV%akpm@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-17 at 14:32 -0700, akpm@linux-foundation.org wrote:
> The patch titled
>      Subject: scripts/deprecated_terms: recommend denylist/allowlist instead of blacklist/whitelist
> has been added to the -mm tree.  Its filename is
>      scripts-deprecated_terms-recommend-denylist-allowlist-instead-of-blacklist-whitelist.patch
[]
> ------------------------------------------------------
> From: SeongJae Park <sjpark@amazon.de>
> Subject: scripts/deprecated_terms: recommend denylist/allowlist instead of blacklist/whitelist
> 
> This commit recommends that patches replace 'blacklist' and 'whitelist'
> with 'denylist' and 'allowlist', because the new suggestions are
> incontrovertible, doesn't make people hurt, and are more self-explanatory.
[]
> --- a/scripts/deprecated_terms.txt~scripts-deprecated_terms-recommend-denylist-allowlist-instead-of-blacklist-whitelist
> +++ a/scripts/deprecated_terms.txt
> @@ -3,3 +3,5 @@
>  # The format of each line is:
>  # deprecated||suggested
>  #
> +blacklist||denylist
> +whitelist||allowlist

I think this is a poor use of deprecated terms
as it has nothing to do with skin color.


