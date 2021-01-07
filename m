Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0496B2EC95F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 05:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbhAGEWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 23:22:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:1526 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbhAGEWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 23:22:20 -0500
IronPort-SDR: oqWu0TDuBhrexe+OXET9NFmOnQTCIL28pE+fdKe7ST4cnGfCQGtP8MDnojhA+J7I0XvXi2UK7B
 3JARg2SYL1zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="174796277"
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="174796277"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 20:21:39 -0800
IronPort-SDR: OhsxQADpyZdRHuOTZ3za8ozh7y5Q/N2zIkRWXcAJGgfpnxRYafN2r+7cSn34Og7mwIbNxiinsN
 WRjiScdkviLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="422430265"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 06 Jan 2021 20:21:37 -0800
Date:   Thu, 7 Jan 2021 12:16:53 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH 1/2] mfd: intel-m10-bmc: specify the retimer sub devices
Message-ID: <20210107041652.GB7750@yilunxu-OptiPlex-7050>
References: <1609918567-13339-1-git-send-email-yilun.xu@intel.com>
 <1609918567-13339-2-git-send-email-yilun.xu@intel.com>
 <20210106082330.GB1592923@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106082330.GB1592923@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 08:23:30AM +0000, Lee Jones wrote:
> On Wed, 06 Jan 2021, Xu Yilun wrote:
> 
> > The patch specifies the 2 retimer sub devices and their resources in the
> > parent driver's mfd_cell. It also adds the register definition of the
> > retimer sub devices.
> > 
> > There are 2 ethernet retimer chips (C827) connected to the Intel MAX 10
> > BMC. They are managed by the BMC firmware, and host could query them via
> > retimer interfaces (shared registers) on the BMC. The 2 retimers have
> > identical register interfaces in different register addresses or fields,
> > so it is better we define 2 retimer devices and handle them with the same
> > driver.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> >  drivers/mfd/intel-m10-bmc.c       | 19 ++++++++++++++++++-
> >  include/linux/mfd/intel-m10-bmc.h |  7 +++++++
> >  2 files changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > index b84579b..e0a99a0 100644
> > --- a/drivers/mfd/intel-m10-bmc.c
> > +++ b/drivers/mfd/intel-m10-bmc.c
> > @@ -17,9 +17,26 @@ enum m10bmc_type {
> >  	M10_N3000,
> >  };
> >  
> > +static struct resource retimer0_resources[] = {
> > +	{M10BMC_PKVL_A_VER, M10BMC_PKVL_A_VER, "version", IORESOURCE_REG, },
> > +};
> > +
> > +static struct resource retimer1_resources[] = {
> > +	{M10BMC_PKVL_B_VER, M10BMC_PKVL_B_VER, "version", IORESOURCE_REG, },
> > +};
> 
> Please use the DEFINE_RES_*() helpers for this.

Yes, will change it.

Thanks,
Yilun
