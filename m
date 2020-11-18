Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400972B7FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgKRPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:01:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:37906 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKRPBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:01:08 -0500
IronPort-SDR: VymetH0v634OdmwNyx+cIHqJ6ccf5c88Lx0NWei2k4yR/3d2p/NPltrNrcHKiCT+ePDgb9itXy
 5NkvHUjvHuMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171224115"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171224115"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:01:07 -0800
IronPort-SDR: oBsI6eQnRmOr2J4c615C9zIETFYkhQOiTS5uLYJZmUJQypHGqZQBlqUtIDDtNHIzn9hF6/u/re
 /HgYvVzf+YSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430881696"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2020 07:01:06 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH 3/3] usb: typec: Expose Product Type VDOs via sysfs
Date:   Wed, 18 Nov 2020 18:00:59 +0300
Message-Id: <20201118150059.3419-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prashant Malani <pmalani@chromium.org>

Interim. ABI doc missing.

A PD-capable device can return up to 3 Product Type VDOs as part of its
DiscoverIdentity Response (USB PD Spec, Rev 3.0, Version 2.0, Section
6.4.4.3.1). Add sysfs attribute to expose these to userspace.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
[ heikki: Only one instead of three attribute files ]
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>'
---
 drivers/usb/typec/class.c | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 303f054181ff7..5e135678f5952 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -165,15 +165,55 @@ static ssize_t product_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(product);
 
+static ssize_t
+product_type_vdo_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct usb_pd_identity *id = get_pd_identity(dev);
+	size_t len = 0;
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		if (!id->vdo[i])
+			break;
+		len += sysfs_emit(buf, "%08x ", id->vdo[i]);
+	}
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static struct device_attribute dev_attr_product_type_vdo = {
+	.attr = {
+		.name = "product_type",
+		.mode = 0444,
+	},
+	.show = product_type_vdo_show,
+};
+
+static umode_t
+typec_identity_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct usb_pd_identity *id = get_pd_identity(kobj_to_dev(kobj));
+
+	if (attr == &dev_attr_product_type_vdo.attr &&
+	    !id->vdo[0])
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *usb_pd_id_attrs[] = {
 	&dev_attr_id_header.attr,
 	&dev_attr_cert_stat.attr,
 	&dev_attr_product.attr,
+	&dev_attr_product_type_vdo.attr,
 	NULL
 };
 
 static const struct attribute_group usb_pd_id_group = {
 	.name = "identity",
+	.is_visible = typec_identity_attr_is_visible,
 	.attrs = usb_pd_id_attrs,
 };
 
@@ -191,6 +231,7 @@ static void typec_product_type_notify(struct device *dev)
 	if (!ptype)
 		return;
 
+	sysfs_notify(&dev->kobj, "identity", "product_type");
 	sysfs_notify(&dev->kobj, NULL, "product_type");
 
 	envp[0] = kasprintf(GFP_KERNEL, "PRODUCT_TYPE=%s", ptype);
-- 
2.29.2

