Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CF4280113
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbgJAOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:14:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:43883 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732380AbgJAON3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:13:29 -0400
IronPort-SDR: EQiVQCH8AQzV/a0KK8nV6nd8SOm8I+Wp1sepWYPk4X5xuDz+JF0mPgq2fmMK9o/RLPibJe8WHr
 XvZXmNgfAOmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="180886429"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="180886429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 07:13:23 -0700
IronPort-SDR: bmZJ7wZCbPa1qohThNsz8ulJQttOgQ9RPtJZpJhw/+c/SvEcD5ckhP1nt8nXHZDeneP3eEYKUf
 LgR1c8zdmB0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="308648024"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 01 Oct 2020 07:13:18 -0700
Date:   Thu, 1 Oct 2020 22:08:34 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     lee.jones@linaro.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com
Subject: Re: [PATCH v3 0/2] add Intel MAX 10 BMC MFD driver & hwmon sub driver
Message-ID: <20201001140834.GA5471@yilunxu-OptiPlex-7050>
References: <1600669071-26235-1-git-send-email-yilun.xu@intel.com>
 <20200930205249.GA241905@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930205249.GA241905@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Wed, Sep 30, 2020 at 01:52:49PM -0700, Guenter Roeck wrote:
> On Mon, Sep 21, 2020 at 02:17:49PM +0800, Xu Yilun wrote:
> > I recently realized that maintainers may have trouble to apply patches to
> > their trees if the patches depend on other being-reviewed patches. So I'm
> > trying to wrapper the 2 patches into one patchset and let all the
> > maintainers see the dependencies.
> > 
> > But the patch version is then not aligned between the 2 patches. I'm not
> > sure how to handle it. I just picked the smaller number on Subject, but
> > you could still see their own version changes in commit message of each
> > patch. Sorry if it makes confusing.
> > 
> 
> If you started with separate patches, it would be much better to pick
> the larger number, and add a note into the individual patch(es) stating
> the reason for the gap. Everything else is highly confusing. I would not
> be surprised if no one in the mfd world even looks at the mfd patch
> since it went back from v6 (?) to v3 according to its subject line.

I got it. Thanks for your guide.

Fortunately, the mfd maintainer has replied and applied the mfd patch
(the previous separate one). And I see you added a Reviewed-by for the hwmon
patch, so I assume I don't have to do anything more, is it?

I'll take care of the version number next time.

Thanks,
Yilun

> 
> Thanks,
> Guenter
> 
> > 
> > Patch #1 implements the basic functions of the BMC chip for some Intel
> > FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
> > Intel MAX 10 CPLD.
> > 
> > This BMC chip is connected to the FPGA by a SPI bus. To provide direct
> > register access from the FPGA, the "SPI slave to Avalon Master Bridge"
> > (spi-avmm) IP is integrated in the chip. It converts encoded streams of
> > bytes from the host to the internal register read/write on the Avalon
> > bus. So This driver uses the regmap-spi-avmm for register accessing.
> > 
> > Patch #2 adds support for the hwmon sub device in Intel MAX 10 BMC
> > 
> > 
> > Xu Yilun (2):
> >   mfd: intel-m10-bmc: add Intel MAX 10 BMC chip support for Intel FPGA
> >     PAC
> >   hwmon: intel-m10-bmc-hwmon: add hwmon support for Intel MAX 10 BMC
> > 
> >  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
> >  Documentation/hwmon/index.rst                      |   1 +
> >  Documentation/hwmon/intel-m10-bmc-hwmon.rst        |  78 +++++
> >  drivers/hwmon/Kconfig                              |  11 +
> >  drivers/hwmon/Makefile                             |   1 +
> >  drivers/hwmon/intel-m10-bmc-hwmon.c                | 334 +++++++++++++++++++++
> >  drivers/mfd/Kconfig                                |  13 +
> >  drivers/mfd/Makefile                               |   2 +
> >  drivers/mfd/intel-m10-bmc.c                        | 164 ++++++++++
> >  include/linux/mfd/intel-m10-bmc.h                  |  65 ++++
> >  10 files changed, 684 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> >  create mode 100644 Documentation/hwmon/intel-m10-bmc-hwmon.rst
> >  create mode 100644 drivers/hwmon/intel-m10-bmc-hwmon.c
> >  create mode 100644 drivers/mfd/intel-m10-bmc.c
> >  create mode 100644 include/linux/mfd/intel-m10-bmc.h
> > 
> > -- 
> > 2.7.4
> > 
