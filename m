Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427462FFD17
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbhAVHJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:09:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:13989 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbhAVHJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:09:10 -0500
IronPort-SDR: FDlXdA/0sKOjw01sD25YAkHAjl0M9RGCwl99zVimzoRzsmayRlRM8ExmAsoTAyhZz5/wAWhcVo
 d1/6+1aiVm8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="159181518"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="159181518"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:31 -0800
IronPort-SDR: 7I9kylbZRSajNoXgdDKC9QMSqWPgHqgn1nduawS4rEEdTyaF+74oryPAQLfEFZFGB+j/W/Gq2s
 DdAaOaRhaFNw==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="427863354"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:27 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH v2 0/9] soundwire/regmap: use _no_pm routines
Date:   Fri, 22 Jan 2021 15:06:25 +0800
Message-Id: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
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

v2:
 - Separate commits according to maintainer's comments.

Bard Liao (4):
  soundwire: export sdw_write/read_no_pm functions
  regmap: sdw: use _no_pm functions in regmap_read/write
  regmap: sdw: use no_pm routines for SoundWire 1.2 MBQ
  regmap: sdw-mbq: use MODULE_LICENSE("GPL")

Pierre-Louis Bossart (5):
  soundwire: bus: use sdw_update_no_pm when initializing a device
  soundwire: bus: use sdw_write_no_pm when setting the bus scale
    registers
  soundwire: bus: use no_pm IO routines for all interrupt handling
  soundwire: bus: fix confusion on device used by pm_runtime
  soundwire: bus: clarify dev_err/dbg device references

 drivers/base/regmap/regmap-sdw-mbq.c |  10 +-
 drivers/base/regmap/regmap-sdw.c     |   4 +-
 drivers/soundwire/bus.c              | 136 +++++++++++++++------------
 include/linux/soundwire/sdw.h        |   2 +
 4 files changed, 85 insertions(+), 67 deletions(-)

-- 
2.17.1

