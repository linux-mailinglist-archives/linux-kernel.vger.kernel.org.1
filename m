Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC942E0410
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 02:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgLVBss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 20:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgLVBss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:48:48 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C0C061285
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 17:48:07 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f17so7395209pge.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 17:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9t6b/EdSq28Lw+fWM3V++IKje/SzmyL7ftmGtHYk+M=;
        b=meFiM90q7IuLgsrTTgMJTxUOJLl3ZDLh0qfjsn1QCJzMocLhnTPjJK0I91rGjVn9gX
         +MFrguH6C0A77CiGyVwOXWriC0LOfzoVOzATWTUZ6Hadh7oDqNOPFJPiNsIenxKSODFO
         bKIZ1hNb/SYcYA7iViJw+OQDnsvSzPpQWJIHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9t6b/EdSq28Lw+fWM3V++IKje/SzmyL7ftmGtHYk+M=;
        b=powYsTKzw8Qaxt5B3B0E9lDwUCUJIBw37uklNsLHlaC14NbSmLIxuYyaL4CzvkNgqk
         2FfYZ4NdxqUPEN14ZhhHqMc4JSU29ZxYGBUtxE8BxrUulvIHlQgjLYyT6C/KH6tmCh7x
         2RWZFeiG1DfspCvAKdjjgIdCnVwppTn6S7vmYxRx/5d+z5KbJjdiGkys/qQfCPGmdeVM
         8Cw1U740Z7ucmODA4zNZV7jyv2Wv1ok77OYb6fj7/GfJzKIBM63z/EcFCTSUzNRYysK+
         wvdXZzvyRJACNKVP+98KoRZd3FlQsTRPujEFE/WN1DhN/1uewQRuM46RGJcTbn9tPZvV
         HP7w==
X-Gm-Message-State: AOAM532sLBDXW1VRMxUfsPCLQMNTA0RWzJMWLoWis8QFQaLrTm/dphRm
        pLcdbTPH8u63mEBsph59Obo25uV+wqSvLQ==
X-Google-Smtp-Source: ABdhPJxANW1O5zypjQ4Vp0PzOiCYfx2GQ+AuJwfYFxjk9yhY2MeC7Q/OJ/HR3FmPTmnHk75osMtP3A==
X-Received: by 2002:a63:5f12:: with SMTP id t18mr17778958pgb.308.1608601687097;
        Mon, 21 Dec 2020 17:48:07 -0800 (PST)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:a6ae:11ff:fe11:fd59])
        by smtp.gmail.com with ESMTPSA id h8sm20164316pjc.2.2020.12.21.17.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 17:48:06 -0800 (PST)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dtor@chromium.org, swboyd@chromium.org, dianders@chromium.org,
        rajatja@chromium.org, Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org
Subject: [PATCH 2/3] Input: cros_ec_keyb - Support custom top-row keys
Date:   Mon, 21 Dec 2020 17:47:58 -0800
Message-Id: <20201221174751.2.If8dc0ec9d1a60e436d1e852eba1316313f45ac0e@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201221174751.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
References: <20201221174751.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function keys in a keyboard's top row are usually intended for
certain actions such as "Browser back" and "Fullscreen".

As of now, when a top-row key is pressed, cros_ec_keyb sends function
key code (e.g. KEY_F1) instead of action key code (e.g. KEY_BACK) to
applications. Because `linux,keymap` defined in cros-ec-keyboard.dtsi
maps the scanlines of the top-row keys to the function key code.

Therefore, an application can only convert each function key to
different action based on a fixed mapping.

This patch aims to support a more flexible keyboard top-row design. If
a board specifies a custom layout for the top row keys in dt binding,
cros_ec_keyb will explicitly sends action key code to applications when
any top-row key is pressed, so the applications no longer have to make
assumptions.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

 drivers/input/keyboard/cros_ec_keyb.c | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index b379ed7628781..c997ec5c5d469 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -27,6 +27,34 @@
 
 #include <asm/unaligned.h>
 
