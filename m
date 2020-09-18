Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97013270283
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIRQqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:46:55 -0400
Received: from plasma31.jpberlin.de ([80.241.56.82]:28081 "EHLO
        plasma31.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgIRQqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:46:55 -0400
Received: from gerste.heinlein-support.de (unknown [80.241.56.124])
        by plasma.jpberlin.de (Postfix) with ESMTP id 2C2E4100D7A;
        Fri, 18 Sep 2020 18:46:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.76])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id YVw5KSDCwv_e; Fri, 18 Sep 2020 18:46:48 +0200 (CEST)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 313B8100C91;
        Fri, 18 Sep 2020 18:46:48 +0200 (CEST)
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <alex.bennee@linaro.org>, <jean-philippe@linaro.org>,
        <igor.skalkin@opensynergy.com>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [RFC PATCH 1/7] firmware: arm_scmi, smccc, mailbox: Make shmem based transports optional
Date:   Fri, 18 Sep 2020 18:46:16 +0200
Message-ID: <20200918164617.256356-1-peter.hilber@opensynergy.com>
In-Reply-To: <20200918162311.254564-1-peter.hilber@opensynergy.com>
References: <20200918162311.254564-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: *
X-Rspamd-Score: 0.94 / 15.00 / 15.00
X-Rspamd-Queue-Id: 2C2E4100D7A
X-Rspamd-UID: d174ef
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Skalkin <igor.skalkin@opensynergy.com>

Upon adding the virtio transport in this patch series, SCMI will also
work without shared memory based transports. Also, the mailbox transport
may not be needed if the smc transport is used.

- Compile shmem.c only if a shmem based transport is available.

- Remove hard dependency of SCMI on mailbox.

Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
---
 drivers/firmware/Kconfig           | 9 ++++++++-
 drivers/firmware/arm_scmi/Makefile | 2 +-
 drivers/firmware/arm_scmi/common.h | 2 ++
 drivers/firmware/arm_scmi/driver.c | 2 ++
 drivers/firmware/smccc/Kconfig     | 1 +
 drivers/mailbox/Kconfig            | 1 +
 6 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index afdbebba628a..bdde51adb267 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -9,7 +9,7 @@ menu "Firmware Drivers"
 config ARM_SCMI_PROTOCOL
 	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
-	depends on MAILBOX
+	depends on ARM_SCMI_HAVE_SHMEM
 	help
 	  ARM System Control and Management Interface (SCMI) protocol is a
 	  set of operating system-independent software interfaces that are
@@ -27,6 +27,13 @@ config ARM_SCMI_PROTOCOL
 	  This protocol library provides interface for all the client drivers
 	  making use of the features offered by the SCMI.
 
+config ARM_SCMI_HAVE_SHMEM
+	bool
+	default n
+	help
+	  This declares whether a shared memory based transport for SCMI is
+	  available.
+
 config ARM_SCMI_POWER_DOMAIN
 	tristate "SCMI power domain driver"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index bc0d54f8e861..3cc7fa40a464 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o notify.o
-scmi-transport-y = shmem.o
+scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 37fb583f1bf5..36c38334a045 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -240,7 +240,9 @@ struct scmi_desc {
 	int max_msg_size;
 };
 
+#ifdef CONFIG_MAILBOX
 extern const struct scmi_desc scmi_mailbox_desc;
+#endif
 #ifdef CONFIG_HAVE_ARM_SMCCC
 extern const struct scmi_desc scmi_smc_desc;
 #endif
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c5dea87edf8f..d070687cf2f6 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -910,7 +910,9 @@ ATTRIBUTE_GROUPS(versions);
 
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
+#ifdef CONFIG_MAILBOX
 	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
+#endif
 #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
 	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
 #endif
diff --git a/drivers/firmware/smccc/Kconfig b/drivers/firmware/smccc/Kconfig
index 15e7466179a6..69c4d6cabf62 100644
--- a/drivers/firmware/smccc/Kconfig
+++ b/drivers/firmware/smccc/Kconfig
@@ -9,6 +9,7 @@ config HAVE_ARM_SMCCC_DISCOVERY
 	bool
 	depends on ARM_PSCI_FW
 	default y
+	select ARM_SCMI_HAVE_SHMEM
 	help
 	 SMCCC v1.0 lacked discoverability and hence PSCI v1.0 was updated
 	 to add SMCCC discovery mechanism though the PSCI firmware
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05b1009e2820..5ffe1ab0c869 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig MAILBOX
 	bool "Mailbox Hardware Support"
+	select ARM_SCMI_HAVE_SHMEM
 	help
 	  Mailbox is a framework to control hardware communication between
 	  on-chip processors through queued messages and interrupt driven
-- 
2.25.1

