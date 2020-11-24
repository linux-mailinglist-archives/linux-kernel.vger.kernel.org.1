Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916912C31BF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgKXULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgKXULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:11:34 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39D5C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 12:11:34 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id l17so197742pgk.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 12:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/hdw7M3AFf0fe2uiwx12/tHt1BVjyQkwyG+1IC9NuQ=;
        b=cTKnasuQyLt0e44sOIGu5dr1XYgMEP8iV1qs032POwBRQoftEBJFIKoxO6yex/sRue
         GiUPGrfSlgvr05+Ob/8xcRt2Aw5G+FrAgFO+k1g642a3NAxa0O4upthmfBY8wDdKsHdK
         x/fp7Qk+nj5nsoNZVb1vnuTOIK7T7P/xlOkhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/hdw7M3AFf0fe2uiwx12/tHt1BVjyQkwyG+1IC9NuQ=;
        b=f2hwZRm5Q09VuIGL4gvoXDFk0Tfo/Qteo4XLQRBLdrNSWxJrNxv6dU4RX+seTDeDqW
         muJkg3XpVPhjjInNhXge/6wx9lw9v9kJaNp2NjYwugY5TwCxYZK/GvI8kcIZIElCfzQ1
         SItOH48gFaZhQQ5XRrZO/TokKavbRHiaSLssifSa+T3UEqubQMRJeWvFo70LgQvgmo9F
         bme+SRN3L+ROqw8z6IWp/2rokILzlgphEU1bPEoHSZNyMYYVk7MfSpXlgmsHtqfLTw1Y
         p4xwJcY8FcLQSSxELoE7esOMM3Wr/ec9zPPzJ5p/Cl/0oKC/ol3XniAs/LKkKZl4oOAn
         VJRw==
X-Gm-Message-State: AOAM530XxiNh4+9k33QWkMyRYYCKh6Sjv8G/dNoDOaUQJ+TquUDXFAX0
        oFYPUFuuGOSQwyuunvTvkhdOkUhTKFBg1Q==
X-Google-Smtp-Source: ABdhPJwbWqqUcZPrR94ebXIG0QHQ/Qih2vrOAit2auVHZmAFdUgjOulJ2kURFNaBw2+xE+H/3W8cxw==
X-Received: by 2002:a17:90a:4283:: with SMTP id p3mr335330pjg.174.1606248694106;
        Tue, 24 Nov 2020 12:11:34 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id w15sm53800pjy.47.2020.11.24.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 12:11:33 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v4 2/2] usb: typec: Expose Product Type VDOs via sysfs
Date:   Tue, 24 Nov 2020 12:10:33 -0800
Message-Id: <20201124201033.592576-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201124201033.592576-1-pmalani@chromium.org>
References: <20201124201033.592576-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PD-capable device can return up to 3 Product Type VDOs as part of its
DiscoverIdentity Response (USB PD Spec, Rev 3.0, Version 2.0, Section
6.4.4.3.1). Add sysfs attributes to expose these to userspace.

Cc: Benson Leung <bleung@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Changes in v4:
- Added Reviewed-by tag from v3's review.
- Rebased on top of usb-next + Patch 1/2

Changes in v3:
- Split each product type VDO into a separate attribute.
- Changed sprintf() to sysfs_emit().
- Changed ABI documentation based on consolidation of identity VDO
  descriptions in the previous patch (1/2).

Changes in v2:
- Added sysfs_notify() call for the attribute.
- Added description for the attribute in
  Documentation/ABI/testing/sysfs-class-typec.

 Documentation/ABI/testing/sysfs-class-typec | 24 +++++++++++++++
 drivers/usb/typec/class.c                   | 33 +++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 88ffc14d4cd2..619c4c67432b 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -228,6 +228,30 @@ Description:
 		will show 0 until Discover Identity command result becomes
 		available. The value can be polled.
 
+What:		/sys/class/typec/<port>-{partner|cable}/identity/product_type_vdo1
+Date:		October 2020
+Contact:	Prashant Malani <pmalani@chromium.org>
+Description:
+		1st Product Type VDO of Discover Identity command result.
+		The value will show 0 until Discover Identity command result becomes
+		available and a valid Product Type VDO is returned.
+
+What:		/sys/class/typec/<port>-{partner|cable}/identity/product_type_vdo2
+Date:		October 2020
+Contact:	Prashant Malani <pmalani@chromium.org>
+Description:
+		2nd Product Type VDO of Discover Identity command result.
+		The value will show 0 until Discover Identity command result becomes
+		available and a valid Product Type VDO is returned.
+
+What:		/sys/class/typec/<port>-{partner|cable}/identity/product_type_vdo3
+Date:		October 2020
+Contact:	Prashant Malani <pmalani@chromium.org>
+Description:
+		3rd Product Type VDO of Discover Identity command result.
+		The value will show 0 until Discover Identity command result becomes
+		available and a valid Product Type VDO is returned.
+
 
 USB Type-C port alternate mode devices.
 
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index cb1362187a7c..df4478baf95b 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -124,10 +124,40 @@ static ssize_t product_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(product);
 
+static ssize_t product_type_vdo1_show(struct device *dev, struct device_attribute *attr,
+				      char *buf)
+{
+	struct usb_pd_identity *id = get_pd_identity(dev);
+
+	return sysfs_emit(buf, "0x%08x\n", id->vdo[0]);
+}
+static DEVICE_ATTR_RO(product_type_vdo1);
+
+static ssize_t product_type_vdo2_show(struct device *dev, struct device_attribute *attr,
+				      char *buf)
+{
+	struct usb_pd_identity *id = get_pd_identity(dev);
+
+	return sysfs_emit(buf, "0x%08x\n", id->vdo[1]);
+}
+static DEVICE_ATTR_RO(product_type_vdo2);
+
+static ssize_t product_type_vdo3_show(struct device *dev, struct device_attribute *attr,
+				      char *buf)
+{
+	struct usb_pd_identity *id = get_pd_identity(dev);
+
+	return sysfs_emit(buf, "0x%08x\n", id->vdo[2]);
+}
+static DEVICE_ATTR_RO(product_type_vdo3);
+
 static struct attribute *usb_pd_id_attrs[] = {
 	&dev_attr_id_header.attr,
 	&dev_attr_cert_stat.attr,
 	&dev_attr_product.attr,
+	&dev_attr_product_type_vdo1.attr,
+	&dev_attr_product_type_vdo2.attr,
+	&dev_attr_product_type_vdo3.attr,
 	NULL
 };
 
@@ -146,6 +176,9 @@ static void typec_report_identity(struct device *dev)
 	sysfs_notify(&dev->kobj, "identity", "id_header");
 	sysfs_notify(&dev->kobj, "identity", "cert_stat");
 	sysfs_notify(&dev->kobj, "identity", "product");
+	sysfs_notify(&dev->kobj, "identity", "product_type_vdo1");
+	sysfs_notify(&dev->kobj, "identity", "product_type_vdo2");
+	sysfs_notify(&dev->kobj, "identity", "product_type_vdo3");
 }
 
 /* ------------------------------------------------------------------------- */
-- 
2.29.2.454.gaff20da3a2-goog

