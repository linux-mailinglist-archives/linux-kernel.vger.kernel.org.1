Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADE2B7FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgKRPBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:01:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:37906 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKRPBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:01:06 -0500
IronPort-SDR: /w1Mx7Xj07B7J8CfuB3MYcXLp5ACOsXMij1l9PSXAoPLVpxnDUB1z0Am6OIQTZC8158YeFcSay
 SgN9/TF606bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171224103"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171224103"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:01:06 -0800
IronPort-SDR: qAlSap8vBzCqCZjXoSG2dP14KpmwJjk1rMwQ2Bapl5E/et8TQOIky73E/V3pVS8LamafG5E84N
 KLX/hKnUgrnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430881633"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2020 07:01:04 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH 2/3] usb: typec: Add product_type sysfs attribute file for partners and cables
Date:   Wed, 18 Nov 2020 18:00:58 +0300
Message-Id: <20201118150059.3419-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Power Delivery Specification defines a set of product
types for partners and cables. The product type is defined
in the ID Header VDO, which is the first object in the
response to the Discover Identity command.

This sysfs attribute file is only created for the partners
and cables if the product type is really known in the
driver. Some interfaces do not give access to the Discover
Identity response from the partner or cable, but they may
still supply the product type separately in some cases.

When the product type of the partner or cable is detected,
uevent is also raised with PRODUCT_TYPE set to show the
actual product type (for example PRODUCT_TYPE=host).

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-class-typec |  55 ++++++++
 drivers/usb/typec/class.c                   | 132 ++++++++++++++++++--
 2 files changed, 180 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index b7794e02ad205..4c09e327c62be 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -139,6 +139,42 @@ Description:
 		Shows if the partner supports USB Power Delivery communication:
 		Valid values: yes, no
 
+What:		/sys/class/typec/<port>-partner/product_type
+Date:		December 2020
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:	USB Power Delivery Specification defines a set of product types
+		for the partner devices. This file will show the product type of
+		the partner if it is known. Dual-role capable partners will have
+		both UFP and DFP product types defined, but only one that
+		matches the current role will be active at the time. If the
+		product type of the partner is not visible to the device driver,
+		this file will not exist.
+
+		When the partner product type is detected, or changed with role
+		swap, uvevent is also raised that contains PRODUCT_TYPE=<product
+		type> (for example PRODUCT_TYPE=hub).
+
+		Valid values:
+
+		UFP / device role
+		========================  ==========================
+		undefined		  -
+		hub			  PDUSB Hub
+		peripheral		  PDUSB Peripheral
+		psd			  Power Bank
+		ama			  Alternate Mode Adapter
+		vpd			  VCONN Powered USB Device
+		========================  ==========================
+
+		DFP / host role
+		========================  ==========================
+		undefined		  -
+		hub			  PDUSB Hub
+		host			  PDUSB Host
+		power_brick		  Power Brick
+		amc			  Alternate Mode Controller
+		========================  ==========================
+
 What:		/sys/class/typec/<port>-partner>/identity/
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
@@ -202,6 +238,25 @@ Description:
 		- type-c
 		- captive
 
+What:		/sys/class/typec/<port>-cable/product_type
+Date:		December 2020
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:	USB Power Delivery Specification defines a set of product types
+		for the cables. This file will show the product type of the
+		cable if it is known. If the product type of the cable is not
+		visible to the device driver, this file will not exist.
+
+		When the cable product type is detected, uvevent is also raised
+		with PRODUCT_TYPE showing the product type of the cable.
+
+		Valid values:
+
+		========================  ==========================
+		undefined		  -
+		active			  Active Cable
+		passive			  Passive Cable
+		========================  ==========================
+
 What:		/sys/class/typec/<port>-cable/identity/
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 35eec707cb512..303f054181ff7 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -11,6 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/usb/pd_vdo.h>
 
 #include "bus.h"
 
@@ -81,6 +82,30 @@ static const char * const typec_accessory_modes[] = {
 	[TYPEC_ACCESSORY_DEBUG]		= "debug",
 };
 
