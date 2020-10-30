Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F7A2A0849
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgJ3Ora (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgJ3Or1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:27 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70B0C0613D5;
        Fri, 30 Oct 2020 07:47:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j21so5718180ota.13;
        Fri, 30 Oct 2020 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
        b=Fo41DSUEVbzQPAdEL5Qtyz4z2iSNc4Le4KQFuUlEHBRFha5WMVd0X8S5hSRZDgTwiR
         UzYmACLYwUxNWcoVuRbLboW7VF1Yd0xkIENJsQ4PxQ3+xp/JpROX4OW1WHkRf4xsK+2b
         boERIt9wtvMSVMk8Y+SHluG9mtVHKNB2rVMS+z5XafLynCEKlRCSgbPgreloqUdnTC1m
         MwScAHNBy5sCmE2UwlugVIcfEagWL9tWiEKW9GZP70CL7JGXDOgRvuRD+BL1AcXA+VhB
         /X0FdXz6k6TEqIAlQOOYzSgwATtzMMj7ubIqtsrmrL/GuJliUGY+gCn205xtvnAc/zWp
         PGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
        b=YIumRTTQU2HSBf7c/szJyLz4f2g+GudZUn5hMM3spOyP033jq2BzpuitfVIHNYuviB
         Bx+qhs1WKB3kTayiwhSiCucIhuu9dmLosMuLxa1P7uL85QRCuRftpiFgYO8IkZKUt+ir
         3vqn5Q3UHsIKQ3TXpxm+9jIe05c6MXw6vbAM5EhloIVB9HK1P6P+qfignHHElrN1pD6o
         XAkVXllTNMYeh+/KCydypmHZ8CqaVkgQbdNYIpv9fD4UBxiiNa3eYtENzKGcFh5kHO29
         zEoE8Jk40KhgL9KpYg0TSpo2VO9O2TOYQeaiZYXy7ba4xN/tbqT+33aXs58/WfFJkFma
         tsaw==
X-Gm-Message-State: AOAM531rAOFn70sM5lNz2Ya6SpQpb1iTVh6HjfxP68SbOLej4CeiEEV/
        d7VfpQqf1MmHC5PxnvXwdK0=
X-Google-Smtp-Source: ABdhPJyKZ6t6HzCgn0v344wc7X+L4p2mhZJAK+1PwynZRyu/yG4kuGiR1Ckhd/jwemoqXYLH1kUSyA==
X-Received: by 2002:a9d:649:: with SMTP id 67mr1989186otn.233.1604069246097;
        Fri, 30 Oct 2020 07:47:26 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:25 -0700 (PDT)
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
Subject: [PATCH v10 10/15] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Fri, 30 Oct 2020 15:46:43 +0100
Message-Id: <20201030144648.397824-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
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

