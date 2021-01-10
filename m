Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4292F0A2A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbhAJWvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:51:51 -0500
Received: from foss.arm.com ([217.140.110.172]:39104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbhAJWvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:51:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74E7E152B;
        Sun, 10 Jan 2021 14:49:33 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 260843F719;
        Sun, 10 Jan 2021 14:49:32 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 20/28] coresight: etm4x: Expose trcdevarch via sysfs
Date:   Sun, 10 Jan 2021 22:48:42 +0000
Message-Id: <20210110224850.1880240-21-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the TRCDEVARCH register via the sysfs for component
detection. Given that the TRCIDR1 may not completely identify
the ETM component and instead need to use TRCDEVARCH, expose
this via sysfs for tools to use it for identification.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v5:
 - Move the trcdevarch to mgmt/ instead of the trcidr (Mike L)
 - Add sysfs documentation for the new register (Mike L)
---
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x         | 8 ++++++++
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
index 881f0cd99ce4..8e53a32f8150 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
@@ -371,6 +371,14 @@ Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(Read) Print the content of the Device ID Register
 		(0xFC8).  The value is taken directly from the HW.
 
+What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcdevarch
+Date:		January 2021
+KernelVersion:	5.12
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(Read) Print the content of the Device Architecture Register
+		(offset 0xFBC).  The value is taken directly read
+		from the HW.
+
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcdevtype
 Date:		April 2015
 KernelVersion:	4.01
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 45aeeac2f50e..b646d53a3133 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2442,6 +2442,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
 	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
 	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
+	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
 	NULL,
 };
 
-- 
2.24.1

