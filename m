Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6E2EE64F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbhAGTlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:41:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbhAGTlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:41:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF50E233CF;
        Thu,  7 Jan 2021 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610048429;
        bh=DDzy5dYGZ3cp3l+gUWOg5br55Y8oZ4PDttZCOGAzotQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKbpD0N+v+VhyGyhRHZNn81Vstiedm6jo1vlZg6s6XKWa9yiEosXmyicgPapzmS+m
         ypwGKQ2qKFCZcr4BcBkLMYbyBHyHgRczSNZ/4gxTozI7LqZ84hrP4/AE2kh/0G9jJ3
         h3AFiuhhgWB1el4bzvf2e4kVintxO1u0/4JTcfdY=
Date:   Thu, 7 Jan 2021 20:41:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Ximing Chen <mike.ximing.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three
 ioctls
Message-ID: <X/dj/NNdF0cy632k@kroah.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105025839.23169-5-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 08:58:23PM -0600, Mike Ximing Chen wrote:
> Introduce the dlb device ioctl layer and the first three ioctls: query
> device version, query available resources, and create a scheduling domain.
> Also introduce the user-space interface file dlb_user.h.
> 
> The device version query is designed to allow each DLB device version/type
> to have its own unique ioctl API through the /dev/dlb%d node. Each such API
> would share in common the device version command as its first command, and
> all subsequent commands can be unique to the particular device.
> 
> The hardware operation for scheduling domain creation will be added in a
> subsequent commit.
> 
> Signed-off-by: Gage Eads <gage.eads@intel.com>
> Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
> Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  drivers/misc/dlb/Makefile                     |   2 +-
>  drivers/misc/dlb/dlb_bitmap.h                 |  32 ++++
>  drivers/misc/dlb/dlb_ioctl.c                  | 119 +++++++++++++
>  drivers/misc/dlb/dlb_ioctl.h                  |  11 ++
>  drivers/misc/dlb/dlb_main.c                   |   3 +
>  drivers/misc/dlb/dlb_main.h                   |   7 +
>  drivers/misc/dlb/dlb_pf_ops.c                 |  21 +++
>  drivers/misc/dlb/dlb_resource.c               |  63 +++++++
>  drivers/misc/dlb/dlb_resource.h               |   5 +
>  include/uapi/linux/dlb.h                      | 166 ++++++++++++++++++
>  11 files changed, 429 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/dlb/dlb_ioctl.c
>  create mode 100644 drivers/misc/dlb/dlb_ioctl.h
>  create mode 100644 include/uapi/linux/dlb.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 55a2d9b2ce33..afca043d59f8 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -241,6 +241,7 @@ Code  Seq#    Include File                                           Comments
>  'h'   00-7F                                                          conflict! Charon filesystem
>                                                                       <mailto:zapman@interlan.net>
>  'h'   00-1F  linux/hpet.h                                            conflict!
> +'h'   00-1F  uapi/linux/dlb.h                                        conflict!
>  'h'   80-8F  fs/hfsplus/ioctl.c
>  'i'   00-3F  linux/i2o-dev.h                                         conflict!
>  'i'   0B-1F  linux/ipmi.h                                            conflict!
> diff --git a/drivers/misc/dlb/Makefile b/drivers/misc/dlb/Makefile
> index 8a49ea5fd752..aaafb3086d8d 100644
> --- a/drivers/misc/dlb/Makefile
> +++ b/drivers/misc/dlb/Makefile
> @@ -7,4 +7,4 @@
>  obj-$(CONFIG_INTEL_DLB) := dlb.o
>  
>  dlb-objs := dlb_main.o
> -dlb-objs += dlb_pf_ops.o dlb_resource.o
> +dlb-objs += dlb_pf_ops.o dlb_resource.o dlb_ioctl.o
> diff --git a/drivers/misc/dlb/dlb_bitmap.h b/drivers/misc/dlb/dlb_bitmap.h
> index fb3ef52a306d..3ea78b42c79f 100644
> --- a/drivers/misc/dlb/dlb_bitmap.h
> +++ b/drivers/misc/dlb/dlb_bitmap.h
> @@ -73,4 +73,36 @@ static inline void dlb_bitmap_free(struct dlb_bitmap *bitmap)
>  	kfree(bitmap);
>  }
>  
> +/**
> + * dlb_bitmap_longest_set_range() - returns longest contiguous range of set
> + *				     bits
> + * @bitmap: pointer to dlb_bitmap structure.
> + *
> + * Return:
> + * Returns the bitmap's longest contiguous range of set bits upon success,
> + * <0 otherwise.
> + *
> + * Errors:
> + * EINVAL - bitmap is NULL or is uninitialized.
> + */
> +static inline int dlb_bitmap_longest_set_range(struct dlb_bitmap *bitmap)
> +{
> +	int max_len, len;
> +	int start, end;
> +
> +	if (!bitmap || !bitmap->map)
> +		return -EINVAL;
> +
> +	if (bitmap_weight(bitmap->map, bitmap->len) == 0)
> +		return 0;
> +
> +	max_len = 0;
> +	bitmap_for_each_set_region(bitmap->map, start, end, 0, bitmap->len) {
> +		len = end - start;
> +		if (max_len < len)
> +			max_len = len;
> +	}
> +	return max_len;
> +}
> +
>  #endif /*  __DLB_OSDEP_BITMAP_H */
> diff --git a/drivers/misc/dlb/dlb_ioctl.c b/drivers/misc/dlb/dlb_ioctl.c
> new file mode 100644
> index 000000000000..c072ed9b921c
> --- /dev/null
> +++ b/drivers/misc/dlb/dlb_ioctl.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
> +
> +#include <linux/uaccess.h>
> +#include <linux/nospec.h>
> +
> +#include <uapi/linux/dlb.h>
> +
> +#include "dlb_ioctl.h"
> +#include "dlb_main.h"
> +
> +/* [7:0]: device revision, [15:8]: device version */
> +#define DLB_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
> +
> +static int
> +dlb_ioctl_get_device_version(struct dlb *dlb __attribute__((unused)),

We don't use __attribute__((unused)) for function variables in Linux.
Please remove and tell whatever operating system you ported this from to
get with the times :)

thanks,

greg k-h
