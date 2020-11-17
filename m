Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2092B6F21
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgKQTpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbgKQTpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:45:25 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C42BC0613CF;
        Tue, 17 Nov 2020 11:45:24 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id e18so23767851edy.6;
        Tue, 17 Nov 2020 11:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/M45YtMWBHvWX7HJgiaCX3duzycDxACgeh25TxK15Eg=;
        b=gv9iMNUExdomLmhZ6/3RtkBaW3AhpWBSUWSrMO1oLfdXYLZKQ0dl9R4nUwEcxPz1V0
         mijrwHA55UDncYNgagM9CjzpkasGyZQoc3OpbH5CXsWqB2RXLkTBzhyOkCyKX2oxJpeb
         Cwkb3M6jllsXM2EVpeBVtFwAtu16JC1xGqamfyB9l0yrXPxgPasdkyldRj/5V4DH6Awd
         iNOINqDFXEiDXichdp0Q/ygBI5MghrASAsL7lKCJ8uR6kmH3Q5B2JU5Dl2Czrb8IMnf+
         ndjcDuDSRacZCVEFgjLl1RQo58XMQZZ6lrS28sjX1rAs/o4SH4t8XgaWKHyUJXwmiPpv
         ov7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/M45YtMWBHvWX7HJgiaCX3duzycDxACgeh25TxK15Eg=;
        b=YigKzk3YCOg2wMypj+ww5FsCBF8JMM1eXqQhBP4DPk5ZQHhn1Y/qVsv0mXZX+OFXz9
         ARvAnOAOYlMJFV8VHSAvvrQRJd08oYtsCxbTlOhnxzsyMQ4G2nxtjYQ3qSmOANhUkzIY
         JxpanVD0hZ8ziYnRb4Iktv13GwI1na8EHZ3YhAU/jLLUM7ov4gFzQd9lg/TpsQ1KhnOo
         CEu1evpgsQPHI3+iExGxAKSo8uMryYYDWXcqIiBNZL5rjEBhVxH9hkVeQwXCF/ON1Xuw
         KSPk34+Rfoodf6hmsIgtr/6aAjX306d7BLeL0sZzlC6aWSmZaaYQVISdH//GAGwZh3UG
         QBIw==
X-Gm-Message-State: AOAM532mD66Ebcbg/MbDIZT7E+BmM+nF3GCXYRga62YDPUQV6Z1L9o/Q
        QF1EHlixG/4HIlzJ0bBR1Nw=
X-Google-Smtp-Source: ABdhPJw0SEhxpFWNTsu1mkMrCWY8UFWsWPMj03LOTEeqmIC1KaMO+Jigt4JOZdpDCQfeyl7XDV8vHQ==
X-Received: by 2002:a05:6402:6d6:: with SMTP id n22mr23176808edy.82.1605642323246;
        Tue, 17 Nov 2020 11:45:23 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w2sm727972ejc.109.2020.11.17.11.45.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 11:45:22 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] ARM: dts: rockchip: add hdmi-sound node to rk3066a.dtsi
Date:   Tue, 17 Nov 2020 20:45:06 +0100
Message-Id: <20201117194507.14843-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201117194507.14843-1-jbx6244@gmail.com>
References: <20201117194507.14843-1-jbx6244@gmail.com>
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

