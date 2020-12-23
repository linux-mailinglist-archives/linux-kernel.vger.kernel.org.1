Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAEE2E1B63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgLWLGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgLWLGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:06:45 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B96C061793
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:06:05 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id z21so10409215pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+MoAq/+qDlbRWnGKVMG/RfZuRkWwtwV+6sJl8++tLE8=;
        b=mMQ638SnHR5ygU+NsnlRRlhkhVODFKvemr4nBdOkwuQ0IgL0IGMztAdbfS0XrPPqph
         r57RCnWqVolbGQozJP2J6+zi/pJFDvz/Fjdbwcn2fI42gCr3HkqatUYT7NqkSIlR9TG1
         WwiwQw8k+kMruVmJusXQc16k7EMkvekvfTl4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+MoAq/+qDlbRWnGKVMG/RfZuRkWwtwV+6sJl8++tLE8=;
        b=gTdMvJL0IdZbTUxT6ZzHCtnDSBAGssgD36fL1W+zYxE++HqSHqhLaIJFV+9c7Q7Gd4
         ucZoxABMiQ/Rl4vN5kiuYaiU22sQz7JJ3PWtTL4rD4whr1CEBYUe2UE4wfgrjxDh4Mpi
         XKaa6LOFVXBJD6znbGujjr7ioqJ7Vx+8uPTzMBqIRENwnPVCIJY5NKduN9BHsmTa60Dp
         OTPGqT9DNta8t2a+3OZt89QbxTpWJIuvEP7zXQatoQ36pvmWqSJcdsjYsAx2fJYcnTDt
         PudiglRF5T7+vBYHNyZDMUnVyCQHD+ESPs/y/FhRWWeQgVObiGYA8VkUCUy9MV9094st
         FhkQ==
X-Gm-Message-State: AOAM532qfWPZfI3VGq+XvHMmMRTFlXtmbGlH9RJD3CzxABjr+f74uwS6
        eGbpUVCGGkwpUNftVj6eFNo7Kg==
X-Google-Smtp-Source: ABdhPJwPNW8ETgaSkecxT8Kd2ZYvi06ZJjv6+yQK3GLe3+HQEsO5MrDkPnrtRExMXsWbi8QdhlHpnA==
X-Received: by 2002:a63:4083:: with SMTP id n125mr24276013pga.356.1608721564767;
        Wed, 23 Dec 2020 03:06:04 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:eca4:40c1:8784:571c])
        by smtp.gmail.com with ESMTPSA id 3sm23275909pfv.92.2020.12.23.03.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:06:04 -0800 (PST)
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
Subject: [PATCH v3 5/6] dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
Date:   Wed, 23 Dec 2020 16:33:42 +0530
Message-Id: <20201223110343.126638-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223110343.126638-1-jagan@amarulasolutions.com>
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive Evaluation
Board from Engicam.

i.Core MX8M Mini needs to mount on top of this Evaluation board for
creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- fix dt-bindings
Changes for v2:
- update commit message

 Documentation/devicetree/bindings/arm/fsl.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f1de68341873..2dab4b5bf99a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -675,7 +675,9 @@ properties:
 
       - description: Engicam i.Core MX8M Mini SoM based boards
         items:
-          - const: engicam,icore-mx8mm-ctouch2     # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
+          - enum:
+              - engicam,icore-mx8mm-ctouch2        # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
+              - engicam,icore-mx8mm-edimm2.2       # i.MX8MM Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
           - const: engicam,icore-mx8mm             # i.MX8MM Engicam i.Core MX8M Mini SoM
           - const: fsl,imx8mm
 
-- 
2.25.1

