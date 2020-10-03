Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9422824A7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgJCOU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgJCOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E561C0613E8;
        Sat,  3 Oct 2020 07:20:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so4845496wrp.8;
        Sat, 03 Oct 2020 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
        b=P/zauoV3UnYTl9IFk5G7J+shBsL1VKfGUfuvwhKM5qXdyOoTdM0ivqT+4r5Keu9jwq
         J5cvAqMRRn6aHfjIxxHsOBNDAFdPDplnOqJ+zmZxCToFzK9qzLUk6nUXR1QU7XIaUrQR
         cqQLPJ+dIo5Mk+Holg0qxLMJb0fyjcjFo9AVu6ctPfEjDRRqbWVitvl+bi/k0xxlxzxY
         gJQKSEDtVE5NXh6z5f/D39hj8Ek+m3X8oyyjBgA6Jw2g3yMw3ExlnfJUjHuZ0oWyrY0p
         4xIHUGRCIb9Or65CQ3ppCbkBqqRNaeuxDIreQC418hjCKS5ImvSq+hfGLoDazW3F4+ch
         QOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
        b=M4UQJDZacNUnutidWpirNILTjD3rSs0n86MWzhM9L38Hi6bYMjDc7o5AYvPXnveELv
         Eiqp5H3gXLOStANU+iHjuy3xcgeY9GBbXN2XWoEzbxXnDdtbdK3LmVRkQfRZSYcaxhua
         RUIjq92mnBf4ESB8ddMcB5edAqGVu6T2lXa4nADxVqBu7id23yeq9mFu3ZUKkblb7w8i
         YdFIL82SEg7kVn/+fvrafum7IHXCTikSy7lLMUrdypcMzLs1tORXW96I3uTmno6lQHal
         CL2DO07FtbGGZSGx4PyLoG+CYiMx4k8+NZVFEJAOmetkZOFEeSHFIFceQzIxNm0xfdiH
         GS4w==
X-Gm-Message-State: AOAM532Blda2hMRKtriwZAIqF+VlboGl2i6vaTnyw1u0Sn6SHOfEHOM4
        eEgK6Fp3dT4pmI5azcQMU94=
X-Google-Smtp-Source: ABdhPJzB6w8DsX08x6bzm4aOWIoCI26CAmWBZJm1FYCvLH8M4NS6Lv4C0xV5G4645Vl2S/E7KTT5JA==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr8427739wrq.59.1601734813670;
        Sat, 03 Oct 2020 07:20:13 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:12 -0700 (PDT)
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
Subject: [PATCH v6 09/14] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Sat,  3 Oct 2020 16:19:45 +0200
Message-Id: <20201003141950.455829-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
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

