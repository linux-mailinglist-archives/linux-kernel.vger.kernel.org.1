Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B402CB4E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgLBGRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:17:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgLBGRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:17:45 -0500
Date:   Wed, 2 Dec 2020 07:18:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606889824;
        bh=E2U4NARVM/V+R9HekKQNGYkLP9RfL8vuqT5kSc+iLes=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=SelEjLA63O4z7Gqw2uLCck5Wd7enkURtYydoI1tMnB6VGXk6hgucWNcqlbKoUxHeG
         NdJlp06wjOpuNNHMeCLzEGzU/CnwM3wrfxKY/mCZ4eWFQhJSABrQ79+qjD0uTF2RpE
         MEGCzoHy9lIiXCGJErDvzIfs1UAX1jj0Ktf/AY9U=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: Re: [PATCH 09/22] misc: xlink-pcie: lh: Add core communication logic
Message-ID: <X8cxpqf7MMCNacqm@kroah.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-10-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201223511.65542-10-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:34:58PM -0800, mgross@linux.intel.com wrote:
> From: Srikanth Thokala <srikanth.thokala@intel.com>
> 
> Add logic to establish communication with the remote host which is through
> ring buffer management and MSI/Doorbell interrupts
> 
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> ---
>  drivers/misc/xlink-pcie/local_host/Makefile |   2 +
>  drivers/misc/xlink-pcie/local_host/core.c   | 894 ++++++++++++++++++++
>  drivers/misc/xlink-pcie/local_host/core.h   | 247 ++++++
>  drivers/misc/xlink-pcie/local_host/epf.c    | 116 ++-
>  drivers/misc/xlink-pcie/local_host/epf.h    |  26 +
>  drivers/misc/xlink-pcie/local_host/util.c   | 375 ++++++++
>  drivers/misc/xlink-pcie/local_host/util.h   |  70 ++
>  drivers/misc/xlink-pcie/local_host/xpcie.h  |  65 ++
>  include/linux/xlink_drv_inf.h               |  60 ++
>  9 files changed, 1847 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/misc/xlink-pcie/local_host/core.c
>  create mode 100644 drivers/misc/xlink-pcie/local_host/core.h
>  create mode 100644 drivers/misc/xlink-pcie/local_host/util.c
>  create mode 100644 drivers/misc/xlink-pcie/local_host/util.h
>  create mode 100644 include/linux/xlink_drv_inf.h
> 
> diff --git a/drivers/misc/xlink-pcie/local_host/Makefile b/drivers/misc/xlink-pcie/local_host/Makefile
> index 54fc118e2dd1..28761751d43b 100644
> --- a/drivers/misc/xlink-pcie/local_host/Makefile
> +++ b/drivers/misc/xlink-pcie/local_host/Makefile
> @@ -1,3 +1,5 @@
>  obj-$(CONFIG_XLINK_PCIE_LH_DRIVER) += mxlk_ep.o
>  mxlk_ep-objs := epf.o
>  mxlk_ep-objs += dma.o
> +mxlk_ep-objs += core.o
> +mxlk_ep-objs += util.o
> diff --git a/drivers/misc/xlink-pcie/local_host/core.c b/drivers/misc/xlink-pcie/local_host/core.c
> new file mode 100644
> index 000000000000..aecaaa783153
> --- /dev/null
> +++ b/drivers/misc/xlink-pcie/local_host/core.c
> @@ -0,0 +1,894 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*****************************************************************************
> + *
> + * Intel Keem Bay XLink PCIe Driver
> + *
> + * Copyright (C) 2020 Intel Corporation
> + *
> + ****************************************************************************/
> +
> +#include <linux/of_reserved_mem.h>
> +
> +#include "epf.h"
> +#include "core.h"
> +#include "util.h"
> +
> +static struct xpcie *global_xpcie;
> +
> +static int rx_pool_size = SZ_32M;
> +module_param(rx_pool_size, int, 0664);
> +MODULE_PARM_DESC(rx_pool_size, "receiving pool size (default 32 MiB)");
> +
> +static int tx_pool_size = SZ_32M;
> +module_param(tx_pool_size, int, 0664);
> +MODULE_PARM_DESC(tx_pool_size, "transmitting pool size (default 32 MiB)");
> +
> +static int fragment_size = XPCIE_FRAGMENT_SIZE;
> +module_param(fragment_size, int, 0664);
> +MODULE_PARM_DESC(fragment_size, "transfer descriptor size (default 128 KiB)");
> +
> +static bool tx_pool_coherent = true;
> +module_param(tx_pool_coherent, bool, 0664);
> +MODULE_PARM_DESC(tx_pool_coherent,
> +		 "transmitting pool using coherent memory (default true)");
> +
> +static bool rx_pool_coherent;
> +module_param(rx_pool_coherent, bool, 0664);
> +MODULE_PARM_DESC(rx_pool_coherent,
> +		 "receiving pool using coherent memory (default false)");

This isn't the 1990's anymore.  Please make these dynamic such that they
are never needed (the code figures out the best values), or on some
per-device basis using configfs or sysfs.

thanks,

greg k-h
