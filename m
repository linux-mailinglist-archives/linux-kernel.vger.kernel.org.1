Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182C32FF8AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 00:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbhAUXW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:22:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:2188 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbhAUXWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:22:23 -0500
IronPort-SDR: rPcBDcQGTuoDwLq9YEtAOnAT2Do/RrrFsr4cCLO0pSvQc1+bC7XaeZ2E4084yV0sXHhXoSxHHq
 V0ykpp/66GdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="159141679"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="159141679"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 15:20:36 -0800
IronPort-SDR: 42+b3MRQ07xH5ccUNXP3wDXNd5gducOozeQw8d83VbDAer6MI9ia22B0H/ZojaG3A50sQx1R8U
 rjWtI8HdeDvQ==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="407488781"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 15:20:36 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 578356365;
        Thu, 21 Jan 2021 15:20:36 -0800 (PST)
Date:   Thu, 21 Jan 2021 15:20:36 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        corbet@lwn.net, leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: Re: [PATCH v2 15/34] misc: xlink-pcie: Add XLink API interface
Message-ID: <20210121232036.GA60912@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-16-mgross@linux.intel.com>
 <YAhvhSpOv2Z4cwlB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAhvhSpOv2Z4cwlB@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 06:59:33PM +0100, Greg KH wrote:
> On Fri, Jan 08, 2021 at 01:25:41PM -0800, mgross@linux.intel.com wrote:
> > From: Srikanth Thokala <srikanth.thokala@intel.com>
> > 
> > Provide interface for XLink layer to interact with XLink PCIe transport
> > layer on both local host and remote host.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > ---
> >  drivers/misc/xlink-pcie/common/interface.c   | 109 +++++++++++++++++++
> >  drivers/misc/xlink-pcie/local_host/Makefile  |   1 +
> >  drivers/misc/xlink-pcie/remote_host/Makefile |   1 +
> >  3 files changed, 111 insertions(+)
> >  create mode 100644 drivers/misc/xlink-pcie/common/interface.c
> > 
> > diff --git a/drivers/misc/xlink-pcie/common/interface.c b/drivers/misc/xlink-pcie/common/interface.c
> > new file mode 100644
> > index 000000000000..56c1d9ed9d8f
> > --- /dev/null
> > +++ b/drivers/misc/xlink-pcie/common/interface.c
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*****************************************************************************
> > + *
> > + * Intel Keem Bay XLink PCIe Driver
> > + *
> > + * Copyright (C) 2020 Intel Corporation
> > + *
> > + ****************************************************************************/
> 
> Do you really need the ******* mess?  :)
> 
> > +
> > +#include <linux/xlink_drv_inf.h>
> > +
> > +#include "core.h"
> > +#include "xpcie.h"
> > +
> > +/* Define xpcie driver interface API */
> > +int xlink_pcie_get_device_list(u32 *sw_device_id_list, u32 *num_devices)
> > +{
> > +	if (!sw_device_id_list || !num_devices)
> > +		return -EINVAL;
> > +
> > +	*num_devices = intel_xpcie_get_device_num(sw_device_id_list);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(xlink_pcie_get_device_list);
> 
> EXPORT_SYMBOL_GPL() for all of these perhaps?  I have to ask...
I can't think of a reason why not using the _GPL flavor of export symbol.  I'll
change them all if that's desired.

--mark
> 
> thanks,
> 
> greg k-h
