Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A85282DB7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 23:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgJDVOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 17:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgJDVOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 17:14:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1E3C0613CE;
        Sun,  4 Oct 2020 14:14:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c8so7265959edv.5;
        Sun, 04 Oct 2020 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gA9oTDv2nx4CTXkWjdZU1D66M5iJ2f3g7L7EeYpRzY=;
        b=YMyZ9mhtEGiDopnT6L0K4z2Bs77YPPsTg7zanex2x0ZRObnttr5PRiug7QsWWcYT44
         KiYBX5N+I862z5Rsbrk/yE3ir3PXG+Feg/S3lFMfx6otoKEuiZfXkQ3EZEcurNk3T+4c
         E34h4mTicLH097dwYQATIvRPY9YhDHvLj9EUpZ9anBzGXbtmdljGP1zrwvIr6Jm4ueZT
         Yt0J9vv1W6WlvxJcG1t/q7vehZfPZj4labmKU9Er5LSVhA40t9tpygAAB0eO0QKtgbBb
         f+7sW9zN5ZWr9vUisiKrFQi27xs8EBbIni7gt3rY/UIZRVOY0Ci1xrOOTe9KUClHSSy2
         ujYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gA9oTDv2nx4CTXkWjdZU1D66M5iJ2f3g7L7EeYpRzY=;
        b=muIk0eF7cjBVu+9iRCKoWfIYx6bVEsVS7JsOMEKSMX41wUvhATsi8n48CkXnPNr/yY
         WPHM2stUqJjpt4cbmoiTDrqGuf7p08rP5BJ2t8sJszTW/FQui3yz3XYJI9mSdwye7IYB
         IzNG4Fs1k0rhTtypfZF5hHC87QtgMfA05VuBiiAEJlDyqRz23u5DhQVKUHfdR9c8I3zx
         DWo4C9oeqdetSIiixPqZ6cTTbgr6nB61rCJSNKtMTT4YkGu1wWPd1kB4CNyandUPDvth
         Igf+hGJ5UOfg6pvzPXD9YNydr+rcaKnFRkOlioY/RwH83uuIy3VBEOUTSuAtJHyExbWc
         3ezw==
X-Gm-Message-State: AOAM533BVy/cw9VU7RsNwDVDPHbK2Yikorx0/5/zvzoj8egzocbIMyI/
        FcVoEgZBoCcJAtKCGt5qeSU=
X-Google-Smtp-Source: ABdhPJwXO7OuY1abcos1ZhW7HdL6Pk5MgNC3CA6lsWBno1qabXMND3RaKAiSb7vl75XOelA8KtF/IA==
X-Received: by 2002:a50:9e87:: with SMTP id a7mr12817999edf.297.1601846043924;
        Sun, 04 Oct 2020 14:14:03 -0700 (PDT)
Received: from localhost.localdomain (host-79-12-92-76.retail.telecomitalia.it. [79.12.92.76])
        by smtp.gmail.com with ESMTPSA id r24sm1387803edm.95.2020.10.04.14.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 14:14:03 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     mgross@linux.intel.com, Elia Devito <eliadevito@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: hp-wmi: add support for thermal policy
Date:   Sun,  4 Oct 2020 23:13:05 +0200
Message-Id: <20201004211305.11628-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917214957.GD29136@mtg-dev.jf.intel.com>
References: <20200917214957.GD29136@mtg-dev.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP Spectre notebooks (and probably other model as well)
support up to 4 thermal policy:
 - HP Recommended
 - Performance
 - Cool
 - Quiet

at least on HP Spectre x360 Convertible 15-df0xxx the firmware sets the
thermal policy to default but hardcode the odvp0 variable to 1, this causes
thermald to choose the wrong DPTF profile witch result in low performance
when notebook is on AC, calling thermal policy write command allow firmware
to correctly set the odvp0 variable.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
 drivers/platform/x86/hp-wmi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 1762f335bac9..6e448a79caee 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -81,6 +81,7 @@ enum hp_wmi_commandtype {
 	HPWMI_FEATURE2_QUERY		= 0x0d,
 	HPWMI_WIRELESS2_QUERY		= 0x1b,
 	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
+	HPWMI_THERMAL_POLICY_QUERY	= 0x4c
 };
 
 enum hp_wmi_command {
@@ -861,6 +862,26 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
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
+	 * call thermal policy write command to ensure that the firmware correctly
+	 * sets the OEM variables for the DPTF
+	 */
+	err = hp_wmi_perform_query(HPWMI_THERMAL_POLICY_QUERY, HPWMI_WRITE, &tp,
+							   sizeof(tp), 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int __init hp_wmi_bios_setup(struct platform_device *device)
 {
 	/* clear detected rfkill devices */
@@ -872,6 +893,8 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (hp_wmi_rfkill_setup(device))
 		hp_wmi_rfkill2_setup(device);
 
+	thermal_policy_setup(device);
+
 	return 0;
 }
 
-- 
2.26.2

