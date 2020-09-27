Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9506427A2AB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgI0T3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgI0T3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB755C0613D4;
        Sun, 27 Sep 2020 12:29:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so4396955wmj.2;
        Sun, 27 Sep 2020 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
        b=YOWcmmkGZkoo0xR3hpRolwIz5WB4o72C2m4j4wWLhP0awIseYW8VrNkbz5M7TVqAh7
         nzd/4xyciScgGAlNkp9Qienl1nb0Qe+wKzdkBpQ4VEIKGvw6slRNbX17TpNhy+o3yuLA
         +RQKKcnSbAqRio0HVhoUxiTb6xRZCuTjtNpwih+iNRagzwKS7LOTXj/zGGWCu2TU1JvT
         TQSmgpe5GuKC5SBoCRJF6DwO/kuBq6xZ36INr0g9z35eJUU83TwGviF01wpNuhaQNnjH
         K80ks2dao6LktdmUIGf9WJ6O7Xg0TF3onlpPgSoyS6+crm70EbqY0FetjCIgX6krXfkw
         cgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
        b=oFXUpP4QkozcJTlPDNOQowdCnl2AOt3R3P9bzBw2i5I1k8Jj36nOTQPZ7iIDcRSFMA
         F5Y8QCBBsMN/dm+HIpN1rEZhllPjGjKxT1D1BBDTI4zqDyYJdmW1VfJDZpqXQ44FGeu3
         HLW2OVrBKGet2XQP0+KUOxktrQAHAWxxRqWcEbepj1iKz+E19zpVi3LS7VXY0OXzr/nb
         MOEQEgDsjqdXuR5K8mruw1qsW+VZ/ciuYP9XrfPjX49wHjkPz/02IRI1Mq6HdFQgIIqX
         9lkLDKPwJo+O7cgFp763QQ1owA6DWZdzzESV3+DfRaPRyjBDKLrYtTYU/rDVdL0WsstA
         Yteg==
X-Gm-Message-State: AOAM530oCX6M5cN/lA1ERMU6RoIUYj0XQqumfu7ssQqNTIHziLKBCPsV
        bT7TC7+VUIEs9AWqm+INqf8=
X-Google-Smtp-Source: ABdhPJwEVVny6H3wcCVbC8vChEo/WrPglNZDmGptdt4Kmi1gaRlgOVezaOJH6sDtWeJkUL30HiHAbg==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr7779709wmi.163.1601234969221;
        Sun, 27 Sep 2020 12:29:29 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:28 -0700 (PDT)
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
Subject: [PATCH v5 10/20] arm64: dts: allwinner: h6: Enable HDMI sound for Beelink GS1
Date:   Sun, 27 Sep 2020 21:29:02 +0200
Message-Id: <20200927192912.46323-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that HDMI sound node is available in the SoC dtsi.
Enable it for this board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3f7ceeb1a767..049c21718846 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -118,6 +118,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s1 {
+	status = "okay";
+};
+
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

