Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B0127A2A2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgI0T3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgI0T3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80AFC0613CE;
        Sun, 27 Sep 2020 12:29:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e11so3036084wme.0;
        Sun, 27 Sep 2020 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
        b=hKf3qxaTjVKN4DLweISEOSGqgAW29sTg5C75FqFcWoZth2AzalZ9en0t8NWvcBDLK0
         S1L7hJblkLs8vBQjLwkwnF2oveIDWtUyLZDohZSkxcucHOU9VrYU7XBcaeikc1y/FE4w
         kaGs9b4Am42PfOfnlc9dGN9ufD87FmJCFZlF3HmGP0mWrIlq7S37thmWbOk4QdImVNMR
         nXwEyvnwZ+DDxZYCs5Q3DVfAP/MBSOs+3zBiM1L5/XMuNmrZcPfp52EdM9fFzaXWfmBo
         FOUjlPPtAmJyMmXomsulwk8cAE/D0v0vN6qINHfrbwcbQjgSj1J1KKLTgahuwzjmk0ma
         nglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
        b=MQX/j9Roe+ewjSTJmg3bAXX1pRLI6YZBENnFPo73uEBmETQFID6frq8VoYlO2NOhHo
         xJmiWYvDVuoc93WTX+FhSoWFvWtphxN821gjIwfk/1m0BDJ6p6F3Ja8d8Hy0xDm1hCtJ
         aFmYKYvP/oSjRpFjnsB5y2n76PoLkY3dovIELRzeMYCyf4YlEuBjr8+vzw/zbHCg4Ogz
         4jMO+DV0bzy+gNbYm8dNzv06w0C0oPzINgLFetQairLbvE8+RBmZbsqO4klG7L36urAo
         gC+XOq+a1VUI6d/l7s5q1JKkg3HvplqoSOclZrLsJVW1cSfq2fmKGJ07vdTDdc83npDw
         EqWA==
X-Gm-Message-State: AOAM532cZGtzJg3pk53c0TklbMJVtb4LxEiYKqi+Q+D0O+qu1+qg698v
        hfOZz/MobooZ8FrQTS1zYfI=
X-Google-Smtp-Source: ABdhPJw/QDoYhDvnvxpteGvAG0/B8IDFN19JpZcPo/KEqFbSJ+XylG/NliGSOFtjvxUpV4sYmexJZA==
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr7934660wml.59.1601234973311;
        Sun, 27 Sep 2020 12:29:33 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:32 -0700 (PDT)
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
Subject: [PATCH v5 14/20] arm: sun8i: h3: Add HDMI audio to Beelink X2
Date:   Sun, 27 Sep 2020 21:29:06 +0200
Message-Id: <20200927192912.46323-15-peron.clem@gmail.com>
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

