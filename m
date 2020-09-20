Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52842716B4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgITSI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgITSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3885C0613D3;
        Sun, 20 Sep 2020 11:08:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e11so10158315wme.0;
        Sun, 20 Sep 2020 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
        b=od8msnBteZldCebjDA0LhBvuf3owGuNVeXNmfc8zL2GnHQS7hZR0U+kvi5obx8Dq8a
         eOOF3U5APL9OcA2gGUxW4wAB7T6ZZkcqxri2nZxq18s+BtaSkBiqPjqedJy6r/spZIUL
         pkAz8YIn13puAv7TpYjMW9xBCk+mN2vHIJ9Yp9qm/3GPKy8rK2RegOH9IpHw7chDX7F/
         agkswXCDJiqfqNfoy8Kf++GcFQElzxzPBltqWl3BBCMzMxknuCPMEED+9mOiYYk/KMWh
         pkH6DaQ88kcjqIUyr88HzCrXykSicoogxw95gXYjNhVi2Jcie/spXWbTBBIE8/bK/6fU
         lxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
        b=NCWvf5iO8IG8WOAhCVGMcukWiJV4xEsq0EokG4pk5icigFYwolHA6KsNxmku/k5zD4
         F4+8rvKmYa/Gacmzeyla/7O2YzrVOpkX0b/j0hcHs9t6WCn7hwBPoRtWC89rcRzEnqlY
         i/mJVCmZYjg8yIl7gIxfFN9+NrbqEEZ6AKcKFmHXXo3d5XgpHtsI+qZRSmjEJpYbgZ8b
         5LH3ZuJ5ccf+RQdMNPtKcQoea8MF3iM7k+f2q8G/9Cl6ytLMbgwf+4NlT3CDvRYwxcHn
         haLcUyRVKJWCWGpYQa/lLKR9fNEoHWDGWlTUvA75bLXg61fn6QYJ32W6zcSKkChunFub
         P71Q==
X-Gm-Message-State: AOAM531eIN6CRSF1WJ+LrQDvd/No3M4I+USft9zClETvrPeVvLjrZkRZ
        z5oMNmZmcxRwDsCL/sCcVTU=
X-Google-Smtp-Source: ABdhPJwcGaD0crtgI3afCNwwoShmAF7R7HzisPHTeGnNrjW67KKPM9CR/iaHPhakzxHB9RZkDcIpYQ==
X-Received: by 2002:a7b:ca4a:: with SMTP id m10mr19858849wml.11.1600625299426;
        Sun, 20 Sep 2020 11:08:19 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:18 -0700 (PDT)
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
Subject: [PATCH v3 08/19] arm64: dts: allwinner: h6: Enable HDMI sound for Beelink GS1
Date:   Sun, 20 Sep 2020 20:07:47 +0200
Message-Id: <20200920180758.592217-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
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

