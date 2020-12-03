Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040472CCEF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgLCGBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgLCGBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:01:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7B3C061A54;
        Wed,  2 Dec 2020 22:00:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id h21so2572162wmb.2;
        Wed, 02 Dec 2020 22:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=flzzMcNnuQ2TK+9oOreZP7+ZK5g8q35jbbhYIv7bR/Q=;
        b=b4oROn2uYBd3EJILA6VTP3ZDTBrWylRxn6PJTleoUIkOvvCZOYF2O5TCsKirv7nKwd
         8yxywt0SE3XJ8NZx1PY1nDQIWU7Pn7zvp2zIg8/Q3abg0d9k6gazejgLdybzJ5Phs6Z9
         VCfFmaL3TrGx4ArFqlzCmqemyijff4HfifG0IAzqFCIUwpI6EJhOTrzJdvvVSIN5Wi50
         RSDPuzJitQ70GCzfOyQXEyBhFrXxeEt9rivzMiHQF1Gl4hqeJwlsEQrI2MMVoxTnUmm6
         s2VDOVOvRInrBckzN7BlAAlRHcT1PyX9qauil1ld1uZNwvJgSMF+6xlhtWARAekuCren
         rQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=flzzMcNnuQ2TK+9oOreZP7+ZK5g8q35jbbhYIv7bR/Q=;
        b=J5EwFKdMZO0LGLkuD7ZGLn4YQrKPlqnu4ZvkAPmleQ4LV6ERNJvJhT8BBmhnybNSUY
         /ijnSwPmnQZugMIE8AdFdAF6mLhqnv/+dWMj2YlT8B9svlLB+T05zmpFb80+IXaokI0R
         1NQVKwKKWF46XI2hk2hOWDZdHNEOxYhFtjmqflmO1g0MZCZyHYWuKNHnkszxYU/KULK2
         m6v/rcmu0xWz7IZgi34C9XgRx9GlkmCaRU8DGcZy/M4kLBeFQXPGovNBp9zBB9AY2UtI
         pfTd63/JWaqwNvE/4vaUoEhvYOHwgH74DIER5Vzz9FQkRMFrzM6Zl8rCSESjyQ8bcwXd
         D61Q==
X-Gm-Message-State: AOAM530fGK2v7CEnsBAnGadCM+W7K+k7TOpOz62g0QyVtv3YkrWgbVmc
        514hbD5peVwiwj0tB1VtGZ4=
X-Google-Smtp-Source: ABdhPJyasl5FzioZeX74Iy3aXqmjj6CpZAy6X9j/0JXgw2knVm/Hcb1ZR5D932g1/aJpwkMPrcH6Vw==
X-Received: by 2002:a1c:e901:: with SMTP id q1mr1395679wmc.148.1606975241061;
        Wed, 02 Dec 2020 22:00:41 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i11sm218439wro.85.2020.12.02.22.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:00:40 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 6/7] arm64: dts: meson: add audio playback to wetek-hub
Date:   Thu,  3 Dec 2020 06:00:22 +0000
Message-Id: <20201203060023.9454-7-christianshewitt@gmail.com>
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
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index 83b985bb015e..0c1570153842 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -7,10 +7,50 @@
 /dts-v1/;
 
 #include "meson-gxbb-wetek.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "wetek,hub", "amlogic,meson-gxbb";
 	model = "WeTek Hub";
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-WETEK-HUB";
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
 
 &ir {
-- 
2.17.1

