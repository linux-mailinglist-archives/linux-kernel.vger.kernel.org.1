Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37762AAD79
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 21:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgKHU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 15:58:59 -0500
Received: from smtprelay0088.hostedemail.com ([216.40.44.88]:39838 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727570AbgKHU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 15:58:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 339BD18029121;
        Sun,  8 Nov 2020 20:58:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:3873:4321:4384:5007:7514:7576:9108:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12296:12297:12438:12740:12895:13069:13095:13311:13357:13439:13894:14181:14659:14721:21080:21433:21451:21627:30009:30045:30054:30079:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bait61_5108df2272e6
X-Filterd-Recvd-Size: 1901
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Nov 2020 20:58:56 +0000 (UTC)
Message-ID: <2b8fb8823fe73f28ef77bbdd78c9c8b2105e3077.camel@perches.com>
Subject: Re: [PATCH] s390/qeth: remove useless if/else
From:   Joe Perches <joe@perches.com>
To:     xiakaixu1987@gmail.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Date:   Sun, 08 Nov 2020 12:58:55 -0800
In-Reply-To: <1604817287-11258-1-git-send-email-kaixuxia@tencent.com>
References: <1604817287-11258-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-08 at 14:34 +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Fix the following coccinelle report:
> 
> ./drivers/s390/net/qeth_l3_main.c:107:2-4: WARNING: possible condition with no effect (if == else)
> 
> Both branches are the same, so remove them.
[]
> diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
[]
> @@ -104,10 +104,7 @@ static bool qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
>  		qeth_l3_convert_addr_to_bits(ipatoe->addr, ipatoe_bits,
>  					  (ipatoe->proto == QETH_PROT_IPV4) ?
>  					  4 : 16);
> -		if (addr->proto == QETH_PROT_IPV4)
> -			rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
> -		else
> -			rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
> +		rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);

It's not always best to remove one branch.

Is this a copy/paste defect or is it useless?
Do you know which?
If you do, you should state this in the commit message.

