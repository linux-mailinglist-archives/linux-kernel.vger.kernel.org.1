Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5952D0934
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 03:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgLGCdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 21:33:33 -0500
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:42220 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727040AbgLGCdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 21:33:33 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3BDF818224D60;
        Mon,  7 Dec 2020 02:32:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2914:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4321:4605:5007:6119:6737:7576:7875:8603:10004:10400:10848:11026:11232:11233:11473:11658:11914:12043:12048:12297:12438:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:21063:21080:21433:21451:21627:21990:30012:30054:30055:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: color32_1710dac273da
X-Filterd-Recvd-Size: 2830
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Dec 2020 02:32:48 +0000 (UTC)
Message-ID: <d33f6b90d50feb6c05bd45ffdedf3fb6d5ceb5ee.camel@perches.com>
Subject: Re: [PATCH 16/22] xlink-ipc: Add xlink ipc driver
From:   Joe Perches <joe@perches.com>
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        linux-doc@vger.kernel.org,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>
Date:   Sun, 06 Dec 2020 18:32:47 -0800
In-Reply-To: <20201201223511.65542-17-mgross@linux.intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
         <20201201223511.65542-17-mgross@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-01 at 14:35 -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Add xLink driver, which interfaces the xLink Core driver with the Keem
> Bay VPU IPC driver, thus enabling xLink to control and communicate with
> the VPU IP present on the Intel Keem Bay SoC.

Trivial style comments:

> diff --git a/drivers/misc/xlink-ipc/xlink-ipc.c b/drivers/misc/xlink-ipc/xlink-ipc.c

[]

> +/*
> + * xlink_reserved_memory_init() - Initialize reserved memory for the device.
> + *
> + * @xlink_dev:	[in] The xlink ipc device the reserved memory is allocated to.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +static int xlink_reserved_memory_init(struct xlink_ipc_dev *xlink_dev)
> +{
> +	struct device *dev = &xlink_dev->pdev->dev;
> +
> +	xlink_dev->local_xlink_mem.dev = init_xlink_reserved_mem_dev(dev,
> +								     "xlink_local_reserved",
> +								     LOCAL_XLINK_IPC_BUFFER_IDX);
> +	if (!xlink_dev->local_xlink_mem.dev)
> +		return -ENOMEM;

This sort of code, with a repeated struct dereference, generally reads
better using a temporary and is also less prone to typo use.

	struct device *dev = &xlink_dev->pdev->dev;
	struct xlink_buf_mem *lxm = &xlink_dev->local_xlink_mem;

	lxm->dev = init_xlink_reserved_mem_dev(dev, "xlink_local_reserved",
					       LOCAL_XLINK_IPC_BUFFER_IDX);
	if (!lxm->dev)
		return -ENOMEM;

> +	xlink_dev->local_xlink_mem.size = get_xlink_reserved_mem_size(dev,
> +								      LOCAL_XLINK_IPC_BUFFER_IDX);

	lxm->size = get_xlink_reserved_mem_size(dev, LOCAL_XLINK_IPC_BUFFER_IDX);

etc...



