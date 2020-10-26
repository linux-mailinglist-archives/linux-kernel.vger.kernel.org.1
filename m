Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E722995DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790954AbgJZSxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:53:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55310 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790526AbgJZSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id a72so12732533wme.5;
        Mon, 26 Oct 2020 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
        b=uBXDPovOBMFZVFMyi0ecnyb7gJHKEa3Y3Pg+Eii0aAU5BShE9k08HtG7/c9C+TFRHi
         fnfGwvw0D2KJ7aI+fTnroNOkyGXBBNLuzhIu0R60c0if/dTK4v0BmBH/mcQnKzafs8UJ
         pHp9ccXYpc+GhX++zeZYvY1iLs/DrgaVuqD1sGnexx6lUfGJVY9/bBupxLOTOx9s80Gk
         ARZPUiQSvZZGio9kDWoxdEEnotFLM+7zm8kbfcbcMM4FkJ3xxROPpbW5ZGCBd1j7bFWh
         X2vYjj0j7FoU4jbj+XPpSw8bICZICZSNVU3sYx5plZywhvmc60k847pOaFqO7BzgwG44
         qKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
        b=E+mh9Rt//TJCE2FvLMXTavhFljP9a+ldtod1BsVr5TNSm9Olgf8IdReMY91GBU0hzA
         6gaMrt1fSSEEkeHTOFk2n8gyjrfpzsgWzHkr1s38jrFw3JOINyZCpLYPQpjQ2+x4pyHn
         ZerVCKn7zrfZyGJaNF5qki95IwxQGcv1Ezn+tEbrObPv6hMDbOuu5BgS2daOBXFAzDK7
         tixY+PtINuY4Neypdgt/05lF5XWs1y/Y2kjvlJl6uxr/F8h7KEa/knpY0EHqhyiRCjz7
         PQjQwzY2h3V+/metiQtze/9Td/z7nIiIxAmJzVrEp3VVU7F7EOkJc2F1xO20+ow4tUCj
         B2NQ==
X-Gm-Message-State: AOAM530t998UFX212lGcNL/IEtDJYkffV67ze8NqlP3ZtXrFokWobXNG
        XV1ZNiYZldOjMI+0thCTQaQ=
X-Google-Smtp-Source: ABdhPJy7j+KMA/VXg7iUDvdY7i2s3it0/Wo2TIqkY/QePxE7/b2ra4Owlarv8r/RVj14DNs1rp1Nug==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr16706454wms.182.1603738373249;
        Mon, 26 Oct 2020 11:52:53 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:52 -0700 (PDT)
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
        linux-sunxi@googlegroups.com, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v8 09/14] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Mon, 26 Oct 2020 19:52:34 +0100
Message-Id: <20201026185239.379417-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
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
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
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

