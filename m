Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB38E2E241A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 04:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgLXDpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 22:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgLXDpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 22:45:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99217C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 19:45:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f14so458279pju.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 19:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcSp+cRdP2bcqWVQZJCDIiTdhj/sfG8FWouaFgmCU4k=;
        b=oF8LweNTM0O1s0jpipHfe0Skl2HB5E2BuMofWlS8SNgvnYFeOQqCMoabngGlgi9vP0
         QIXvD9HulcL+AG9TpZTBjrDDGf0Bxw9ZbwxgpK7IaTrWBmEMazXhnFkhwbpIG7hEYMPX
         42AXp7O7KfFL4ea41pn6PXA1ilhSzOP0IHJ0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcSp+cRdP2bcqWVQZJCDIiTdhj/sfG8FWouaFgmCU4k=;
        b=HK2UPyrNRpVqm7sDsjTjdg8XBi8eH7WoWPG8VPOFe6yrdIU0N9w87wcnGRh5ky09M6
         82uLSZCE3MnehptxgdZyNYZz9QLVEp9mJwnVhmkR7kwkdAHyBKCq7iO6wo6cnj/aHX1y
         YqlEDhJPn8FaCElXu2GPslGE9IqW2hn9gfThj/PcbHXIy1ALTxELV+NVQKtjoBKOIUWV
         xIE9vUCliLKevSAtAlEhdqdCCGIIkG3/YHfcFOzumGIVONDD5fW5J68g8vR9bu3tS7l3
         AGP6h2J1VW9jqBjZb6HxjtGQM94+E/dEpemArYLBlFRUgLfsagCbJHxvBLsKicuwPcz0
         dDrg==
X-Gm-Message-State: AOAM532OZhDn8qInJ3wk65SznXXEIEC3OjRD3q9oqhv9c3qyLrqGDoww
        OROmwS9wIPZscEoU/Y4PfPFdaQ==
X-Google-Smtp-Source: ABdhPJzZmyMvqGZq9wHizORK2I38iQiCXGrUALo4r7txgdGVZT4btTypZYtuIYMmUDpPExmMijfXjg==
X-Received: by 2002:a17:90b:4acc:: with SMTP id mh12mr2606669pjb.54.1608781512942;
        Wed, 23 Dec 2020 19:45:12 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id f24sm942332pjj.5.2020.12.23.19.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 19:45:12 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dtor@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: google: Get HID report on probe to confirm tablet switch state
Date:   Thu, 24 Dec 2020 11:45:07 +0800
Message-Id: <20201224114502.1.I41b9795e4b5bda7209eb9099aebdc6a29677391e@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This forces reading the base folded status anytime the device is
probed.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
Instead of all this manual parsing, it'd be easier to just call:
hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
However, that fails silently as hdev->driver_input_lock is held
during probe (or even some callbacks like input_configured.

 drivers/hid/hid-google-hammer.c | 85 +++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 85a054f1ce38..d9319622da44 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -392,30 +392,34 @@ static int hammer_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
-static int hammer_event(struct hid_device *hid, struct hid_field *field,
-			struct hid_usage *usage, __s32 value)
+static void hammer_folded_event(struct hid_device *hdev, bool folded)
 {
 	unsigned long flags;
 
-	if (usage->hid == HID_USAGE_KBD_FOLDED) {
-		spin_lock_irqsave(&cbas_ec_lock, flags);
+	spin_lock_irqsave(&cbas_ec_lock, flags);
 
-		/*
-		 * If we are getting events from Whiskers that means that it
-		 * is attached to the lid.
-		 */
-		cbas_ec.base_present = true;
-		cbas_ec.base_folded = value;
-		hid_dbg(hid, "%s: base: %d, folded: %d\n", __func__,
-			cbas_ec.base_present, cbas_ec.base_folded);
-
-		if (cbas_ec.input) {
-			input_report_switch(cbas_ec.input,
-					    SW_TABLET_MODE, value);
-			input_sync(cbas_ec.input);
-		}
+	/*
+	 * If we are getting events from Whiskers that means that it
+	 * is attached to the lid.
+	 */
+	cbas_ec.base_present = true;
+	cbas_ec.base_folded = folded;
+	hid_dbg(hdev, "%s: base: %d, folded: %d\n", __func__,
+		cbas_ec.base_present, cbas_ec.base_folded);
 
-		spin_unlock_irqrestore(&cbas_ec_lock, flags);
+	if (cbas_ec.input) {
+		input_report_switch(cbas_ec.input, SW_TABLET_MODE, folded);
+		input_sync(cbas_ec.input);
+	}
+
+	spin_unlock_irqrestore(&cbas_ec_lock, flags);
+}
+
+static int hammer_event(struct hid_device *hid, struct hid_field *field,
+			struct hid_usage *usage, __s32 value)
+{
+	if (usage->hid == HID_USAGE_KBD_FOLDED) {
+		hammer_folded_event(hid, value);
 		return 1; /* We handled this event */
 	}
 
@@ -457,6 +461,47 @@ static bool hammer_has_backlight_control(struct hid_device *hdev)
 				HID_GD_KEYBOARD, HID_AD_BRIGHTNESS);
 }
 
+static void hammer_get_folded_state(struct hid_device *hdev)
+{
+	struct hid_report *report;
+	char *buf;
+	int len, rlen;
+	int a;
+
+	report = hdev->report_enum[HID_INPUT_REPORT].report_id_hash[0x0];
+
+	if (!report || report->maxfield < 1)
+		return;
+
+	len = hid_report_len(report) + 1;
+
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	rlen = hid_hw_raw_request(hdev, report->id, buf, len, report->type, HID_REQ_GET_REPORT);
+
+	if (rlen != len) {
+		hid_warn(hdev, "Unable to read base folded state: %d (expected %d)\n", rlen, len);
+		goto out;
+	}
+
+	for (a = 0; a < report->maxfield; a++) {
+		struct hid_field *field = report->field[a];
+
+		if (field->usage->hid == HID_USAGE_KBD_FOLDED) {
+			u32 value = hid_field_extract(hdev, buf+1,
+					field->report_offset, field->report_size);
+
+			hammer_folded_event(hdev, value);
+			break;
+		}
+	}
+
+out:
+	kfree(buf);
+}
+
 static int hammer_probe(struct hid_device *hdev,
 			const struct hid_device_id *id)
 {
@@ -481,6 +526,8 @@ static int hammer_probe(struct hid_device *hdev,
 		error = hid_hw_open(hdev);
 		if (error)
 			return error;
+
+		hammer_get_folded_state(hdev);
 	}
 
 	if (hammer_has_backlight_control(hdev)) {
-- 
2.29.2.729.g45daf8777d-goog

