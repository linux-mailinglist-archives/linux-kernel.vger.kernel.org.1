Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB312C6D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 23:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgK0WRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 17:17:13 -0500
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:59776 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731783AbgK0WLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 17:11:06 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1FCA218043D23;
        Fri, 27 Nov 2020 22:10:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1434:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3653:3865:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7576:7903:9010:9025:9108:10004:10400:10848:11232:11658:11914:12043:12048:12297:12740:12895:13018:13019:13069:13161:13229:13311:13357:13439:13894:14181:14659:14721:21080:21324:21627:21788:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: vase42_2916d252738b
X-Filterd-Recvd-Size: 2116
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Nov 2020 22:10:47 +0000 (UTC)
Message-ID: <a4e796f8c0bfdb2c0a2816fa706d13cc0ae06d40.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS add D: tag for subsystem commit prefix
From:   Joe Perches <joe@perches.com>
To:     trix@redhat.com, apw@canonical.com, nickhu@andestech.com,
        green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 27 Nov 2020 14:10:46 -0800
In-Reply-To: <20201127214316.3045640-1-trix@redhat.com>
References: <20201127214316.3045640-1-trix@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-27 at 13:43 -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> From
> RFC MAINTAINERS tag for cleanup robot
> https://lkml.org/lkml/2020/11/21/190

I think this should be RFC.
It looks as as if it's only for subsystems through A

> The prefix used by subsystems in their commit log is arbitrary.
> To elimitate the time and effort to manually find a reasonable
> prefix, store the preferred prefix in the MAINTAINERS file.
> 
> Populate with reasonable prefixes using this algorithm.
> What did the maintainers use in their commits?
> If there were no maintainers commits then what did everyone
> else use in their commits.

The algorithm used to produce these prefixes should also be published.

> The results were manually reviewed and about 25% were rejected.

Because this isn't necessarily the best option.

I think an exception mechanism would be better than a specific
mechanism added to various entries.

>  # check MAINTAINERS entries for the right ordering too
> -			my $preferred_order = 'MRLSWQBCPTFXNK';
> +			my $preferred_order = 'MRLSWQBCPTFXNKD';
>  			if ($rawline =~ /^\+[A-Z]:/ &&
>  			    $prevrawline =~ /^[\+ ][A-Z]:/) {
>  				$rawline =~ /^\+([A-Z]):\s*(.*)/;

I'd prefer to keep the file and keyword list last.




