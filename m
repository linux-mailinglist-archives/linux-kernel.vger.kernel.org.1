Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4BB2B3CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgKPGUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgKPGUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:20:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D3C0613CF;
        Sun, 15 Nov 2020 22:20:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 23so17346134wrc.8;
        Sun, 15 Nov 2020 22:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+sbzGxZrB59pV6U+pYub8QGMoi1y6WlUsM0RAR+NpTo=;
        b=CSyeqbDMvdjKLX8MtLbreSDP02EDh+7Zm+zOmhScel2VP6cQwl95sF2y7Jblr7RzVf
         JmjhyoWj3YS8KND+fhd7LSWv8NilLxgCxhGp8VCMrDtwcPs89eSYQjEdGf/m75RgOa5E
         5mCzn+B26V+GwEqEtBEyAHU4QaRat5rkn2ZhFhQEiGxInbwd3WUeY6BctNNuh04K/602
         Wykf7t9k4HHphoEmZ6ywlhxKVpjYbfTi6oS5tW6rG+iPGVvItzVgzKLDJu3o+Hf3R2DP
         oX+kytguYUw2SiRe/5r1SxVjjz5d70HtGEIzMiAN1SmT7jzZvOWUgj4jcZwia6XDCieg
         aQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+sbzGxZrB59pV6U+pYub8QGMoi1y6WlUsM0RAR+NpTo=;
        b=N+3QKr7pFm7wVldYUo1w6BPn10RWrvM3gph4+1loaQAuoXZqz0w0lZXkOSbApTBXun
         PKUBuhqCTLP1LdG7Mqt7Vns9gI/lDhtnPIjWm7zgrgF4oqqOVxV8Pl4Li1z0RGKZ68O0
         jQ4HC6z3HTdPykGYagTCqmU7d+lP837BNEh+mtImFPWu/P7y3gqlE4x6WilQOQfNupdp
         42cj0fflV+ye0N6ZQnUa/lPnCX14KGHa1oy05ziZlpKWUmkdQ3/BILoXcZME2Hj2GbkN
         lWi1uIWtYxyQa+0AZ7bi/A/OmiAUp/kBfRHxTKqibguVS2HjTbZoqHkqG4reC2vR+SZj
         Nvrw==
X-Gm-Message-State: AOAM531ZtolJmm8CytpVupLaKnE1LA2FwgA5/Cfy28oIOUDGE1AeCXBX
        As2rZ+lN//a/1nbzAal4vNQtyG0R2HQ=
X-Google-Smtp-Source: ABdhPJzmrLFU5dvMmXy7h5EUkBgwiGp4rm9nBBhE5RBvs2NeOPKorE9a+wIGzCM2EpS8YoQDOXrSeQ==
X-Received: by 2002:adf:a191:: with SMTP id u17mr2437524wru.421.1605507647994;
        Sun, 15 Nov 2020 22:20:47 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m3sm17065985wrv.6.2020.11.15.22.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 22:20:47 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 6/7] arm64: dts: meson: add audio playback to wetek-hub
Date:   Mon, 16 Nov 2020 06:20:30 +0000
Message-Id: <20201116062031.11233-7-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116062031.11233-1-christianshewitt@gmail.com>
References: <20201116062031.11233-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
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

