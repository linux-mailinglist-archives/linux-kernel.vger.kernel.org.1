Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9658E2AFCA7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgKLBlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgKLBYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:24:25 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3FEC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:24:24 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f27so2768021pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WCpS0aS+17iz7yDGMFlHKebZYZGUnged3i65MrwnzY=;
        b=Rw6R2li2CgbtawGLsTK5QGL6oAaPcs+U3E1ANmP8AQMc+Y6eFkdzgco8i/9kxgcQgl
         ecoIsAGV2mG6JWf6YYGswBZWhk9oDf+veHdh1x94Wq4uKFyqAqtRLFWKUzPM1mBSD2ZY
         dcGQR4fw/A4SEtvsrclpc+YUaN2AyuREWTWbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WCpS0aS+17iz7yDGMFlHKebZYZGUnged3i65MrwnzY=;
        b=OFLXuikFgs9PicsubgldEo7RJ90TRjwEr4FLq9VaeNNOSwKgpGCnHgaxgCxWejT+hY
         vFTWVuoPi1x2ElwyKNdLOsqwUiirXovE/b9/p5wHiL9i3KMaDQ39mF/oLQc0+IihAoHo
         4/PsLAbdRG6V1rDB3NJjeZmNqSBvEeq8TCIGxFIGUG9hPTbqdH+IU0RUsB0Mz7ZU4hmG
         qCnrFWNM/vhYgK1Pa3VuFshRhcRc/GTcUeV57YliWdlhQyyPJGRRfUkxAAcdqYR4quK/
         XCcjjOFR7xv6J3Ykifhakwz5z4KtnCyYiSMqTCq3OfWmOwU//tvaxzh0zbWtvzg7l9go
         StZA==
X-Gm-Message-State: AOAM53384lvSnmCtChsaWR5OHnZP6Y7RwGtJyG1L4cgujT9Ce37FWMuF
        mjs4iHfWiPIdAcQeyQcJj0jaRsFmA26QlA==
X-Google-Smtp-Source: ABdhPJxKMVOL/R+75gOff0QjpM/Vas8bo7F6Z2MVGZgM+wKhH4GMsLrRDoz2wZGZ8ceYXCdGEfXIHw==
X-Received: by 2002:a63:e54a:: with SMTP id z10mr22639942pgj.297.1605144264113;
        Wed, 11 Nov 2020 17:24:24 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id k25sm4057227pfi.42.2020.11.11.17.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 17:24:23 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/3] usb: typec: Add plug num_altmodes sysfs attr
Date:   Wed, 11 Nov 2020 17:23:28 -0800
Message-Id: <20201112012329.1364975-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201112012329.1364975-1-pmalani@chromium.org>
References: <20201112012329.1364975-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a field to the typec_plug struct to record the number of available
altmodes as well as the corresponding sysfs attribute to expose this to
userspace.

This allows userspace to determine whether there are any
remaining alternate modes left to be registered by the kernel driver. It
can begin executing any policy state machine after all available
alternate modes have been registered with the connector class framework.

This value is set to "-1" initially, signifying that a valid number of
alternate modes haven't been set for the plug. The sysfs file remains
hidden as long as the attribute value is -1.

We re-use the partner attribute for number_of_alternate_modes since the
usage and name is similar, and update the corresponding *_show() command
to support both partner and plugs.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-typec |  9 +++
 drivers/usb/typec/class.c                   | 77 ++++++++++++++++++++-
 include/linux/usb/typec.h                   |  1 +
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 73ac7b461ae5..29eccf5fb8ed 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -204,6 +204,15 @@ Description:
 		- type-c
 		- captive
 
