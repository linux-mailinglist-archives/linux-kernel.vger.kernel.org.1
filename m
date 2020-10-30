Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67C52A0845
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgJ3Oro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgJ3Ori (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:38 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E2EC0613D2;
        Fri, 30 Oct 2020 07:47:38 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id f37so5728619otf.12;
        Fri, 30 Oct 2020 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lryb+OP/I/Ms7egySRuAjr25d3wKcdnJ3fbOd1ZGv1M=;
        b=TyBDGJ3wIylb4gjlBDCtDtpfP+nJ9PmgmGbLZ3Dm2jAdxrwElvjrd+tFDAnXq4oqde
         huO6S08fJ6TysELD2fXV5zwyVIWZIxCPY2ouO0Qn3YXaWWXJr9Wc8l/ADvFNnKouDhue
         ivafVtR0gqzjl9DwS8zd2fB0J/z4Ne52OsYn6taeFk7KlrJcDZLkZO6fuO5+XiBRRsjJ
         1XddmUpBqrzgRwjiaBGI06A11Wa57MrTimVbOvsZmm8D1MNPuhcynjxI/GD5T33vuy2z
         iwuRn35R4S8dxT3gCuZQTbant7/D40rAuv+/ve60CuV6zrmvuYsoOkfqp7QzwDjIV3dX
         6J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lryb+OP/I/Ms7egySRuAjr25d3wKcdnJ3fbOd1ZGv1M=;
        b=tu06+K7yrCQ0gaUKNMTdYDVh8Caw5KyDGM7Ru6dhAf0iE+KWYjZmv3UuWolzr+LeIw
         Dm+rPrYc3rl0ByA22hcNJbcCr5bQrjt/A4am2sE4xP4WV8yDhN/4prMuIo0ekJ5HZgmx
         VTTni2TlERW6M+OB8poQS8MiWjFGpf8nsskt+tpQW8wLpJr+5DceoXGjUUtYmaWsrSFp
         +2T7Z5BW2A6sWlVyTyF/J4uCrGNsaEFm8VFK+7GS4YvRluW8ThrFwTe/unPSjtU+Yr0R
         ba7xnW2H4UiCyUvaYgYVc5ltPwW0tLbXiB2puYAf5X2wIZVLUd4eZyc0WuBU2y/Odruk
         5E+Q==
X-Gm-Message-State: AOAM533TMjfcZ8SLQfmZIm5bDPH33nJbPHgcRHktoY4Sg6vVSO0DS3XC
        UapTXPgkF5S7a8mSLhNaPjo=
X-Google-Smtp-Source: ABdhPJx/zMztCtP29RQZq2MUgF2cChnQA8L4sJ0hBJ9oMvypsiYMDKoZgstrh1rIdiCERnuM0cnt0g==
X-Received: by 2002:a05:6830:154d:: with SMTP id l13mr2074653otp.61.1604069257953;
        Fri, 30 Oct 2020 07:47:37 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:37 -0700 (PDT)
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
Subject: [PATCH v10 14/15] dt-bindings: sound: sun4i-i2s: Document H3 with missing RX channel possibility
Date:   Fri, 30 Oct 2020 15:46:47 +0100
Message-Id: <20201030144648.397824-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like A83T the Allwinner H3 doesn't have the DMA reception available for
some audio interfaces.

As it's already documented for A83T convert this to an enum and add the H3
interface.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 606ad2d884a8..a16e37b01e1d 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -70,7 +70,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: allwinner,sun8i-a83t-i2s
+            enum:
+              - allwinner,sun8i-a83t-i2s
+              - allwinner,sun8i-h3-i2s
 
     then:
       properties:
-- 
2.25.1

