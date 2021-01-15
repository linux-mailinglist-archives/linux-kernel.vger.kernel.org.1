Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717952F7255
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbhAOFj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:39:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:21255 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbhAOFj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:39:26 -0500
IronPort-SDR: jgatApBvKce5qZJtfJ02Wsp7RqmuSmGCyIb1irdhWIgR5eBnz4O1yRcCSjr8QTaigH2KtoiaHG
 Ue0ArYg3kG/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="158276377"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="158276377"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:41 -0800
IronPort-SDR: g0hzGoynIz+FAkoIGrwwCuXmSbhF3yQ5TnAYMEaf90rJ3Vq1dBiWDddkCmaKD9z/u5JOLbAn9B
 P+deQjwnk49w==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382542427"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:38 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: [PATCH 1/5] soundwire: use consistent format for Slave devID logs
Date:   Fri, 15 Jan 2021 13:37:34 +0800
Message-Id: <20210115053738.22630-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
References: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We mix decimal and hexadecimal values, this leads to confusions in
dmesg logs and bug reports. Let's add a 0x prefix for all hexadecimal
values and a format when more than 4 bits are used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c   |  5 ++---
 drivers/soundwire/slave.c | 10 ++++------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index d1e8c3a54976..3cc006bfae71 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -679,9 +679,8 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
 	id->class_id = SDW_CLASS_ID(addr);
 
 	dev_dbg(bus->dev,
-		"SDW Slave class_id %x, part_id %x, mfg_id %x, unique_id %x, version %x\n",
-				id->class_id, id->part_id, id->mfg_id,
-				id->unique_id, id->sdw_version);
+		"SDW Slave class_id 0x%02x, mfg_id 0x%04x, part_id 0x%04x, unique_id 0x%x, version 0x%x\n",
+		id->class_id, id->mfg_id, id->part_id, id->unique_id, id->sdw_version);
 }
 
 static int sdw_program_device_num(struct sdw_bus *bus)
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index a08f4081c1c4..180f38bd003b 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -163,15 +163,13 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
 
 			if (id.unique_id != id2.unique_id) {
 				dev_dbg(bus->dev,
-					"Valid unique IDs %x %x for Slave mfg %x part %d\n",
-					id.unique_id, id2.unique_id,
-					id.mfg_id, id.part_id);
+					"Valid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
+					id.unique_id, id2.unique_id, id.mfg_id, id.part_id);
 				ignore_unique_id = false;
 			} else {
 				dev_err(bus->dev,
-					"Invalid unique IDs %x %x for Slave mfg %x part %d\n",
-					id.unique_id, id2.unique_id,
-					id.mfg_id, id.part_id);
+					"Invalid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
+					id.unique_id, id2.unique_id, id.mfg_id, id.part_id);
 				return -ENODEV;
 			}
 		}
-- 
2.17.1

