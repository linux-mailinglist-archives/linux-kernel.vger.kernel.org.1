Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2778A2ACF80
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgKJGPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgKJGPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:15:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936BAC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 22:15:47 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w6so4933762pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 22:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LCjaa2+ZDzyMpp6rXWIBgooM2TUDsF7cGfUV06VXLIQ=;
        b=Q//nWbDM7rB33p5BDxBDwYhPt+E2lvFctSHuFsv4XgW5esX7EwMB2z3enN3ARlkvA/
         h0RWtNah+ZfkNQv68Zhl9X/zvx4vM8HIAO1WaK+BRCtURckCOA1aH0J7emwHeScNzjMB
         TO+1Y4bgPoL7qx42nXJQxkRcv2jCBgqMXt/wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LCjaa2+ZDzyMpp6rXWIBgooM2TUDsF7cGfUV06VXLIQ=;
        b=Yl/pcdqr4Ytp51pBVOjBSKLXvWArC2ryQz5eFRveTX9InwjiwzYAYnl01JLaqIX8rf
         L43tae7iapL8VbdO0kAiaTqti1LlW7llpRMi4D7qhsn9ghqLYeOXHqKidRE8RlLeuGs9
         zULjieSXUqRjwjgvGiL3dHJygRkyJboXvOBz9ampeBfkTYmoJQ5QI5mjkuvuFnPuMO4e
         7kyYRfcvXa5FyLNLU0wgJy4tgNQf5HwGkUBvcbrb6+bqN8sZGA85HaP6I2h31p1VCh4I
         Df7UXCzG+8k0gG0CWOSZtiXv8Ouo0xDooi9WMgSV49/52dW85ijyFniBEwK9lvWdl0SG
         uuuw==
X-Gm-Message-State: AOAM5302g9WiH2QiR6aPeh83eZD/qHA6HhjSLx4Bmw/NgJ48aNAZ4SX0
        goFInMIqgEGJHBR+j/+n6iyQgYkX38DYGQ==
X-Google-Smtp-Source: ABdhPJxBLQdt29k4/3op2GxtMZs7G0IH6QrJy72JpIt3FwQNDvQJ0isZGLLaR0RU2nSUU4qAmPZECQ==
X-Received: by 2002:a17:90a:bb8b:: with SMTP id v11mr3346952pjr.57.1604988946611;
        Mon, 09 Nov 2020 22:15:46 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id gw10sm1499932pjb.24.2020.11.09.22.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 22:15:45 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 1/2] usb: typec: Add number of altmodes partner attr
Date:   Mon,  9 Nov 2020 22:15:34 -0800
Message-Id: <20201110061535.2163599-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a user-visible attribute for the number of alternate modes available
in a partner. This allows userspace to determine whether there are any
remaining alternate modes left to be registered by the kernel driver. It
can begin executing any policy state machine after all available
alternate modes have been registered with the connector class framework.

This value is set to "-1" initially, signifying that a valid number of
alternate modes haven't been set for the partner.

Also add a sysfs file which exposes this attribute. The file remains
hidden as long as the attribute value is -1.

Cc: Benson Leung <bleung@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Added ABI/testing documentation entry for added sysfs file.
- Changed name of the sysfs file to "number_of_alternate_modes" based on
  review comments.
- Added is_visible() logic suggested by Heikki in the comments of v1.
- Updated commit message.

v1:
https://lore.kernel.org/lkml/20200701003149.3101219-1-pmalani@chromium.org/

 Documentation/ABI/testing/sysfs-class-typec |  8 +++
 drivers/usb/typec/class.c                   | 66 ++++++++++++++++++++-
 include/linux/usb/typec.h                   |  1 +
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index b834671522d6..73ac7b461ae5 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -134,6 +134,14 @@ Description:
 		Shows if the partner supports USB Power Delivery communication:
 		Valid values: yes, no
 
