Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5342960FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900960AbgJVOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:37:25 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:42194 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2507890AbgJVOhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:37:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 14B69181D302B;
        Thu, 22 Oct 2020 14:37:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4184:4321:4362:5007:8985:9025:10004:10400:10471:10848:11232:11658:11914:12043:12297:12438:12555:12740:12760:12895:12986:13069:13161:13229:13255:13311:13357:13439:14180:14181:14659:14721:21060:21080:21627:21811:30029:30054:30083:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: look79_060935127251
X-Filterd-Recvd-Size: 1588
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 22 Oct 2020 14:37:22 +0000 (UTC)
Message-ID: <f9c354dae2e470e2982ea1e6d850b7380f149c10.camel@perches.com>
Subject: Re: Problem with checkpatch.pl (commit f5f613259f3f ("checkpatch:
 allow not using -f with files that are in git"))
From:   Joe Perches <joe@perches.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 22 Oct 2020 07:37:21 -0700
In-Reply-To: <82054b17-292d-3b3d-e95c-9abe7fa0c444@csgroup.eu>
References: <82054b17-292d-3b3d-e95c-9abe7fa0c444@csgroup.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-22 at 15:59 +0200, Christophe Leroy wrote:
> Hi,
> 
> Runnning ./scripts/checkpatch.pl -g HEAD, I get the following error:
> 
> Global symbol "$gitroot" requires explicit package name at ./scripts/checkpatch.pl line 980.
> Execution of ./scripts/checkpatch.pl aborted due to compilation errors.
> 
> Reverting commit f5f613259f3f ("checkpatch: allow not using -f with files that are in git") clears 
> the problem.
> 
> Christophe

Thanks for the report.

The problem depended on another patch in -next
that was not send.

https://lore.kernel.org/lkml/c5e23b45562373d632fccb8bc04e563abba4dd1d.camel@perches.com/


