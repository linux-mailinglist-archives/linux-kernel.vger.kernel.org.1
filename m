Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1C92FE4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbhAUIMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:12:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:65421 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbhAUILR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:11:17 -0500
IronPort-SDR: s5xanVrcWUfizjx2ceKLgojF4WS+59KWC2a6nE9SqmmTmaF0Bx3FosQmI8yH07ilqy4esfTsDs
 Cu1mu2aUDVeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="243307153"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="243307153"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 00:10:35 -0800
IronPort-SDR: jeptuGEH3IU/4R5RnSgFE1LVPj9NYQ0GXR4p/EUFhGpzw+g+N/5d7qoQYjWbvr0B5CDf3Fq6TT
 LuyAky0PGJUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="403109570"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2021 00:10:20 -0800
Date:   Thu, 21 Jan 2021 16:05:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 2/2] mfd: intel-m10-bmc: add access table configuration
 to  the regmap
Message-ID: <20210121080554.GA1943@yilunxu-OptiPlex-7050>
References: <1611110081-10056-1-git-send-email-yilun.xu@intel.com>
 <1611110081-10056-2-git-send-email-yilun.xu@intel.com>
 <0f17f8a7-d2f5-e88e-b3dc-0a75ea7f5ada@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f17f8a7-d2f5-e88e-b3dc-0a75ea7f5ada@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 07:32:53AM -0800, Tom Rix wrote:
> 
> On 1/19/21 6:34 PM, Xu Yilun wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > This patch adds access tables to the MAX 10 BMC regmap. This prevents
> > the host from accessing the unwanted I/O space. It also filters out the
> > invalid outputs when reading the regmap debugfs interface.
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> >  drivers/mfd/intel-m10-bmc.c       | 14 ++++++++++++++
> >  include/linux/mfd/intel-m10-bmc.h |  5 ++++-
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > index b84579b..0ae3053 100644
> > --- a/drivers/mfd/intel-m10-bmc.c
> > +++ b/drivers/mfd/intel-m10-bmc.c
> > @@ -23,10 +23,24 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
> >  	{ .name = "n3000bmc-secure" },
> >  };
> >  
> > +static const struct regmap_range m10bmc_regmap_range[] = {
> > +	regmap_reg_range(M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
> > +			 M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER),
> 
> If this is the only value in the legacy map to be accessed, could it have its own #define ?
> 
> Something like
> 
> #define M10BMC_LEGACY_BUILD_VER ?

Yes, it could be more clear. I'll change it.

> 
> > +	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> > +	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
> > +};
> > +
> > +static const struct regmap_access_table m10bmc_access_table = {
> > +	.yes_ranges	= m10bmc_regmap_range,
> > +	.n_yes_ranges	= ARRAY_SIZE(m10bmc_regmap_range),
> > +};
> > +
> >  static struct regmap_config intel_m10bmc_regmap_config = {
> >  	.reg_bits = 32,
> >  	.val_bits = 32,
> >  	.reg_stride = 4,
> > +	.wr_table = &m10bmc_access_table,
> > +	.rd_table = &m10bmc_access_table,
> 
> The legacy build ver should only be read, so shouldn't these tables be different ?

I'm not sure if a register could be regarded as writable if hardware
ensures writing it has no effect but makes no harm. Usually these
registers are marked as RO in spec.

I think it could be quite common case in hardware design. But it could
be trivial if we pick every such register out of wr_table. I just want
to define the valid reg range.

So could I keep the current implementation?

Thanks,
Yilun
