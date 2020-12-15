Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB05C2DB571
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgLOUvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgLOUuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:50:04 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12868C061248;
        Tue, 15 Dec 2020 12:49:05 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so21209399wrt.2;
        Tue, 15 Dec 2020 12:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wV534DfkN5sTNnT83uyHyT2KSyCvHOtYaBu2oInCf1A=;
        b=IdKJ1wQ5XETh0BTVy27pvKFZvPiyE/Xp7F7f/H7E+uE/Em+cKSUF2E/gUBIs6Kwl+P
         5vRBp7JGbaPQ4+D/EdiOuwYqsHjq2qVP8Cnyf824uo2cmPucCLS0aosLV5Orhzg0vgCa
         SU8VfDoaFkceNdmi2yz2mloAFf5CNGgE8m/R1X5vVw6Ex7YKC2Uoc2P3bsX4NqZnLJ96
         P7YeufGC7aEHKNf0c1PDPcFcOofwDz9vso9zgQb6XnrtiUEM20cvRKn8B8NjpoCdSIZ8
         sLxhr0KV/XGpLNYhIyBoNojfOQloG/DU9QReUIII6PV2u3WPBWWh65ImJnXkufl0cfSP
         gVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wV534DfkN5sTNnT83uyHyT2KSyCvHOtYaBu2oInCf1A=;
        b=aMwA6d8v8Zn8GjKpCwfDhB4iZPtSEz6ujxo3N+Ns74onuHhorbU8X0wIcvWej5XG9T
         J/uxqdhCMtyBDOqXOGXLso/9JwvruGarzXsdMqgAURi2h+3BjQ5+qOju210JguvRy0z1
         1jaGaOSeqejk6ZOoMflapygPUkwXn7OQLVgPxwoXX53s8nIKXjiDvddtxHygMU3nDkpW
         dJTbAjR+RxlZKXU+KLK2K9qvsmqTCTDxbGbuCdxxXYqc+g0OLD3Tn70YUvxUHYX387o2
         OIZXSQQaL260LcaOTaPGcwJDhEp8PFc7REb3x0OHROxQr03vbv4YkccMm3cQ9YU+opHv
         zXTA==
X-Gm-Message-State: AOAM530OctUAHwfnyeWLXlETKqCaImi/8BSfhmoZpki2/DP5X0Txb8Qc
        e1E0j6Xff3W3wt7h1egqfYE=
X-Google-Smtp-Source: ABdhPJwQPFt6lqveYhkQ7ARZcopu+93vyMu61yTy+l4BopJMOnNWJCboboViVIoALhcN+7LSbzquWw==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr36557472wrp.340.1608065343856;
        Tue, 15 Dec 2020 12:49:03 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id i16sm37199246wrx.89.2020.12.15.12.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:49:03 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
To:     broonie@kernel.org, jagan@amarulasolutions.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 4/6] regulator: dt-bindings: pf8x00: remove nxp,ilim-ma property
Date:   Tue, 15 Dec 2020 21:48:56 +0100
Message-Id: <20201215204858.8186-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215204858.8186-1-adrien.grassein@gmail.com>
References: <20201215204858.8186-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property seems useless because we can use the
regulator-max-microamp generic property to do the same
and using generic code.

The only things it changes is the default value. The original
code was using "2100" (mA) as default, but I think we should
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

