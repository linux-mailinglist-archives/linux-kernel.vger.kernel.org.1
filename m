Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9804B2C44FD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgKYQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbgKYQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:25:29 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B606C0613D4;
        Wed, 25 Nov 2020 08:25:29 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so3965131lfc.4;
        Wed, 25 Nov 2020 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wB6l0ia6oMI14k/Xdxb+u2Q0ubtDmL3njdY+HNE16RA=;
        b=IlCZ9p62aWxMwiUtQcqX9pwU5Zhxt1PXMgi6VRUw/mN+wM9S8ndgGf7NZYc5C2KagF
         shLcXba3o8peJ09ZDaL2nWZ6Oa+qgkJSJXcF6sS6DUrv711h3HuxscSfEPsZO6Q6HOWt
         Ofw4ZIFp7bVPaiSWNQhh6C2+hfiSJ2AKBKio3ARm1aCJdaYi3Ptm6xu8969eA7GxUG3k
         9qs0zCey1pg783SzJ8zTYQnb5aX/Hm3p8WfzNNMeXlc/eWleywl/5NQGiDDObt+1TM3s
         u+UTOMvysepu6SiZsOzspQhOBC3XaMJhi47ksLG9rO3BXyzEaS/afi7tTxjyubdy6syo
         bh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wB6l0ia6oMI14k/Xdxb+u2Q0ubtDmL3njdY+HNE16RA=;
        b=dRAxaRJumWqEFsJnPD8fjdwZzMBGTe2soFl1FKS88laEejNqLaiVHUHgu+t5us5dSX
         +r3J46ptV7yXFKXu56+76H9+EHUF5/YW7NdarENPtAvac4u8gRlKsNKFeslX//9ALpel
         2Ys/Tsn2BhyQq0jW0b9b94eGVhUX5tpm9Z3R1gHFo40E7ROWMrERrg+XFlAvCXY3zlyW
         tePp1H7F/b50GO/Zl1YXWrdHjdCCDEjRSm28podQf0OTkYZgW//MZ0PsPqNlFKNwCGVy
         nlNBumJL32zHsS1LlJAUbhny+uEszNS7KzQiUlas8Npv9bf/rlB7ZMl6klMhYkRl/09s
         2V0A==
X-Gm-Message-State: AOAM530Ibwt8/bozzIlw6aKYsMvwzssyU6v6k9p6u9/E+SqlMdEG91Nm
        z9iSXEVPRACrDDTjrO7PN3k=
X-Google-Smtp-Source: ABdhPJyo6UdUJYI9d8PaWjXlgPAOTbY0ki4HORNYAwatV05muFNseDojTkZ0ITNZ1ZsAR5Kgoc+ojA==
X-Received: by 2002:a19:4293:: with SMTP id p141mr1623511lfa.591.1606321527714;
        Wed, 25 Nov 2020 08:25:27 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-6.NA.cust.bahnhof.se. [158.174.22.6])
        by smtp.gmail.com with ESMTPSA id z131sm313881lfc.56.2020.11.25.08.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:25:26 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        chenqiwu <chenqiwu@xiaomi.com>,
        Zeng Tao <prime.zeng@hisilicon.com>
Subject: [PATCH 1/3] USB: core: Constify static attribute_group structs
Date:   Wed, 25 Nov 2020 17:24:58 +0100
Message-Id: <20201125162500.37228-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125162500.37228-1-rikard.falkeborn@gmail.com>
References: <20201125162500.37228-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are never modified, so make them const to allow the compiler to
put them in read-only memory. Done with the help of coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/usb/core/endpoint.c |  2 +-
 drivers/usb/core/port.c     |  4 ++--
 drivers/usb/core/sysfs.c    | 14 +++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/core/endpoint.c b/drivers/usb/core/endpoint.c
index 1c2c04079676..903426b6d305 100644
--- a/drivers/usb/core/endpoint.c
+++ b/drivers/usb/core/endpoint.c
@@ -153,7 +153,7 @@ static struct attribute *ep_dev_attrs[] = {
 	&dev_attr_direction.attr,
 	NULL,
 };
-static struct attribute_group ep_dev_attr_grp = {
+static const struct attribute_group ep_dev_attr_grp = {
 	.attrs = ep_dev_attrs,
 };
 static const struct attribute_group *ep_dev_groups[] = {
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 235a7c645503..dfcca9c876c7 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -155,7 +155,7 @@ static struct attribute *port_dev_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group port_dev_attr_grp = {
+static const struct attribute_group port_dev_attr_grp = {
 	.attrs = port_dev_attrs,
 };
 
@@ -169,7 +169,7 @@ static struct attribute *port_dev_usb3_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group port_dev_usb3_attr_grp = {
+static const struct attribute_group port_dev_usb3_attr_grp = {
 	.attrs = port_dev_usb3_attrs,
 };
 
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 8d134193fa0c..d85699bee671 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -641,7 +641,7 @@ static struct attribute *usb2_hardware_lpm_attr[] = {
 	&dev_attr_usb2_lpm_besl.attr,
 	NULL,
 };
-static struct attribute_group usb2_hardware_lpm_attr_group = {
+static const struct attribute_group usb2_hardware_lpm_attr_group = {
 	.name	= power_group_name,
 	.attrs	= usb2_hardware_lpm_attr,
 };
@@ -651,7 +651,7 @@ static struct attribute *usb3_hardware_lpm_attr[] = {
 	&dev_attr_usb3_hardware_lpm_u2.attr,
 	NULL,
 };
-static struct attribute_group usb3_hardware_lpm_attr_group = {
+static const struct attribute_group usb3_hardware_lpm_attr_group = {
 	.name	= power_group_name,
 	.attrs	= usb3_hardware_lpm_attr,
 };
@@ -663,7 +663,7 @@ static struct attribute *power_attrs[] = {
 	&dev_attr_active_duration.attr,
 	NULL,
 };
-static struct attribute_group power_attr_group = {
+static const struct attribute_group power_attr_group = {
 	.name	= power_group_name,
 	.attrs	= power_attrs,
 };
@@ -832,7 +832,7 @@ static struct attribute *dev_attrs[] = {
 #endif
 	NULL,
 };
-static struct attribute_group dev_attr_grp = {
+static const struct attribute_group dev_attr_grp = {
 	.attrs = dev_attrs,
 };
 
@@ -865,7 +865,7 @@ static umode_t dev_string_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static struct attribute_group dev_string_attr_grp = {
+static const struct attribute_group dev_string_attr_grp = {
 	.attrs =	dev_string_attrs,
 	.is_visible =	dev_string_attrs_are_visible,
 };
@@ -1222,7 +1222,7 @@ static struct attribute *intf_attrs[] = {
 	&dev_attr_interface_authorized.attr,
 	NULL,
 };
-static struct attribute_group intf_attr_grp = {
+static const struct attribute_group intf_attr_grp = {
 	.attrs = intf_attrs,
 };
 
@@ -1246,7 +1246,7 @@ static umode_t intf_assoc_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static struct attribute_group intf_assoc_attr_grp = {
+static const struct attribute_group intf_assoc_attr_grp = {
 	.attrs =	intf_assoc_attrs,
 	.is_visible =	intf_assoc_attrs_are_visible,
 };
-- 
2.29.2

