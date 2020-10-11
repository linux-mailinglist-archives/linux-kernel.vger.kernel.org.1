Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C028AA43
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgJKUXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgJKUW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:22:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2948CC0613CE;
        Sun, 11 Oct 2020 13:22:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f21so3197955qko.5;
        Sun, 11 Oct 2020 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
        b=f3tVxWzuTZPM69wGJy32/sd4H9TTipQy1StiEG6HQgLlulOLuyLEVUcmr8ttGqLIYt
         IKGsj7o92pXBr1lHUWODiBZ0fw9P54JZbaB2fpfL3nOohglPuk6UgqUJfT8zUWl1ZgVZ
         0DWWaC/1eZD1zFUZprA7ZXOPpCiLLkpXleeEgnqwxuJrP4U6BU+q/1eUiZb2Z0ulwXN/
         vKxWNPAcCCIr9NJx1zhbvb9DYKhuhTwW5kQSUDlRjNh+Q2b5wvUYyQbdhSnFIJTHGieF
         MpM1XV6VLHyquwy/vmb9k6LuulmBvxUbGkeqYxk2YdLE0qfQaQCwMqdry1vAZ1VPDbFg
         hXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
        b=DAFExP+xgJwG9PGU165r0GUYv0gYGLJxIPlji/Ic7n+I/Ts1ph9OLxRVolqrEc44Q2
         LvGbdPXk0UtyffGLL8yuJWqS8qiuvRnGEl1NrIVbYxVMOKEzBuQlSf/wawbIpqCmGbBQ
         QLhDGNFIJRaOKgy+2ATRSeRONvAJHkQfYqqZEG5956ntoyyU3hJ4jBm8txYxDv4xI1qR
         M/66aDSW/1kagFwg1ip5TAAlRgMEmNvH3f14TfONSswzp1Vjq4L58Sh2/eXHZRvMdvLq
         fNXF3f0ARhsczregu1R2IrumS+kQWiLbdsWPY4lmscgni8AnHQvc6EyX55+Oyxf+NNZa
         2jLg==
X-Gm-Message-State: AOAM532aqM+WYXOtgiPq9ko6Cbs/ArSZyHAzuKJdoyLqwx4fIl524d/8
        SiOwqZs/wlnSm9n5oZ+j9XM=
X-Google-Smtp-Source: ABdhPJzHlhqV1xCQ0Op9gkdvmwU8yERM86DpAL4NgRdRLBxtYG5F0hRVc5gwImajV4zjbtoH3PUeCg==
X-Received: by 2002:a37:a2cd:: with SMTP id l196mr6644348qke.201.1602447778306;
        Sun, 11 Oct 2020 13:22:58 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:22:57 -0700 (PDT)
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
Subject: [PATCH v7 09/14] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Sun, 11 Oct 2020 22:22:19 +0200
Message-Id: <20201011202224.47544-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
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

