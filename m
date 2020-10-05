Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C503F283710
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJEN5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:57:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:40290 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgJEN5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:57:43 -0400
IronPort-SDR: 9gzm7KT2732yrrmcDG+pZGUPjCflU+OQGWF0WPvKahMoFGjibFy64iY7m3iIFJSwKmMu4RdCeG
 rkoNsgRxDwoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="143522991"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="143522991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 06:55:28 -0700
IronPort-SDR: a1vc2Ay6wyFXOodi0nuSgFuCEwUHKEa3S2NYtFYc4rr0+/UFftHziNp+oWCh06h9CS8kEg/q8n
 hec4/R3fs7IA==
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="314390949"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 06:55:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kPQxV-004gYw-Ez; Mon, 05 Oct 2020 16:55:21 +0300
Date:   Mon, 5 Oct 2020 16:55:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.9-2
Message-ID: <20201005135521.GA1116903@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I know that this is not the right time for the PR of such size, but we kinda
have a force major situation. As you know Darren have been not having time to
fulfil maintainer's responsibilities for some time already and now I have to
step down as a maintainer as well. I will concentrate on the tasks that are
closer to my area of responsibilities (GPIO and pin control drivers for Intel
PCHs, SoCs and PMICs along with some standalone drivers here and there).

Meanwhile PDx86 is not going to be abandoned or forgotten. We have got Hans and
Mark to support and as you may see in the MAINTAINERS update the status of the
subsystem becomes rather alive than dead. So, I welcome new maintainers and
vive le sous-système PDx86!

This is PR for v5.9 release as we have some troubles with Tablet Mode reporting
and users are complaining a lot about.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.9-2

for you to fetch changes up to 720ef73d1a239e33c3ad8fac356b9b1348e68aaf:

  platform/x86: thinkpad_acpi: re-initialize ACPI buffer size when reuse (2020-10-05 12:20:42 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.9-2

* Attempt #3 of enabling Tablet Mode reporting w/o regressions
* Improve battery recognition code in ASUS WMI driver
* Fix Kconfig dependency warning for Fujitsu and LG laptop drivers
* Add fixes in Thinkpad ACPI driver for _BCL method and NVRAM polling
* Fix power supply extended topology in Mellanox driver
* Fix memory leak in OLPC EC driver
* Avoid static struct device in Intel PMC core driver
* Add support for the touchscreen found in MPMAN Converter9 2-in-1
* Update MAINTAINERS to reflect the real state of affairs

The following is an automated git shortlog grouped by driver:

asus-nb-wmi:
 -  Revert "Do not load on Asus T100TA and T200TA"

asus-wmi:
 -  Add BATC battery name to the list of supported

intel_pmc_core:
 -  do not create a static struct device

intel-vbtn:
 -  Switch to an allow-list for SW_TABLET_MODE reporting
 -  Revert "Fix SW_TABLET_MODE always reporting 1 on the HP Pavilion 11 x360"
 -  Fix SW_TABLET_MODE always reporting 1 on the HP Pavilion 11 x360

MAINTAINERS:
 -  Add Mark Gross and Hans de Goede as x86 platform drivers maintainers

mlx-platform:
 -  Fix extended topology configuration for power supply units

pcengines-apuv2:
 -  Fix typo on define of AMD_FCH_GPIO_REG_GPIO55_DEVSLP0

Platform:
 -  fix kconfig dependency warning for FUJITSU_LAPTOP
 -  fix kconfig dependency warning for LG_LAPTOP
 -  OLPC: Fix memleak in olpc_ec_probe

thinkpad_acpi:
 -  re-initialize ACPI buffer size when reuse
 -  initialize tp_nvram_state variable
 -  fix underline length build warning

touchscreen_dmi:
 -  Add info for the MPMAN Converter9 2-in-1

----------------------------------------------------------------
Aaron Ma (1):
      platform/x86: thinkpad_acpi: re-initialize ACPI buffer size when reuse

Andy Shevchenko (1):
      platform/x86: intel-vbtn: Revert "Fix SW_TABLET_MODE always reporting 1 on the HP Pavilion 11 x360"

Dinghao Liu (1):
      Platform: OLPC: Fix memleak in olpc_ec_probe

Ed Wildgoose (1):
      platform/x86: pcengines-apuv2: Fix typo on define of AMD_FCH_GPIO_REG_GPIO55_DEVSLP0

Greg Kroah-Hartman (1):
      platform/x86: intel_pmc_core: do not create a static struct device

Hans de Goede (5):
      platform/x86: touchscreen_dmi: Add info for the MPMAN Converter9 2-in-1
      platform/x86: asus-nb-wmi: Revert "Do not load on Asus T100TA and T200TA"
      platform/x86: intel-vbtn: Fix SW_TABLET_MODE always reporting 1 on the HP Pavilion 11 x360
      platform/x86: intel-vbtn: Switch to an allow-list for SW_TABLET_MODE reporting
      MAINTAINERS: Add Mark Gross and Hans de Goede as x86 platform drivers maintainers

Marius Iacob (1):
      platform/x86: asus-wmi: Add BATC battery name to the list of supported

Necip Fazil Yildiran (2):
      platform/x86: fix kconfig dependency warning for LG_LAPTOP
      platform/x86: fix kconfig dependency warning for FUJITSU_LAPTOP

Randy Dunlap (1):
      Documentation: laptops: thinkpad-acpi: fix underline length build warning

Tom Rix (1):
      platform/x86: thinkpad_acpi: initialize tp_nvram_state variable

Vadim Pasternak (1):
      platform/x86: mlx-platform: Fix extended topology configuration for power supply units

 .../admin-guide/laptops/thinkpad-acpi.rst          |  2 +-
 MAINTAINERS                                        |  6 +--
 drivers/platform/olpc/olpc-ec.c                    |  4 +-
 drivers/platform/x86/Kconfig                       |  2 +
 drivers/platform/x86/asus-nb-wmi.c                 | 24 ----------
 drivers/platform/x86/asus-wmi.c                    |  1 +
 drivers/platform/x86/intel-vbtn.c                  | 52 ++++++++++++++++++----
 drivers/platform/x86/intel_pmc_core_pltdrv.c       | 26 +++++++----
 drivers/platform/x86/mlx-platform.c                | 18 +++++---
 drivers/platform/x86/pcengines-apuv2.c             |  2 +-
 drivers/platform/x86/thinkpad_acpi.c               |  6 ++-
 drivers/platform/x86/touchscreen_dmi.c             | 25 +++++++++++
 include/linux/platform_data/gpio/gpio-amd-fch.h    |  2 +-
 13 files changed, 114 insertions(+), 56 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


