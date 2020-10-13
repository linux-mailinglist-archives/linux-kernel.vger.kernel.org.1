Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52E428CE4C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgJMM03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbgJMM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602591983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ja+r3YielG3AT3NMTjOXVQSsflGJ/Mbns2ya4m+C1ZI=;
        b=iavwtoStIqf4KmvmlQ9zT3yVnL92tmGP/f9f3pfymhYbUenyUX93ddTtqv/udEOjNm2rh1
        WtLHKGt3tItjkyHeAM7AX1hCKKRJ6/tNDGixfv1Rq5I4RWNCXa2ncuA+jmOc/eKjbbTQiT
        DXAIWR+ZpSQG8CsSLOIzK88cHmFtfp4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-q_lAn4oXNcu5fETn5_g0Hw-1; Tue, 13 Oct 2020 08:26:22 -0400
X-MC-Unique: q_lAn4oXNcu5fETn5_g0Hw-1
Received: by mail-ed1-f72.google.com with SMTP id ay19so7938776edb.23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ja+r3YielG3AT3NMTjOXVQSsflGJ/Mbns2ya4m+C1ZI=;
        b=Fn3wUyf0ywQ1OK+UL7PpyJSRoAJYBsLrqBxxQk0mCvtc/HHpfQU2NwIBDQD2OzeZXx
         ZdOSwEsF8Uuk61Evv/HqQG7jiklhoRg8T6zuBtDgS8EsUFpbDkcCNuVJPePJWnJzawVK
         mynjJBn8xE0JN1R7Dz7bLyEPWEn8ih7+RUD6IfW5FmEPoAYvXulYeJzdFcwSUV9PcST7
         cCyMsI7uwZfSxvSs8r0xr0mUynUEMJIaE1b5Q2CbG+2H5taojB5SRUvB7uDEuR6vUgi/
         jkwAehlRL1RL6fmXJOGZpE7UefjODzUJeLC+o+tIB2a9evp3xcMC5UMqaEbTKAL5P0WP
         fPPA==
X-Gm-Message-State: AOAM531dWDpHJaPGQBdM9XhwMYEJw3Gzn3ykFLO8+8I+g7VlnZRPpnDk
        X31fxTBFtXB1mg8yG7OBhCcf9hHWjzcUrsu+BuYGvuf5XqCrBCSN+8who9xYzotppoZTZv0ylhI
        aY6onv3/R63zvluP33aRyjEAG
X-Received: by 2002:a50:80e3:: with SMTP id 90mr20487253edb.39.1602591979976;
        Tue, 13 Oct 2020 05:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHe5rkSAa0+2hTq0DHl5d18NHFGzxBrYbJUhOUgJKt9h4Wx/7FzYB2fbo3EXtdi8zCPwhVIA==
X-Received: by 2002:a50:80e3:: with SMTP id 90mr20487227edb.39.1602591979765;
        Tue, 13 Oct 2020 05:26:19 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r3sm8117479edw.42.2020.10.13.05.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 05:26:19 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.10-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <9335fbd5-81a2-59cb-d6ee-52e3b4de641f@redhat.com>
Date:   Tue, 13 Oct 2020 14:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v5.10. Rather calm cycle for PDx86,
all these have been in for-next for a couple of days with no bot
complaints.

Note this includes all the fixes which you have merged since 5.9-rc1
(this is based on the platform-drivers-x86-v5.9-3 tag, which itself is
based on 5.9-rc1).

Regards,

Hans

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.10-1

