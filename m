Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFCD2AFFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 07:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgKLGuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 01:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLGt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 01:49:57 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADAEC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 22:49:57 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 74so6736738lfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 22:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyzxJA1yyS9iLnFVio9VG2RO1yn5H0xdCoOTgWMMJRo=;
        b=jb3akMkqX4M5xWnMMgPo5IPri+zua2YfriiKuiPBV9wsyySECqbQC4jzXBEEpQvlCQ
         873KzG1JSeSgLmcZxzu6Z3DLyeLJg9I4D2F29m/S5kLum+4pzjxD3Xld0Jl0a59+qjiS
         LQINrfnd9Z037hJIg3xuvBCFFUHMkOEBSXA2ysWMljFBzmPcLbjpEdMD4F3zXpbmItuD
         13EotDEIu1k89huuWqWIJ3UkiG2sMhUKnxCv3yI5me/MDiHnCm0I8w/CxRHcSSQW+MbK
         dv9bv3KUujbhFugA3qSqsmN+ZEzWlnIXW22f5owKzDj4OwyYICF1fF7wUg8DC+NwwrLy
         KaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyzxJA1yyS9iLnFVio9VG2RO1yn5H0xdCoOTgWMMJRo=;
        b=DMxGhGTsvAai2UVUYC4bKme/+X0BtPruOx9eqZ/krcVhifUpdAs2sjWvtXsk5XJRzp
         a94uKUPVjW5dHOWGCCOY6vbi8ugQRelTd67FNqG/BHdlC8i7wocWwj3AwFrbjLy2DLwl
         l3M+anrsJ9WB1TpUWCfP8SaB9GdDUPQpCxmKCfJMxSt8Fb2IgIw2WDIhSIEaNvsUF8qB
         uf0S/3utwDa+lQWvu4w8X6V1bGlmIG4vCJVnPbyWS149qjFNMwqUO2gOkrjpO7O8f+Qm
         XpSiudp+gi+BDTCAjFBn4Re82YH4wkb6kLPnf9CyoFZfSXWt3veNxrBU3n1azp2LvSni
         mBMw==
X-Gm-Message-State: AOAM531j50JIG78PLsMVKWtLY07y44yVQJjcvIkQ9hYQzA2K3k7Ufg72
        z5CoT7I2msIYtFQ3K8AG5kMMsA==
X-Google-Smtp-Source: ABdhPJzOJ4c9EeKKoxYQEwuQQ+GzI7zEANOt0/tS4OSBDtwAdO3aU9gWNeODw8UeRWChY6Fc+zu7bA==
X-Received: by 2002:a19:a415:: with SMTP id q21mr3980856lfc.508.1605163795738;
        Wed, 11 Nov 2020 22:49:55 -0800 (PST)
Received: from localhost.localdomain ([2.92.120.24])
        by smtp.googlemail.com with ESMTPSA id f2sm450996ljc.118.2020.11.11.22.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 22:49:55 -0800 (PST)
From:   Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>,
        Evgeny Boger <boger@wirenboard.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] w1: w1_therm: Rename conflicting sysfs attribute 'eeprom' to 'eeprom_cmd'
Date:   Thu, 12 Nov 2020 09:49:31 +0300
Message-Id: <20201112064931.8471-1-ivan.zaentsev@wirenboard.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate attribute 'eeprom' is defined in:
1) Documentation/ABI/testing/sysfs-driver-w1_therm
2) Documentation/ABI/stable/sysfs-driver-w1_ds28e04

Both drivers define an attribute: /sys/bus/w1/devices/.../eeprom
with conflicting behavior.

Fix by renaming the newer one in w1_therm.c to 'eeprom_cmd'.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/lkml/20201029152845.6bbb39ce@coco.lan/
Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
---
 Documentation/ABI/testing/sysfs-driver-w1_therm |  2 +-
 Documentation/w1/slaves/w1_therm.rst            |  2 +-
 drivers/w1/slaves/w1_therm.c                    | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 6a37dc33ffdb..74642c73d29c 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -14,7 +14,7 @@ Users:		any user space application which wants to communicate with
 		w1_term device
 
 
-What:		/sys/bus/w1/devices/.../eeprom
+What:		/sys/bus/w1/devices/.../eeprom_cmd
 Date:		May 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
 Description:
diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
index e39202e2b000..c3c9ed7a356c 100644
--- a/Documentation/w1/slaves/w1_therm.rst
+++ b/Documentation/w1/slaves/w1_therm.rst
@@ -82,7 +82,7 @@ resolution is read back from the chip and verified.
 
 Note: Changing the resolution reverts the conversion time to default.
 
-The write-only sysfs entry ``eeprom`` is an alternative for EEPROM operations.
+The write-only sysfs entry ``eeprom_cmd`` is an alternative for EEPROM operations.
 Write ``save`` to save device RAM to EEPROM. Write ``restore`` to restore EEPROM
 data in device RAM.
 
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index cddf60b7309c..3712b1e6dc71 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -315,7 +315,7 @@ static ssize_t resolution_show(struct device *device,
 static ssize_t resolution_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size);
 
-static ssize_t eeprom_store(struct device *device,
+static ssize_t eeprom_cmd_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size);
 
 static ssize_t alarms_store(struct device *device,
@@ -350,7 +350,7 @@ static DEVICE_ATTR_RO(w1_seq);
 static DEVICE_ATTR_RO(temperature);
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
-static DEVICE_ATTR_WO(eeprom);
+static DEVICE_ATTR_WO(eeprom_cmd);
 static DEVICE_ATTR_RW(alarms);
 static DEVICE_ATTR_RW(conv_time);
 static DEVICE_ATTR_RW(features);
@@ -386,7 +386,7 @@ static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
-	&dev_attr_eeprom.attr,
+	&dev_attr_eeprom_cmd.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_conv_time.attr,
 	&dev_attr_features.attr,
@@ -397,7 +397,7 @@ static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
-	&dev_attr_eeprom.attr,
+	&dev_attr_eeprom_cmd.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_conv_time.attr,
 	&dev_attr_features.attr,
@@ -410,7 +410,7 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
-	&dev_attr_eeprom.attr,
+	&dev_attr_eeprom_cmd.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_conv_time.attr,
 	&dev_attr_features.attr,
@@ -1740,7 +1740,7 @@ static ssize_t resolution_store(struct device *device,
 	return size;
 }
 
-static ssize_t eeprom_store(struct device *device,
+static ssize_t eeprom_cmd_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size)
 {
 	struct w1_slave *sl = dev_to_w1_slave(device);
-- 
2.25.1

