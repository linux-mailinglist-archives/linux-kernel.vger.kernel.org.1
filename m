Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6A2ED009
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbhAGMlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:41:14 -0500
Received: from foss.arm.com ([217.140.110.172]:59932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbhAGMlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:41:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAE8F1500;
        Thu,  7 Jan 2021 04:39:38 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0ED53F719;
        Thu,  7 Jan 2021 04:39:37 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 18/26] coresight: etm4x: Expose trcdevarch via sysfs
Date:   Thu,  7 Jan 2021 12:38:51 +0000
Message-Id: <20210107123859.674252-19-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210107123859.674252-1-suzuki.poulose@arm.com>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c       | 2 ++
 2 files changed, 10 insertions(+)

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
index 009818675928..b590b042dca3 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2357,6 +2357,7 @@ coresight_etm4x_cross_read(trclsr, TRCLSR);
 coresight_etm4x_cross_read(trcauthstatus, TRCAUTHSTATUS);
 coresight_etm4x_cross_read(trcdevid, TRCDEVID);
 coresight_etm4x_cross_read(trcdevtype, TRCDEVTYPE);
+coresight_etm4x_cross_read(trcdevarch, TRCDEVARCH);
 coresight_etm4x_cross_read(trcpidr0, TRCPIDR0);
 coresight_etm4x_cross_read(trcpidr1, TRCPIDR1);
 coresight_etm4x_cross_read(trcpidr2, TRCPIDR2);
@@ -2375,6 +2376,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	&dev_attr_trcauthstatus.attr,
 	&dev_attr_trcdevid.attr,
 	&dev_attr_trcdevtype.attr,
+	&dev_attr_trcdevarch.attr,
 	&dev_attr_trcpidr0.attr,
 	&dev_attr_trcpidr1.attr,
 	&dev_attr_trcpidr2.attr,
-- 
2.24.1

