Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CE92A5D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 06:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgKDFQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 00:16:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:36329 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbgKDFQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 00:16:28 -0500
IronPort-SDR: k5l83pImmwRHCdd0LJY5ZOATNUITAePy/05lqPm7o6evn2aoRz52KVqtmFQeqBBrlJi9+7ugY8
 ZSQLxyj4jrZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="166577216"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="166577216"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 21:16:27 -0800
IronPort-SDR: 7uHtBrmbcbM7obVhPWTMSKrfggqF+bWqbpPKVWZWl8GDEFCozIqira4v28BVLg9cwqWSY08gCw
 A/BlucN5BXOg==
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="538764052"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 21:16:23 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 0/5] regmap/SoundWire/ASoC: Add SoundWire SDCA support
Date:   Wed,  4 Nov 2020 01:22:21 +0800
Message-Id: <20201103172226.4278-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI SoundWire Device Class standard will define audio functionality
beyond the scope of the existing SoundWire 1.2 standard, which is limited
to the bus and interface.

The description is inspired by the USB Audio Class, with "functions",
"entities", "control selectors", "audio clusters". The main difference
with the USB Audio class is that the devices are typically on a motherboard
and descriptors stored in platform firmware instead of being retrieved
from the device.

The current set of devices managed in this patchset are conformant with the
SDCA 0.6 specification and require dedicated drivers since the descriptors
and platform firmware specification is not complete at this time. They do
however rely on the hierarchical addressing required by the SDCA standard.
Future devices conformant with SDCA 1.0 should rely on a class driver.

This series adds support for the hierarchical SDCA addressing and extends
regmap. It then provides 3 codecs for RT711-sdca headset codec, RT1316
amplifier and RT715-scda microphone codec.

Note that the release of this code before the formal adoption of the
SDCA 1.0 specification was formally endorsed by the MIPI Board to make
sure there is no delay for Linux-based support of this specification.

Jack Yu (1):
  ASoC/SoundWire: rt715-sdca: First version of rt715 sdw sdca codec
    driver

Pierre-Louis Bossart (2):
  soundwire: SDCA: add helper macro to access controls
  regmap/SoundWire: sdw: add support for SoundWire 1.2 MBQ

Shuming Fan (2):
  ASoC/SoundWire: rt1316: Add RT1316 SDCA vendor-specific driver
  ASoC/SoundWire: rt711-sdca: Add RT711 SDCA vendor-specific driver

 drivers/base/regmap/Kconfig             |    6 +-
 drivers/base/regmap/Makefile            |    1 +
 drivers/base/regmap/regmap-sdw-mbq.c    |  101 ++
 include/linux/regmap.h                  |   35 +
 include/linux/soundwire/sdw_registers.h |   32 +
 sound/soc/codecs/Kconfig                |   20 +
 sound/soc/codecs/Makefile               |    6 +
 sound/soc/codecs/rt1316-sdw.c           |  756 ++++++++++++
 sound/soc/codecs/rt1316-sdw.h           |  115 ++
 sound/soc/codecs/rt711-sdca-sdw.c       |  424 +++++++
 sound/soc/codecs/rt711-sdca-sdw.h       |  101 ++
 sound/soc/codecs/rt711-sdca.c           | 1481 +++++++++++++++++++++++
 sound/soc/codecs/rt711-sdca.h           |  246 ++++
 sound/soc/codecs/rt715-sdca-sdw.c       |  278 +++++
 sound/soc/codecs/rt715-sdca-sdw.h       |  170 +++
 sound/soc/codecs/rt715-sdca.c           |  936 ++++++++++++++
 sound/soc/codecs/rt715-sdca.h           |  124 ++
 17 files changed, 4831 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-sdw-mbq.c
 create mode 100644 sound/soc/codecs/rt1316-sdw.c
 create mode 100644 sound/soc/codecs/rt1316-sdw.h
 create mode 100644 sound/soc/codecs/rt711-sdca-sdw.c
 create mode 100644 sound/soc/codecs/rt711-sdca-sdw.h
 create mode 100644 sound/soc/codecs/rt711-sdca.c
 create mode 100644 sound/soc/codecs/rt711-sdca.h
 create mode 100644 sound/soc/codecs/rt715-sdca-sdw.c
 create mode 100644 sound/soc/codecs/rt715-sdca-sdw.h
 create mode 100644 sound/soc/codecs/rt715-sdca.c
 create mode 100644 sound/soc/codecs/rt715-sdca.h

-- 
2.17.1

