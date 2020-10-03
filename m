Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CC2824AA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgJCOUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJCOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4B5C0613E7;
        Sat,  3 Oct 2020 07:20:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so4839924wrl.12;
        Sat, 03 Oct 2020 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Vn8gNOh/wKA2WvgMpjGgWUJ9E+Y38DnT8eZowhn/64=;
        b=jzcP/LY1R4mKytFaahWdEO6Vk5jcLb0n2gUt9PHon2fNj+pnpnm74kL/WiSwQsSrba
         XyTs7Ehty/ez/LZibzv1ie3AYf2SiJKRmlZC2Crj7wkX+IZiEPYntYrk9zhql4N4ogWJ
         kxtDpjD1iP2Do0P7C0xVjWq2kchkCNgagaVmsmFG4VPOI2N589R3HCPOSy3BO8QNj13/
         GfK4+o2Q5eX5z+AfuUGXppBCnU+pk15TzqOIAU5tCnmhYpCP9xnCzyjroSTsoiZlzTiS
         s70Ck4xa5/EPODDcfA1sHsVSkk6TYrCGJKsRxTWhjQK0nLzAU+tGyblybAAhq5E8n1wC
         1mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Vn8gNOh/wKA2WvgMpjGgWUJ9E+Y38DnT8eZowhn/64=;
        b=APfWWSyMTDVf7HeAaRi37FNJ7mDFxR+/Aci090r4eTLVFCvVVgVb8Qm1NSnuuVBdDq
         f3O3eFqvC1OAYQpuqAE6v/phMf0dN+AJK+NJAE0y2uOT0JEHUphRCSKXJJtacO5HaeEF
         prEP0qxvtrnTIsMsipbtbV/1hUx53yS0xE3CmaMckr3LNifBQPaQjeVkWvhtQFax6Mts
         vyLCwigO//IQWsuHshzwpd8tPdOCaV1R/Hj45cv2sk9UwQZeKoim6bKafNHM8xozDRAZ
         rOcirZkX1AGJz8LFzIoGq4KzPP02GSMWKCMo6/ddP05+Ws5v0ymK66V1a+bld73tR+d3
         KVWA==
X-Gm-Message-State: AOAM5322QMBcjaQmJAHXqHTxUnYfEKt3jznKCip49NtS/dEsIqA2Q5aY
        fHCbdX/0i0rA2NYOV5sxp9I=
X-Google-Smtp-Source: ABdhPJwJa1+mT6bz1Ov2s+1Epz4l4uZlYboSwoCWZZWSW6DUoHBJkmfjtIlC79fVHVIPgJfbrgvYOA==
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr8103039wrg.335.1601734822080;
        Sat, 03 Oct 2020 07:20:22 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:21 -0700 (PDT)
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
Subject: [PATCH v6 13/14] dt-bindings: sound: sun4i-i2s: Document H3 with missing RX channel possibility
Date:   Sat,  3 Oct 2020 16:19:49 +0200
Message-Id: <20201003141950.455829-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
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

