Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110BD2716C4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgITSJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgITSI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9555C0613D0;
        Sun, 20 Sep 2020 11:08:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d4so9965276wmd.5;
        Sun, 20 Sep 2020 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
        b=nAGJogiMQGjo9YZAHft0GpvtGurKMbuQTXDDJfJ2PQs2ccDP3wGSz3v9Gb94E0knTi
         1NbB0txtdgeSTIPzIRro3B3bviuEwLCxohz/3H4GP/B8iIZxpzL6/o6vy2uldACntNZx
         OUBQfx2T340IawIdG00VKquSvi1T5kExWaur9/R9a7X74rabGayD+WHLF5HIgIJKH35E
         STc5fCAs8cVpvHmXTyhLWjDcgdzh58TbOIOuGP4CKrxrAJgC4EnH4t9WWhs2y+atPQL6
         5xfnbp1JcUD/SbnqcKpoTkj0GAF3Sl7AC+yevO3jZmd27ngFJmOlfVhSGI2PvJpB3yIi
         kjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
        b=F5aakYLq8Hgyf436VhQz/pP3M0/5UKtpEhp9j1hLJjNRL+MU5A+SCB9xl5Pjh24ioT
         qgNNnlXroDhtnqrJoRvXsDja+4Zy73ks5015p384CFOAbupL675oCSV74AILxYQGIQ8T
         zzDSBhj1FARLv6vyjWajoVxX1XqmiHccvNZ4hwwFuM10XV7idApELF8GU0KlMDpIxa9O
         n/wonz3GzMieUA+KHEQrS/QNgymOQ1JCm5WFjo1rimr6aKSK9/Fq5CbmvUBUzexT8b8W
         APC+YfXH1X7SQEOH8ZmHichkiannKvrFEsF5a6GKzwWE0tbiKJngdw5ron9z4yraI1oX
         wiiQ==
X-Gm-Message-State: AOAM533hc+Qnf9KNtTDwJUB9KAa4ummFP63IdtQJHixmbnNuY0splFN9
        kVc/897Ufy0CiQmahspwzS8v/fVaLRlaEdet
X-Google-Smtp-Source: ABdhPJzuEXxGi+iH0uFwm4f8P1YRMnMIJ+tqW1wXaiWWppRY9NHT0o0Ylxfb/0d7GQj8AWidYkxRFg==
X-Received: by 2002:a1c:f208:: with SMTP id s8mr27082024wmc.85.1600625307570;
        Sun, 20 Sep 2020 11:08:27 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:26 -0700 (PDT)
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
Subject: [PATCH v3 14/19] arm: sun8i: h3: Add HDMI audio to Beelink X2
Date:   Sun, 20 Sep 2020 20:07:53 +0200
Message-Id: <20200920180758.592217-15-peron.clem@gmail.com>
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

Enable HDMI audio on the Beelink X2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 45a24441ff18..f9bec6935120 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -142,6 +142,14 @@ hdmi_out_con: endpoint {
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
 	linux,rc-map-name = "rc-tanix-tx3mini";
 	pinctrl-names = "default";
-- 
2.25.1

