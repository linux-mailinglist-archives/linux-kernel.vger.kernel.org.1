Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB839242CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 18:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHLQRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 12:17:51 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:53540 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgHLQRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:17:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 473701802E60D;
        Wed, 12 Aug 2020 16:17:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3353:3622:3867:3870:3874:4321:4605:5007:7903:9036:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12296:12297:12438:12740:12760:12895:13069:13101:13311:13357:13439:14659:14721:21080:21611:21627:21990:30012:30046:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: play11_200348126fec
X-Filterd-Recvd-Size: 2835
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Aug 2020 16:17:48 +0000 (UTC)
Message-ID: <49f9d3c8dc8882e36bb8785ac9d6b75e5f35d77b.camel@perches.com>
Subject: Re: [PATCH 10/44] staging: spmi: hisi-spmi-controller: do some code
 cleanups
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date:   Wed, 12 Aug 2020 09:17:47 -0700
In-Reply-To: <49a517017f1efbfc97cb0e88f151dc2844d54351.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
         <49a517017f1efbfc97cb0e88f151dc2844d54351.1597247164.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-12 at 17:56 +0200, Mauro Carvalho Chehab wrote:
> There are several minor things that can be cleanup in
> order to make this driver more prepared for leaving staging.

trivial style notes:

> diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
[]
> @@ -106,14 +83,13 @@ static int spmi_controller_wait_for_done(struct device *dev,
>  					 struct spmi_controller_dev *ctrl_dev,
>  					 void __iomem *base, u8 sid, u16 addr)
>  {
> -	u32 status = 0;
>  	u32 timeout = SPMI_CONTROLLER_TIMEOUT_US;
> -	u32 offset;
> +	u32 status, offset;
>  
>  	offset  = SPMI_APB_SPMI_STATUS_BASE_ADDR;
>  	offset += SPMI_CHANNEL_OFFSET * ctrl_dev->channel + SPMI_SLAVE_OFFSET * sid;
>  
> -	while (timeout--) {
> +	do {
>  		status = readl(base + offset);
>  
>  		if (status & SPMI_APB_TRANS_DONE) {
> @@ -126,21 +102,21 @@ static int spmi_controller_wait_for_done(struct device *dev,
>  			return 0;
>  		}
>  		udelay(1);
> -	}
> +	}  while(timeout--);

Odd spacing.
Two spaces after close brace, none before open parenthesis.

> @@ -237,14 +217,13 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
[]
> -	i = 0;
> -	do {
> +	for (i = 0; bc > i * SPMI_PER_DATAREG_BYTE; i++) {
>  		data = 0;
>  		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
>  			memcpy(&data, buf, sizeof(data));
> @@ -256,22 +235,22 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
>  
>  		writel((u32)cpu_to_be32(data),
>  		       spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_WDATA0_BASE_ADDR + SPMI_PER_DATAREG_BYTE * i);
> -		i++;
> -	} while (bc > i * SPMI_PER_DATAREG_BYTE);
> +	};

Unnecessary semicolon after for loop close brace.


