Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F5429DB53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbgJ1XwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389261AbgJ1Xv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:51:57 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C6CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:51:57 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id x5so753866qkn.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=wXk0jpGRoVSSSZTLRss3R/eA/tOkUu7upyzqvXkflS4=;
        b=u9LxDok+CVXn0ZgT+2fs12BARxd8pdCOn5GwNfRhkY94MpxBomWoHrWqqA3Qzh3rrS
         +yCaYxLKFw/WeSefLtRmBgOZf7hgcUk0itOeJz6CPXUvRdnWLPRCiWBqaR7idPhcnsta
         ZMrAItVZjvnH5Zi0M3QPYfiw4Se5jSIa3XYiSVzUudP88PgHynz9numfYC/ViD47Livz
         WMPG0T6Rse1u47mo3toUJCFHDc44CHBndz49u+2lL1vl3wdCWM1r2r3a7hA0LEansCIL
         a5lQSO6Va3kMRsq8nJE4fQR1i3rZdkUPPBFYBhORk34BVmYPNsxRj6sce7fs67rQ2ngO
         wleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=wXk0jpGRoVSSSZTLRss3R/eA/tOkUu7upyzqvXkflS4=;
        b=HroUB5HqAgJ55BYT5Lza8PxZ1rL8yT+DMOocJU/DbA68ctlL3Y7kbuD92kmLxERBRl
         CSOACGL5IfQFzd7Cf9DAHTaPvi3sPLWoO0feivuzSwa/YXuHD1bHgejIizLgtcOG8f70
         9/1tCRMfyQwf6d3rDFEnHXpFt5a6azC5nftj2PT3aFkvhWxRyqLkusTuu5wlKEnJq3lQ
         UUQrX4cb5Q1k3hrrBd1TYm2Jn9PpTQac4o7CB9/gqobnAoGSYbM2p7kHCm9e5scokp8I
         T4wjrel0FwXTN8vOda8p7op+j5jfY9Yswpf2jrH/R5hpipYnHcGbI8dc+NgA1asp+8TY
         G1fw==
X-Gm-Message-State: AOAM532DU+hnHD+Aqbiq4fk11UI/3gCHJ6KQ0EfVqSvDRDFtWepNeeWu
        P4ekicpMVJ8RJAbskSaqMTfJrESz
X-Google-Smtp-Source: ABdhPJwgxHLn3zsHr4PuRlcUngvm6mTPD+5R1Ciyamf7me/AFwLwmVvclxUJw9GBpgrZDclFSn1IMDg5
Sender: "lzye via sendgmr" <lzye@chrisye.mtv.corp.google.com>
X-Received: from chrisye.mtv.corp.google.com ([2620:15c:211:2:f693:9fff:fef4:4323])
 (user=lzye job=sendgmr) by 2002:a0c:a5a2:: with SMTP id z31mr2003459qvz.15.1603929116278;
 Wed, 28 Oct 2020 16:51:56 -0700 (PDT)
Date:   Wed, 28 Oct 2020 16:51:50 -0700
Message-Id: <20201028235150.662864-1-lzye@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] ANDROID: Fix the HID usage of DPAD input event generation.
From:   FirstName LastName <lzye@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linzhao.ye@gmail.com, linux-kernel@vger.kernel.org,
        trivial@kernel.org, stable@vger.kernel.org,
        Chris Ye <lzye@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Ye <lzye@google.com>

Generic Desktop DPAD usage is mapped by hid-input, that only the first
DPAD usage maps to usage type EV_ABS and code of an axis. If HID
descriptor has DPAD UP/DOWN/LEFT/RIGHT HID usages and each of usage size
is 1 bit, then only the first one will generate input event, the rest of
the HID usages will be assigned to hat direction only.
The hid input event should check the HID report value and generate
HID event for its hat direction.

Test: Connect HID device with Generic Desktop DPAD usage and press the
DPAD to generate input events.

Signed-off-by: Chris Ye <lzye@google.com>
---
 drivers/hid/hid-input.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9770db624bfa..6c1007de3409 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1269,7 +1269,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	struct input_dev *input;
 	unsigned *quirks = &hid->quirks;
 
-	if (!usage->type)
+	if (!usage->type && !field->dpad)
 		return;
 
 	if (usage->type == EV_PWR) {
@@ -1286,9 +1286,17 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		int hat_dir = usage->hat_dir;
 		if (!hat_dir)
 			hat_dir = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
-		if (hat_dir < 0 || hat_dir > 8) hat_dir = 0;
-		input_event(input, usage->type, usage->code    , hid_hat_to_axis[hat_dir].x);
-		input_event(input, usage->type, usage->code + 1, hid_hat_to_axis[hat_dir].y);
+		if (hat_dir < 0 || hat_dir > 8 || value == 0)
+			hat_dir = 0;
+		if (field->dpad) {
+			input_event(input, EV_ABS, field->dpad, hid_hat_to_axis[hat_dir].x);
+			input_event(input, EV_ABS, field->dpad + 1, hid_hat_to_axis[hat_dir].y);
+		} else {
+			input_event(input, usage->type, usage->code,
+				hid_hat_to_axis[hat_dir].x);
+			input_event(input, usage->type, usage->code + 1,
+				hid_hat_to_axis[hat_dir].y);
+		}
 		return;
 	}
 
-- 
2.29.1.341.ge80a0c044ae-goog

