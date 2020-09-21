Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA922720EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgIUK1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIUK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A271C061755;
        Mon, 21 Sep 2020 03:27:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b79so12036668wmb.4;
        Mon, 21 Sep 2020 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
        b=oMGph5JMS4IMByo7SEq/EEhqYCEJSAJWh1ORxSJdk937N8/sdqhkw4QGAVsLEGav9D
         OQFpLA3octkJqhiE8KvODqkhUj/cSYivsyKi9OqR7wqEf2miYf8SgoNuNstgFblEdovL
         rxM6CP2+VsdcY5KlAitt6Rkil21GvMA5c9JtyvpwSOWDBSNk9KC0Y9e5Rrd2aZOYwCyP
         L7E7v0KzcqsA4ttlb4JqDdWTi3WmbC+jGWmGWCbk8Db+ox+CVndkongV9gS7cPFYzJQK
         AiAjqenClWxrRUq749n4e5i4YAV3fF+wlv8aMDACpNhOk6N8HmN6GDWGDOnYAuWktxiA
         izBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
        b=Lg5Qj8UCBvNodKglpJdY1o27S0ztAjbrrF33rehZr4H0X8pxcpA3jsiQRWcDYvAtsf
         EF4bSwoFE1gTl44ZMr1UZGwjqa8yQ5OrF2lh/UR3B+0YCw5ghJi7v3czyWfSJjgXYvFp
         p7zaOzVG1ePl5luDz0r8JjpuTkXAM+DE2lEfXFWorgLukuOFwLMy+LqcReE9qG3mPhjR
         AD2AzuQf/npgAnGQQPKKKDEQSSKdyxQ65mcTGBGIs0yU3YTwmJQ1VHSh3Tzw/VpCDVNI
         +86PZoB0KYspVaGX2N6eDe4vY9M/6OL1LlqbjeANCGmIB0o5TtyZZmhOeGr/Jr9xmKyy
         oX6g==
X-Gm-Message-State: AOAM533rnQ6PJTrZN2oylaOPuIjNhQqTlWEEIBt0elicT8o/I2y4D00f
        wwTb7cQBua4SOYdiPh3IwFPn4CnwPZ5KBp1T
X-Google-Smtp-Source: ABdhPJxgV5A3pfob1xTad7/Ki6Cu/+R5MNVmZQTcenpCcuIPvax7TnEV66cdNM7NM+tYZOL/8I/gsQ==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr8080935wmj.123.1600684060840;
        Mon, 21 Sep 2020 03:27:40 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:39 -0700 (PDT)
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
Subject: [PATCH v4 04/22] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Mon, 21 Sep 2020 12:27:13 +0200
Message-Id: <20200921102731.747736-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
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

