Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875A82D053E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 14:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgLFNfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 08:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgLFNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 08:35:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D06C061A4F;
        Sun,  6 Dec 2020 05:34:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q16so10778446edv.10;
        Sun, 06 Dec 2020 05:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/M45YtMWBHvWX7HJgiaCX3duzycDxACgeh25TxK15Eg=;
        b=VyMr2Z2Y2FxVMjApnc35MnfMrKlfVe62MA73cWFUYFKdSao13p18AZKDCQ+AunENQJ
         0smVDtZJueGCSqpz90+Q0ghFZy0UViSu31AEWd+pH6kF9OrNDBnodljF3Qy1MOMO58D5
         xKBgYx6mK431AusxL2+qYZ3hU0+QZf7tmbPdtREX/jsFaUVKjlzkkEd6nokY+CZEoK8e
         DJzHQ0qWdcPIdsqqNdLd1pFK4HJ5+t24UPV5b7Hfp0V19a8gLDU/jd8jwIpAgEvA/4WM
         cyxB2IpQUGhhs4YMLz/fi/zrcf59//JIl7DLjaXmj72PowGdVJkZfVYHw7ifH/kjhoDG
         45Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/M45YtMWBHvWX7HJgiaCX3duzycDxACgeh25TxK15Eg=;
        b=bGbuOuVjXPe1vPgP/swg7l3Hnti1MRvPfn1w7jWwAzhP9mSyA35/0rEaBdrT36tITN
         w/3Ge8kMbU1zEG5pUTPqa+xQLQ5Ypv5Lb6RfghMmSrK+1h52T3FIla7rHGEeeICFRA8x
         FanCGpOqRq5KbBMnz+Xnk0NAbEFN2veMZUhsYbOWpK65IQSRkMJLSFadayOdQH5WzaXq
         hrQ2Rw/WMTXT7lAfi6jdZ9p6kDKU5ZYo7pBt+/eE/3NG7ZRi5FcJF+8p2rJDOEDryR80
         k2753RoVBGasfeJzrx19njmEqsp0UJajpZQ/SjVQfRjhZvJrpA2fXnwf5U2kYArRHLVf
         0R/A==
X-Gm-Message-State: AOAM533NEjHthv9aHlJULN8LXc5w0nr0DduFNzxmDw97KsQbViv+ONVc
        zmCYHUWAsXbq1CnCUXBc5tE=
X-Google-Smtp-Source: ABdhPJw1Wm1W5qPXXa98kmLBiwpshvAAU1dUvFzjqg3/KeUGfBrmVqaOo4gngpFc6QMwaVBCy31C+w==
X-Received: by 2002:a50:dac7:: with SMTP id s7mr15721439edj.106.1607261650199;
        Sun, 06 Dec 2020 05:34:10 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id qh23sm7770129ejb.71.2020.12.06.05.34.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 05:34:09 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/5] ARM: dts: rockchip: add hdmi-sound node to rk3066a.dtsi
Date:   Sun,  6 Dec 2020 14:33:54 +0100
Message-Id: <20201206133355.16007-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201206133355.16007-1-jbx6244@gmail.com>
References: <20201206133355.16007-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hdmi-sound node to rk3066a.dtsi, so that it
can be reused by boards with HDMI support.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 67fcb0dc9..f91ce3054 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -49,6 +49,22 @@
 		ports = <&vop0_out>, <&vop1_out>;
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "HDMI";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+		};
+	};
+
 	sram: sram@10080000 {
 		compatible = "mmio-sram";
 		reg = <0x10080000 0x10000>;
-- 
2.11.0

