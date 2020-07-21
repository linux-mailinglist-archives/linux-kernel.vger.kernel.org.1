Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2B9227743
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 05:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGUDyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 23:54:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:24442 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgGUDyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:54:04 -0400
IronPort-SDR: nZaCPd8Uys9EbKRujbQeiCESbY6cNdQ4/bPwaC6xNtS1Hdi4J7NRUdI0USFIMkZ6e6pwyhg9RN
 iHH9kpzm1DwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="150043514"
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="150043514"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 20:54:04 -0700
IronPort-SDR: yOJ44oLBxYqhbOO2G4tMrOH5k52SbcayThBBwCC9rYuwFWmz8zfcxbLv3yMJYzJvZG3EVnpdoC
 PRb16iZ/4O6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="487470240"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2020 20:54:01 -0700
Date:   Tue, 21 Jul 2020 11:50:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com
Subject: Re: [PATCH v2 3/3] mfd: intel-m10-bmc: add Max10 BMC chip support
   for Intel FPGA PAC
Message-ID: <20200721035054.GA8895@yilunxu-OptiPlex-7050>
References: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
 <1594896174-18826-4-git-send-email-yilun.xu@intel.com>
 <20200717181609.GB905@sirena.org.uk>
 <20200721034713.GB17091@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721034713.GB17091@yilunxu-OptiPlex-7050>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:47:13AM +0800, Xu Yilun wrote:
> On Fri, Jul 17, 2020 at 07:16:09PM +0100, Mark Brown wrote:
> > On Thu, Jul 16, 2020 at 06:42:54PM +0800, Xu Yilun wrote:
> > 
> > > +static const struct spi_device_id m10bmc_spi_id[] = {
> > > +	{ "m10-n3000", M10_N3000 },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> > 
> > > +static struct spi_driver intel_m10bmc_spi_driver = {
> > > +	.driver = {
> > > +		.name = "intel-m10-bmc",
> > > +		.dev_groups = m10bmc_dev_groups,
> > > +	},
> > > +	.probe = intel_m10_bmc_spi_probe,
> > > +	.id_table = m10bmc_spi_id,
> > > +};
> > 
> > > +module_spi_driver(intel_m10bmc_spi_driver);
> > 
> > This device has no ACPI information - how will it be instantiated?
> 
> In our case, The m10-bmc is connected to the intel FPGA (PAC N3000),
> which uses the Device Feature List (DFL) mechanism to enumerate features
> (devices) on FPGA. Each feature in DFL has a feature_id. And for this
> m10-n3000 feature (feature_id = 0xd), it contains a spi-altera & a
> m10-n3000 chip. So the DFL subsystem would help enumerate the info.

And some DFL related infomation:
  Documentation/fpga/dfl.rst
  drivers/fpga/dfl*

Thanks,
Yilun

> 
> Recently I added the platform data for slave information in spi-altera,
> to support this use case.
> 
> Thanks,
> Yilun
