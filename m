Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2042F6708
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbhANRKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbhANRJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:09:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D544C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:39 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f4so9255465ejx.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yyk1VCADWCOtnTqYMeHY5n4r0ojuUJlLb/a2WuLwo1w=;
        b=mPjPwjS76keC69Orxdpik9MecxeBsduAbm25sCylxVU+KPdqAWMInSWZdxYaGT3a7Y
         lIu5ryp30HVGgXu0oX6NGkVTD8GU+zSM6sxHv/XAv7y0BH86NhYs2CowacD9rCO3F0DZ
         1uC+6KSe2mIYMkB1yqQVC1czBeDRhdqPBV5x0fCxujClISq4zkFyfpUl7DCNBjggzJVV
         4J0wer0sTzepr01KrJ8XkItARutOE4H5WvUQ5ggBVdAxgJ1RtSp1th0KJzSNhNoi5nY5
         7/b1cskmEWMj8OQUaE/4JH0nekPgsIlthjQ7uTqRWwdoHWBk7rHXS2fOhwAqioWDcrzD
         bbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yyk1VCADWCOtnTqYMeHY5n4r0ojuUJlLb/a2WuLwo1w=;
        b=NcND+oZG9ltwbnLUP5LjKnZcCyz8W9Y4X80/TQr/9L+MN7iPuDRCCaYUWcz4xtQsRE
         dqfu7vS34Mg6m05UKH8S0Jw4jjj9W/gAvjPnMVPr4WMHhk6xpYGCUhMBVS1gTjhjBPX6
         84w7xyD2Oa3am3lAMEywK7J4Spuzdv6EA68WlikLQSFCbFzJVMi1fSjQ0rXcj7Ui9p2u
         Q/5BrpgIHiH/kPWjPShcpyo/qXfV1cbJksdw4uCaWdaNFtHzcLz/NddARshihD0Jw5QL
         ywJjqQV9ybUiY691tqIL8sdHDSXftNQ9HYjNdVlPXFkOw9GIR0xPEzBpvHRJY9HuO/bB
         V0Ug==
X-Gm-Message-State: AOAM530Zce6nS6A2Nz7dy8yID934Nww2n8ZFsXGgjvpgnZIJzQUXh64H
        DxrSLRw16ouk1/jGcCyl0XQvOPWAinTY7w==
X-Google-Smtp-Source: ABdhPJyRoPUfFhN5wjD0OMaIKBWPVS0QtZ1bnkRlUaBxmCmnJAVRO2H6BNu1jafgvYbBipxw2VXQQA==
X-Received: by 2002:a17:907:9483:: with SMTP id dm3mr5965483ejc.120.1610644117955;
        Thu, 14 Jan 2021 09:08:37 -0800 (PST)
Received: from yoga-910.localhost (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id be6sm2397644edb.29.2021.01.14.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:08:37 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 5/5] bus: fsl-mc: add autorescan sysfs
Date:   Thu, 14 Jan 2021 19:07:52 +0200
Message-Id: <20210114170752.2927915-6-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114170752.2927915-1-ciorneiioana@gmail.com>
References: <20210114170752.2927915-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add the autorescan sysfs in order to enable/disable the DPRC IRQs on
which automatic rescan of the bus is performed. This is important when
dynamic creation of objects is needed to happen in a timely manner because
object creation can be bundled together.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 Documentation/ABI/stable/sysfs-bus-fsl-mc | 10 +++++
 drivers/bus/fsl-mc/dprc-driver.c          | 17 ++++++-
 drivers/bus/fsl-mc/fsl-mc-bus.c           | 55 +++++++++++++++++++++++
 drivers/bus/fsl-mc/fsl-mc-private.h       |  5 +++
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc b/Documentation/ABI/stable/sysfs-bus-fsl-mc
index a4d384df9ba8..58f06c7eeed7 100644
--- a/Documentation/ABI/stable/sysfs-bus-fsl-mc
+++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
@@ -7,3 +7,13 @@ Description:	Writing a non-zero value to this attribute will
 		synchronize the objects under fsl-mc bus and the
 		Management Complex firmware.
 Users:		Userspace drivers and management tools
