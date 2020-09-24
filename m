Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB982768FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgIXGfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgIXGfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:35:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA09C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:35:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z19so1265949pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labau-com-tw.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WdbXNUPD6MY2k7zfhudyHvM2eQJZTVebaDaCbQjjSc4=;
        b=R4ZRBj8YXWIGdZwMOechCKdR8uAv2fnfhQwdmfxjzpD1CjkGzjhKxac1qzn/LpOIsQ
         kzMuCcp3Q1QSx7fgXJ2H47e+BHVMvzTeRvR/cVyHyzGHEpcHm3qHHcaAdNlHeUxns+6E
         e5WTCqYUGcfnVEvTmUJq1cG7OW1smjI/ZDRITipA1GqH9APx6JLucfGeC6E9OFzHjUgQ
         Y9oMhUw4jewY845zC5Zu00ZmLv0Ndh8NikpTff+ungAF6alTS5na1cqZsJvvsWZXNsBl
         sTkwRw9jMUuSR8KqLnu2d8Ne1fPQAjmw+KeksySBlqLLGgYpiEiX8ehAR5M7L2/pAS9m
         ZCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WdbXNUPD6MY2k7zfhudyHvM2eQJZTVebaDaCbQjjSc4=;
        b=dmxKctL1QA7Ho4bjXMQZYA7ZnEelC7GS+wNR5yWDvBKEYtx8S+lacUYTTJsaUX9hUI
         LiS95LaYM6qO/cFTdQi8b3Oi/EqwvipOZEe1S0y5sbyS2c1z96PWXD/CErxRo9dyNQZd
         Eua5/7+Ys9v1ASLsYruAjV/Pop1WIqUUouS6n8SjPhz3QFOTUagfaKTi1MEqDrL96MFA
         lCdQ5skBBBN1uwsmabrTK6ERpGmGZjRx5G4zYh+2vmR++pDGsiV5ueFs/A7nFWVLGJOb
         eqzfTHQ+EjOX0jU0o0MTax4XqWiY0YR+BRa84EmJwQoBRiVtuK4sMW0ekIYiWyPgkqH0
         EHFA==
X-Gm-Message-State: AOAM530A3WLjCfDSHg93Q1SZ0oYurrYPAFBO2vwTWtB7Q1iE34p43EzA
        4MaKJ+bMnE4POyxULA0L2H1b7yO4Ec8dpSrFQm0=
X-Google-Smtp-Source: ABdhPJzikG7gxmnbljPjmCLOet8UO5lrllVUo0qfMOp0FRkGfzZZ/16CkCAL5dUv0RHCsC0TmnEMNg==
X-Received: by 2002:a63:4d5b:: with SMTP id n27mr2722132pgl.360.1600929313019;
        Wed, 23 Sep 2020 23:35:13 -0700 (PDT)
Received: from localhost.localdomain (60-251-64-13.HINET-IP.hinet.net. [60.251.64.13])
        by smtp.gmail.com with ESMTPSA id z9sm1493939pfk.118.2020.09.23.23.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 23:35:12 -0700 (PDT)
From:   Scott Chen <scott@labau.com.tw>
Cc:     young@labau.com.tw, jocelyn@labau.com.tw,
        Scott Chen <scott@labau.com.tw>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: pl2303: add device-id for HP GC device
Date:   Thu, 24 Sep 2020 14:27:45 +0800
Message-Id: <20200924062745.5791-1-scott@labau.com.tw>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is adds a device id for HP LD381 which is a pl2303GC-base device.

Signed-off-by: Scott Chen <scott@labau.com.tw>
---
 drivers/usb/serial/pl2303.c | 1 +
 drivers/usb/serial/pl2303.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 048452d8a4a4..be8067017eaa 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -100,6 +100,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220TA_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD381_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LD381GC_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960TA_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM220_PRODUCT_ID) },
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 7d3090ee7e0c..b0f399a8c628 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -127,6 +127,7 @@
 
 /* Hewlett-Packard POS Pole Displays */
 #define HP_VENDOR_ID		0x03f0
+#define HP_LD381GC_PRODUCT_ID   0x0183
 #define HP_LM920_PRODUCT_ID	0x026b
 #define HP_TD620_PRODUCT_ID	0x0956
 #define HP_LD960_PRODUCT_ID	0x0b39
-- 
2.17.1

