Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72662F8886
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbhAOWhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbhAOWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:37:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2B9C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:36:22 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b8so5451218plx.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywqlXS0DMFG48gu1pC9iNZc0yRyZGXmZHZluYtDfIDk=;
        b=UqUPocA4ts0gq9hP7f3Qb1J/OcQWAbekkb/roAdZFEt+PFWRVJaGkiZ3M1DCDK9oq6
         SDQRVWVgjzuswDEGgV2OEFl8cIhhDRZxSqeAy0lPsk6vV8sJ7yIn06UPTmhvmrJhp9ky
         6ZZY+9kVsYuVaJFYgx+GGUj2hSFHdX4QmrGTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywqlXS0DMFG48gu1pC9iNZc0yRyZGXmZHZluYtDfIDk=;
        b=kCwQx9qyvsrXuoQ/6j/S3kCcA/GGm3Uk7Y9kBd4OWMVW43SvfPLSo0I0gsHluTlbDI
         KL/gvH+rhbVcT0IYqOkpkwHEHy3QWWgt6xeXQ+yVy8BVHSGXyRR6rxN6oquAgEM6uZbk
         Ny5HSyl3rW9xnZDKxV8+twHNYfb6Yyy9KHcVolM7lrkCpfRC+t41IOiURyIq9lmhyTvv
         TP8esgnVHB4KeCAwkOmxYqfatEa1frSaVW5A2pM58CplAzM51w3lUkm2JbpdUl9Mv6ah
         aqm2OV+5OfaaM17p7rVWzaHKG0c2MbVizKg2KudEOV5s0+H/QlABylPlqHUnrvByGBki
         mZug==
X-Gm-Message-State: AOAM531ln0Ypi6esetE8qxx4CMnzkBFNDqCxbL3ciNBhLdxoR1gBQmA6
        iGWWFAIWDaA7+vR34c8fg9uo67HqOo04vQ==
X-Google-Smtp-Source: ABdhPJwfcmXp/Enm8DCTmC7DYAAKuOQuMDLgHMXVVWWlrn5h2vpAzgoQvQr0nlFLMVn6zX5FCVbHmA==
X-Received: by 2002:a17:902:ba8d:b029:dc:bc0:4d5 with SMTP id k13-20020a170902ba8db02900dc0bc004d5mr14763136pls.75.1610750182188;
        Fri, 15 Jan 2021 14:36:22 -0800 (PST)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:a6ae:11ff:fe11:fd59])
        by smtp.gmail.com with ESMTPSA id l3sm5208670pjz.27.2021.01.15.14.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:36:21 -0800 (PST)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: input: Create macros for cros-ec keymap
Date:   Fri, 15 Jan 2021 14:36:15 -0800
Message-Id: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Chrome OS, the keyboard matrix can be split to two groups:

The keymap for the top row keys can be customized based on OEM
preference, while the keymap for the other keys is generic/fixed
across boards.

This patch creates marcos for the keymaps of these two groups, making
it easier to reuse the generic portion of keymap when we override the
keymap in the board-specific dts for custom top row design.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

(no changes since v2)

Changes in v2:
- Rename CROS_STD_NON_TOP_ROW_KEYMAP to CROS_STD_MAIN_KEYMAP

 include/dt-bindings/input/cros-ec-keyboard.h | 103 +++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 include/dt-bindings/input/cros-ec-keyboard.h

