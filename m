Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8532716C3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgITSJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgITSIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D767C0613D1;
        Sun, 20 Sep 2020 11:08:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so9971310wme.0;
        Sun, 20 Sep 2020 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZhYwaoUjzd/wEdIR2SZMGyqDMCzyDmEzzuRB3l0wN4=;
        b=cbSqHIX9aRG5K5ZMCUbuVkVSOWfBJ3Gox32yJYQ0M3IE9X75NOg6MOKWHMhqCTOj4W
         i1zamfmrZhnA06kC85WVJYrliSBH7fooKs/tN19iGL8DOm/UF08na/0axh8Cnq1qLOxI
         9g27nxVFXSBrTinbvRxXomr/v/Ky4nE5Ig6GSDRxM0mB9LGz//xUHWOMfeeQQebxi9CK
         b5tJ71MBB/1Q7T4jAwbnIJ7Uoe66WT6zp8scsvnf7LssZTNHUm0Bjh68mSMjt6cnnvBq
         PxYbgg+9g1VTNCUgYMyGwJRX8bhcLmXNF7/rSWk84f7voahQ4jPvlpUUd1WwhH/Qe8il
         pyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZhYwaoUjzd/wEdIR2SZMGyqDMCzyDmEzzuRB3l0wN4=;
        b=BWqqyNbLwvPUDmNXEL1GFVx7QxKm++LFvCUdYS9ttqVP0NhyqdZWLY2MD9T87Utyob
         fLXTlWwnqtJ6SAupgnnzhDoTXqc4w2OaOdybZK5iPJUtSeOQFaMIS8WhIxoI3Wl4Tj/N
         yjxcIw1FTiHufeJ/sxLnAwxdwHFYUclgBFnk8M28zByyRIRMipjJsGQxB2Zef3UAuwAh
         DV2s1/y+AYiPP3F2FZX3kKBeo/N6fklpe1aIEJ0Dts0Lk7jS8bUVQSKXl3K4LegLUJZo
         4k0m3edVBDwcbVWb3geRZkjWphAzBLApTsxJ0ORNYmrfoUnnLofvJ73dXH7BOCXUV/yT
         7elQ==
X-Gm-Message-State: AOAM533mUpTq/df1pbyE3Xem33tnDaGi0VlyvtNtr3iaDMyCr3OaRWvF
        iKMC4xKdahvJvgpduSI5XI0=
X-Google-Smtp-Source: ABdhPJzzr58B0gbR4UpjbCunENpo2Bl0uHmKEBGheR6tULQdmKdmZ/eQz9KOEaH7BFLvpN2SKKXjMA==
X-Received: by 2002:a05:600c:ce:: with SMTP id u14mr27169163wmm.137.1600625309982;
        Sun, 20 Sep 2020 11:08:29 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:29 -0700 (PDT)
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
Subject: [PATCH v3 15/19] arm64: dts: allwinner: a64: Add HDMI audio to Pine64
Date:   Sun, 20 Sep 2020 20:07:54 +0200
Message-Id: <20200920180758.592217-16-peron.clem@gmail.com>
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

Enable HDMI audio on Pine64.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 329cf276561e..b54b02e59085 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -99,6 +99,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -107,6 +111,10 @@ &i2c1_pins {
 	bias-pull-up;
 };
 
+&i2s2 {
+	status = "okay";
+};
+
 &mdio {
 	ext_rmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

