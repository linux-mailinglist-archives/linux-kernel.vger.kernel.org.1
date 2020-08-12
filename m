Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83E9242D13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgHLQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 12:21:58 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:35168 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgHLQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:21:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1B41A8378BB9;
        Wed, 12 Aug 2020 16:21:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3873:4321:4605:5007:9036:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12296:12297:12438:12555:12740:12760:12895:13101:13255:13439:14096:14097:14659:14721:21080:21451:21627:21740:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: spot60_1a07ad626fec
X-Filterd-Recvd-Size: 3696
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Aug 2020 16:21:55 +0000 (UTC)
Message-ID: <fa2d01411982f3f0873a895f4790ce65d9d6d185.camel@perches.com>
Subject: Re: [PATCH 06/44] staging: spmi: hisi-spmi-controller: use le32
 macros where needed
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Date:   Wed, 12 Aug 2020 09:21:54 -0700
In-Reply-To: <910eeee38f1a13b5dc1d423aed3f7dc74bc48029.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
         <910eeee38f1a13b5dc1d423aed3f7dc74bc48029.1597247164.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-12 at 17:56 +0200, Mauro Carvalho Chehab wrote:
> Instead of manually using bswap_32(), just use the
> le32 macros.

Are you certain this code will now work on any endian cpu?

Maybe just use __swab32 instead

> diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
[]
> @@ -43,11 +42,6 @@
>  #define SPMI_APB_SPMI_CMD_TYPE_OFFSET			24
>  #define SPMI_APB_SPMI_CMD_LENGTH_OFFSET			20
>  
> -#define bswap_32(X)   \
> -    ((((u32)(X) & 0xff000000) >> 24) | \
> -     (((u32)(X) & 0x00ff0000) >> 8) | \
> -     (((u32)(X) & 0x0000ff00) << 8) | \
> -     (((u32)(X) & 0x000000ff) << 24))
>  #define SPMI_APB_SPMI_CMD_SLAVEID_OFFSET		16
>  #define SPMI_APB_SPMI_CMD_ADDR_OFFSET			0
>  
> @@ -179,14 +173,15 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
>  
>  	writel(cmd, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_CMD_BASE_ADDR);
>  
> -	rc = spmi_controller_wait_for_done(spmi_controller, spmi_controller->base, sid, addr);
> +	rc = spmi_controller_wait_for_done(spmi_controller,
> +					   spmi_controller->base, sid, addr);
>  	if (rc)
>  		goto done;
>  
>  	i = 0;
>  	do {
>  		data = readl(spmi_controller->base + chnl_ofst + SPMI_SLAVE_OFFSET * sid + SPMI_APB_SPMI_RDATA0_BASE_ADDR + i * SPMI_PER_DATAREG_BYTE);
> -		data = bswap_32(data);
> +		data = be32_to_cpu((__be32)data);
>  		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
>  			memcpy(buf, &data, sizeof(data));
>  			buf += sizeof(data);
> @@ -210,8 +205,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
>  {
>  	struct spmi_controller_dev *spmi_controller = dev_get_drvdata(&ctrl->dev);
>  	unsigned long flags;
> -	u32 cmd;
> -	u32 data = 0;
> +	u32 cmd, data;
>  	int rc;
>  	u32 chnl_ofst = SPMI_CHANNEL_OFFSET * spmi_controller->channel;
>  	u8 op_code, i;
> @@ -246,7 +240,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
>  
>  	i = 0;
>  	do {
> -		memset(&data, 0, sizeof(data));
> +		data = 0;
>  		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
>  			memcpy(&data, buf, sizeof(data));
>  			buf += sizeof(data);
> @@ -255,8 +249,8 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
>  			buf += (bc % SPMI_PER_DATAREG_BYTE);
>  		}
>  
> -		data = bswap_32(data);
> -		writel(data, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_WDATA0_BASE_ADDR + SPMI_PER_DATAREG_BYTE * i);
> +		writel((u32)cpu_to_be32(data),
> +		       spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_WDATA0_BASE_ADDR + SPMI_PER_DATAREG_BYTE * i);
>  		i++;
>  	} while (bc > i * SPMI_PER_DATAREG_BYTE);
>  

