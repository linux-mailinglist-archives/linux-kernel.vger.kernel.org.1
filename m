Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177E1242CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHLQNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 12:13:00 -0400
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:46150 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726394AbgHLQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:12:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 03A5618224D6A;
        Wed, 12 Aug 2020 16:12:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3872:3874:4321:5007:7903:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30003:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: bikes50_180d8bd26fec
X-Filterd-Recvd-Size: 1729
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Aug 2020 16:12:57 +0000 (UTC)
Message-ID: <89523042b8d574fa49e7d5c52ec12f1f5f848773.camel@perches.com>
Subject: Re: [PATCH 20/44] staging: mfd: hi6421-spmi-pmic: fix some coding
 style issues
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Date:   Wed, 12 Aug 2020 09:12:56 -0700
In-Reply-To: <867108ee50302f933fade56f8c25ef775ade36b3.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
         <867108ee50302f933fade56f8c25ef775ade36b3.1597247164.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-12 at 17:56 +0200, Mauro Carvalho Chehab wrote:
> Checkpatch complains about some minor issues inside this
> driver that were not addressed by the previous patch.
> 
> Address them.
[]
> diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
[]
> @@ -38,7 +38,8 @@ struct hi6421_spmi_pmic {
>  	unsigned int				*irqs;
>  	int					irqnum;
>  	int					irqarray;
> -	struct hi6421_spmi_irq_mask_info 	irq_mask_addr;
> +
> +	struct hi6421_spmi_irq_mask_info	irq_mask_addr;
>  	struct hi6421_spmi_irq_info		irq_addr;
>  };

Was adding a blank line one of checkpatch complaints?
I doubt it. 

