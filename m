Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8912E1B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgLWLFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgLWLFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:05:41 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F326C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:05:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e2so8942749plt.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVAwYhY605SAEDbOs0QxfT3jdZd8fH4RLlfZ8Qm9ewI=;
        b=aZ0/Y7+Mf3kkO9Xty9DO4lPriwuLnt171ioy6SSo/fw32sk+OGtXhqC3FMtw3DAeQl
         ig879whOupO+Sm39SobJVKcH5Udrm6JRsZ8f8q7jrniAXHQrr2yerK9U2HXrdVDrKuQP
         syRccRnTjNIeX2b2+kBMDfjGPMZgnHZLdA1Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVAwYhY605SAEDbOs0QxfT3jdZd8fH4RLlfZ8Qm9ewI=;
        b=FTAi6VNa4gwPin5wBzr4FXpTMsdaYTluyDmsP6aU+VbCppF1FX/eApIbbwKNYA5xco
         ev9B2SX6SpxYEfNQ9jd5AuPyAuHS8/ixO9e8zZQ3RnTIGxZ+Cz8RIUmYO8QAXygPd6t+
         XQa58J781s4f01rNT845gybow/Q4n3Kk8aCMeUm38KP75ZXXgHXRbs4eaO1REHfMHSTX
         2jqsKsareATE2AKvpMWM/l5rvlXEEYj5Bw7d6klXbxDwgqSqA5r6/Jvyil2xem6Nvr/z
         SbHFYVGYwgmh8jKl+i2Wyv7Ysg3vhbp1iXwLHy+1oNwk7hO0t1MUt5svg6fxAVNr0qGQ
         LZwQ==
X-Gm-Message-State: AOAM531nDOTFBWGUmqo/1WYeckBlQfqnXqg07tbYUZ2pmyj99rgugOoB
        /3gONutu6UDq+ChzGijz/JL5uQ==
X-Google-Smtp-Source: ABdhPJwvSsuoooLM88eoPtgxrmNj7/6mKz2LqwPuxzBF/oFBJQLN2LgnJNKLMe9Rvm2fLOQqQW/how==
X-Received: by 2002:a17:902:8d8d:b029:dc:4609:58a9 with SMTP id v13-20020a1709028d8db02900dc460958a9mr6511503plo.27.1608721500658;
        Wed, 23 Dec 2020 03:05:00 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:eca4:40c1:8784:571c])
        by smtp.gmail.com with ESMTPSA id 3sm23275909pfv.92.2020.12.23.03.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:05:00 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 2/6] dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
Date:   Wed, 23 Dec 2020 16:33:39 +0530
Message-Id: <20201223110343.126638-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223110343.126638-1-jagan@amarulasolutions.com>
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

i.Core MX8M Mini needs to mount on top of this Carrier board for
creating complete i.Core MX8M Mini C.TOUCH 2.0 board.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- add proper bindings 
Changes for v2:
- updated commit message

 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 67980dcef66d..f1de68341873 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -673,6 +673,12 @@ properties:
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
 
+      - description: Engicam i.Core MX8M Mini SoM based boards
+        items:
+          - const: engicam,icore-mx8mm-ctouch2     # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
+          - const: engicam,icore-mx8mm             # i.MX8MM Engicam i.Core MX8M Mini SoM
+          - const: fsl,imx8mm
+
       - description: Kontron BL i.MX8MM (N801X S) Board
         items:
           - const: kontron,imx8mm-n801x-s
-- 
2.25.1

