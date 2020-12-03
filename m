Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805FC2CCEE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgLCGBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgLCGBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:01:11 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54762C061A4E;
        Wed,  2 Dec 2020 22:00:31 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g14so589381wrm.13;
        Wed, 02 Dec 2020 22:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yQx2ZxmNKfhSKBL/RrXY6Av26UDGD56hcg2QvfdLjZ8=;
        b=Jd9yX4ZOB15VnyBC8HtYGGV+qWz0rzvNEOgyLezF/x//sq2cSjs08/RZlvSTb6vzzc
         IL7EFIonPtrRIdECE+AmNaYdalTg9LEAJi8HQ/flZO0t+6Onye8s6cJdQ1WzlIrPPau4
         sg6OXgcT/7n3hBvQUOHL2Dmu8I/WjxRY92c5/D690ttwWsNHRhyXFOcxBuGy4VW4YIJO
         PjiryC/WXVbcmLbtFDLe6FjDl8/zBM88VPsCMUuLRARRJ7uAeGyAkLvBf/fMJD9EbziK
         G9hM8TnEGw+s5EduYmP64M55RuFReEV0OBrWFdvuCOod8CyWfTOve3JM8UKt7VNY/Bsa
         7NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yQx2ZxmNKfhSKBL/RrXY6Av26UDGD56hcg2QvfdLjZ8=;
        b=KoZpOhRfw/hlOwF4BMbqrB9UJSv9APl1x7ZlZH5T9EOjmigGxgGKB32mzlgFWFWlbk
         Xw4LpiRMznIgRuZqdHS39yFCwDLsmc8xnqIg9QqLFc/Zo2gN3XWsvyjAwmNF/i4Vb+z8
         XL90C9Yrg/DvZ2MuwnR8FKR+RXGBdA5GewACczo97M8mavznn9IjslUHvppixR+UjRzz
         SxAchM/sY+Qx3QLqOsaVrlUKoJAcaYgaaccR9qionE926nv5HrBzAt2aKaB3k+ACpy/e
         35TzwoHCov8W0h30WVUxtQjli6vkctsBuxfWPb8JtqcEofHRAO68N01+rlnJKXfKN7Vm
         EjCQ==
X-Gm-Message-State: AOAM533LuoWmhyJj3ICWIBJvtO1D25hQZvn63W9aXAbP0M4cVxGl0SIn
        lz2qLjRDAzUGuxI7MM04xV4=
X-Google-Smtp-Source: ABdhPJz5touPQ8gRAj5bAX0jBVDBM4EYThkiQpjW8op4pjO742vkaxdCX2O0sKSfLgLIRh3HPv/WRg==
X-Received: by 2002:a05:6000:45:: with SMTP id k5mr1750499wrx.108.1606975230142;
        Wed, 02 Dec 2020 22:00:30 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i11sm218439wro.85.2020.12.02.22.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:00:29 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 1/7] arm64: dts: meson: add audio playback to a95x
Date:   Thu,  3 Dec 2020 06:00:17 +0000
Message-Id: <20201203060023.9454-2-christianshewitt@gmail.com>
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
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 67d901ed2fa3..b5b11cb9f393 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -10,6 +10,7 @@
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "nexbox,a95x", "amlogic,meson-gxbb";
@@ -139,6 +140,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-NEXBOX-A95X";
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
 
 &cvbs_vdac_port {
-- 
2.17.1

