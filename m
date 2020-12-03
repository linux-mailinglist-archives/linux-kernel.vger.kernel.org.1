Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A991C2CCEED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgLCGBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgLCGBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:01:16 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2CCC061A51;
        Wed,  2 Dec 2020 22:00:35 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 3so2521862wmg.4;
        Wed, 02 Dec 2020 22:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qiNlJdqxsbnz4NC0VDWGxLMRJ3AyXGB8P9pN0Z7BvMc=;
        b=YGxKo493V2KvNC4Fntbenbw8xLGA4Q3xktli4n6/Rx/bhhZmQd7KG18wMM7sd6mur3
         NDTp7OeKoyl0/tPuJ26oPgzGw0bAVm+JO4ekBF3n6Lr4IgWThv31tO0cF0MG90yoQBXy
         PPj0Cq9zM9xBH6SMRXjYYutc6P893/ST9oX31p4iRMyByE+yf/NdH/CEOM2Z6j2h+SJH
         +ze+lISI/hF2tDw6raVfApDG9Qh6t++5aeDl1JkGqMZDz+v+Amb5gdvI8zHAZyW/Bf2e
         uzZ5BM+awunwN5Yq43Nc65OSZb6LamHnde8EmOhVtBd2L7aZ/DKIU3XLJ8Sc2hzYWo+I
         z8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qiNlJdqxsbnz4NC0VDWGxLMRJ3AyXGB8P9pN0Z7BvMc=;
        b=lhQUwX0ljxQPv58pohtmNlPzK5v6tNWIh00eeXrNGSV5XnWxDp3lP9ucGzkP1Lzuz0
         r3CiMAvKNOXfPu6LHYClMmK3YBpzuuaAsxcOWhP+n4oFcgDXFeEeCp8bMbrPomODq9cL
         GVxZ5cJKGdKVeowk1te8mvYZt04hjeDifRbaJ43dlozfDx7pY7TC9Vmhv8h1UBjVLvpb
         LDKIbj9xnTSwVgLSWPBNvCmHrNsnMxwxzh7aDzjRQAthpr4qt4B0cdXmjTW0N8LRh3aN
         LgDwCCz//c6QB3eq1Dc6CdoS0jOwHYW3YB0nwehyElhuGtB20haxh9xVWU/Y9S4rfe+o
         fKvw==
X-Gm-Message-State: AOAM530oR/f3d6NnQvXcMrTA1fwETS4JJhzdzMXhMS3UjZmv6zweWJj8
        5Rh4bENIqAefmtfz8Km4csQ=
X-Google-Smtp-Source: ABdhPJzo0oIB2vo0mTvBTl9n+VEw61QX9ZG6RxT0SBPAFF9o8Jz2l2AvulMUhruFVEv55OYqb70RTA==
X-Received: by 2002:a1c:e445:: with SMTP id b66mr1367316wmh.187.1606975234407;
        Wed, 02 Dec 2020 22:00:34 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i11sm218439wro.85.2020.12.02.22.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:00:33 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 3/7] arm64: dts: meson: add audio playback to khadas-vim2
Date:   Thu,  3 Dec 2020 06:00:19 +0000
Message-Id: <20201203060023.9454-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203060023.9454-1-christianshewitt@gmail.com>
References: <20201203060023.9454-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index c5ee55caae0a..0250c98dbe9e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 
 #include "meson-gxm.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "khadas,vim2", "amlogic,s912", "amlogic,meson-gxm";
@@ -145,6 +146,45 @@
 		clock-frequency = <32768>;
 		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXM-KHADAS-VIM2";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
 };
 
 &cec_AO {
-- 
2.17.1