+
+What:		/sys/bus/fsl-mc/autorescan
+Date:		January 2021
+KernelVersion:	5.12
+Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
+Description:	Writing a zero value to this attribute will
+		disable the DPRC IRQs on which automatic rescan
+		of the fsl-mc bus is performed. A non-zero value
+		will enable the DPRC IRQs.
+Users:		Userspace drivers and management tools
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 4adb6f318884..e3e2ae41c22b 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -458,8 +458,9 @@ static irqreturn_t dprc_irq0_handler_thread(int irq_num, void *arg)
 /*
  * Disable and clear interrupt for a given DPRC object
  */
-static int disable_dprc_irq(struct fsl_mc_device *mc_dev)
+int disable_dprc_irq(struct fsl_mc_device *mc_dev)
 {
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 	int error;
 	struct fsl_mc_io *mc_io = mc_dev->mc_io;
 
@@ -496,9 +497,18 @@ static int disable_dprc_irq(struct fsl_mc_device *mc_dev)
 		return error;
 	}
 
+	mc_bus->irq_enabled = 0;
+
 	return 0;
 }
 
+int get_dprc_irq_state(struct fsl_mc_device *mc_dev)
+{
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
+
+	return mc_bus->irq_enabled;
+}
+
 static int register_dprc_irq_handler(struct fsl_mc_device *mc_dev)
 {
 	int error;
@@ -525,8 +535,9 @@ static int register_dprc_irq_handler(struct fsl_mc_device *mc_dev)
 	return 0;
 }
 
-static int enable_dprc_irq(struct fsl_mc_device *mc_dev)
+int enable_dprc_irq(struct fsl_mc_device *mc_dev)
 {
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 	int error;
 
 	/*
@@ -554,6 +565,8 @@ static int enable_dprc_irq(struct fsl_mc_device *mc_dev)
 		return error;
 	}
 
+	mc_bus->irq_enabled = 1;
+
 	return 0;
 }
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 77708eaf2700..28d5da1c011c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -241,8 +241,63 @@ static ssize_t rescan_store(struct bus_type *bus,
 }
 static BUS_ATTR_WO(rescan);
 
+static int fsl_mc_bus_set_autorescan(struct device *dev, void *data)
+{
+	struct fsl_mc_device *root_mc_dev;
+	unsigned long val;
+	char *buf = data;
+
+	if (!fsl_mc_is_root_dprc(dev))
+		goto exit;
+
+	root_mc_dev = to_fsl_mc_device(dev);
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val)
+		enable_dprc_irq(root_mc_dev);
+	else
+		disable_dprc_irq(root_mc_dev);
+
+exit:
+	return 0;
+}
+
+static int fsl_mc_bus_get_autorescan(struct device *dev, void *data)
+{
+	struct fsl_mc_device *root_mc_dev;
+	char *buf = data;
+
+	if (!fsl_mc_is_root_dprc(dev))
+		goto exit;
+
+	root_mc_dev = to_fsl_mc_device(dev);
+
+	sprintf(buf, "%d\n", get_dprc_irq_state(root_mc_dev));
+exit:
+	return 0;
+}
+
+static ssize_t autorescan_store(struct bus_type *bus,
+				const char *buf, size_t count)
+{
+	bus_for_each_dev(bus, NULL, (void *)buf, fsl_mc_bus_set_autorescan);
+
+	return count;
+}
+
+static ssize_t autorescan_show(struct bus_type *bus, char *buf)
+{
+	bus_for_each_dev(bus, NULL, (void *)buf, fsl_mc_bus_get_autorescan);
+	return strlen(buf);
+}
+
+static BUS_ATTR_RW(autorescan);
+
 static struct attribute *fsl_mc_bus_attrs[] = {
 	&bus_attr_rescan.attr,
+	&bus_attr_autorescan.attr,
 	NULL,
 };
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 42bdb8679a36..1958fa065360 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -578,6 +578,7 @@ struct fsl_mc_bus {
 	struct mutex scan_mutex;    /* serializes bus scanning */
 	struct dprc_attributes dprc_attr;
 	struct fsl_mc_uapi uapi_misc;
+	int irq_enabled;
 };
 
 #define to_fsl_mc_bus(_mc_dev) \
@@ -656,4 +657,8 @@ static inline void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus)
 
 #endif
 
+int disable_dprc_irq(struct fsl_mc_device *mc_dev);
+int enable_dprc_irq(struct fsl_mc_device *mc_dev);
+int get_dprc_irq_state(struct fsl_mc_device *mc_dev);
+
 #endif /* _FSL_MC_PRIVATE_H_ */
-- 
2.29.2

