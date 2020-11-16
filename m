Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAD32B521A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbgKPUMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbgKPUMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:12:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA43C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:12:32 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 131so4676443pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cvu6lrdt5sZy1ojhENHDrSU3GodwauRNHyAm+VWqpcs=;
        b=gjPY0wXTqo9Qx1RyJPYWniFEfol4CKuM2+y3LeC50c4CZk2eoSmRz1Bsp/pjQginCG
         7o/ITHdjWYLiWUrJQQSpRHt1nYI5xtfg7TebEtkV8LDWCIru2c2UeAwBey/ItZttFlHG
         bJHSwYTNqHv+OyWIeZsOA3P9Pslejvv/2nnUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cvu6lrdt5sZy1ojhENHDrSU3GodwauRNHyAm+VWqpcs=;
        b=dt52y+66zQUDX9P8iq9O1qwSU0093+Tra4jIFsx14hFP2oIT+iQTRyth/74PGoEWGt
         KsvJZhk35AJK0SL6wlwVwg/nTdc0Yo1hSUYKqZi3JMIHPPdXLJ/I0jIEzqWaJjD/ZiJe
         1nzQWoUSOUuivoT+46Y0gFONw3EHsYkA+4MJnPmhVxPxLbN1u1x5R/CGt7kt+dRgKrgP
         7JZwQttEMMeZ7yhR2SyrQZJUeEkmEDLD8qFLMevVy//We5bF0bsqh3k18MrNSihp+lCd
         6wwrAPlFhkEEPadLDmkFmvo4P+SvtZ61+NylU7T7cf9KpLmUNAla/U1V4OjHvPPs5hDY
         HCbw==
X-Gm-Message-State: AOAM530No/YvDPFGM7+zEqgHo8IVIAs2JLlCMHvGU2323AEIXcTDsLec
        POznBJ++GLQo+Bb2c+ALntPAhrV7H5ufPg==
X-Google-Smtp-Source: ABdhPJyOIODki9q7kZpcNVhYPekDtBkuYujJD4AMyNwL1dPB5WkxFtOpDU/1cfMrzsAUJU1WjmfhVw==
X-Received: by 2002:a63:d46:: with SMTP id 6mr726120pgn.227.1605557551908;
        Mon, 16 Nov 2020 12:12:31 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a12sm234577pjh.48.2020.11.16.12.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:12:31 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 02/11] usb: typec: Add number of altmodes partner attr
Date:   Mon, 16 Nov 2020 12:11:40 -0800
Message-Id: <20201116201150.2919178-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201116201150.2919178-1-pmalani@chromium.org>
References: <20201116201150.2919178-1-pmalani@chromium.org>
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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Changes in v3:
- Re-arranged patch order and combined it with related series of
  patches.
- Added Reviewed-by tags

Changes in v2:
- Added ABI/testing documentation entry for added sysfs file.
- Changed name of the sysfs file to "number_of_alternate_modes" based on
  review comments.
- Added is_visible() logic suggested by Heikki in the comments of v1.
- Updated commit message.

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
2.29.2.299.gdc1121823c-goog

