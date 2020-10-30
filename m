Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE229FCC1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 05:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgJ3Emh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 00:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgJ3Emg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 00:42:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C36C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:42:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 13so4207224pfy.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PVZRt0YkAiKORZguRTElyjMs0Igwt5Q779i6Rt3CboM=;
        b=q1nnCvEw8fGNhVTLyAnKjBgw4EPNEmuQnFA724r+w/nVyhoVw8z5XEPz1NzPPajclN
         xg9fUaxm3SIMpo/wmfZuHKvLAfo++5ofnOslnSsvyNgG+Pxb1UUCwIWMLyBwRVdAr2KY
         ZiXg23T8Nrx8UcthENVuKJDkqK58DzRz8/kmtpH2B5TZb/a3FfqJvqa6f6WDwvNQnjD5
         6zRK9aJUvF41j/omRdrhyJQiHeyh10ML51WzgqsOW7AkmiyIM6XXXp4inKFUiUguNmr6
         2BGK5NRMylbo8RMs6Nay5/x5i0ZkgY8zMIiSUMoJVaacnkFdj1zptNaB2MU6TT1Fh+iS
         5wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=PVZRt0YkAiKORZguRTElyjMs0Igwt5Q779i6Rt3CboM=;
        b=pshsPbZFZjsI6iKFvzQun3bnkG5Xbra6JPoLL0OXYTPPdNP/N4jrSyZ9aCYIe+FiP6
         aXQKbyRee73lTTm+mIco7sO0FXw4s/Kq9bFSdzZFFVvY0TaRvAk2S2k6de98iCivkExv
         nHlYtw3xNCZ4RS5sGIqq9sezr5bapWDRLlVdcnvilgbvL5lRAfYKPnegO6lpM7RHwAGr
         AfhocNjT1YnhV9xTpeGj1B65s4wyQ121nOZ2LWYHHkg4SGQmINAWmWa5/g2Ddjx2EgLG
         4vY4p63iCfkP2fDiheCMEhGYaotiQMxbfIN8UGYia65PakAA1iaJ32xtEljq/iRhtvxY
         QpmQ==
X-Gm-Message-State: AOAM532Xe9P6U6Skp6I1pxE+Ghj41eiXgBS96SmrtjmInMc2V5Q2yzEu
        MB3/uwlQuqw/cxtchZfQ+ARRbZF6Z5f1qA==
X-Google-Smtp-Source: ABdhPJxy5DHkYxKJ8dwAT3ogWi0TnUnW4lrDAy7t1vkgRcaLIlmaM4Hd4knv8XFpjmn+nO6KshSg6Q==
X-Received: by 2002:a62:3857:0:b029:155:37a5:295 with SMTP id f84-20020a6238570000b029015537a50295mr7474198pfa.23.1604032951180;
        Thu, 29 Oct 2020 21:42:31 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4a0f:cfff:fe66:e92e])
        by smtp.gmail.com with ESMTPSA id t129sm4703909pfc.140.2020.10.29.21.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 21:42:30 -0700 (PDT)
Sender: Benson Leung <bleung@google.com>
Date:   Thu, 29 Oct 2020 21:42:24 -0700
From:   Benson Leung <bleung@chromium.org>
To:     heikki.krogerus@linux.intel.com
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        bleung@chromium.org, bleung@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmalani@chromium.org,
        bleung@google.com
Subject: [PATCH] typec: Provide USB PD Specification Revision for cable and
 partner
Message-ID: <20201030044224.GA1269490@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB Power Delivery specification Section 6.2.1.1.5 outlines
revision backward compatibility requirements starting from Revision 3.0.

The Port, the Cable Plug, and the Port Partner may support either revision
2 or revision 3 individually, and communication between ports, partners,
and cables of different revisions are allowed under rules that the parties
agree to communicate between each other using the lowest common operating
revision.

This may mean that Port-to-Port operating revision comms may be different
than Port-to-CablePlug operating revision comms. For example, it is
possible for a R3.0 port to communicate with a R3.0 cable using R3.0
messages, while the R3.0 port (in the same session) must communicate with
a R2.0 partner using PD R2.0 messages only.

This change will introduce individual revision number tracking for cable
and port partner so that the port can track them independently.

This will also enable future changes which change cable identifier
decoding and visible sysfs nodes based on revision 2 or 3.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-typec |  8 +++++
 drivers/usb/typec/class.c                   | 38 +++++++++++++++------
 include/linux/usb/typec.h                   | 10 ++++++
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index b834671522d6..740b226bb80e 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -102,6 +102,14 @@ Description:
 		Revision number of the supported USB Power Delivery
 		specification, or 0 when USB Power Delivery is not supported.
 
