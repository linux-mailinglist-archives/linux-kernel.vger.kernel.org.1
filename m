Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238672F57EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbhANCLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbhAMWP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:15:59 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A87EC06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:15:10 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b3so2130606pft.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7bqjqyNMNRKUMpyvIVtBoxWCtfjOddcBvsaRlMYFD1g=;
        b=iMrajDHJEz/umDMCYOEYnYYZHaq0ICY+tD94QYb3MxZvjcUFl6o6Fn5T5STXyQk207
         UxQ7OWJOntc/S0WpvNzHJvbHIncIADgGvCaiXE/oJLdhgE0EC9Dng68Np6fY3XhPo3AC
         GDioBtanQ8HFXtIeh7IrLAPrvA9KFuji3Q2R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bqjqyNMNRKUMpyvIVtBoxWCtfjOddcBvsaRlMYFD1g=;
        b=fvwt0613lekMpBbdhOZxtwxSQww01w0CN5l4AM0iN/IC4lHwhsGuNhlCXmRLKwL9li
         09P/wJvlSF8secvZ26ysSbc0hk64MUrX2xgfwmXoLwWk0Oty/LJY/BjfoQF4xjZE7o1M
         rjCy4R38SYQ5jSmwWBD4SAQbvl9QpqmIjNYGodTbVkWFPKVVKMmzkb88wLu03cIS2Cyu
         CNhpMJ/S2vIYn/s4svzTJr3N52VMztdacdKR1TwReULPllxIJqrOAxXK0e8EcVA241J0
         NKLjo8z2lCm/iPVfuM2AsxL/BSl8ERoxbKRCzlKSltt8az0zIkdVYSUjEyAa2OjZIUag
         LY3g==
X-Gm-Message-State: AOAM5321euuH27KDl46sqYDsD+qvpvOBI/pQB728ZQxHUAmAEOZ/a6gF
        Ve5atBAn07bw0EcYfp2ztdQ1u3Tj6/Megg==
X-Google-Smtp-Source: ABdhPJwiLYFciV6ed19rhAY1RqODBcKfqMSatrsj2KCYwTiTgE79x/1v6lvL03MOQNWmC7rKZlo1VQ==
X-Received: by 2002:a63:6344:: with SMTP id x65mr4118247pgb.172.1610576109471;
        Wed, 13 Jan 2021 14:15:09 -0800 (PST)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:a6ae:11ff:fe11:fd59])
        by smtp.gmail.com with ESMTPSA id o190sm3538477pga.2.2021.01.13.14.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:15:09 -0800 (PST)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5 2/2] ARM: dts: cros-ec-keyboard: Use keymap macros
Date:   Wed, 13 Jan 2021 14:15:02 -0800
Message-Id: <20210113141426.v5.2.I9ec9c3c61eded22a5f7fbff838d23fc95ec7cfe0@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113141426.v5.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
References: <20210113141426.v5.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common cros-ec keymap has been defined as macros. This patch uses
the macros to simply linux,keymap in cros-ec-keyboard.dtsi file.

This patch also creates an alias for keyboard-controller to make it
easier to override the keymap in board-specific dts later.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

Changes in v5:
- Fix a typo in the subject line

Changes in v4:
- Fix a typo

Changes in v3:
- Create an alias for keyboard-controller

Changes in v2:
- Replace CROS_STD_NON_TOP_ROW_KEYMAP with CROS_STD_MAIN_KEYMAP

 arch/arm/boot/dts/cros-ec-keyboard.dtsi | 93 ++-----------------------
 1 file changed, 4 insertions(+), 89 deletions(-)

