Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F342CD16E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgLCIlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:41:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:64107 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgLCIlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:41:02 -0500
IronPort-SDR: /PtdjtFeYwo9XAYHH+HLIEpWt14/kS5WgNtdV4+m7eCh3d0gDhzcfpbWMn0Zqjzeq5IC0V5dGH
 mWYx6mzXmhRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152984837"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="152984837"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:39:16 -0800
IronPort-SDR: py55meYhyezQ3cpL/iVPqQ8f6Air30SUNQMnH2PGlbGb4kg927x0l7R+5JCQhFkONTcNX+BAEE
 6Z/OTm/NAKJw==
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="481880875"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:39:12 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/7] soundwire/regmap: use _no_pm routines
Date:   Thu,  3 Dec 2020 04:46:38 +0800
Message-Id: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a Slave device is resumed, it may resume the bus and restart the
enumeration. And Slave drivers will wait for initialization_complete
complete in their resume function, however initialization_complete will
complete after sdw_update_slave_status function is finished and codec
driver usually call some IO functions in the update_status callback
function.
It will become a deadlock if we use regular read/write routines during
the resuming process.

This series touches both soundwire and regmap trees.
commit fb5103f9d6ce ("regmap/SoundWire: sdw: add support for SoundWire 1.2 MBQ")
is needed for soundwire tree to complie.
On the other hands,
commit 6e06a85556f9 ("soundwire: bus: add comments to explain interrupt loop filter")
to
commit 47b8520997a8 ("soundwire: bus: only clear valid DPN interrupts")
are needed for regmap tree.

Bard Liao (2):
  soundwire/regmap: use _no_pm functions in regmap_read/write
  regmap: sdw: use no_pm routines for SoundWire 1.2 MBQ

Pierre-Louis Bossart (5):
  soundwire: bus: use sdw_update_no_pm when initializing a device
  soundwire: bus: use sdw_write_no_pm when setting the bus scale
    registers
  soundwire: bus: use no_pm IO routines for all interrupt handling
  soundwire: bus: fix confusion on device used by pm_runtime
  soundwire: bus: clarify dev_err/dbg device references

 drivers/base/regmap/regmap-sdw-mbq.c |  10 +-
 drivers/base/regmap/regmap-sdw.c     |   4 +-
 drivers/soundwire/bus.c              | 135 +++++++++++++++------------
 include/linux/soundwire/sdw.h        |   2 +
 4 files changed, 85 insertions(+), 66 deletions(-)

-- 
2.17.1

