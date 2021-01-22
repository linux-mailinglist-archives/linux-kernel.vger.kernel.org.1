Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31BC2FFB11
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 04:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbhAVD3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 22:29:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:41763 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbhAVD3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:29:11 -0500
IronPort-SDR: pVEod4Cmh0zQTjNr196Y5uMJvAo6jrFLIV4gxIb9jkymG7z7HjP+C/hWKMAENPcPoFtiIjHdKQ
 A9vZpF9rL9DA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264204820"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="264204820"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 19:28:27 -0800
IronPort-SDR: oE8ABsLyW6wMeT59RIo+xTyS17muS8/a4QYFLS/cztAuHWEIraDrGdTZne1HJxsGokeL360/5Y
 BFLhpYEVBLjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="356767258"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jan 2021 19:28:22 -0800
Date:   Fri, 22 Jan 2021 11:23:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 2/2] mfd: intel-m10-bmc: add access table configuration
 to  the regmap
Message-ID: <20210122032355.GB1943@yilunxu-OptiPlex-7050>
References: <1611110081-10056-1-git-send-email-yilun.xu@intel.com>
 <1611110081-10056-2-git-send-email-yilun.xu@intel.com>
 <0f17f8a7-d2f5-e88e-b3dc-0a75ea7f5ada@redhat.com>
 <20210121080554.GA1943@yilunxu-OptiPlex-7050>
 <82884394-f8aa-4957-04c3-285381e13d57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82884394-f8aa-4957-04c3-285381e13d57@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 05:19:56AM -0800, Tom Rix wrote:
> 
> On 1/21/21 12:05 AM, Xu Yilun wrote:
> > On Wed, Jan 20, 2021 at 07:32:53AM -0800, Tom Rix wrote:
> >> On 1/19/21 6:34 PM, Xu Yilun wrote:
> >>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >>>
> >>> This patch adds access tables to the MAX 10 BMC regmap. This prevents
> >>> the host from accessing the unwanted I/O space. It also filters out the
> >>> invalid outputs when reading the regmap debugfs interface.
> >>>
> >>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> >>> ---
> >>>  drivers/mfd/intel-m10-bmc.c       | 14 ++++++++++++++
> >>>  include/linux/mfd/intel-m10-bmc.h |  5 ++++-
> >>>  2 files changed, 18 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> >>> index b84579b..0ae3053 100644
> >>> --- a/drivers/mfd/intel-m10-bmc.c
> >>> +++ b/drivers/mfd/intel-m10-bmc.c
> >>> @@ -23,10 +23,24 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
> >>>  	{ .name = "n3000bmc-secure" },
> >>>  };
> >>>  
> >>> +static const struct regmap_range m10bmc_regmap_range[] = {
> >>> +	regmap_reg_range(M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
> >>> +			 M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER),
> >> If this is the only value in the legacy map to be accessed, could it have its own #define ?
> >>
> >> Something like
> >>
> >> #define M10BMC_LEGACY_BUILD_VER ?
> > Yes, it could be more clear. I'll change it.
> >
> >>> +	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> >>> +	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
> >>> +};
> >>> +
> >>> +static const struct regmap_access_table m10bmc_access_table = {
> >>> +	.yes_ranges	= m10bmc_regmap_range,
> >>> +	.n_yes_ranges	= ARRAY_SIZE(m10bmc_regmap_range),
> >>> +};
> >>> +
> >>>  static struct regmap_config intel_m10bmc_regmap_config = {
> >>>  	.reg_bits = 32,
> >>>  	.val_bits = 32,
> >>>  	.reg_stride = 4,
> >>> +	.wr_table = &m10bmc_access_table,
> >>> +	.rd_table = &m10bmc_access_table,
> >> The legacy build ver should only be read, so shouldn't these tables be different ?
> > I'm not sure if a register could be regarded as writable if hardware
> > ensures writing it has no effect but makes no harm. Usually these
> > registers are marked as RO in spec.
> >
> > I think it could be quite common case in hardware design. But it could
> > be trivial if we pick every such register out of wr_table. I just want
> > to define the valid reg range.
> >
> > So could I keep the current implementation?
> 
> I mean that the write table would not have first element the read table has because it has the single ro entry.
> 
> The other ranges i am sure have ro's and are not worth breaking apart.
> 
> If something like
> 
> .wr_table = &m10bmc_access_table[1] doesn't work or looks to hacky, i don't mind leaving it as-is.

It looks hacky to me.

If the first one has to be marked RO, I think it could be like:

  static const struct regmap_range m10bmc_regmap_ro_range[] = {
	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
  };

  static const struct regmap_range m10bmc_regmap_range[] = {
	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
	regmap_reg_range(...),
	...
  };

  static const struct regmap_access_table m10bmc_write_table = {
	.yes_ranges     = m10bmc_regmap_range,
	.n_yes_ranges   = ARRAY_SIZE(m10bmc_regmap_range),
	.no_range	= m10bmc_regmap_ro_range,
	.n_no_range	= ARRAY_SIZE(m10bmc_regmap_ro_range),
  };

  static const struct regmap_access_table m10bmc_read_table = {
	.yes_ranges     = m10bmc_regmap_range,
	.n_yes_ranges   = ARRAY_SIZE(m10bmc_regmap_range),
  };

But I think this is unnecessary. I feel it is indicating all the other
registers are RW in spec, actually they are not. So I tend to keep
it simple, just tell the valid range.

Thanks,
Yilun
