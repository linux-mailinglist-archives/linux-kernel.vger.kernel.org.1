Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C207B2A9604
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgKFMM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFMM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:12:56 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9FC0613CF;
        Fri,  6 Nov 2020 04:12:54 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n12so1238095ioc.2;
        Fri, 06 Nov 2020 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQdK8XuLAhEZwu9vpBmqHuUm6fgLRkW5CRR6Wloup+c=;
        b=kbTkJbRbEI2NkQIQLvX1JU7Pz59Wxvq6uXC0hHqD5GL1dmBgeACksEWmJjSp7GbXNg
         p3JC7OtQpJTi378mmC82sYFmo/WX1fQlYiIvcOLjGfxl21v8xTg9yDcF4ZoDFLOnHzbN
         MXAlN1Bzdov7Y7Sylr9m+Y6SCukETaDaOTyEB3UEK5fxFPEO1Wi06SVUdLQR9kNcQAuF
         KMU4ipd0fWL2C+X+sCdPwoCoiEPam2f3w946IyTuvhkSDi2VS/K3Nmxe6pFU4sLVKiSB
         WslyId+GlnzMRHhk1wN1x9AazHMN02SWyOX1OcVGDK8sRzbwopwamBPj9E9m1jWk8BpR
         T20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQdK8XuLAhEZwu9vpBmqHuUm6fgLRkW5CRR6Wloup+c=;
        b=Gyx2IOniFvOKK8s+iAymkZlH567SYxzilEldsd3SE5gHOpXTo+AhOvz6OazFlHPMjn
         a5PdtKyuYMGV4hsteYNSy8QQEa2Z0D9hgjFiZ4P3id0DcMcyfTjQgly0Ulks2Em0BDQg
         JX3p6eFbV3LzUm6Lh7EBt7mGV9HLDhhpsxcMwFGKbZ8AUTCiA6ixmbbJICLLQQ25tF8F
         S3Fm7LtOpuoIIjIv4SxlLkwD3VI0mWgRoo0Prhlhfgg6ViZHeg7dv57usPvteT3pvAX7
         HrpcQ71k6AtEC/8MMYK+CA0CUuxpKvDlAddXbEaDG9pXaYblX/BLM4NDV6vAtp9q7yvx
         7j3Q==
X-Gm-Message-State: AOAM531sjgJy3kwlMQE2AQxcQC5tbvmJzX1Av/KHysAoU5Zjr0YUx3sL
        xqrrAe6G68WZXYRaWht95Vg=
X-Google-Smtp-Source: ABdhPJxY5OpN1N6GtrVI2dPb/9B7pIeBtQpRGLl3OhWRcp2TeV9n2nFuORa6vToMlvaUEKG4KAOGiw==
X-Received: by 2002:a02:cc3c:: with SMTP id o28mr1226011jap.107.1604664773902;
        Fri, 06 Nov 2020 04:12:53 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8492:7d60:7e29:2784])
        by smtp.gmail.com with ESMTPSA id 9sm1102935ila.61.2020.11.06.04.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 04:12:53 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, krzk@kernel.org,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] dt-bindings: arm: fsl: Add beacon,imx8mn-beacon-kit
Date:   Fri,  6 Nov 2020 06:12:35 -0600
Message-Id: <20201106121238.1814427-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add beacon,imx8mn-beacon-kit to list of compatible options.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  New to series

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 85fb24da4a02..808e001aa81a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -659,6 +659,7 @@ properties:
         items:
           - enum:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
+              - beacon,imx8mn-beacon-kit  # i.MX8MM Beacon Development Kit
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
               - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
-- 
2.25.1

