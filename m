Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2557295841
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503415AbgJVGQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503403AbgJVGQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:16:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C60C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 23:16:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o7so329283pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 23:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p4zyflvLNk2+EDbB05FNEfMm3ZGiLOE0+ZtK8G7u7Bw=;
        b=KUDVqKnI8dD809pBH9VdHFKm+dvrwV27BzFWcfsCdydcRnO51xJmB4NgC5UtqS/wi7
         317fU5tzipc415bSIlCVfWexFrN5Aj2wBloXugx8mSDES6NJjcowRDbrSwKv/cwlLuEq
         LHneimLc5h5tXyBNhIVPjw+8hzxnC9jfo9uHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p4zyflvLNk2+EDbB05FNEfMm3ZGiLOE0+ZtK8G7u7Bw=;
        b=sWztXcV2mTWFzFwRBQs/b8JkiZk8BtbHhZ5LzJuHxiJM0jyAdg/M01Yk1+Rrg2oNIu
         dxAIz4z2o0FGhGAa6ZIayrRoSub3YY3LJ3CZT/pSGVZqgNhnJuZ7fjO/00s9nzRz9EO5
         +TU40mvikmxR4asPrstgVq+sSOIZBeDoEvVQUtB4WDGSzw6PA/920Q3Pnd7Ytw/cA1WO
         3Eos2tRvBcP3YhF0dp7zkTW0qefGrtZRATAmN5lPw+K2A8YYf8xnWtVKGRFrA2xTgqwD
         /uR18nq8WEAJvnd4xSo074OTOHGhoDR+7jynJbIxGGqE/7j5wMJpEPQo9UKhlLT5bhRG
         u09A==
X-Gm-Message-State: AOAM5300NdtvKcDBvqGFFhJGd+/Xvm4WdVX5iuCIYdAoxBsEUdQV/nIo
        X2dTkxyrOmL6XWSbJIymdpjg5B4PGyrVQw==
X-Google-Smtp-Source: ABdhPJzpiJi2b04YecF0gC0YVOc+LB3OPRre1usQZZ5rGhWdLM2Y7xyPOHR6cvPslbmLNsQGGTaCZg==
X-Received: by 2002:aa7:9059:0:b029:151:d725:e230 with SMTP id n25-20020aa790590000b0290151d725e230mr1105975pfo.77.1603347364006;
        Wed, 21 Oct 2020 23:16:04 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id l7sm849194pja.11.2020.10.21.23.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 23:16:03 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2] usb: typec: Expose Product Type VDOs via sysfs
Date:   Wed, 21 Oct 2020 23:15:54 -0700
Message-Id: <20201022061554.3418060-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PD-capable device can return up to 3 Product Type VDOs as part of its
DiscoverIdentity Response (USB PD Spec, Rev 3.0, Version 2.0, Section
6.4.4.3.1). Add a sysfs attribute to expose these to userspace.

Cc: Benson Leung <bleung@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

NOTE: I didn't include Benson's Reviewed-by from v1, since this version
introduced the sysfs_notify() call.

Changes in v2:
- Added sysfs_notify() call for the attribute.
- Added description for the attribute in
  Documentation/ABI/testing/sysfs-class-typec.

 Documentation/ABI/testing/sysfs-class-typec | 17 +++++++++++++++++
 drivers/usb/typec/class.c                   | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index b834671522d6..16440a236b66 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -170,6 +170,14 @@ Description:
 		will show 0 until Discover Identity command result becomes
 		available. The value can be polled.
 
+What:		/sys/class/typec/<port>-partner/identity/product_type_vdo
+Date:		October 2020
+Contact:	Prashant Malani <pmalani@chromium.org>
+Description:
+		Product Type VDOs part of Discover Identity command result. 3 values
+		are displayed (for the 3 possible Product Type VDOs), one per line.
+		The values will show 0s until Discover Identity command result becomes
+		available. The values can be polled.
 
 USB Type-C cable devices (eg. /sys/class/typec/port0-cable/)
 
@@ -230,6 +238,15 @@ Description:
 		will show 0 until Discover Identity command result becomes
 		available. The value can be polled.
 
+What:		/sys/class/typec/<port>-cable/identity/product_type_vdo
+Date:		October 2020
+Contact:	Prashant Malani <pmalani@chromium.org>
+Description:
+		Product Type VDOs part of Discover Identity command result. 3 values
+		are displayed (for the 3 possible Product Type VDOs), one per line.
+		The values will show 0s until Discover Identity command result becomes
+		available. The values can be polled.
+
 
 USB Type-C port alternate mode devices.
 
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 35eec707cb51..37fa4501e75f 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -122,10 +122,20 @@ static ssize_t product_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(product);
 
+static ssize_t product_type_vdo_show(struct device *dev, struct device_attribute *attr,
+				     char *buf)
+{
+	struct usb_pd_identity *id = get_pd_identity(dev);
+
+	return sprintf(buf, "0x%08x\n0x%08x\n0x%08x\n", id->vdo[0], id->vdo[1], id->vdo[2]);
+}
+static DEVICE_ATTR_RO(product_type_vdo);
+
 static struct attribute *usb_pd_id_attrs[] = {
 	&dev_attr_id_header.attr,
 	&dev_attr_cert_stat.attr,
 	&dev_attr_product.attr,
+	&dev_attr_product_type_vdo.attr,
 	NULL
 };
 
@@ -144,6 +154,7 @@ static void typec_report_identity(struct device *dev)
 	sysfs_notify(&dev->kobj, "identity", "id_header");
 	sysfs_notify(&dev->kobj, "identity", "cert_stat");
 	sysfs_notify(&dev->kobj, "identity", "product");
+	sysfs_notify(&dev->kobj, "identity", "product_type_vdo");
 }
 
 /* ------------------------------------------------------------------------- */
-- 
2.29.0.rc1.297.gfa9743e501-goog

