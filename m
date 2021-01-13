Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9E52F4D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbhAMOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbhAMOfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:35:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1358CC061794;
        Wed, 13 Jan 2021 06:34:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y17so2331994wrr.10;
        Wed, 13 Jan 2021 06:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uAkE89jO3FfCKZpOr20u/UTabJSL17T7VKX/vxjG0G8=;
        b=Os1CuP8yD1Y80lKki4OW+DZ+neFCbyAC0vaz+0mm/ZaWt6q0v6vLeO2CY04svbwVT9
         8z8lJHneuE0piGw6uPR/4fCSy1uPLf8C9zPUnop7Ntm8L35SXdFSLLul0sikFniol+O2
         VrZmPMx+fdV2c25sbR4vlQBXAyOfRhQoXOJ+4UDOX1m8OKR3bHVLE6UqXhfRjZn6A8Mv
         m8MrM7JP6+FC5kA+y4SVYpBSLtxDjbWEMP/ETj/Nz9EFupaQoTh/mDE403hptlPN8Y7B
         mxil7xhucADAuHt147dw/ITbK75pu7E5YTNiio+YsnTodbJDjYKoksK4EHQrokSfrtX3
         Of1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uAkE89jO3FfCKZpOr20u/UTabJSL17T7VKX/vxjG0G8=;
        b=X1MV+9McEg9hUqbhrykSK3E3kmJPgIt7M+/ZJ4bFd8JEURgT/8OJzoLGRLh1JacHxX
         8QtnDZlLQpxzHi7EdFwusWeepW4wRhzJlp2hV08AodZiKinmsHNtrvKLqbqxpz5tY5bf
         z8oUSzDuohc6aH3hezg0NXAkML9D1s9/ej5i0QWTJB8Obva37cWvGtKlSHI/27vdNwbX
         iRMbShkvpl61u40MB1zi+2KMLH1vmLLpxNeMXoZq44XC/RWhToB2Oz23KO24SZfY22FM
         2/6jUvWaulZIfDHxDBUgr44W9lR3LV6cqzg4kD+PQvDve+EwP3B5swuhj7wKZrkovaT/
         wuaA==
X-Gm-Message-State: AOAM531ca8GS6qHRBgKt3aa4sY6jd/f8WXu62c7o3rQcS3vby3MYTc9K
        yQ058iG0MNA+OCypaqtM3y0=
X-Google-Smtp-Source: ABdhPJwVXeMPclbSKneCcGEyHyt+ha/Bb8XPLIN9rA2MZ3lGvQ82WMUXY0mR2cGDFa0hQDPQAwwEuQ==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr2886925wrx.7.1610548490796;
        Wed, 13 Jan 2021 06:34:50 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id h13sm3720502wrm.28.2021.01.13.06.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:34:50 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: imx: add imx8mm nitrogen support
Date:   Wed, 13 Jan 2021 15:34:41 +0100
Message-Id: <20210113143443.1148506-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113143443.1148506-1-adrien.grassein@gmail.com>
References: <20210113143443.1148506-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nitrogen8M Mini is an ARM based single board computer (SBC).

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index cee74fc0c115..c09d58ebb0f3 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -670,6 +670,7 @@ properties:
         items:
           - enum:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
+              - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
               - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
-- 
2.25.1

