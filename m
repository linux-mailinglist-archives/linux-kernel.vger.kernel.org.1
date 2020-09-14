Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9326926F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgINREt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgINRD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:03:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED1C061788;
        Mon, 14 Sep 2020 10:03:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so480889wrn.0;
        Mon, 14 Sep 2020 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePb9DxxKhh2OapBidol1DSiOU9yd1o2zfA2sSgMMoJE=;
        b=WkC8TJ8LnXAv+nq6A3CAU9AoIDiQZIOpJNgie7xsZEq4lv9AulOxReBZb6Tfcb+Ep4
         J62rVKtR0gMyDyOu2p3x0++CM2n9rp6syuHDX/sQbubN0kT8haKUfGKiDEuNBb78AjX1
         LfEleVawlsQ7C/HJ8XwBlCGn/rQ5EYkzxcc+sgBbYoKb8z2BzE9IZYsfeSzcKUb+2fkD
         P7mpgEUFqkCl3wHmheo0qRqpEbUfR8ZlYYm3Fr9jm0loX0znHMIe+8mX8E+TtFoqmwsR
         OyDMzNKnSntTp58tkDn2hAn62lXMWjQvq1bQB+tIcg+a42c0HcqoMd5g2hxt0uOiFXpu
         NtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePb9DxxKhh2OapBidol1DSiOU9yd1o2zfA2sSgMMoJE=;
        b=YiKzsZ9fvqVZY03ggJwroFg3ja1hCWF1nYYa+TMjBJ/zJwZSULci2ygfwqs5ni64xd
         j9QTAVh28pFsHRi9Pm/NbHNhEqt1r3aFPM4WfBdEm7IJo7DtIbOrHZvYGyVv+x5SvswB
         SdTNvl9BOWKCS9OCA84ULJ51uL6QTG4Y+HCK1VU5yZaY5Mgggj01irbKazxtiRPifp9v
         lgTz9aNBx3LeCEA5Wu47UJ9O8yvqmemrGUhqhEy/4FdU1wny1GZ9NK4GjdskSFbngHox
         XNxTNZ+QzIcKd31zhAg5y4yccn3HGjhWDWXuhl4cmc7l7mV+wqya1m+jGeW4M3+OFSqM
         z6ng==
X-Gm-Message-State: AOAM530yfgc5E0XPpQeVyFFqLIQ3fNKPpb4Qw1FAfOkmxmnHWim7RNEE
        Kpy9yKsENmXWZmEL4KbtVDxpHhD9NdfGRErM
X-Google-Smtp-Source: ABdhPJzfmGfbOiI5KitE3L0zEdDd6z/WpDJ/ijjXev4KminGQKCqyScKe4ml5okGAVxGLQzJdSLM7A==
X-Received: by 2002:a5d:61c2:: with SMTP id q2mr18232486wrv.25.1600103005190;
        Mon, 14 Sep 2020 10:03:25 -0700 (PDT)
Received: from localhost.localdomain (host-79-12-92-76.retail.telecomitalia.it. [79.12.92.76])
        by smtp.gmail.com with ESMTPSA id n17sm23044108wrw.0.2020.09.14.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 10:03:23 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: add support for thermal policy
Date:   Mon, 14 Sep 2020 19:02:51 +0200
Message-Id: <20200914170252.41125-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP Spectre notebooks (and probabily other model as well)
support at least 3 thermal policy:
 - Default
 - Performance
 - Cool