for you to fetch changes up to 1a3f7813f38e400b0b63492b626b425f0a043d0b:

   MAINTAINERS: update X86 PLATFORM DRIVERS entry with new kernel.org git repo (2020-10-08 21:38:30 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.10-1

Rather calm cycle for PDx86, all these have been in for-next for
a couple of days with no bot complaints.

Highlights:
- PMC TigerLake fixes and new RocketLake support
- Various small fixes / updates in other drivers/tools

The following is an automated git shortlog grouped by driver:

MAINTAINERS:
  -  update X86 PLATFORM DRIVERS entry with new kernel.org git repo
  -  Update maintainers for pmc_core driver

hp-wmi:
  -  add support for thermal policy

intel_pmc_core:
  -  fix: Replace dev_dbg macro with dev_info()
  -  Add Intel RocketLake (RKL) support
  -  Clean up: Remove the duplicate comments and reorganize
  -  Fix the slp_s0 counter displayed value
  -  Fix TigerLake power gating status map

mlx-platform:
  -  Add capability field to platform FAN description
  -  Remove PSU EEPROM configuration

platform_data/mlxreg:
  -  Extend core platform structure
  -  Update module license

pmc_core:
  -  Use descriptive names for LPM registers

tools/power/x86/intel-speed-select:
  -  Update version for v5.10
  -  Fix missing base-freq core IDs

----------------------------------------------------------------
Aaron Ma (1):
       platform/x86: thinkpad_acpi: re-initialize ACPI buffer size when reuse

Andy Shevchenko (1):
       platform/x86: intel-vbtn: Revert "Fix SW_TABLET_MODE always reporting 1 on the HP Pavilion 11 x360"

David E. Box (1):
       platform/x86: pmc_core: Use descriptive names for LPM registers

Dinghao Liu (1):
       Platform: OLPC: Fix memleak in olpc_ec_probe

Ed Wildgoose (1):
       platform/x86: pcengines-apuv2: Fix typo on define of AMD_FCH_GPIO_REG_GPIO55_DEVSLP0

Elia Devito (1):
       platform/x86: hp-wmi: add support for thermal policy

Gayatri Kammela (6):
       platform/x86: intel_pmc_core: Fix TigerLake power gating status map
       platform/x86: intel_pmc_core: Fix the slp_s0 counter displayed value
       platform/x86: intel_pmc_core: Clean up: Remove the duplicate comments and reorganize
       platform/x86: intel_pmc_core: Add Intel RocketLake (RKL) support
       platform/x86: intel_pmc_core: fix: Replace dev_dbg macro with dev_info()
       MAINTAINERS: Update maintainers for pmc_core driver

Greg Kroah-Hartman (1):
       platform/x86: intel_pmc_core: do not create a static struct device

Hans de Goede (7):
       platform/x86: touchscreen_dmi: Add info for the MPMAN Converter9 2-in-1
       platform/x86: asus-nb-wmi: Revert "Do not load on Asus T100TA and T200TA"
       platform/x86: intel-vbtn: Fix SW_TABLET_MODE always reporting 1 on the HP Pavilion 11 x360
       platform/x86: intel-vbtn: Switch to an allow-list for SW_TABLET_MODE reporting
       MAINTAINERS: Add Mark Gross and Hans de Goede as x86 platform drivers maintainers
       platform/x86: asus-wmi: Fix SW_TABLET_MODE always reporting 1 on many different models
       MAINTAINERS: update X86 PLATFORM DRIVERS entry with new kernel.org git repo

Jonathan Doman (1):
       tools/power/x86/intel-speed-select: Fix missing base-freq core IDs

Marius Iacob (1):
       platform/x86: asus-wmi: Add BATC battery name to the list of supported

Necip Fazil Yildiran (2):
       platform/x86: fix kconfig dependency warning for LG_LAPTOP
       platform/x86: fix kconfig dependency warning for FUJITSU_LAPTOP

Randy Dunlap (1):
       Documentation: laptops: thinkpad-acpi: fix underline length build warning

Srinivas Pandruvada (1):
       tools/power/x86/intel-speed-select: Update version for v5.10

Tom Rix (1):
       platform/x86: thinkpad_acpi: initialize tp_nvram_state variable

Vadim Pasternak (5):
       platform/x86: mlx-platform: Fix extended topology configuration for power supply units
       platform/x86: mlx-platform: Remove PSU EEPROM configuration
       platform_data/mlxreg: Update module license
       platform_data/mlxreg: Extend core platform structure
       platform/x86: mlx-platform: Add capability field to platform FAN description

  .../admin-guide/laptops/thinkpad-acpi.rst          |   2 +-
  MAINTAINERS                                        |  12 +-
  drivers/platform/olpc/olpc-ec.c                    |   4 +-
  drivers/platform/x86/Kconfig                       |   2 +
  drivers/platform/x86/asus-nb-wmi.c                 |  56 ++++++----
  drivers/platform/x86/asus-wmi.c                    |  17 +--
  drivers/platform/x86/asus-wmi.h                    |   1 +
  drivers/platform/x86/hp-wmi.c                      |  23 ++++
  drivers/platform/x86/intel-vbtn.c                  |  52 +++++++--
  drivers/platform/x86/intel_pmc_core.c              | 121 ++++++++++++---------
  drivers/platform/x86/intel_pmc_core.h              |   5 +-
  drivers/platform/x86/intel_pmc_core_pltdrv.c       |  26 +++--
  drivers/platform/x86/mlx-platform.c                |  28 +++--
  drivers/platform/x86/pcengines-apuv2.c             |   2 +-
  drivers/platform/x86/thinkpad_acpi.c               |   6 +-
  drivers/platform/x86/touchscreen_dmi.c             |  25 +++++
  include/linux/platform_data/gpio/gpio-amd-fch.h    |   2 +-
  include/linux/platform_data/mlxreg.h               |  34 +-----
  tools/power/x86/intel-speed-select/isst-config.c   |  23 ++--
  tools/power/x86/intel-speed-select/isst-core.c     |   8 +-
  tools/power/x86/intel-speed-select/isst.h          |   2 +-
  21 files changed, 275 insertions(+), 176 deletions(-)

