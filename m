Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E2304536
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbhAZRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:25:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:43516 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389089AbhAZG4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:56:00 -0500
IronPort-SDR: 2ldhHp8zOLe9aLI5eu+TY0G8cm3qOhMehdbVv2GQi+fonEmVStWs3MRXBetg3Y9IUByrkRhUsX
 2mf5cR2WIIow==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159633407"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159633407"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 22:55:17 -0800
IronPort-SDR: AwPeCoJ5QG4ABzJq7H4eM5QQmNhYdpL8ZPTthvB9m2WYLwtdnPG92UQrJTYZS3wCTGkJglnrmV
 cF7a2mzARpLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387713125"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2021 22:55:14 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v2 4/4] MAINTAINERS: Add entry for Intel MAX 10 mfd driver
Date:   Tue, 26 Jan 2021 14:50:36 +0800
Message-Id: <1611643836-7183-5-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611643836-7183-1-git-send-email-yilun.xu@intel.com>
References: <1611643836-7183-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds maintainer info for Intel MAX 10 mfd driver.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5aa18cb..10985d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9132,6 +9132,15 @@ F:	include/linux/mei_cl_bus.h
 F:	include/uapi/linux/mei.h
 F:	samples/mei/*
 
+INTEL MAX 10 BMC MFD DRIVER
+M:	Xu Yilun <yilun.xu@intel.com>
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
+F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
+F:	drivers/hwmon/intel-m10-bmc-hwmon.c
+F:	drivers/mfd/intel-m10-bmc.c
+F:	include/linux/mfd/intel-m10-bmc.h
+
 INTEL MENLOW THERMAL DRIVER
 M:	Sujith Thomas <sujith.thomas@intel.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.7.4