+/* Product types defined in USB PD Specification R3.0 V2.0 */
+static const char * const product_type_ufp[8] = {
+	[IDH_PTYPE_UNDEF]		= "undefined",
+	[IDH_PTYPE_HUB]			= "hub",
+	[IDH_PTYPE_PERIPH]		= "peripheral",
+	[IDH_PTYPE_PSD]			= "psd",
+	[IDH_PTYPE_AMA]			= "ama",
+	[IDH_PTYPE_VPD]			= "vpd",
+};
+
+static const char * const product_type_dfp[8] = {
+	[IDH_PTYPE_DFP_UNDEF]		= "undefined",
+	[IDH_PTYPE_DFP_HUB]		= "hub",
+	[IDH_PTYPE_DFP_HOST]		= "host",
+	[IDH_PTYPE_DFP_PB]		= "power_brick",
+	[IDH_PTYPE_DFP_AMC]		= "amc",
+};
+
+static const char * const product_type_cable[8] = {
+	[IDH_PTYPE_UNDEF]		= "undefined",
+	[IDH_PTYPE_PCABLE]		= "passive",
+	[IDH_PTYPE_ACABLE]		= "active",
+};
+
 static struct usb_pd_identity *get_pd_identity(struct device *dev)
 {
 	if (is_typec_partner(dev)) {
@@ -95,6 +120,24 @@ static struct usb_pd_identity *get_pd_identity(struct device *dev)
 	return NULL;
 }
 
+static const char *get_pd_product_type(struct device *dev)
+{
+	struct typec_port *port = to_typec_port(dev->parent);
+	struct usb_pd_identity *id = get_pd_identity(dev);
+	const char *ptype = NULL;
+
+	if (is_typec_partner(dev)) {
+		if (port->data_role == TYPEC_HOST)
+			ptype = product_type_ufp[PD_IDH_PTYPE(id->id_header)];
+		else
+			ptype = product_type_dfp[PD_IDH_DFP_PTYPE(id->id_header)];
+	} else if (is_typec_cable(dev)) {
+		ptype = product_type_cable[PD_IDH_PTYPE(id->id_header)];
+	}
+
+	return ptype;
+}
+
 static ssize_t id_header_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
@@ -139,11 +182,55 @@ static const struct attribute_group *usb_pd_id_groups[] = {
 	NULL,
 };
 
+static void typec_product_type_notify(struct device *dev)
+{
+	const char *ptype;
+	char *envp[2];
+
+	ptype = get_pd_product_type(dev);
+	if (!ptype)
+		return;
+
+	sysfs_notify(&dev->kobj, NULL, "product_type");
+
+	envp[0] = kasprintf(GFP_KERNEL, "PRODUCT_TYPE=%s", ptype);
+	if (!envp[0])
+		return;
+
+	envp[1] = NULL;
+	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
+	kfree(envp[0]);
+}
+
 static void typec_report_identity(struct device *dev)
 {
 	sysfs_notify(&dev->kobj, "identity", "id_header");
 	sysfs_notify(&dev->kobj, "identity", "cert_stat");
 	sysfs_notify(&dev->kobj, "identity", "product");
+	typec_product_type_notify(dev);
+}
+
+static ssize_t
+product_type_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	const char *ptype;
+
+	ptype = get_pd_product_type(dev);
+	if (!ptype)
+		return 0;
+
+	return sysfs_emit(buf, "%s\n", ptype);
+}
+static DEVICE_ATTR_RO(product_type);
+
+static umode_t typec_product_type_attr_is_visible(struct kobject *kobj,
+						  struct attribute *attr, int n)
+{
+	if (attr == &dev_attr_product_type.attr)
+		if (!get_pd_identity(kobj_to_dev(kobj)))
+			return 0;
+
+	return attr->mode;
 }
 
 /* ------------------------------------------------------------------------- */
@@ -534,10 +621,20 @@ static DEVICE_ATTR_RO(supports_usb_power_delivery);
 
 static struct attribute *typec_partner_attrs[] = {
 	&dev_attr_accessory_mode.attr,
+	&dev_attr_product_type.attr,
 	&dev_attr_supports_usb_power_delivery.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(typec_partner);
+
+static struct attribute_group typec_partner_group = {
+	.is_visible = typec_product_type_attr_is_visible,
+	.attrs = typec_partner_attrs,
+};
+
+static const struct attribute_group *typec_partner_groups[] = {
+	&typec_partner_group,
+	NULL
+};
 
 static void typec_partner_release(struct device *dev)
 {
@@ -773,9 +870,19 @@ static DEVICE_ATTR_RO(plug_type);
 static struct attribute *typec_cable_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_plug_type.attr,
+	&dev_attr_product_type.attr,
+	NULL
+};
+
+static struct attribute_group typec_cable_group = {
+	.is_visible = typec_product_type_attr_is_visible,
+	.attrs = typec_cable_attrs,
+};
+
+static const struct attribute_group *typec_cable_groups[] = {
+	&typec_cable_group,
 	NULL
 };
-ATTRIBUTE_GROUPS(typec_cable);
 
 static void typec_cable_release(struct device *dev)
 {
@@ -1352,6 +1459,11 @@ const struct device_type typec_port_dev_type = {
 /* --------------------------------------- */
 /* Driver callbacks to report role updates */
 
+static int partner_match(struct device *dev, void *data)
+{
+	return is_typec_partner(dev);
+}
+
 /**
  * typec_set_data_role - Report data role change
  * @port: The USB Type-C Port where the role was changed
@@ -1361,12 +1473,23 @@ const struct device_type typec_port_dev_type = {
  */
 void typec_set_data_role(struct typec_port *port, enum typec_data_role role)
 {
+	struct device *partner_dev;
+
 	if (port->data_role == role)
 		return;
 
 	port->data_role = role;
 	sysfs_notify(&port->dev.kobj, NULL, "data_role");
 	kobject_uevent(&port->dev.kobj, KOBJ_CHANGE);
+
+	partner_dev = device_find_child(&port->dev, NULL, partner_match);
+	if (!partner_dev)
+		return;
+
+	if (to_typec_partner(partner_dev)->identity)
+		typec_product_type_notify(partner_dev);
+
+	put_device(partner_dev);
 }
 EXPORT_SYMBOL_GPL(typec_set_data_role);
 
@@ -1407,11 +1530,6 @@ void typec_set_vconn_role(struct typec_port *port, enum typec_role role)
 }
 EXPORT_SYMBOL_GPL(typec_set_vconn_role);
 
-static int partner_match(struct device *dev, void *data)
-{
-	return is_typec_partner(dev);
-}
-
 /**
  * typec_set_pwr_opmode - Report changed power operation mode
  * @port: The USB Type-C Port where the mode was changed
-- 
2.29.2

