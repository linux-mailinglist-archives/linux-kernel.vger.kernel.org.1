Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FC12E2FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 04:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL0DSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 22:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgL0DSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 22:18:10 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927DBC0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 19:17:30 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c22so5284157pgg.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 19:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYIM+mYtyqY+yCFeee8kL6L8zert0ZB/NFPW/mxtlTk=;
        b=VbgBrFUmveYY8h4y1bbMn2RhKrS9FALtbLc9FD/ZieS8ZtBEL55Vsm11lczNth7dK5
         1P4onFC+lZf9pn6c2hGpYBWMWGwe/NJ+Lk9njYdzsAgJ143iFwL51AblehgEXdUzD5bt
         Kn5sy5xuE+8imBeipPrtqw1fYUeqdQgZGyMP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYIM+mYtyqY+yCFeee8kL6L8zert0ZB/NFPW/mxtlTk=;
        b=HdVXfqsC3yHxDocAyW1mKpWtsiaUo2bVSVVa8xdqRHuN5x2X0hxqiRrqMUBpMDIpIo
         xLisQkI8o5dj8ab2+VDuj1F+lUFOCy2FDNijbm+62aPsGHRssFejscMnVsOqEs+FZT1v
         piYHuZFmB0n/kS6XDEfVApzgKfNXxAsGfCaz339n3qqbSbopVQ8tSsGms/rHy5NOX6/S
         iUHZEaRE8iCQo9WilhIJ/XlzbE0q9OWg+0MxF7nolu4XDKRBclLfzCo2ACMIPqOwuU8S
         dVu388/iH57c1bA02SyPKO2dMU2ZuG2KzdJT0wmFNi3hwsYvJXoRu6jX/dG8aXyyhPJC
         J/hQ==
X-Gm-Message-State: AOAM531w7dH9+JkOnvMTOHm6Kb6Ag/6TcFyrS0J2tJmb4SqzaktOjk18
        o2fvM29dKhcvbo77ayNzCp5Q9w==
X-Google-Smtp-Source: ABdhPJzZIGPuHkvDujqDq5tSEYeDpk5rvl8jDRr+9ZnUcAaM4JSKnYq4cztpv2P1BBC46dp4i7b6Ow==
X-Received: by 2002:aa7:8f0e:0:b029:19e:5a34:8c85 with SMTP id x14-20020aa78f0e0000b029019e5a348c85mr36090800pfr.22.1609039050020;
        Sat, 26 Dec 2020 19:17:30 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id v10sm8928967pjr.47.2020.12.26.19.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 19:17:29 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     johan@kernel.org, linux-usb@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] USB: serial: option: add LongSung M5710 module support
Date:   Sun, 27 Dec 2020 12:17:16 +0900
Message-Id: <20201227031716.1343300-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor id for LongSung and a product id for the M5710 module.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/usb/serial/option.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 2c21e34235bb..2666e061c38d 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -560,6 +560,9 @@ static void option_instat_callback(struct urb *urb);
 #define WETELECOM_PRODUCT_6802			0x6802
 #define WETELECOM_PRODUCT_WMD300		0x6803
 
+/* LongSung */
+#define LONGSUNG_VENDOR_ID			0x2df3
+#define LONGSUNG_PRODUCT_M5710			0x9d03
 
 /* Device flags */
 
@@ -2060,6 +2063,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
+	/* LongSung devices */
+	{ USB_DEVICE(LONGSUNG_VENDOR_ID, LONGSUNG_PRODUCT_M5710) },		/* LongSung M5710 */
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.30.0.rc2

