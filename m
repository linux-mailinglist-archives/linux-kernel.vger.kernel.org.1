Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74C28152E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbgJBOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388151AbgJBOb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:31:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1866C0613E2;
        Fri,  2 Oct 2020 07:31:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so2052292wrn.13;
        Fri, 02 Oct 2020 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ylzKfvJHgekxjZxp4VQuW17EoD7pYVoukf8XeW0SJg8=;
        b=XbqwofO3O11m65QXRe/QBPxMtlN0jHNDW1/9N1+6KY/kcOu4HpE6dpJb6A26HH3P8F
         1aKh9GaoUe2mGwk3lS6sYEvr8hKBKSFa6PxhJhe1IRjH/20J+qH6Nx1IVRqopBAqFp4b
         sHv+YoNSmLmrrgXOUyUA/xNYYYHix6ETd1bK7mj5mxeFBY5INPHFeF8GC1RQT9cw+qtk
         C0M8Uk4WjFZdsaaRa/omRTLiTz8RtjTQhJ1lPQ7JkltIDIL7Gp2YrUgL4vslq3+K9P0d
         0QVjmLEsJg1yxcMOR8aIhwLSg2lg5XBHAz4zTKCb3tXhD3wJ9llY5+uU4hHOGKZFX0iI
         9PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ylzKfvJHgekxjZxp4VQuW17EoD7pYVoukf8XeW0SJg8=;
        b=TwVBgqe36Ty4S2Ng8ZVgAJW3PO2NckNCZElTtpGCZCe7hk5kOCFI2alA48Klvxg1eG
         uKQEksAGIAXNi8v0HHGOEAKoMEewFhStBZcZqqKZ5XlhfDu588TuydlXfhjpWCnbJU7j
         zsSkyVcdPVyATSU0wtXLtO3OaJh06jWnwAonE0RJ3qpetJzvhG7pDuki1GfLTWfl8LyU
         uktCR3Z7xaAqCFXfPySWr73wO9HJKumHoMncL111gi08HIGJTZG6WRKNuZIKfenX8F+t
         tK6+l6V43vJRCEMEcnqwu+aAqeJD+fMSUPZGdMNSGT3LBXpBmGFaUU/x3ylrrzJzwewP
         qMxA==
X-Gm-Message-State: AOAM5332tsa0vHWg+nwugtWyHRLESKEAR+s0tK8RywYqnaI6Yt//yslj
        ECTnvdASvo6r7goWULPJVNI=
X-Google-Smtp-Source: ABdhPJxuSUH+cCX/j54h5vSEXs1aca7IwudIaTc+P/uCLZpygcYQ2z5Wz5xyMZvEumEh7cMnuc9l2Q==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr3327483wrs.48.1601649117431;
        Fri, 02 Oct 2020 07:31:57 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:31:56 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 05/10] arm64: dts: meson: add audio playback to p201
Date:   Fri,  2 Oct 2020 14:31:36 +0000
Message-Id: <20201002143141.14870-6-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002143141.14870-1-christianshewitt@gmail.com>
References: <20201002143141.14870-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-p201.dts      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
index 150a82f3b2d7..2e2bccbcfd43 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
@@ -8,10 +8,50 @@
 /dts-v1/;
 
 #include "meson-gxbb-p20x.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "amlogic,p201", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P201 Development Board";
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-P201";
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
 
 &ethmac {
-- 
2.17.1

