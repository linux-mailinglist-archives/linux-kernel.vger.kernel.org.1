Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122B42B7ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgKRN6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgKRN6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:58:38 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662E5C0613D4;
        Wed, 18 Nov 2020 05:58:38 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id y17so2845654ejh.11;
        Wed, 18 Nov 2020 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/M45YtMWBHvWX7HJgiaCX3duzycDxACgeh25TxK15Eg=;
        b=WzfS5ftWkRMUzolpSh5HCyN4cmp70soK14s87h+2M08gwqkRfSM1li/SeATS7MA8CA
         n/sY36cmWUjV1SvmUdcnwVr88B4NjXCBd+xogRlmqDnN7DqOLXdQuISdhL57o6jwPxee
         IawguAG9hPu0NW7aAXvvmQ1fW4WTfO8oOP7dScEJdK0PnNfDMu27k9qRigi+sJu4VF3b
         Bxoik+iaaYnm1yT8K2F4x8HHZKjjlkbPX0lbLt7LpEQvd0TKi3Me4dyadjHW11Onb46M
         xYjT0zw3/9G6+6KLQJwPFviF+W9Sf6NNTpaw0SBLiN2PLCWcq6h5hvUlWV8NfZRGOh+h
         YOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/M45YtMWBHvWX7HJgiaCX3duzycDxACgeh25TxK15Eg=;
        b=pZay9WPz6lwxR2G7ByCPzRSbZ74+2Ap3PuDS0GoJySNd0O5PkR3URt3/qGumdBQyH3
         7kGIk8OwDLnW0s8gQ46mSlx/9ubeJ7Up3MKgppTTeOxVfZcXirk+4BsEw240EuhXnklS
         na2B7Sj1x3BM+1DZsHgE/o7B5qSAtN7a+8m1KSK5v8xYgPUqi8c0hmeSbEL0xkl0dqkf
         rft5ofkLb+C3ZWuyEQ+gPeZ3uf09+ukGDrVAr2X6iVa3H5bDIOwMAcYL2hxGPyzXtLty
         ffLiD/6OXyUNcX3TYgzX87WbuM+u27RNd+f0Ude3yFuymPf0FRuphCFrKKMbdQqjPFPB
         TRKQ==
X-Gm-Message-State: AOAM532gtq7+efqPuZfA57hkX0Q8v07hoJQM67xfShzriNSbK0d4VPxx
        F8BgUcdAmCtN6+tBa8ihCcU=
X-Google-Smtp-Source: ABdhPJzjtTA6aSJDvhbh3mZRYc7KQzylCh451tX0U9bpOnGQQ2ddCN9W+I66OX1Z3ial8hqeM8QM/w==
X-Received: by 2002:a17:907:4335:: with SMTP id ni5mr20187759ejb.459.1605707917128;
        Wed, 18 Nov 2020 05:58:37 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cx6sm13721384edb.61.2020.11.18.05.58.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 05:58:36 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/7] ARM: dts: rockchip: add hdmi-sound node to rk3066a.dtsi
Date:   Wed, 18 Nov 2020 14:58:21 +0100
Message-Id: <20201118135822.9582-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201118135822.9582-1-jbx6244@gmail.com>
References: <20201118135822.9582-1-jbx6244@gmail.com>
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

