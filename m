Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2B2EF892
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbhAHULm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbhAHULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:11:39 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E75C0612FE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:10:59 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n7so8329537pgg.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqnbKqpISV5+WcGpuVpiPkrjiHKz2oeV7SJM/0PfExs=;
        b=bARS1FD5bNcPVbYwfwu7t43PAJE5GyJpZJACn5MSOsuYlRjYz0XiC0ktB36kZjXb8T
         XxPjEv23ulE0l9655O4C/kCQj2uw0B7opiwbmw8UjuLD/Rp93RLJin5y7L4iD6/EAhf3
         AKR/vgIzCRD14qGv3sOfB009vPedBjHMdFZLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqnbKqpISV5+WcGpuVpiPkrjiHKz2oeV7SJM/0PfExs=;
        b=GVSZNFRvh77LmSr9Cd0HB46XXccCSBR5LV+cKDBISwABmHaiRX0sh+UqkTBjLWT7+w
         sjb9LaN9AodOeLhQvu98BGaB2nkg67WbNhxlUbO+exJwgJtb8Z/jURMIZFehwR6A6tYb
         btZ+Xu2jEnZwYMLl0KwKR6qSIX7xHS9sS+R5GByZnKaxMX7bZjA+uyUzDPpugfp6HoZV
         0blMdTVwMuJHWyA2SPSV0zYO1988c3Wbdi24Za3T01sLiEf31YLB12vVFkK4lYpKcO88
         fbsfxeqHpdmSrETipwZAjRAHmHTp2RDJBecI3UgBc0d8L4njy2otYVOLoM1bRziD2iUW
         wcPA==
X-Gm-Message-State: AOAM531cIgwg25GRCiFZiv0Z8vAPcLkF1ypnf40HYV5VCnXilWXo8mN/
        6zPf4rXK3gzF1ObFEwGHvMeTl6t3Oj8LDw==
X-Google-Smtp-Source: ABdhPJzPyCA2lvQNKC8nleiCoC66c3C8Yueph6vigVWHUHtX3QPbcCkGNH8zBeDlYuJIs1hvd0OVkg==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr8575643pgb.332.1610136658496;
        Fri, 08 Jan 2021 12:10:58 -0800 (PST)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:a6ae:11ff:fe11:fd59])
        by smtp.gmail.com with ESMTPSA id s5sm9404651pfh.5.2021.01.08.12.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:10:58 -0800 (PST)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
Cc:     dianders@chromium.org, swboyd@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: cros-ec-keyboard: use keymap marcos
Date:   Fri,  8 Jan 2021 12:10:51 -0800
Message-Id: <20210108120956.2.I969aec81269bb64b2fa970482511426180d6ea8c@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210108120956.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
References: <20210108120956.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common cros-ec keymap has been defined as macros.
This patch uses the macros to simply linux,keymap in
cros-ec-keyboard.dtsi file.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

 arch/arm/boot/dts/cros-ec-keyboard.dtsi | 91 +------------------------
 1 file changed, 3 insertions(+), 88 deletions(-)

diff --git a/arch/arm/boot/dts/cros-ec-keyboard.dtsi b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
index 165c5bcd510e5..af994c8eb8163 100644
--- a/arch/arm/boot/dts/cros-ec-keyboard.dtsi
+++ b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
@@ -6,6 +6,7 @@
 */
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/input/cros-ec-keyboard.h>
 
 &cros_ec {
 	keyboard-controller {
@@ -15,94 +16,8 @@ keyboard-controller {
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
+			CROS_STD_NON_TOP_ROW_KEYMAP
 		>;
 	};
 };
-- 
2.26.2