+What:		/sys/class/typec/<port>-partner/number_of_alternate_modes
+Date:		November 2020
+Contact:	Prashant Malani <pmalani@chromium.org>
+Description:
+		Shows the number of alternate modes which are advertised by the partner
+		during Power Delivery discovery. This file remains hidden until a value
+		greater than or equal to 0 is set by Type C port driver.
+
 What:		/sys/class/typec/<port>-partner>/identity/
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 35eec707cb51..c7412ddbd311 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -33,6 +33,7 @@ struct typec_partner {
 	struct usb_pd_identity		*identity;
 	enum typec_accessory		accessory;
 	struct ida			mode_ids;
+	int				num_altmodes;
 };
 
 struct typec_port {
@@ -532,12 +533,43 @@ static ssize_t supports_usb_power_delivery_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(supports_usb_power_delivery);
 
+static ssize_t number_of_alternate_modes_show(struct device *dev, struct device_attribute *attr,
+					      char *buf)
+{
+	struct typec_partner *p = to_typec_partner(dev);
+
+	return sysfs_emit(buf, "%d\n", p->num_altmodes);
+}
+static DEVICE_ATTR_RO(number_of_alternate_modes);
+
 static struct attribute *typec_partner_attrs[] = {
 	&dev_attr_accessory_mode.attr,
 	&dev_attr_supports_usb_power_delivery.attr,
+	&dev_attr_number_of_alternate_modes.attr,
+	NULL
+};
+
+static umode_t typec_partner_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct typec_partner *partner = to_typec_partner(kobj_to_dev(kobj));
+
+	if (attr == &dev_attr_number_of_alternate_modes.attr) {
+		if (partner->num_altmodes < 0)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static struct attribute_group typec_partner_group = {
+	.is_visible = typec_partner_attr_is_visible,
+	.attrs = typec_partner_attrs
+};
+
+static const struct attribute_group *typec_partner_groups[] = {
+	&typec_partner_group,
 	NULL
 };
-ATTRIBUTE_GROUPS(typec_partner);
 
 static void typec_partner_release(struct device *dev)
 {
@@ -570,6 +602,37 @@ int typec_partner_set_identity(struct typec_partner *partner)
 }
 EXPORT_SYMBOL_GPL(typec_partner_set_identity);
 
+/**
+ * typec_partner_set_num_altmodes - Set the number of available partner altmodes
+ * @partner: The partner to be updated.
+ * @num_alt_modes: The number of altmodes we want to specify as available.
+ *
+ * This routine is used to report the number of alternate modes supported by the
+ * partner. This value is *not* enforced in alternate mode registration routines.
+ *
+ * @partner.num_altmodes is set to -1 on partner registration, denoting that
+ * a valid value has not been set for it yet.
+ *
+ * Returns 0 on success or negative error number on failure.
+ */
+int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmodes)
+{
+	int ret;
+
+	if (num_altmodes < 0)
+		return -EINVAL;
+
+	partner->num_altmodes = num_altmodes;
+	ret = sysfs_update_group(&partner->dev.kobj, &typec_partner_group);
+	if (ret < 0)
+		return ret;
+
+	sysfs_notify(&partner->dev.kobj, NULL, "number_of_alternate_modes");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_partner_set_num_altmodes);
+
 /**
  * typec_partner_register_altmode - Register USB Type-C Partner Alternate Mode
  * @partner: USB Type-C Partner that supports the alternate mode
@@ -612,6 +675,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 	ida_init(&partner->mode_ids);
 	partner->usb_pd = desc->usb_pd;
 	partner->accessory = desc->accessory;
+	partner->num_altmodes = -1;
 
 	if (desc->identity) {
 		/*
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 6be558045942..bc6b1a71cb8a 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -126,6 +126,7 @@ struct typec_altmode_desc {
 	enum typec_port_data	roles;
 };
 
+int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmodes);
 struct typec_altmode
 *typec_partner_register_altmode(struct typec_partner *partner,
 				const struct typec_altmode_desc *desc);
-- 
2.29.2.222.g5d2a92d10f8-goog