+What:		/sys/class/typec/<port>-<plug>/number_of_alternate_modes
+Date:		November 2020
+Contact:	Prashant Malani <pmalani@chromium.org>
+Description:
+		Shows the number of alternate modes which are advertised by the plug
+		associated with a particular cable during Power Delivery discovery.
+		This file remains hidden until a value greater than or equal to 0
+		is set by Type C port driver.
+
 What:		/sys/class/typec/<port>-cable/identity/
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index c7412ddbd311..e68798599ca8 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -18,6 +18,7 @@ struct typec_plug {
 	struct device			dev;
 	enum typec_plug_index		index;
 	struct ida			mode_ids;
+	int				num_altmodes;
 };
 
 struct typec_cable {
@@ -536,9 +537,21 @@ static DEVICE_ATTR_RO(supports_usb_power_delivery);
 static ssize_t number_of_alternate_modes_show(struct device *dev, struct device_attribute *attr,
 					      char *buf)
 {
-	struct typec_partner *p = to_typec_partner(dev);
+	struct typec_partner *partner;
+	struct typec_plug *plug;
+	int num_altmodes;
+
+	if (is_typec_partner(dev)) {
+		partner = to_typec_partner(dev);
+		num_altmodes = partner->num_altmodes;
+	} else if (is_typec_plug(dev)) {
+		plug = to_typec_plug(dev);
+		num_altmodes = plug->num_altmodes;
+	} else {
+		return 0;
+	}
 
-	return sysfs_emit(buf, "%d\n", p->num_altmodes);
+	return sysfs_emit(buf, "%d\n", num_altmodes);
 }
 static DEVICE_ATTR_RO(number_of_alternate_modes);
 
@@ -726,11 +739,70 @@ static void typec_plug_release(struct device *dev)
 	kfree(plug);
 }
 
+static struct attribute *typec_plug_attrs[] = {
+	&dev_attr_number_of_alternate_modes.attr,
+	NULL
+};
+
+static umode_t typec_plug_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct typec_plug *plug = to_typec_plug(kobj_to_dev(kobj));
+
+	if (attr == &dev_attr_number_of_alternate_modes.attr) {
+		if (plug->num_altmodes < 0)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static struct attribute_group typec_plug_group = {
+	.is_visible = typec_plug_attr_is_visible,
+	.attrs = typec_plug_attrs
+};
+
+static const struct attribute_group *typec_plug_groups[] = {
+	&typec_plug_group,
+	NULL
+};
+
 static const struct device_type typec_plug_dev_type = {
 	.name = "typec_plug",
+	.groups = typec_plug_groups,
 	.release = typec_plug_release,
 };
 
+/**
+ * typec_plug_set_num_altmodes - Set the number of available plug altmodes
+ * @plug: The plug to be updated.
+ * @num_altmodes: The number of altmodes we want to specify as available.
+ *
+ * This routine is used to report the number of alternate modes supported by the
+ * plug. This value is *not* enforced in alternate mode registration routines.
+ *
+ * @plug.num_altmodes is set to -1 on plug registration, denoting that
+ * a valid value has not been set for it yet.
+ *
+ * Returns 0 on success or negative error number on failure.
+ */
+int typec_plug_set_num_altmodes(struct typec_plug *plug, int num_altmodes)
+{
+	int ret;
+
+	if (num_altmodes < 0)
+		return -EINVAL;
+
+	plug->num_altmodes = num_altmodes;
+	ret = sysfs_update_group(&plug->dev.kobj, &typec_plug_group);
+	if (ret < 0)
+		return ret;
+
+	sysfs_notify(&plug->dev.kobj, NULL, "number_of_alternate_modes");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_plug_set_num_altmodes);
+
 /**
  * typec_plug_register_altmode - Register USB Type-C Cable Plug Alternate Mode
  * @plug: USB Type-C Cable Plug that supports the alternate mode
@@ -776,6 +848,7 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
 	sprintf(name, "plug%d", desc->index);
 
 	ida_init(&plug->mode_ids);
+	plug->num_altmodes = -1;
 	plug->index = desc->index;
 	plug->dev.class = typec_class;
 	plug->dev.parent = &cable->dev;
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index bc6b1a71cb8a..54475323f83b 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -130,6 +130,7 @@ int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmod
 struct typec_altmode
 *typec_partner_register_altmode(struct typec_partner *partner,
 				const struct typec_altmode_desc *desc);
+int typec_plug_set_num_altmodes(struct typec_plug *plug, int num_altmodes);
 struct typec_altmode
 *typec_plug_register_altmode(struct typec_plug *plug,
 			     const struct typec_altmode_desc *desc);
-- 
2.29.2.222.g5d2a92d10f8-goog

