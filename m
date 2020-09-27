Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B39127A2A1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI0T3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgI0T3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFA9C0613D3;
        Sun, 27 Sep 2020 12:29:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so4378232wmh.4;
        Sun, 27 Sep 2020 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZhYwaoUjzd/wEdIR2SZMGyqDMCzyDmEzzuRB3l0wN4=;
        b=BTvsFbJmBED9nWWFx0ySyEfb1ek2Lk+a2RoS+gWg+3xw8sD3JEgL0GgtQjZeGmVUOc
         DWM1C0N/ZoxPbw+FwNOb9JCEx3jP5cEO/eC/maZPLG7eBgGGBngVaOoIug4LFiaQp760
         sfUdzB3WQk03K2iVs+JADPUFO3Rcx3bNV1i4Og+NeewSxdaycKCfHTndcyag/3EJUHOA
         PbsZW0PmaRvM2a37Az7bPf30z8K5EkHAfZvWJ2HpKI+lkClZqvIll7rMAWmeWLikhw4P
         HATjfrZsgNynX90bCbYvga2B+JLvTR6e1V68dxRv/QxlH/AeyIyrYRCDfo5zuZxeEVpJ
         SMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZhYwaoUjzd/wEdIR2SZMGyqDMCzyDmEzzuRB3l0wN4=;
        b=IrsEjXQIuuwyB79ycdUxd1Q2xqYl/naAf/HvL2gy7RYg5/WS6rPr+huN1yC28A8KuX
         7NRL0c2mvt2h4BeJW9uZ47twnTpkuu8BdYuBgH1TXCObefXWfLRxHXM9KxSioeJx1owl
         9641K627liXgYEzc148KZa85WEMWbs9enhBnZx7m3WOioCIHAFuVCcWk+88CvMK+PJeg
         lbA5LsDtOJ3QhFljRffPlDUgAbxaq0hTVm5z4naGZxyCYJEGurAd1+sLJgISW342aVUi
         oe3gSZMDaELr+hYY9tBXa1TE/iJrOx/Qy1BkyghYLGq/MK7IZk972AHxLP1Fge2mFiPY
         BXTw==
X-Gm-Message-State: AOAM532D/ORoTHzagAkawPRRjpRkr/mCdh50aMj3hsh6AXEhGTRukTS7
        AGll0BmM4K/tb3R8qs78dww=
X-Google-Smtp-Source: ABdhPJwCdIQR98e1axxF8yYJ0f+R6ecrEmDf4R2AGdjdcLpkVOow5lcdLgZ30NtEJrSCvDX/+bjH4Q==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr7842009wmj.19.1601234974395;
        Sun, 27 Sep 2020 12:29:34 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:33 -0700 (PDT)
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
Subject: [PATCH v5 15/20] arm64: dts: allwinner: a64: Add HDMI audio to Pine64
Date:   Sun, 27 Sep 2020 21:29:07 +0200
Message-Id: <20200927192912.46323-16-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
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