diff --git a/arch/arm/boot/dts/cros-ec-keyboard.dtsi b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
index 165c5bcd510e5..55c4744fa7e7a 100644
--- a/arch/arm/boot/dts/cros-ec-keyboard.dtsi
+++ b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
@@ -6,103 +6,18 @@
 */
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/input/cros-ec-keyboard.h>
 
 &cros_ec {
-	keyboard-controller {
+	keyboard_controller: keyboard-controller {
 		compatible = "google,cros-ec-keyb";
 		keypad,num-rows = <8>;
 		keypad,num-columns = <13>;
 		google,needs-ghost-filter;
 
 		linux,keymap = <
-			MATRIX_KEY(0x00, 0x01, KEY_LEFTMETA)
-			MATRIX_KEY(0x00, 0x02, KEY_F1)
-			MATRIX_KEY(0x00, 0x03, KEY_B)
-			MATRIX_KEY(0x00, 0x04, KEY_F10)
-			MATRIX_KEY(0x00, 0x05, KEY_RO)
-			MATRIX_KEY(0x00, 0x06, KEY_N)
-			MATRIX_KEY(0x00, 0x08, KEY_EQUAL)
-			MATRIX_KEY(0x00, 0x0a, KEY_RIGHTALT)
-
-			MATRIX_KEY(0x01, 0x01, KEY_ESC)
-			MATRIX_KEY(0x01, 0x02, KEY_F4)
-			MATRIX_KEY(0x01, 0x03, KEY_G)
-			MATRIX_KEY(0x01, 0x04, KEY_F7)
-			MATRIX_KEY(0x01, 0x06, KEY_H)
-			MATRIX_KEY(0x01, 0x08, KEY_APOSTROPHE)
-			MATRIX_KEY(0x01, 0x09, KEY_F9)
-			MATRIX_KEY(0x01, 0x0b, KEY_BACKSPACE)
-			MATRIX_KEY(0x01, 0x0c, KEY_HENKAN)
-
-			MATRIX_KEY(0x02, 0x00, KEY_LEFTCTRL)
-			MATRIX_KEY(0x02, 0x01, KEY_TAB)
-			MATRIX_KEY(0x02, 0x02, KEY_F3)
-			MATRIX_KEY(0x02, 0x03, KEY_T)
-			MATRIX_KEY(0x02, 0x04, KEY_F6)
-			MATRIX_KEY(0x02, 0x05, KEY_RIGHTBRACE)
-			MATRIX_KEY(0x02, 0x06, KEY_Y)
-			MATRIX_KEY(0x02, 0x07, KEY_102ND)
-			MATRIX_KEY(0x02, 0x08, KEY_LEFTBRACE)
-			MATRIX_KEY(0x02, 0x09, KEY_F8)
-			MATRIX_KEY(0x02, 0x0a, KEY_YEN)
-
-			MATRIX_KEY(0x03, 0x00, KEY_LEFTMETA)
-			MATRIX_KEY(0x03, 0x01, KEY_GRAVE)
-			MATRIX_KEY(0x03, 0x02, KEY_F2)
-			MATRIX_KEY(0x03, 0x03, KEY_5)
-			MATRIX_KEY(0x03, 0x04, KEY_F5)
-			MATRIX_KEY(0x03, 0x06, KEY_6)
-			MATRIX_KEY(0x03, 0x08, KEY_MINUS)
-			MATRIX_KEY(0x03, 0x09, KEY_F13)
-			MATRIX_KEY(0x03, 0x0b, KEY_BACKSLASH)
-			MATRIX_KEY(0x03, 0x0c, KEY_MUHENKAN)
-
-			MATRIX_KEY(0x04, 0x00, KEY_RIGHTCTRL)
-			MATRIX_KEY(0x04, 0x01, KEY_A)
-			MATRIX_KEY(0x04, 0x02, KEY_D)
-			MATRIX_KEY(0x04, 0x03, KEY_F)
-			MATRIX_KEY(0x04, 0x04, KEY_S)
-			MATRIX_KEY(0x04, 0x05, KEY_K)
-			MATRIX_KEY(0x04, 0x06, KEY_J)
-			MATRIX_KEY(0x04, 0x08, KEY_SEMICOLON)
-			MATRIX_KEY(0x04, 0x09, KEY_L)
-			MATRIX_KEY(0x04, 0x0a, KEY_BACKSLASH)
-			MATRIX_KEY(0x04, 0x0b, KEY_ENTER)
-
-			MATRIX_KEY(0x05, 0x01, KEY_Z)
-			MATRIX_KEY(0x05, 0x02, KEY_C)
-			MATRIX_KEY(0x05, 0x03, KEY_V)
-			MATRIX_KEY(0x05, 0x04, KEY_X)
-			MATRIX_KEY(0x05, 0x05, KEY_COMMA)
-			MATRIX_KEY(0x05, 0x06, KEY_M)
-			MATRIX_KEY(0x05, 0x07, KEY_LEFTSHIFT)
-			MATRIX_KEY(0x05, 0x08, KEY_SLASH)
-			MATRIX_KEY(0x05, 0x09, KEY_DOT)
-			MATRIX_KEY(0x05, 0x0b, KEY_SPACE)
-
-			MATRIX_KEY(0x06, 0x01, KEY_1)
-			MATRIX_KEY(0x06, 0x02, KEY_3)
-			MATRIX_KEY(0x06, 0x03, KEY_4)
-			MATRIX_KEY(0x06, 0x04, KEY_2)
-			MATRIX_KEY(0x06, 0x05, KEY_8)
-			MATRIX_KEY(0x06, 0x06, KEY_7)
-			MATRIX_KEY(0x06, 0x08, KEY_0)
-			MATRIX_KEY(0x06, 0x09, KEY_9)
-			MATRIX_KEY(0x06, 0x0a, KEY_LEFTALT)
-			MATRIX_KEY(0x06, 0x0b, KEY_DOWN)
-			MATRIX_KEY(0x06, 0x0c, KEY_RIGHT)
-
-			MATRIX_KEY(0x07, 0x01, KEY_Q)
-			MATRIX_KEY(0x07, 0x02, KEY_E)
-			MATRIX_KEY(0x07, 0x03, KEY_R)
-			MATRIX_KEY(0x07, 0x04, KEY_W)
-			MATRIX_KEY(0x07, 0x05, KEY_I)
-			MATRIX_KEY(0x07, 0x06, KEY_U)
-			MATRIX_KEY(0x07, 0x07, KEY_RIGHTSHIFT)
-			MATRIX_KEY(0x07, 0x08, KEY_P)
-			MATRIX_KEY(0x07, 0x09, KEY_O)
-			MATRIX_KEY(0x07, 0x0b, KEY_UP)
-			MATRIX_KEY(0x07, 0x0c, KEY_LEFT)
+			CROS_STD_TOP_ROW_KEYMAP
+			CROS_STD_MAIN_KEYMAP
 		>;
 	};
 };
-- 
2.26.2

