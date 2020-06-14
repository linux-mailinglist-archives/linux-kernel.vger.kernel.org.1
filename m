Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E311F8A82
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 22:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgFNUCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 16:02:02 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:39492 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726844AbgFNUB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:01:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id ABA7C15C6;
        Sun, 14 Jun 2020 20:01:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:965:966:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2196:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3866:3867:3870:3871:3872:4321:4385:4390:4395:4605:5007:7903:8568:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: light02_2e08cc026df0
X-Filterd-Recvd-Size: 1857
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun, 14 Jun 2020 20:01:53 +0000 (UTC)
Message-ID: <803557cc672ef0bcd9565c7d5d78e7053388f5d7.camel@perches.com>
Subject: Re: [PATCH] coccinelle: api: add kzfree script
From:   Joe Perches <joe@perches.com>
To:     efremov@linux.com, Julia Lawall <Julia.Lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Date:   Sun, 14 Jun 2020 13:01:51 -0700
In-Reply-To: <345c783b-a8cf-9dd1-29c6-d32b9b29053f@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
         <e4981fd76a88e18376c4e634c235501b57d321e7.camel@perches.com>
         <345c783b-a8cf-9dd1-29c6-d32b9b29053f@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-06-14 at 22:42 +0300, Denis Efremov wrote:
> On 6/4/20 7:27 PM, Joe Perches wrote:
> > On Thu, 2020-06-04 at 17:08 +0300, Denis Efremov wrote:
> > > Check for memset() with 0 followed by kfree().
> > 
> > Perhaps those uses should be memzero_explicit or kvfree_sensitive.
> > 
> Is it safe to suggest to use kzfree instead of memzero_explicit && kfree?
> Or it would be better to use kvfree_sensitive in this case.
> kzfree uses memset(0) with no barrier_data.
> 
> For example:
> diff -u -p a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
[]
> @@ -1081,8 +1081,7 @@ static int safexcel_hmac_init_pad(struct
>                 }
>  
>                 /* Avoid leaking */
> -               memzero_explicit(keydup, keylen);
> -               kfree(keydup);
> +               kzfree(keydup);

It would be better to use kvfree_sensitive()


