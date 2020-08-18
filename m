Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0A8248D68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 19:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHRRo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 13:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgHRRo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:44:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C772054F;
        Tue, 18 Aug 2020 17:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597772668;
        bh=onQFFNb26cT+U2VVH+aoG5XV2IEw+ODDDbuu02NYzP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tby04IYXoKLmrkGNwYiBdnp+BPk4yLtiPg8oDPDt8k1qy/RsYGikSG9muDe8qyCNv
         xCMrBQAVTY6wbBa6k4eEaVQnsnhlj4PNciQRHD+LnFaaWrHG6jI+C4QmpSaqX7smma
         pGhWFFW3BHoqyGAYCZrdOKqJxNyQzcdtph8AT9I0=
Date:   Tue, 18 Aug 2020 19:44:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 1/3] bcm-vk: add bcm_vk UAPI
Message-ID: <20200818174451.GA749919@kroah.com>
References: <20200806004631.8102-1-scott.branden@broadcom.com>
 <20200806004631.8102-2-scott.branden@broadcom.com>
 <20200818135313.GB495837@kroah.com>
 <8894c3c4-4d5c-cb94-bc90-a26833ebf268@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8894c3c4-4d5c-cb94-bc90-a26833ebf268@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:23:42AM -0700, Scott Branden wrote:
> Hi Greg,
> 
> On 2020-08-18 6:53 a.m., Greg Kroah-Hartman wrote:
> > On Wed, Aug 05, 2020 at 05:46:29PM -0700, Scott Branden wrote:
> >> Add user space api for bcm-vk driver.
> >>
> >> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> >> ---
> >>  include/uapi/linux/misc/bcm_vk.h | 99 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 99 insertions(+)
> >>  create mode 100644 include/uapi/linux/misc/bcm_vk.h
> >>
> >> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
> >> new file mode 100644
> >> index 000000000000..783087b7c31f
> >> --- /dev/null
> >> +++ b/include/uapi/linux/misc/bcm_vk.h
> >> @@ -0,0 +1,99 @@
> >> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
> >> +/*
> >> + * Copyright 2018-2020 Broadcom.
> >> + */
> >> +
> >> +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
> >> +#define __UAPI_LINUX_MISC_BCM_VK_H
> >> +
> >> +#include <linux/ioctl.h>
> >> +#include <linux/types.h>
> >> +
> >> +#define BCM_VK_MAX_FILENAME 64
> >> +
> >> +struct vk_image {
> >> +	__u32 type; /* Type of image */
> >> +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
> >> +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
> >> +	char filename[BCM_VK_MAX_FILENAME]; /* Filename of image */
> >> +};
> >> +
> >> +struct vk_reset {
> >> +	__u32 arg1;
> >> +	__u32 arg2;
> >> +};
> >> +
> >> +#define VK_MAGIC		0x5e
> >> +
> >> +/* Load image to Valkyrie */
> >> +#define VK_IOCTL_LOAD_IMAGE	_IOW(VK_MAGIC, 0x2, struct vk_image)
> >> +
> >> +/* Send Reset to Valkyrie */
> >> +#define VK_IOCTL_RESET		_IOW(VK_MAGIC, 0x4, struct vk_reset)
> >> +
> >> +/*
> >> + * message block - basic unit in the message where a message's size is always
> >> + *		   N x sizeof(basic_block)
> >> + */
> >> +struct vk_msg_blk {
> >> +	__u8 function_id;
> >> +#define VK_FID_TRANS_BUF	5
> >> +#define VK_FID_SHUTDOWN		8
> >> +	__u8 size;
> >> +	__u16 trans_id; /* transport id, queue & msg_id */
> >> +	__u32 context_id;
> >> +	__u32 args[2];
> >> +#define VK_CMD_PLANES_MASK	0x000f /* number of planes to up/download */
> >> +#define VK_CMD_UPLOAD		0x0400 /* memory transfer to vk */
> >> +#define VK_CMD_DOWNLOAD		0x0500 /* memory transfer from vk */
> >> +#define VK_CMD_MASK		0x0f00 /* command mask */
> >> +};
> >> +
> >> +#define VK_BAR_FWSTS			0x41c
> >> +#define VK_BAR_COP_FWSTS		0x428
> >> +/* VK_FWSTS definitions */
> >> +#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
> > <snip>
> >
> > I thought BIT() was not allowed in uapi .h files, this really works
> > properly???
> I did some investigation and it looks like a few other header files in include/uapi also use the BIT() macro:
> include/uapi/misc/uacce/uacce.h
> include/uapi/linux/psci.h
> include/uapi/linux/v4l2-subdev.h

Does the header install test target now fail for these?

> tools/include/uapi/linux/pkt_sched.h

That doesn't count :)

> It does look like we end up defining the BIT() macro in our user space app that includes the header file.
> 
> So, what is the proper thing to be done?
> 1) Move the BIT() macro somewhere in include/uapi and include it in the necessary header files
> 2) Use the _BITUL macro in include/uapi/linux/const.h instead?
> 3) something else?

open-code it for now please, that's the best way as I am pretty sure we
can not contaminate the global C namespace with out BIT() macro, no
matter how much we would like to...

thanks,

greg k-h
