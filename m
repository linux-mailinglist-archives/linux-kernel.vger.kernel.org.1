Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE602FE051
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbhAUD6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 22:58:38 -0500
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:55276 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727891AbhAUDlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:41:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E9EBD837F24C;
        Thu, 21 Jan 2021 03:40:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2110:2393:2559:2562:2828:3138:3139:3140:3141:3142:3151:3352:3622:3865:3867:3868:3871:3873:4321:4552:5007:6119:7576:7652:8957:9010:10004:10400:10848:11232:11658:11914:12043:12048:12297:12740:12895:13069:13071:13095:13146:13163:13229:13230:13311:13357:13439:13894:14180:14181:14659:14721:21060:21080:21433:21451:21600:21627,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: robin65_1b0014627560
X-Filterd-Recvd-Size: 1916
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 Jan 2021 03:40:07 +0000 (UTC)
Message-ID: <6d4b70cd1a4e82ac9669b7341c05537f8741e4b6.camel@perches.com>
Subject: Re: [PATCH v2] scripts/spelling.txt: increase error-prone spell
 checking
From:   Joe Perches <joe@perches.com>
To:     ChunyouTang <tangchunyou@163.com>, akpm@linux-foundation.org,
        colin.king@canonical.com, david@redhat.com, xndchn@gmail.com,
        ebiggers@google.com, sjpark@amazon.de
Cc:     linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        tangchunyou@yulong.com
Date:   Wed, 20 Jan 2021 19:40:06 -0800
In-Reply-To: <20210121032952.2537-1-tangchunyou@163.com>
References: <20210121032952.2537-1-tangchunyou@163.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-21 at 11:29 +0800, ChunyouTang wrote:
> From: tangchunyou <tangchunyou@yulong.com>
> 
> Increase maping spelling error check

Hi again.  Thank you.  I appreciate the addition.

Your word choice here is slightly odd English.

When you 'increase' a spelling error check, you might better use another
word like 'improve' as 'increase' here tends to mean 'more errors' rather
than mean a new addition to the spelling correction list.

Next time, a better subject and commit message might be something like:

[PATCH] spelling.txt: Add maping -> mapping

Add an entry for maping and its mapping correction.

Signed-off-by: You <your_email@domain.tld>

cheers, Joe

> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
[]
> @@ -875,6 +875,7 @@ manger||manager
>  manoeuvering||maneuvering
>  manufaucturing||manufacturing
>  mappping||mapping
> +maping||mapping
>  matchs||matches
>  mathimatical||mathematical
>  mathimatic||mathematic


