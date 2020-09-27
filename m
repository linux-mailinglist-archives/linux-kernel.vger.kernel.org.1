Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9124227A2A0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgI0T3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI0T3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E1CC0613D4;
        Sun, 27 Sep 2020 12:29:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so9529232wrx.7;
        Sun, 27 Sep 2020 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7kdiKWYhgrXc/dLuy4QmJOJzV5nCR1FMn7KxcL86B2g=;
        b=F6ph8XTb6Jv9FXVYW3glwPA1tIKm8quNpkWf2VOxD1VYzAHBr04NauORR/BY7R90LP
         eEnXgCgWnveW7V5bj8IcbfmBZouffSA38AOLzdbpxg0YdpLFo+BlpWsBpsSCIonaByw0
         brQKxBy3nstw+oiHpawAlRKwiWLlI6F79Cg9pYrTaADg+ZrkEyUD6KwCJCD0JHbpyBMn
         hQPDOUXhyz5OXj3Xel9LuiqeWG9HK8F9yKMLFyf2KtKr8UoPxSo8CweUSrAcKnLVcV/o
         MTZQJe1KJlYdFSrct1B5ImwK50np+sSaSI+xliBNTn4gnipgMfSGH6Nw1NPLgEov0Rts
         H4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kdiKWYhgrXc/dLuy4QmJOJzV5nCR1FMn7KxcL86B2g=;
        b=r+GfJXY+BfQPzz4MPPXlvDc6LMHdu9B6WS9dkEl69ZWw8fHr/tAJookC3gCqDCVknv
         fJqz/l0Kel/A0sf9p5fE3VcP4DyFLnqGEinDYHSXvkTXDkw0Oib+mji8MnyeOO99+UEd
         2pLZPzZckyunpfYGhzBAJax4I6BETfVc03Iv6UIqo+DtC05RpxHeXOxISC1Qc/zTdK7l
         QiTYsxmCWGobTepZqSWLnBC7M/xSajF15UmEQH03nDgPHQnZ3c0oLuRevqSi1pcH+zwx
         YGNFKQ5JS6wyRb/C6GQ5QKmFWQtwdmWwYNLT0vFVov+fCrsfRiKtjppOTsr/9xjcEoUS
         aJjQ==
X-Gm-Message-State: AOAM532uvwMg65Ce45b0fIcBFIwQc5ur2wlymFMlF1OoKYH/0XVuBhlj
        LDr7x9JGMHElfTWeGjgXqPk=
X-Google-Smtp-Source: ABdhPJyyCzYnZGSwRmOTXmFhk6QYvJY31J6KYXHkVdCv7BuScwP2uXyucdfc7nly/WI1HgtWtMG+uw==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr15666769wru.10.1601234975687;
        Sun, 27 Sep 2020 12:29:35 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:35 -0700 (PDT)
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
Subject: [PATCH v5 16/20] arm64: dts: allwinner: Enable HDMI audio on Orange Pi PC 2
Date:   Sun, 27 Sep 2020 21:29:08 +0200
Message-Id: <20200927192912.46323-17-peron.clem@gmail.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 7d7aad18f078..e6ed8774a17f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
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

