Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6532716CA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgITSJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgITSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A966FC0613CF;
        Sun, 20 Sep 2020 11:08:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so9968658wmi.1;
        Sun, 20 Sep 2020 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
        b=DTugHYDQurkLCf7YEB23JZoq9hjCg3G438oz6nsSwpc3SFB/4a0OpEghykeDOF0weK
         cJAHjsQubS/fikJTAO/56fbHqZ+2asoz8AjWGIYOUs5GM9YfSWJ4BbJGnPa7Q3pxIUDr
         lUCuUrMMNbNsgJFxR1Dv4VUydRlvRuTi60AkTGQuv+yFF6x4o1pjat9OzsExfXCyokI1
         SZM5nG8EviAP9TvUyQFg80Rgupk8YH5z1hcr/Fy4Bo3+w6wDjWT9slQoq/T5kT0NpgrD
         orRO/Ab1BXyOqQ9XphBqrWQZPW+YKKAaN3ofMJ6JQTrswWwvAGmh6XyQnxkS2Uyq/Yvz
         iMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
        b=PtldGchsyPX+EThZUpG6s3sPuGZn5Cjl9IAItAP+A8oEtYeqPRQ3t0HleCzNjPK4vG
         2MSGfezQsghfHmlpuHbZhD5t+OpZa6vIFMFMaEsRM8iF3Ltt0AfwhsgGLBBeHoR2mlri
         G1dR3xXZJ9ZwrrEYbZtnbdkZPRML+0Bf+LVnAqru8f2qUV9DCWRX1qgUapg3SVVnCgp9
         5Y7JuD7K9umcCOym75nu/LL5vDAJPLQEvYaTk+CGuG9YVW6b65FCEwdtmZxAMhQJt4jm
         nc/uqJMBnjCfM7hXRT+TX0TKRnD/z7Lb07C3v3yNISocek6YqO5p2KaH5jwHsr5sTQf0
         hTKw==
X-Gm-Message-State: AOAM533foYlsccGFqzfXvifc3sXAam7c/9rxJ1wZstMYkaww3ksGCV6T
        LjOcgWPQVLwVfQFcgpDCCeQ=
X-Google-Smtp-Source: ABdhPJz2QaNPDpWIrkvJtScA2IDVibZUxsVBjTipRV+CaMx06zYvvxwXowqoa9Omn92mxSTZEr8IhA==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr27631898wmi.140.1600625306214;
        Sun, 20 Sep 2020 11:08:26 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:25 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 13/19] arm: sun8i: h3: Add HDMI audio to Orange Pi 2
Date:   Sun, 20 Sep 2020 20:07:52 +0200
Message-Id: <20200920180758.592217-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Enable HDMI audio on the Orange Pi 2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 597c425d08ec..64e8e2829f27 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -144,6 +144,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s2 {
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_ir_rx_pin>;
-- 
2.25.1

