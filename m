Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4352720EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgIUK16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgIUK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A3C0613D3;
        Mon, 21 Sep 2020 03:27:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so12137389wrn.10;
        Mon, 21 Sep 2020 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
        b=f7TSlv3Zki9LVbtvu9NTG3s0n6hpuVnFM4+BDV1KEd+sdjo0/0RIPme/6ti1gx6khV
         DzTa1eRKRHfldjY21P8bYwuO1QyW4Msnmk6zxA/NWGd1keNd8nfDeDL93cXk3jPDmDVW
         duxZ5dXVHcn4IyOQlQ+4WUVj1UxdK3lWj2WKYyu84zSn8zZE9VQUM5n3YOa+N6jvPr4R
         DNIkDdugvM9ta8xIWyCq9kivXj/Ga19PAc9rgCh46UvBCxXIYaKbMzPjViGyevQEgVSq
         K/eh9qn69H8FHONI9nH9+tanPIpG2bC9FWE5/1NHcVPfC0Z3rMKjVjBHrNQ42iHDs+pi
         8mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
        b=mBygFitxnVEis6rdehxHD20BILjPajnJyqADw3MkC04zPH8kmnVfM6LwL9xWSxswP7
         mzhX9vKFRTzJBjEOD75EUQxOdjQuvFCq63gP2kVeHbCizQ//j1/sn4zeDCnWpGPaNrxh
         NywA3QjVezrxJu7TSbJYCGYiwEDBiA48KzogxX4mtaIODcwPNOMKm8hjLjHa9AB2h5Jn
         0pWES5SSBKY7tU6Q5KDVVGnDxPZQJSazTx4OlDHQ5KHo1m5s0UU6FlpmaVY1MFyfm+gi
         p6L1fGC8e+qa4MayyG9UJDymnw0KHIF3PsG2LLOosjIzpLJx4a5kOfsi4WZd0XL4zP+l
         xvfA==
X-Gm-Message-State: AOAM5317wCzrwyR2MqbsINSPf576xuaqOlrwj56QkdpCZ/viP8YCUJ84
        zhkipivZnilkH3l7kPH2PCE=
X-Google-Smtp-Source: ABdhPJya/DfIfX42lmgcaaMFvDOf6VbMI/5f6dCC2Jc+wM8fb/BSa4GzprNf9ummrrBnFz+joK74qw==
X-Received: by 2002:a5d:6049:: with SMTP id j9mr47888141wrt.295.1600684068018;
        Mon, 21 Sep 2020 03:27:48 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:47 -0700 (PDT)
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
Subject: [PATCH v4 10/22] arm64: dts: allwinner: h6: Enable HDMI sound for Beelink GS1
Date:   Mon, 21 Sep 2020 12:27:19 +0200
Message-Id: <20200921102731.747736-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
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