the correct thermal policy configuration make the firmware to correctly
set OEM variables for Intel DPTF and optimize fan management to reach
the best performance.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
 drivers/platform/x86/hp-wmi.c | 80 +++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 1762f335bac9..14ee176f5588 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -81,6 +81,7 @@ enum hp_wmi_commandtype {
 	HPWMI_FEATURE2_QUERY		= 0x0d,
 	HPWMI_WIRELESS2_QUERY		= 0x1b,
 	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
+	HPWMI_THERMAL_POLICY_QUERY	= 0x4c
 };
 
 enum hp_wmi_command {
@@ -114,6 +115,12 @@ enum hp_wireless2_bits {
 	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
 };
 
+enum hp_thermal_policy {
+	HP_THERMAL_POLICY_PERFORMANCE	= 0x00,
+	HP_THERMAL_POLICY_DEFAULT		= 0x01,
+	HP_THERMAL_POLICY_COOL			= 0x02
+};
+
 #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
 #define IS_SWBLOCKED(x) !(x & HPWMI_POWER_SOFT)
 
@@ -458,6 +465,28 @@ static ssize_t postcode_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "0x%x\n", value);
 }
 
+static ssize_t thermal_policy_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	int value;
+
+	/* Get the current thermal policy */
+	value = hp_wmi_read_int(HPWMI_THERMAL_POLICY_QUERY);
+	if (value < 0)
+		return value;
+
+	switch (value) {
+	case HP_THERMAL_POLICY_PERFORMANCE:
+		return sprintf(buf, "Performance (%x)\n", value);
+	case HP_THERMAL_POLICY_DEFAULT:
+		return sprintf(buf, "Default (%x)\n", value);
+	case HP_THERMAL_POLICY_COOL:
+		return sprintf(buf, "Cool (%x)\n", value);
+	default:
+		return sprintf(buf, "Unknown (%x)\n", value);
+	}
+}
+
 static ssize_t als_store(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count)
 {
@@ -499,12 +528,35 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static ssize_t thermal_policy_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	u32 tmp;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &tmp);
+	if (ret)
+		return ret;
+
+	if (tmp < HP_THERMAL_POLICY_PERFORMANCE || tmp > HP_THERMAL_POLICY_COOL)
+		return -EINVAL;
+
+	/* Set thermal policy */
+	ret = hp_wmi_perform_query(HPWMI_THERMAL_POLICY_QUERY, HPWMI_WRITE, &tmp,
+				       sizeof(tmp), sizeof(tmp));
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(display);
 static DEVICE_ATTR_RO(hddtemp);
 static DEVICE_ATTR_RW(als);
 static DEVICE_ATTR_RO(dock);
 static DEVICE_ATTR_RO(tablet);
 static DEVICE_ATTR_RW(postcode);
+static DEVICE_ATTR_RW(thermal_policy);
 
 static struct attribute *hp_wmi_attrs[] = {
 	&dev_attr_display.attr,
@@ -861,6 +913,30 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
 	return err;
 }
 
+static int thermal_policy_setup(struct platform_device *device)
+{
+	int err, tp;
+
+	tp = hp_wmi_read_int(HPWMI_THERMAL_POLICY_QUERY);
+	if (tp < 0)
+		return tp;
+
+	/*
+	 * set thermal policy to ensure that the firmware correctly
+	 * sets the OEM variables for the DPTF
+	 */
+	err = hp_wmi_perform_query(HPWMI_THERMAL_POLICY_QUERY, HPWMI_WRITE, &tp,
+							   sizeof(tp), 0);
+	if (err)
+		return err;
+
+	err = device_create_file(&device->dev, &dev_attr_thermal_policy);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int __init hp_wmi_bios_setup(struct platform_device *device)
 {
 	/* clear detected rfkill devices */
@@ -872,6 +948,8 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (hp_wmi_rfkill_setup(device))
 		hp_wmi_rfkill2_setup(device);
 
+	thermal_policy_setup(device);
+
 	return 0;
 }
 
@@ -879,6 +957,8 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
 {
 	int i;
 
+	device_remove_file(&device->dev, &dev_attr_thermal_policy);
+
 	for (i = 0; i < rfkill2_count; i++) {
 		rfkill_unregister(rfkill2[i].rfkill);
 		rfkill_destroy(rfkill2[i].rfkill);
-- 
2.26.2

