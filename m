Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823A927F63A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbgI3XsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:48:10 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:51752 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732081AbgI3XsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:48:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 433AA180A7FFC;
        Wed, 30 Sep 2020 23:48:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3872:4321:4362:5007:6119:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: joke99_370c4f327196
X-Filterd-Recvd-Size: 1410
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 23:48:08 +0000 (UTC)
Message-ID: <255b00055133b148526b6dca0255109eec94e381.camel@perches.com>
Subject: Re: [PATCH] scripts/spelling.txt: fix malformed entry
From:   Joe Perches <joe@perches.com>
To:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Andy Whitcroft <apw@canonical.com>
Date:   Wed, 30 Sep 2020 16:48:07 -0700
In-Reply-To: <20200930234359.255295-1-ebiggers@kernel.org>
References: <20200930234359.255295-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-30 at 16:43 -0700, Eric Biggers wrote:
> One of the entries has three fields "mistake||correction||correction"
> rather than the expected two fields "mistake||correction".  Fix it.
[]
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
[]
> @@ -589,7 +589,7 @@ explictly||explicitly
>  expresion||expression
>  exprimental||experimental
>  extened||extended
> -exteneded||extended||extended
> +exteneded||extended
>  extensability||extensibility
>  extention||extension
>  extenstion||extension

Thanks

