Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19AD2DB76F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgLPABX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgLOX6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:58:09 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5390EC06179C;
        Tue, 15 Dec 2020 15:57:29 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t30so3459540wrb.0;
        Tue, 15 Dec 2020 15:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TciKQua1Ll9RQvAhc3Pu3lYA4PKfRl1aCeFwNLnQOrU=;
        b=CQpphjHVGsUumCwFF8HB7mDqCrmu+QPfKA9AfwTy1xfXl/iwcO1c9oAchGL4VIz537
         Wgw7ypZgH2k5ansowzl23Rx4whso2pfHEyVI51vVme6NqbDYpBN4v9cx/E4mjcJtqsdI
         jxfuEHD38Ic1K1wOsuqUhy9Dnbn8WIZdz/uk65+g0UtXZqBweETtbTfnke6v437aFXyb
         uZXtUh4ibF0kRcH9k5oKW+eEGg3wIAWI5pl6iQwAidvpiWtRiwjjt3HLb1ssFDDo2WMi
         vTRD9nU474w/SPcUXYGd2F3TIilhxQngrRAlEsRPBCrmyNyi0pGYDnIZouF7nTFqODhl
         t4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TciKQua1Ll9RQvAhc3Pu3lYA4PKfRl1aCeFwNLnQOrU=;
        b=GOGfLWvMS1BFghTIz3g/G84SnUJTwZE3b0Hv6/85h7fAmORvwkhyqQh8gGLDm1cOXG
         OTY55vY9fpsw3aAB5IHSVShFHBasyP1IbR919E8LUfN0juSz4FAEl3anBkvqGntm3yP5
         IP5zN4yw4qipZGvaZB9rL8POYxERKrxq9rYnRpVnzlJZZg7b8UWNc/msBnNPP2ySp1pg
         QD3Sb2A9DawspL+k4h3n/JOH3n2yFQcj8fFNUgtR5mSysTw2jdIO25LtRK0Lw8pnYHkY
         Aj8oo0dE9/ErIansCnEgB/9HCa/5KLMVEJcNKlzaYYIeoQUovah40gfzUf+YmxM2eJCE
         dTHQ==
X-Gm-Message-State: AOAM5312JAuKHRZDAjuJGaWH4BvMdcrC8Bw0DcNQxkb5pTveDL/CIyYH
        e/BWASTGSOWvCxstRbu5loU=
X-Google-Smtp-Source: ABdhPJxMdpWzM6SRfps3iMZSitaSDdNZDp8FYn/PxkHZ5S2BgDjZ3kIfiQbQcqZPHUpQCscJy29E0g==
X-Received: by 2002:a5d:6106:: with SMTP id v6mr34967373wrt.173.1608076648116;
        Tue, 15 Dec 2020 15:57:28 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id c10sm204160wrb.92.2020.12.15.15.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:57:27 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 4/7] regulator: dt-bindings: pf8x00: remove nxp,ilim-ma property
Date:   Wed, 16 Dec 2020 00:56:36 +0100
Message-Id: <20201215235639.31516-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215235639.31516-1-adrien.grassein@gmail.com>
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property seems useless because we can use the
regulator-max-microamp generic property to do the same
and using generic code.

The only things it changes is the default value. The original
code was using "2100" (mA) as default one, but I think we should
keep the value in the OTP memory as the default one. This value
is automatically loaded in the register by the chip.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../bindings/regulator/nxp,pf8x00-regulator.yaml    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index 1da724c6e2ba..b6ea3b8eb811 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -45,19 +45,6 @@ properties:
           Properties for single BUCK regulator.
 
         properties:
-          nxp,ilim-ma:
-            $ref: "/schemas/types.yaml#/definitions/uint32"
-            minimum: 2100
-            maximum: 4500
-            description:
-              BUCK regulators current limit in mA.
-
-              Listed current limits in mA are,
-              2100 (default)
-              2600
-              3000
-              4500
-
           nxp,phase-shift:
             $ref: "/schemas/types.yaml#/definitions/uint32"
             minimum: 0
-- 
2.20.1

