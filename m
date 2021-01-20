Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31CE2FDA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392755AbhATUIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:08:19 -0500
Received: from ale.deltatee.com ([204.191.154.188]:49766 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392827AbhATUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:07:45 -0500
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jan 2021 15:07:45 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=FpuctqQYr7HiImXDtxO/Xmx4gM6wv9pGDhDLLlURPOs=; b=YDfes3u6g94InF+L7Eb1SDp49B
        ABL/A4XSKrcHSzyKASffzB6ePsnECaDDQkvIXypGmmkXftC2h9QOeEPd42wGc3VIBWG55Zgz2v5Df
        92MzwVRCGqnIYMMyfsb8l5DbMmpQSN0X1kl8GYC6Bd5L0IqmrfYz87adODZr6Wp+Il8JjCbq2Be2A
        ypbRzyHyYlvm5HZSFt63QRRO/vONle105KzlgMr4uFBap7rhEYZTJTxfP/UmufThWd3xw0vGuUAdQ
        CRFeQVWe9gdVx+CPwXnmJMIZ+wClHsD0b2DKd1ZndyJKZ53Byq9DQduJ97FWphbVtrWP8/Ni3lL+p
        h2pFyAfQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1l2JV8-00022C-Hh; Wed, 20 Jan 2021 12:50:47 -0700
To:     Dan Williams <dan.j.williams@intel.com>, gregkh@linuxfoundation.org
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Jiang <dave.jiang@intel.com>, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <809823fb-6eb6-8ce9-c49a-d85b03897fc7@deltatee.com>
Date:   Wed, 20 Jan 2021 12:50:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, viro@zeniv.linux.org.uk, alexandre.belloni@free-electrons.com, hans.verkuil@cisco.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 2021-01-20 12:38 p.m., Dan Williams wrote:
> ...common reference count handling scenarios were addressed, but the
> shutdown-synchronization problem was only mentioned as something driver
> developers need to be aware in the following note:
> 
>     NOTE: This guarantees that associated sysfs callbacks are not running
>     or runnable, however any cdevs already open will remain and their fops
>     will still be callable even after this function returns.
> 
> Remove that responsibility from driver developers with the concept of a
> 'queued' mode for cdevs.

I find the queued name confusing. What's being queued?

> +static const struct file_operations cdev_queued_fops = {
> +	.owner = THIS_MODULE,
> +	.open = cdev_queued_open,
> +	.unlocked_ioctl = cdev_queued_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,
> +	.llseek = noop_llseek,
> +};

Why do we only protect these fops? I'd find it a bit confusing to have
ioctl protected from use after del, but not write/read/etc.

Logan
