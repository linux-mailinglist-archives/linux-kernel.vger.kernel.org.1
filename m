Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003EF27A2B2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgI0TaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgI0T3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7DC0613D3;
        Sun, 27 Sep 2020 12:29:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so4597936wmj.5;
        Sun, 27 Sep 2020 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
        b=iZyv2VLEgfXdTf101uh6h3DUe68TxHsCdp8h9PNhz+JBiBd5noYxV5hWSysw3svFrO
         3hzxseVeGw9pxlCAjvA1BEPYcTTNVp8XRSYF73HyhH/NAYotAPrd5ORkSlV3htIziMEV
         bsnAMNkOGupuZWgg++cuyQImqtV6MwB6N9Sd0RWmNtFcYWfqV3VgP2yNKOdZlPy+Nqf0
         nXuHSJBIpvQs/gztfKSdSLSxOO/cWLMnu6a9O+wf3uF8ENpQY+2OSARre3pdmy0RgC0c
         I1gzQj5z6mrTNLZvqlS2y9qNL4XvFDQ+rEawDAYMIWC9K/6G02J3NvyONDaTQlWhN5yB
         QXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
        b=H+bHvixHY2SOschUtcRKlW6IS2ezfwZ4gHCVjgDkUWiFOkVJcccyaMyxFSL5XusWL6
         E/wBgBL1YzEtjBHhnIRRDVpcC3hbhT9VSwcZIPLrLiVk+4RQxPX14uULZGdNxWDBI3KN
         hDiHtN+Ligocl2zxSj9XUjeD2Ph3xqzQHmekAbsaQf8z66rCdlAnH4SbBPUJsx+PGkiK
         Yl84y7dl/Ch0gjWRB7T9+yQMBMrfq7uQYgtWOKW53uDZ2+ss1yojXRKB1wKUjSGiplnE
         sPfPB2QYb0iT9DCMLmJYI4qWWAMUj1LJraDZgTgicgvE/9w9IDCGSLENF30H3wFW51iT
         hBOg==
X-Gm-Message-State: AOAM532JxmkZYijaNp577lmvojgmAlVuFQ+VIbxkOtfu7XWETxyeayJI
        FkiOMcLK+O2tcL1hqr4m7sM=
X-Google-Smtp-Source: ABdhPJyMfhFmZdZRNFIA7hlt5CN0yPE3ZvZ+6BZVp9QyVpTd/nn/PhNL8cZhWvAv4entdLHdnxWazA==
X-Received: by 2002:a7b:c141:: with SMTP id z1mr8285789wmi.79.1601234977829;
        Sun, 27 Sep 2020 12:29:37 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:37 -0700 (PDT)
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
        linux-sunxi@googlegroups.com, Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 18/20] arm64: dts: sun50i-h6-orangepi-3: Enable HDMI audio
Date:   Sun, 27 Sep 2020 21:29:10 +0200
Message-Id: <20200927192912.46323-19-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

The board has HDMI output, enable audio on it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 15c9dd8c4479..193587e78031 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -128,6 +128,14 @@ hdmi_out_con: endpoint {
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
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-- 
2.25.1