diff --git a/include/dt-bindings/input/cros-ec-keyboard.h b/include/dt-bindings/input/cros-ec-keyboard.h
new file mode 100644
index 0000000000000..a37a8c5701219
--- /dev/null
+++ b/include/dt-bindings/input/cros-ec-keyboard.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides the constants of the standard Chrome OS key matrix
+ * for cros-ec keyboard-controller bindings.
+ *
+ * Copyright (c) 2021 Google, Inc
+ */
+
+#ifndef _CROS_EC_KEYBOARD_H
+#define _CROS_EC_KEYBOARD_H
+
+#define CROS_STD_TOP_ROW_KEYMAP	\
+	MATRIX_KEY(0x00, 0x02, KEY_F1)	\
+	MATRIX_KEY(0x03, 0x02, KEY_F2)	\
+	MATRIX_KEY(0x02, 0x02, KEY_F3)	\
+	MATRIX_KEY(0x01, 0x02, KEY_F4)	\
+	MATRIX_KEY(0x03, 0x04, KEY_F5)	\
+	MATRIX_KEY(0x02, 0x04, KEY_F6)	\
+	MATRIX_KEY(0x01, 0x04, KEY_F7)	\
+	MATRIX_KEY(0x02, 0x09, KEY_F8)	\
+	MATRIX_KEY(0x01, 0x09, KEY_F9)	\
+	MATRIX_KEY(0x00, 0x04, KEY_F10)	\
+	MATRIX_KEY(0x03, 0x09, KEY_F13)
+
+#define CROS_STD_MAIN_KEYMAP	\
+	MATRIX_KEY(0x00, 0x01, KEY_LEFTMETA)	\
+	MATRIX_KEY(0x00, 0x03, KEY_B)		\
+	MATRIX_KEY(0x00, 0x05, KEY_RO)		\
+	MATRIX_KEY(0x00, 0x06, KEY_N)		\
+	MATRIX_KEY(0x00, 0x08, KEY_EQUAL)	\
+	MATRIX_KEY(0x00, 0x0a, KEY_RIGHTALT)	\
+	MATRIX_KEY(0x01, 0x01, KEY_ESC)		\
+	MATRIX_KEY(0x01, 0x03, KEY_G)		\
+	MATRIX_KEY(0x01, 0x06, KEY_H)		\
+	MATRIX_KEY(0x01, 0x08, KEY_APOSTROPHE)	\
+	MATRIX_KEY(0x01, 0x0b, KEY_BACKSPACE)	\
+	MATRIX_KEY(0x01, 0x0c, KEY_HENKAN)	\
+						\
+	MATRIX_KEY(0x02, 0x00, KEY_LEFTCTRL)	\
+	MATRIX_KEY(0x02, 0x01, KEY_TAB)		\
+	MATRIX_KEY(0x02, 0x03, KEY_T)		\
+	MATRIX_KEY(0x02, 0x05, KEY_RIGHTBRACE)	\
+	MATRIX_KEY(0x02, 0x06, KEY_Y)		\
+	MATRIX_KEY(0x02, 0x07, KEY_102ND)	\
+	MATRIX_KEY(0x02, 0x08, KEY_LEFTBRACE)	\
+	MATRIX_KEY(0x02, 0x0a, KEY_YEN)		\
+						\
+	MATRIX_KEY(0x03, 0x00, KEY_LEFTMETA)	\
+	MATRIX_KEY(0x03, 0x01, KEY_GRAVE)	\
+	MATRIX_KEY(0x03, 0x03, KEY_5)		\
+	MATRIX_KEY(0x03, 0x06, KEY_6)		\
+	MATRIX_KEY(0x03, 0x08, KEY_MINUS)	\
+	MATRIX_KEY(0x03, 0x0b, KEY_BACKSLASH)	\
+	MATRIX_KEY(0x03, 0x0c, KEY_MUHENKAN)	\
+						\
+	MATRIX_KEY(0x04, 0x00, KEY_RIGHTCTRL)	\
+	MATRIX_KEY(0x04, 0x01, KEY_A)		\
+	MATRIX_KEY(0x04, 0x02, KEY_D)		\
+	MATRIX_KEY(0x04, 0x03, KEY_F)		\
+	MATRIX_KEY(0x04, 0x04, KEY_S)		\
+	MATRIX_KEY(0x04, 0x05, KEY_K)		\
+	MATRIX_KEY(0x04, 0x06, KEY_J)		\
+	MATRIX_KEY(0x04, 0x08, KEY_SEMICOLON)	\
+	MATRIX_KEY(0x04, 0x09, KEY_L)		\
+	MATRIX_KEY(0x04, 0x0a, KEY_BACKSLASH)	\
+	MATRIX_KEY(0x04, 0x0b, KEY_ENTER)	\
+						\
+	MATRIX_KEY(0x05, 0x01, KEY_Z)		\
+	MATRIX_KEY(0x05, 0x02, KEY_C)		\
+	MATRIX_KEY(0x05, 0x03, KEY_V)		\
+	MATRIX_KEY(0x05, 0x04, KEY_X)		\
+	MATRIX_KEY(0x05, 0x05, KEY_COMMA)	\
+	MATRIX_KEY(0x05, 0x06, KEY_M)		\
+	MATRIX_KEY(0x05, 0x07, KEY_LEFTSHIFT)	\
+	MATRIX_KEY(0x05, 0x08, KEY_SLASH)	\
+	MATRIX_KEY(0x05, 0x09, KEY_DOT)		\
+	MATRIX_KEY(0x05, 0x0b, KEY_SPACE)	\
+						\
+	MATRIX_KEY(0x06, 0x01, KEY_1)		\
+	MATRIX_KEY(0x06, 0x02, KEY_3)		\
+	MATRIX_KEY(0x06, 0x03, KEY_4)		\
+	MATRIX_KEY(0x06, 0x04, KEY_2)		\
+	MATRIX_KEY(0x06, 0x05, KEY_8)		\
+	MATRIX_KEY(0x06, 0x06, KEY_7)		\
+	MATRIX_KEY(0x06, 0x08, KEY_0)		\
+	MATRIX_KEY(0x06, 0x09, KEY_9)		\
+	MATRIX_KEY(0x06, 0x0a, KEY_LEFTALT)	\
+	MATRIX_KEY(0x06, 0x0b, KEY_DOWN)	\
+	MATRIX_KEY(0x06, 0x0c, KEY_RIGHT)	\
+						\
+	MATRIX_KEY(0x07, 0x01, KEY_Q)		\
+	MATRIX_KEY(0x07, 0x02, KEY_E)		\
+	MATRIX_KEY(0x07, 0x03, KEY_R)		\
+	MATRIX_KEY(0x07, 0x04, KEY_W)		\
+	MATRIX_KEY(0x07, 0x05, KEY_I)		\
+	MATRIX_KEY(0x07, 0x06, KEY_U)		\
+	MATRIX_KEY(0x07, 0x07, KEY_RIGHTSHIFT)	\
+	MATRIX_KEY(0x07, 0x08, KEY_P)		\
+	MATRIX_KEY(0x07, 0x09, KEY_O)		\
+	MATRIX_KEY(0x07, 0x0b, KEY_UP)		\
+	MATRIX_KEY(0x07, 0x0c, KEY_LEFT)
+
+#endif /* _CROS_EC_KEYBOARD_H */
-- 
2.26.2

