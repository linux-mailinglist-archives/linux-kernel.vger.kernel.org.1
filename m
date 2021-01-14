Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277E02F6709
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbhANRKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbhANRJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:09:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F5C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:38 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r5so6468221eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJ6mOa9ldCJj0M8dHttr6Lt8MCzBTMDPe895o9rFCCU=;
        b=J2u2PCpUovQ5ApPZDe6bvZLV1i68jFwzTGEnafkYsAIgVo3ARYQWYSxIXJ7QIFddD4
         IZ2jR504g+Oz39IKSq2u//JoUkCwcycj0C/6uHlbknc9Jm6DBmWbvmZnoR1S0uCCIPzv
         ylMzBv/GAQ1GUi2SVPOxhEr43Cq4aVf1+laZqPKKFHOB6OaKZemfm7dw6DFKMeZhehTa
         OfLAU5IWd/yGtEFkdPonF4znoV8v4Ff2YdAMnnbctp56OPxHEPujmOzEPYHwKWCJFoNI
         xLa843Sm359P8w9Kujd4ZveFJxpzYBTcls1si/j5oc2KoaU44p3AHS6FDRc5mAoCvF9J
         9hgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJ6mOa9ldCJj0M8dHttr6Lt8MCzBTMDPe895o9rFCCU=;
        b=SZmAwpSxCY1TLczCuLhr1jRu6ORdPG1yRBSZIUxCi3fn36PPT7gMZO3cRVf87dfMh9
         VW54tAoc0NriVoXN8DZIOdLYPMILj8uNdb8kEDI4ecgmG6XMq80caURRV3y1cDKi2qPe
         +2eZIJn4ZRAOQZRYedHO1pfD9zlt5KJG2YaFY1S7suGucDyFGu8qD2tWJwtAinNqkoiA
         jRFCP8jsIybI2CoGtCYqn9Pja3NX7b8qmWNUgex3182SLAVR+4DFbP0jv0feZz6Zs6A/
         ktQe927K+swz+z1mbH4TImWsPvnbeutDNZHyFCCPvNVAo9xu+2q0bfD5DnRj7L0LyR8X
         khOw==
X-Gm-Message-State: AOAM530R1lCMMq7MW6AhwfZMSRSfhO5iKisicwq+FopzCfsu9N5d+LEL
        OeDRWna9amFDHPDj3EMqJalfijIJrTAuug==
X-Google-Smtp-Source: ABdhPJzRS5QhzsgRO9BLcx/z/fgGc02VWlPrz/ZzSdE2GzHAkWNWUn+rmmSf/URfXM/HWG/2USeyHw==
X-Received: by 2002:aa7:cc15:: with SMTP id q21mr6524228edt.213.1610644116764;
        Thu, 14 Jan 2021 09:08:36 -0800 (PST)
Received: from yoga-910.localhost (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id be6sm2397644edb.29.2021.01.14.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:08:36 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 4/5] bus: fsl-mc: add bus rescan attribute
Date:   Thu, 14 Jan 2021 19:07:51 +0200
Message-Id: <20210114170752.2927915-5-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114170752.2927915-1-ciorneiioana@gmail.com>
References: <20210114170752.2927915-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Introduce the rescan attribute as a bus attribute to
synchronize the fsl-mc bus objects and the MC firmware.

To rescan the fsl-mc bus, e.g.,
echo 1 > /sys/bus/fsl-mc/rescan

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 Documentation/ABI/stable/sysfs-bus-fsl-mc |  9 +++++
 MAINTAINERS                               |  1 +
 drivers/bus/fsl-mc/dprc-driver.c          |  4 +--
 drivers/bus/fsl-mc/fsl-mc-bus.c           | 41 +++++++++++++++++++++++
 drivers/bus/fsl-mc/fsl-mc-private.h       |  3 ++
 5 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc

diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc b/Documentation/ABI/stable/sysfs-bus-fsl-mc
new file mode 100644
index 000000000000..a4d384df9ba8
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
@@ -0,0 +1,9 @@
+What:		/sys/bus/fsl-mc/rescan
+Date:		January 2021
+KernelVersion:	5.12
+Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
+Description:	Writing a non-zero value to this attribute will
+		force a rescan of fsl-mc bus in the system and
+		synchronize the objects under fsl-mc bus and the
+		Management Complex firmware.
+Users:		Userspace drivers and management tools
diff --git a/MAINTAINERS b/MAINTAINERS
index 13b589396b61..66e90e326f6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14651,6 +14651,7 @@ M:	Stuart Yoder <stuyoder@gmail.com>
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
 F:	drivers/bus/fsl-mc/
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index ccec375095f2..4adb6f318884 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -237,8 +237,8 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
  * populated before they can get allocation requests from probe callbacks
  * of the device drivers for the non-allocatable devices.
  */
-static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
-			    bool alloc_interrupts)
+int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+		      bool alloc_interrupts)
 {
 	int num_child_objects;
 	int dprc_get_obj_failures;
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8af978bd0000..77708eaf2700 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -208,12 +208,53 @@ static struct attribute *fsl_mc_dev_attrs[] = {
 
 ATTRIBUTE_GROUPS(fsl_mc_dev);
 
+static int scan_fsl_mc_bus(struct device *dev, void *data)
+{
+	struct fsl_mc_device *root_mc_dev;
+	struct fsl_mc_bus *root_mc_bus;
+
+	if (!fsl_mc_is_root_dprc(dev))
+		goto exit;
+
+	root_mc_dev = to_fsl_mc_device(dev);
+	root_mc_bus = to_fsl_mc_bus(root_mc_dev);
+	mutex_lock(&root_mc_bus->scan_mutex);
+	dprc_scan_objects(root_mc_dev, NULL);
+	mutex_unlock(&root_mc_bus->scan_mutex);
+
+exit:
+	return 0;
+}
+
+static ssize_t rescan_store(struct bus_type *bus,
+			    const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val)
+		bus_for_each_dev(bus, NULL, NULL, scan_fsl_mc_bus);
+
+	return count;
+}
+static BUS_ATTR_WO(rescan);
+
+static struct attribute *fsl_mc_bus_attrs[] = {
+	&bus_attr_rescan.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(fsl_mc_bus);
+
 struct bus_type fsl_mc_bus_type = {
 	.name = "fsl-mc",
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
 	.dma_configure  = fsl_mc_dma_configure,
 	.dev_groups = fsl_mc_dev_groups,
+	.bus_groups = fsl_mc_bus_groups,
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 6293a24de456..42bdb8679a36 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -594,6 +594,9 @@ int __init dprc_driver_init(void);
 
 void dprc_driver_exit(void);
 
+int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+		      bool alloc_interrupts);
+
 int __init fsl_mc_allocator_driver_init(void);
 
 void fsl_mc_allocator_driver_exit(void);
-- 
2.29.2

