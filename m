Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983562EFB6D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbhAHWvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbhAHWvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:51:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A9AC061793;
        Fri,  8 Jan 2021 14:50:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m5so10398830wrx.9;
        Fri, 08 Jan 2021 14:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNfTtBLIcdTbFMkk31wtAgNDzDDOmgueHCelKbYklYI=;
        b=bjlTAJZWOBYHyVIhT0A5CAmT19N2z0qXhgawBe1eNWly9S2QDd1dRm/Kk0KzUAzd69
         FLGcsNLJHKn0V0hs1bUV+luLpavtY+hIMAkpPSyN1asJhi+PqXqmFq61xizY1kkv6vcx
         kxGoMRbZQ/2Y6EIn2EMze60EIgOjWmfsdwvEPsbzdmNJI0ESE1s+oV6lIQajhx2E4/eQ
         t/hd5LfkJr8XqxVbbKLypc3+vevdPS30zAKpTbyE6EAcLYxuPKBA79cD7+5h/DB4z58q
         vb4uOvubAzCUjOiMkdqrCAnlhhfXN3xS9EPAmPj4bi3fBSFAkvel9TSDuNp61thBnrZh
         LC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNfTtBLIcdTbFMkk31wtAgNDzDDOmgueHCelKbYklYI=;
        b=IPOyB3jeFvN/JmTtDqenFfP57If/B7AgU4Pk03sdHqagdf04Etxk6FK3uwNvgoNhTH
         w3YwZvWLuTFeNP66+3Kz+9d8dLH1l7K4Lm94SgrSeEYGwPi1CVzPx6if7ueKv/EizRuK
         8yH+qBeLsuab4pjH389E8dM+8FqaOUzqsZ5KYt1f7Xt9zWy6g8jTDOG8kCkyP5nuotdz
         QAMpAB6928VqN24HefB6Hp5Ym8GgrHFBJAiAfcxh+KfVvWE4MkgI5L0//E920YKz4lH5
         mLlWotkt3XkPGcGgqDqZ50ENM6so0yyA43beGrJ3yKuaCjBKAkkmsBb6kJKVQKnD1THt
         htDg==
X-Gm-Message-State: AOAM533C2ecvx9pFdpknmXCOLBMEjNIQrZ0y3lyu5CH/zr/CsS2iEarN
        ux69C/NqM/u4KUOUFE+h3iA=
X-Google-Smtp-Source: ABdhPJwz8V38Vk02bPYrifZgSuZZPbOBBGT5Z17x1GqY9PVGwOKHY+5MMO7raJTkQeOMgzc8ImuZ/w==
X-Received: by 2002:adf:e60f:: with SMTP id p15mr5563251wrm.60.1610146253533;
        Fri, 08 Jan 2021 14:50:53 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270094076597458eade1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9407:6597:458e:ade1])
        by smtp.gmail.com with ESMTPSA id o23sm15900644wro.57.2021.01.08.14.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:50:53 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/6] regulator: dt-bindings: pf8x00: remove nxp,ilim-ma property
Date:   Fri,  8 Jan 2021 23:50:03 +0100
Message-Id: <20210108225006.153700-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108225006.153700-1-adrien.grassein@gmail.com>
References: <20210108225006.153700-1-adrien.grassein@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/nxp,pf8x00-regulator.yaml    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index 095cfdae7b67..05d5e9a2219c 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -58,19 +58,6 @@ properties:
             description:
               should be "buck1", ..., "buck7"
 
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
             default: 0
-- 
2.25.1

