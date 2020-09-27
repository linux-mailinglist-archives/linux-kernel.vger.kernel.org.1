Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C168F27A2A9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgI0T3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgI0T3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B327DC0613D7;
        Sun, 27 Sep 2020 12:29:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so4399213wmi.1;
        Sun, 27 Sep 2020 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
        b=WuSM27ihaY7HvK2d2jBbe8/5M6vGm4KLG4Ix/Tru69x7t4pNz83yNOd9vreTdOqWAK
         V61OQsNGlsVPePxpPM5ysIZSglxgADvF0EDAJqhME+KvZLA0wBsUxpEZTSVv4+9qtOjS
         w+9xmT5szD1SZ0updA+1F5x9+PJk4GfTc9BzHRgTwXpxclppGupLuGJm34fwfiyM1Yy/
         MPA/Hn8fsL4Sy0cS6k6zL0IvapMRHPlLnvpMPLi3Lx0bZ1QC8Ngk0c7ndbAHAXGfqlXm
         dNraa+h3+AExmcLQfsFiB+T1Wo5v6rgJvani4PEk3RZtgYw7HG96TTGDgCAEAuLHiGhX
         Aitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
        b=n19i2/yTfLFWNUzlJQ36zcXQHwRrRhVeKCorFS9jobd2HLocULTYQJTQk8JT1BpFAI
         BT9+zxOxzwUrpIfpKiopLQKCi/5Na781hVUZ4L5Kw0EGGKonNlV7No7sIrr5Hge1EK+w
         RHArx4t4bwEXCoEVkO/+JencukhikdpeWqtok8ZWY+CHqJtvOkR4iSqh9ANApHlrxneG
         uW7e57jH50CFnDlrg739CVpGumaa/I3wS78RsRjy79BXF/W/eHft3nMTHa99UG8js8xw
         ZIlcWGjNwROUBeJvxzJE7VFz4nEuD6RfW50InjIQlePJdTDPwMy/I3TfzAP8OFpxKd7X
         2/DA==
X-Gm-Message-State: AOAM530Qq37BWNlM2xJVBdCkkB3KrFQ4IHAgIrU+ajAbzuT2sqSkl5QT
        ALl0WT6bzx3qmnXCOtY3Tme9hSUYPYZTAw==
X-Google-Smtp-Source: ABdhPJyURiLf4YlSa3Qa75suU5D4nme65ur4OltvA877EE1WX/lOUjgff/+olLYacFgpFL3o/xgK/Q==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr7930499wmi.37.1601234972334;
        Sun, 27 Sep 2020 12:29:32 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:31 -0700 (PDT)
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
Subject: [PATCH v5 13/20] arm: sun8i: h3: Add HDMI audio to Orange Pi 2
Date:   Sun, 27 Sep 2020 21:29:05 +0200
Message-Id: <20200927192912.46323-14-peron.clem@gmail.com>
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