+What:		/sys/class/typec/<port>-{partner|cable}/usb_power_delivery_revision
+Date:		October 2020
+Contact:	Benson Leung <bleung@chromium.org>
+Description:
+		Revision number of the supported USB Power Delivery
+		specification of the port partner or cable, or 0 when USB Power
+		Delivery is not supported.
+
 What:		/sys/class/typec/<port>/usb_typec_revision
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 35eec707cb51..abae4cbe66d5 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -25,6 +25,7 @@ struct typec_cable {
 	enum typec_plug_type		type;
 	struct usb_pd_identity		*identity;
 	unsigned int			active:1;
+	u16				pd_revision; /* 0300H = "3.0" */
 };
 
 struct typec_partner {
@@ -33,6 +34,7 @@ struct typec_partner {
 	struct usb_pd_identity		*identity;
 	enum typec_accessory		accessory;
 	struct ida			mode_ids;
+	u16				pd_revision; /* 0300H = "3.0" */
 };
 
 struct typec_port {
@@ -146,6 +148,28 @@ static void typec_report_identity(struct device *dev)
 	sysfs_notify(&dev->kobj, "identity", "product");
 }
 
+static ssize_t usb_power_delivery_revision_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	if (is_typec_partner(dev)) {
+		struct typec_partner *partner = to_typec_partner(dev);
+
+		return sprintf(buf, "%d\n", (partner->pd_revision >> 8) & 0xff);
+	} else if (is_typec_cable(dev)) {
+		struct typec_cable *cable = to_typec_cable(dev);
+
+		return sprintf(buf, "%d\n", (cable->pd_revision >> 8) & 0xff);
+	} else if (is_typec_port(dev)) {
+		struct typec_port *p = to_typec_port(dev);
+
+		return sprintf(buf, "%d\n", (p->cap->pd_revision >> 8) & 0xff);
+	}
+}
+static DEVICE_ATTR_RO(usb_power_delivery_revision);
+
+
+
 /* ------------------------------------------------------------------------- */
 /* Alternate Modes */
 
@@ -535,6 +559,7 @@ static DEVICE_ATTR_RO(supports_usb_power_delivery);
 static struct attribute *typec_partner_attrs[] = {
 	&dev_attr_accessory_mode.attr,
 	&dev_attr_supports_usb_power_delivery.attr,
+	&dev_attr_usb_power_delivery_revision.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(typec_partner);
@@ -612,6 +637,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 	ida_init(&partner->mode_ids);
 	partner->usb_pd = desc->usb_pd;
 	partner->accessory = desc->accessory;
+	partner->pd_revision = desc->pd_revision;
 
 	if (desc->identity) {
 		/*
@@ -773,6 +799,7 @@ static DEVICE_ATTR_RO(plug_type);
 static struct attribute *typec_cable_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_plug_type.attr,
+	&dev_attr_usb_power_delivery_revision.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(typec_cable);
@@ -875,6 +902,7 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
 
 	cable->type = desc->type;
 	cable->active = desc->active;
+	cable->pd_revision = desc->pd_revision;
 
 	if (desc->identity) {
 		/*
@@ -1240,16 +1268,6 @@ static ssize_t usb_typec_revision_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(usb_typec_revision);
 
-static ssize_t usb_power_delivery_revision_show(struct device *dev,
-						struct device_attribute *attr,
-						char *buf)
-{
-	struct typec_port *p = to_typec_port(dev);
-
-	return sprintf(buf, "%d\n", (p->cap->pd_revision >> 8) & 0xff);
-}
-static DEVICE_ATTR_RO(usb_power_delivery_revision);
-
 static ssize_t orientation_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 6be558045942..2306d40e18a1 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -162,6 +162,7 @@ struct typec_plug_desc {
  * @type: The plug type from USB PD Cable VDO
  * @active: Is the cable active or passive
  * @identity: Result of Discover Identity command
+ * @pd_revision: USB Power Delivery Specification revision if supported
  *
  * Represents USB Type-C Cable attached to USB Type-C port.
  */
@@ -169,6 +170,8 @@ struct typec_cable_desc {
 	enum typec_plug_type	type;
 	unsigned int		active:1;
 	struct usb_pd_identity	*identity;
+	u16			pd_revision; /* 0300H = "3.0" */
+
 };
 
 /*
@@ -176,15 +179,22 @@ struct typec_cable_desc {
  * @usb_pd: USB Power Delivery support
  * @accessory: Audio, Debug or none.
  * @identity: Discover Identity command data
+ * @pd_revision: USB Power Delivery Specification Revision if supported
  *
  * Details about a partner that is attached to USB Type-C port. If @identity
  * member exists when partner is registered, a directory named "identity" is
  * created to sysfs for the partner device.
+ *
+ * @pd_revision is based on the setting of the "Specification Revision" field
+ * in the message header on the initial "Source Capabilities" message receieved
+ * from the partner, or a "Request" message received from the partner, depending
+ * on whether our port is a Sink or a Source.
  */
 struct typec_partner_desc {
 	unsigned int		usb_pd:1;
 	enum typec_accessory	accessory;
 	struct usb_pd_identity	*identity;
+	u16			pd_revision; /* 0300H = "3.0" */
 };
 
 /**
-- 
2.29.1.341.ge80a0c044ae-goog


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
