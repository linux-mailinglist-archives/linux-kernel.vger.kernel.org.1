Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1036E27A2C0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgI0Tac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgI0T3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8384C0613D5;
        Sun, 27 Sep 2020 12:29:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so4609895wmb.4;
        Sun, 27 Sep 2020 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
        b=gei0Cili4R4kTLkWnNRS5LS1Snz1H99u64OKPgiJCVtJPbMwQl9pR6qWMTQsaH/PgC
         1rGHjXmIksEg5lBqJ585jkMIMz6Q2pGWdILg8YfcO5MduEXLdTee3gEfmTy8K74Z5aRv
         O68KaYgYFDHfQNx1ycz6Gu+WL+QCbinnvI64ODJUJ6EliM+gywZwSw0RJenpf8VAgK6T
         hylQp5/09retHIeeoctImxzV3MfS3wDQwjvlQEI22CdCpMJw8cklaa1Q58CYwNomcQpd
         7/O7bF3stvBN+WpRoZuiqvG8M62hqt2NYprUPr/ojYk6Jm2KGuwq0vp8R+0n0ysmZPbR
         osIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
        b=KUwZuYbBRyz62/m3d+4aTxc6f5gkS2ZFBsLw2aZ2C6McbGJQuXVGd2IBB4HPwg/Osy
         AM8dqArS85zWlF6efKMrg8DwGrJV9j4/HXtfcejBZPvJWTCCboXg7/dagEmSqIpk/O+X
         0C/7WuhBBK41AP6o5NJww7YjoCi0/eq5J7MtZI675NwnyvUBSsPyimZpOQTqOm7Zltc+
         my70NnN6JNQn6LOIW3xTNK6G2kVo2LLs4SsPBp4H6xUg8eqgFptWUZVEV0ldvXaLWBKk
         N1tAADKY5ROzGMPd4euZG9oKTO+qF8d/lGE8QLY/Puej8Uu4LUZGn2ChDgZKKEp6ShGR
         j1lQ==
X-Gm-Message-State: AOAM532CitIOrAFxlU0kXYPNl2JLvP7xbY7JnBSM4mNxDC+TupNkAjp1
        UTqRfBkrgzgkW0OywDzJvKs=
X-Google-Smtp-Source: ABdhPJzL20IuSoEos5Hr/m63YoY7P83YNnDH8cnMV0uhx/ViCSshnGfScEiigkftVS0N2E/abt+i4Q==
X-Received: by 2002:a1c:9a10:: with SMTP id c16mr7591922wme.96.1601234962423;
        Sun, 27 Sep 2020 12:29:22 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:21 -0700 (PDT)
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
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 04/20] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Sun, 27 Sep 2020 21:28:56 +0200
Message-Id: <20200927192912.46323-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 I2S is very similar to H3, except that it supports up to 16 channels
and thus few registers have fields on different position.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 112ae00d63c1..606ad2d884a8 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-i2s
           - const: allwinner,sun8i-h3-i2s
+      - const: allwinner,sun50i-h6-i2s
 
   reg:
     maxItems: 1
@@ -59,6 +60,7 @@ allOf:
               - allwinner,sun8i-a83t-i2s
               - allwinner,sun8i-h3-i2s
               - allwinner,sun50i-a64-codec-i2s
+              - allwinner,sun50i-h6-i2s
 
     then:
       required:
-- 
2.25.1

