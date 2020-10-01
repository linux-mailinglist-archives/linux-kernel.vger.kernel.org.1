Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7827F792
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgJABoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:44:12 -0400
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:53716 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725800AbgJABoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:44:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7EE063648;
        Thu,  1 Oct 2020 01:44:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3874:4250:4321:4384:5007:7901:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13095:13311:13357:13439:13972:14161:14659:14721:21080:21433:21627:30009:30054:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: hate49_5204d4a27197
X-Filterd-Recvd-Size: 2746
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 01:44:09 +0000 (UTC)
Message-ID: <6cbd011cef2e52f39812bc8f6505fdd95f98d14d.camel@perches.com>
Subject: Re: [PATCH v5 09/15] misc: bcm-vk: add VK messaging support
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Date:   Wed, 30 Sep 2020 18:43:44 -0700
In-Reply-To: <20201001012810.4172-10-scott.branden@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
         <20201001012810.4172-10-scott.branden@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-30 at 18:28 -0700, Scott Branden wrote:
> Add message support in order to be able to communicate
> to VK card via message queues.

trivia:

> +/* structure that is used to faciliate displaying of register content */
> +struct bcm_vk_entry {
> +	const u32 mask;
> +	const u32 exp_val;
> +	const char *str;
> +};
[]
> +/*
> + * alerts that could be generated from peer
> + */
> +struct bcm_vk_entry const bcm_vk_peer_err[BCM_VK_PEER_ERR_NUM] = {

const struct bcm_vk_entry

> +	{ERR_LOG_UECC, ERR_LOG_UECC, "uecc"},
> +	{ERR_LOG_SSIM_BUSY, ERR_LOG_SSIM_BUSY, "ssim_busy"},
> +	{ERR_LOG_AFBC_BUSY, ERR_LOG_AFBC_BUSY, "afbc_busy"},
> +	{ERR_LOG_HIGH_TEMP_ERR, ERR_LOG_HIGH_TEMP_ERR, "high_temp"},
> +	{ERR_LOG_WDOG_TIMEOUT, ERR_LOG_WDOG_TIMEOUT, "wdog_timeout"},
> +	{ERR_LOG_SYS_FAULT, ERR_LOG_SYS_FAULT, "sys_fault"},
> +	{ERR_LOG_RAMDUMP, ERR_LOG_RAMDUMP, "ramdump"},
> +	{ERR_LOG_MEM_ALLOC_FAIL, ERR_LOG_MEM_ALLOC_FAIL, "malloc_fail warn"},
> +	{ERR_LOG_LOW_TEMP_WARN, ERR_LOG_LOW_TEMP_WARN, "low_temp warn"},
> +	{ERR_LOG_ECC, ERR_LOG_ECC, "ecc"},
> +};
> +
> +/* alerts detected by the host */
> +struct bcm_vk_entry const bcm_vk_host_err[BCM_VK_HOST_ERR_NUM] = {

here too

> +	{ERR_LOG_HOST_PCIE_DWN, ERR_LOG_HOST_PCIE_DWN, "PCIe_down"},
> +	{ERR_LOG_HOST_HB_FAIL, ERR_LOG_HOST_HB_FAIL, "hb_fail"},
> +	{ERR_LOG_HOST_INTF_V_FAIL, ERR_LOG_HOST_INTF_V_FAIL, "intf_ver_fail"},
> +};
[]
> @@ -970,6 +1251,9 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		}
>  	}
>  
> +	/* enable hb */
> +	bcm_vk_hb_init(vk);
> +
>  	dev_dbg(dev, "BCM-VK:%u created, 0x%p\n", id, vk);

Not much purpose in displaying the pointer.


