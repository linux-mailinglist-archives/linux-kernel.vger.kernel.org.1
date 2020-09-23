Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADE2275880
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgIWNO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWNO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:14:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CAAC0613CE;
        Wed, 23 Sep 2020 06:14:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md22so2715067pjb.0;
        Wed, 23 Sep 2020 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpX4jEQhpZjqmFfBBMmC4/su6hz0jFlTBy64OjqIAYg=;
        b=djygtyOCmbYY9xJBAjdCRsRKdw40RofC5mdFMBCGz5ZY4GUIoih2D8xvYd6mshI9tY
         90PMsUG5nSnzArfmlGLvWCJXv93F+yLcHqU72R4kjxBE/yL8D/0yaOQWcSKhdX47tB/g
         FUidcjgybh/5QmNBBQIpWWeHrVeze6WNyYml7mXWd3FmhIwXbQaqt9hk6ZJYcTWgNzlD
         JpUbChKJUxski1MMzhrJ40rrBRYhw/loWYK0mIAoRAGtYjeGpQ91IZzx0uTKe6GaYxOA
         w9ek8rv8A6ywxMeag58fsu/CRurYvFY0Sqhj54x03YdDA2JyYSq/KJjYrvHINDU0M8Ii
         5UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpX4jEQhpZjqmFfBBMmC4/su6hz0jFlTBy64OjqIAYg=;
        b=W5uF5HGlmcjCdatbiUGL70qhyac5HuiVKKJVN7gPDZIeLvJpMTi5mscx86IR0DZWgR
         m0Bas7h72IdHRCZ/MC3H6AYLpNsW6A3KY2hLLs3c4OF3pCP5FvoGdj0M5LNqs00zihWH
         EwNr51luLfYig0D2+1ECO2Um9flZgyS78e9/l27q4gENfybEHCmYGnnya/p3+3GED3V3
         jxU5DeZYcdBNjBPLTB91xfoyNK5OunfRhMQxlMtZz98vTp9x0NpPRnbIFA7f78ofwJYZ
         mHKSPntX/ZJ89jpyXOfDwuVrSTBR3uEnf+MI7o+SY8BsZtIT2EJB+DQ/fYaJPSuEYxaz
         I37w==
X-Gm-Message-State: AOAM531OuKVzeRAC7bwsnKL/0RnRI9Mfhw3TXR5X97W+cR7Gk4cqMoE1
        acuhGxzOZYs6+3JoV8CEp7I=
X-Google-Smtp-Source: ABdhPJzcST+KCkg4dN6Kgevfxp9Sm63Je529H2t9eUnalwJpuVaYzFf1AJN71VbrNA8DuOK25z+05g==
X-Received: by 2002:a17:90a:d914:: with SMTP id c20mr8512299pjv.34.1600866895698;
        Wed, 23 Sep 2020 06:14:55 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id kf10sm5045280pjb.2.2020.09.23.06.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 06:14:55 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, art@khadas.com, jbx6244@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add ir-receiver node to rk3399-khadas-edge
Date:   Wed, 23 Sep 2020 21:14:24 +0800
Message-Id: <20200923131424.1612960-3-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923131424.1612960-1-art@khadas.com>
References: <20200923131424.1612960-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add missed ir-receiver and ir_rx pinctl nodes to rk3399-khadas-edge
Khadas Edge board uses gpio-ir-receiver on RK_PB6 gpio

Signed-off-by: Artem Lapkin <art@khadas.com>
Tested-by: Artem Lapkin <art@khadas.com>
---
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index c67420578fa..e4655097f22 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -109,6 +109,14 @@ vsys_5v0: vsys-5v0 {
 		vin-supply = <&vsys>;
 	};
 
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_rx>;
+		linux,rc-map-name = "rc-khadas";
+	};
+
 	adc-keys {
 		compatible = "adc-keys";
 		io-channels = <&saradc 1>;
@@ -585,6 +593,12 @@ pwrbtn: pwrbtn {
 		};
 	};
 
+	ir {
+		ir_rx: ir-rx {
+		    rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	leds {
 		sys_led_pin: sys-led-pin {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.25.1

