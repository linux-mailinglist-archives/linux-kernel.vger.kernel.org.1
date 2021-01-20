Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8512FD7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbhATSBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:01:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390516AbhATSAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:00:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DFFD223DB;
        Wed, 20 Jan 2021 17:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611165576;
        bh=s0dN1TK33kbfDqHmKurIDYw4217DCfn5gFKZLOzRfU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ziQt/0GX6BOYqiMcw5gpnlqIQ89SoM+F114/feT/OPUQ2albCFRDVmli5GR0nXBRw
         CC8ACWzI1I39iNciaYpyDpKw7R8cKoKJ6V+K1o1sfbTywBSFktvZTix0XwTfS0WehR
         EFLR06t9bCTKR1QbC/tRMFO6tOvFzBE3vtUr0JCM=
Date:   Wed, 20 Jan 2021 18:59:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: Re: [PATCH v2 15/34] misc: xlink-pcie: Add XLink API interface
Message-ID: <YAhvhSpOv2Z4cwlB@kroah.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-16-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108212600.36850-16-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 01:25:41PM -0800, mgross@linux.intel.com wrote:
> From: Srikanth Thokala <srikanth.thokala@intel.com>
> 
> Provide interface for XLink layer to interact with XLink PCIe transport
> layer on both local host and remote host.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> ---
>  drivers/misc/xlink-pcie/common/interface.c   | 109 +++++++++++++++++++
>  drivers/misc/xlink-pcie/local_host/Makefile  |   1 +
>  drivers/misc/xlink-pcie/remote_host/Makefile |   1 +
>  3 files changed, 111 insertions(+)
>  create mode 100644 drivers/misc/xlink-pcie/common/interface.c
> 
> diff --git a/drivers/misc/xlink-pcie/common/interface.c b/drivers/misc/xlink-pcie/common/interface.c
> new file mode 100644
> index 000000000000..56c1d9ed9d8f
> --- /dev/null
> +++ b/drivers/misc/xlink-pcie/common/interface.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*****************************************************************************
> + *
> + * Intel Keem Bay XLink PCIe Driver
> + *
> + * Copyright (C) 2020 Intel Corporation
> + *
> + ****************************************************************************/

Do you really need the ******* mess?  :)

> +
> +#include <linux/xlink_drv_inf.h>
> +
> +#include "core.h"
> +#include "xpcie.h"
> +
> +/* Define xpcie driver interface API */
> +int xlink_pcie_get_device_list(u32 *sw_device_id_list, u32 *num_devices)
> +{
> +	if (!sw_device_id_list || !num_devices)
> +		return -EINVAL;
> +
> +	*num_devices = intel_xpcie_get_device_num(sw_device_id_list);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(xlink_pcie_get_device_list);

EXPORT_SYMBOL_GPL() for all of these perhaps?  I have to ask...

thanks,

greg k-h
