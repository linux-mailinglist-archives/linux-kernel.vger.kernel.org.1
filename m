Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27692D0944
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 04:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgLGDGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 22:06:20 -0500
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:55494 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727375AbgLGDGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 22:06:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6D4761730841;
        Mon,  7 Dec 2020 03:05:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2895:2901:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3873:3874:4250:4321:5007:6737:7576:7901:8603:8660:10004:10400:10471:10482:10848:11026:11232:11473:11658:11783:11914:12043:12048:12109:12296:12297:12438:12740:12895:12986:13148:13230:13255:13439:13894:14181:14659:14721:19901:19997:21080:21451:21627:21795:21939:21987:21990:30029:30051:30054:30064:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mask08_1a0dff5273db
X-Filterd-Recvd-Size: 3549
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Dec 2020 03:05:35 +0000 (UTC)
Message-ID: <3595d2e5e5de009730b3374bf65e96359c02392d.camel@perches.com>
Subject: Re: [PATCH 22/22] xlink-core: factorize xlink_ioctl function by
 creating sub-functions for each ioctl command
From:   Joe Perches <joe@perches.com>
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Seamus Kelly <seamus.kelly@intel.com>
Date:   Sun, 06 Dec 2020 19:05:34 -0800
In-Reply-To: <20201201223511.65542-23-mgross@linux.intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
         <20201201223511.65542-23-mgross@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-01 at 14:35 -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Refactor the too large IOCTL function to call helper functions.

This should not be sent as a known poor patch as patch 21 of 22
and then updated in patch 22 of 22 with a better style.

This should be sent in the as desired final form the first time
so that people don't give you useless notes.

> @@ -342,427 +323,84 @@ static int kmb_xlink_remove(struct platform_device *pdev)
>   * IOCTL function for User Space access to xlink kernel functions
>   *
>   */
> +int ioctl_connect(unsigned long arg);
>  
> 
>  static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
> -	struct xlink_handle		devh	= {0};
> -	struct xlinkopenchannel		op	= {0};
> -	struct xlinkwritedata		wr	= {0};
> -	struct xlinkreaddata		rd	= {0};
> -	struct xlinkreadtobuffer	rdtobuf = {0};
> -	struct xlinkconnect		con	= {0};
> -	struct xlinkrelease		rel	= {0};
> -	struct xlinkstartvpu		startvpu = {0};
> -	struct xlinkcallback		cb	= {0};
> -	struct xlinkgetdevicename	devn	= {0};
> -	struct xlinkgetdevicelist	devl	= {0};
> -	struct xlinkgetdevicestatus	devs	= {0};
> -	struct xlinkbootdevice		boot	= {0};
> -	struct xlinkresetdevice		res	= {0};
> -	struct xlinkdevmode		devm	= {0};
> -	struct xlinkregdevevent		regdevevent = {0};
> -	u32 sw_device_id_list[XLINK_MAX_DEVICE_LIST_SIZE];
> -	char name[XLINK_MAX_DEVICE_NAME_SIZE];
> -	int interface = NULL_INTERFACE;
> -	u32 device_status = 0;
> -	u32 num_devices = 0;
> -	u32 device_mode = 0;
> -	u32 num_events = 0;
> -	char filename[64];
> -	u32 *ev_list;
> -	u8 reladdr;
> -	u8 *rdaddr;
> -	u32 size;
>  	int rc;
>  
> 
>  	switch (cmd) {
>  	case XL_CONNECT:
> -		if (copy_from_user(&con, (void __user *)arg,
> -				   sizeof(struct xlinkconnect)))
> -			return -EFAULT;
> -		if (copy_from_user(&devh, (void __user *)con.handle,
> -				   sizeof(struct xlink_handle)))
> -			return -EFAULT;
> -		rc = xlink_connect(&devh);
> -		if (rc == X_LINK_SUCCESS) {
> -			if (copy_to_user((void __user *)con.handle,
> -					 &devh, sizeof(struct xlink_handle)))
> -				return -EFAULT;
> -		}
> -		if (copy_to_user((void __user *)con.return_code, (void *)&rc,
> -				 sizeof(rc)))
> -			return -EFAULT;
> +		rc = ioctl_connect(arg);
>  		break;

etc...

