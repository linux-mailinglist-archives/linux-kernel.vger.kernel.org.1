Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5774B2BAF01
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgKTPck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgKTPcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:32:39 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C0CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:32:38 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id j7so10474318wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2URB6hakc3nWkld7N5FdP4Ld/qwc/CD2JkWsHdCYAQs=;
        b=h8exnCpZKHXR89TT/5X8scjQZIQp3im2/S/Q0Ksp7sXE4P0d5ZfiUHbxdI60xBusxD
         d75hym+1Gog6SD5dRzL1efyh6z8fHNoxXCUZ08VMEpgUPJucRq0xGmOihHoj8EJVIGvg
         RhogM8G/L91ltrIuCFL5GAGHggEcbLwJVd6MUco+1ziBct4rQjm8MKClLQoD8fhjpEoM
         ICWBcKX/Ocrhfgyty+xHlq5/oG4DQc4/5c83+tc+THRl6v8a1BG5J2nHc8hJyZeQlaKS
         JjqSnIdq7Z9YnLAxDtOI5GMVXuUy2aHFdcdW1c6A3idDuVosvHNws/97BRGUHE3YGfyQ
         XfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2URB6hakc3nWkld7N5FdP4Ld/qwc/CD2JkWsHdCYAQs=;
        b=fERSOWASzkFyZmWoXUONoGh6hI8P7RT7SjnGSh7r8lX7SM94XoPlbER1ZvgPBSLwbf
         1myJgb9MlNv3RaALSsc4Yl3sQOmFDMODTCI1CQXnEwRq9+PuZMglrwYeFrtYmSJR3+uB
         HYLalQRETsbdUaceqfquR9nYtvfzNUiHF0sMpzDjQzKPnc2DTeMMG4LuTYKfzYyTw5V0
         VdUCGp5j/e8Lq9s6PThG7bm6ouGdYSfA1WL0oiaLo1YviZnFAsJJIDv6SJxlOsrZOv2d
         IwowkqifE9JkAZJXU4uBKtDj9tw9rlm5t8fxgSovLQFLW0vldDg25WNLHx+cf/sR9P8R
         +spw==
X-Gm-Message-State: AOAM530auH97VN7AW7060RDDBp4M8qg2oLow1iLA0u/0WEqOZACj1/Pm
        soQPm78kOusF6kDav/SUXycOUQ==
X-Google-Smtp-Source: ABdhPJwfTf3h73Vesxg5zZZDESi0OcUkDcB0L1ZerQOBfi/92rBfQHISXh4c/iYb8xFzstjxUrWu0w==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr17909454wrv.371.1605886356665;
        Fri, 20 Nov 2020 07:32:36 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id i16sm5398180wru.92.2020.11.20.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:32:35 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/4] arm64: dts: meson-axg-s400: enable USB OTG
Date:   Fri, 20 Nov 2020 16:32:27 +0100
Message-Id: <20201120153229.3920123-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120153229.3920123-1-narmstrong@baylibre.com>
References: <20201120153229.3920123-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables USB OTG on the S400 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index cb1360ae1211..7740f97c240f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -584,3 +584,9 @@ &uart_AO {
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "otg";
+	vbus-supply = <&usb_pwr>;
+};
-- 
2.25.1