+#define MAX_NUM_TOP_ROW_KEYS   15
+
+/*
+ * Row/column (in the scan matrix) of the function keys (T1-T15)
+ * defined in Chrome OS keyboard spec
+ */
+static const struct key_pos {
+	u8 row;
+	u8 col;
+} top_row_key_pos[] = {
+	{.row = 0, .col = 2},	/* T1 */
+	{.row = 3, .col = 2},	/* T2 */
+	{.row = 2, .col = 2},	/* T3 */
+	{.row = 1, .col = 2},	/* T4 */
+	{.row = 3, .col = 4},	/* T5 */
+	{.row = 2, .col = 4},	/* T6 */
+	{.row = 1, .col = 4},	/* T7 */
+	{.row = 2, .col = 9},	/* T8 */
+	{.row = 1, .col = 9},	/* T9 */
+	{.row = 0, .col = 4},	/* T10 */
+	{.row = 0, .col = 1},	/* T11 */
+	{.row = 1, .col = 5},	/* T12 */
+	{.row = 3, .col = 5},	/* T13 */
+	{.row = 0, .col = 9},	/* T14 */
+	{.row = 0, .col = 11},	/* T15 */
+};
+BUILD_ASSERT(ARRAY_SIZE(top_row_key_pos) == MAX_NUM_TOP_ROW_KEYS);
+
 /**
  * struct cros_ec_keyb - Structure representing EC keyboard device
  *
@@ -42,6 +70,7 @@
  * @idev: The input device for the matrix keys.
  * @bs_idev: The input device for non-matrix buttons and switches (or NULL).
  * @notifier: interrupt event notifier for transport devices
+ * @num_function_row_keys: The number of top row keys in a custom keyboard
  */
 struct cros_ec_keyb {
 	unsigned int rows;
@@ -58,6 +87,8 @@ struct cros_ec_keyb {
 	struct input_dev *idev;
 	struct input_dev *bs_idev;
 	struct notifier_block notifier;
+
+	uint8_t num_function_row_keys;
 };
 
 /**
@@ -511,6 +542,44 @@ static int cros_ec_keyb_register_bs(struct cros_ec_keyb *ckdev)
 	return 0;
 }
 
+/**
+ * cros_ec_keyb_update_custom_keymap
+ *
+ * Update the keymap if the board has custom top row keys.
+ *
+ * @ckdev: The keyboard device
+ */
+
+static void cros_ec_keyb_update_custom_keymap(struct cros_ec_keyb *ckdev)
+{
+	u8 i;
+	u16 code;
+	u16 top_row_key_code[MAX_NUM_TOP_ROW_KEYS] = {0};
+	struct input_dev *idev = ckdev->idev;
+	unsigned short *keymap = idev->keycode;
+
+	if (of_property_read_variable_u16_array(ckdev->dev->of_node,
+						"google,custom-keyb-top-row",
+						top_row_key_code,
+						0,
+						MAX_NUM_TOP_ROW_KEYS) > 0) {
+		for (i = 0; i < MAX_NUM_TOP_ROW_KEYS; i++) {
+			if (!top_row_key_code[i])
+				break;
+			code = MATRIX_SCAN_CODE(top_row_key_pos[i].row,
+						top_row_key_pos[i].col,
+						ckdev->row_shift);
+			/*
+			 * Add the action key code for a top row key
+			 * into the keymap.
+			 */
+			keymap[code] = top_row_key_code[i];
+			__set_bit(keymap[code], idev->keybit);
+		}
+		ckdev->num_function_row_keys = i;
+	}
+}
+
 /**
  * cros_ec_keyb_register_bs - Register matrix keys
  *
@@ -576,6 +645,8 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	input_set_capability(idev, EV_MSC, MSC_SCAN);
 	input_set_drvdata(idev, ckdev);
 	ckdev->idev = idev;
+
+	cros_ec_keyb_update_custom_keymap(ckdev);
 	cros_ec_keyb_compute_valid_keys(ckdev);
 
 	err = input_register_device(ckdev->idev);
-- 
2.26.2

