Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B022995D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790910AbgJZSxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:53:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42777 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790541AbgJZSw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id j7so13866309wrt.9;
        Mon, 26 Oct 2020 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lryb+OP/I/Ms7egySRuAjr25d3wKcdnJ3fbOd1ZGv1M=;
        b=mY8aroLSz1nGeSrxTnx4Sme9Ni+bW451qsuOiXSkc24mpKnaIx7sbNAOq8L+/XsdGC
         avDTaXB96y8l3eO8DMVKu/o1Ey5ry7zZ/bdt3gr+06tix6M9L8kMJ5ySpnw2buWKbNYd
         YGmne1cE5QISH5mQcRwV+0Z19VJ6fDomD3HiTB0kXd0fl+IHlmHXRsXWo0aBj/ueVzfn
         lum3gxVPEzy746i5yfrsbJCc1AJUOTRuet4tj8CzekBS31XeGQ7GlzqYqzVp/15xgh4X
         bxDZ5KWf6K+WddQqEa2EzeV8pVvwqY343L+UFFcv9ow3Yag6SBAh7FVLkE76ObcyjWRg
         H80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lryb+OP/I/Ms7egySRuAjr25d3wKcdnJ3fbOd1ZGv1M=;
        b=WGlq9y2q/ZVPlz+lRjrNX964yIbVQaOodIJ4o9k5gELT68kEU0eztXlejLgLFsz1pD
         E13QhjD38/yFVPjD/w63RHmitZphOUysS8HaQ3SV9zUeZi8cI8b6hke5EaHPSKgWBP92
         Q5ZL+OqsGyoB/BrpP6oGttAyVUWL9PlNrV7Lb58NaC8jqwow44JEx9F414hXWsMByyKc
         8icKH7Vh3QdKS6BshoR5wUhMys08R7OD5qwRQG85bz9bmGFB79ZkMw5MoEN+0wl/YKkI
         UdD65xEudgJRLZBjeRNlVDO1EwjeWIzDiG3/wW0WRwlabfso9j02PaqDKDCsIsSx+H4e
         Tq8A==
X-Gm-Message-State: AOAM5317muYgQXY7Qw+y5OLEAWLxS++pE/aqp1WP3t/T58gSlJXLq9FB
        bZkKq59VTkaxZt1wTvVoAqn1GsVBvlc6UA==
X-Google-Smtp-Source: ABdhPJwEG7gDFVW6v4Is0z5snwiPucvy5DMtgCJWZospVdAskQyaVJFTeCV2jan1tgP2/IFBf9IBWA==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr20391118wro.326.1603738377924;
        Mon, 26 Oct 2020 11:52:57 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:57 -0700 (PDT)
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
Subject: [PATCH v8 13/14] dt-bindings: sound: sun4i-i2s: Document H3 with missing RX channel possibility
Date:   Mon, 26 Oct 2020 19:52:38 +0100
Message-Id: <20201026185239.379417-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
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

