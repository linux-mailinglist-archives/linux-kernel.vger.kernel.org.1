Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C153F2F9E29
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbhARL3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390091AbhARLRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:17:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C2C0613D3;
        Mon, 18 Jan 2021 03:15:38 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so12402687wrx.4;
        Mon, 18 Jan 2021 03:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfibYL5xNahX8LA5CAFj5sU2ovXxAFSThLjIDqOxaPY=;
        b=W+rrTMzPye14lY1CvIEPoM3mLQBaCpUwq7GMo7rb6TIkAqAtsfVnttLZphIBXOzrfq
         GeNIxsJSNaGqfh3bEz57gqNspACYn2vQdsQ2qm4wbh8eKxoUdn8sfC/nQ+i3CbnuRfyh
         MVqBD6LU/Wm4H7a8zcyGGavipnMa3AMfvwv1RvzT/F4fwhVkiRXuDzqdE3X+KBqSuLWr
         m4oQlXsrjXRYlICbC7gYn4tqiejUQYTxEnxFxRDe8lxQALAMBc2zEfF+iafdHet2wIet
         f7R5RBhuUjVM4ESlkekriNNxXW8WFti0Hq3b5USsbw+AB/krVKIZMA3aHC98G0gHfmbR
         8oCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfibYL5xNahX8LA5CAFj5sU2ovXxAFSThLjIDqOxaPY=;
        b=ixMrU78irpXtv9qTLtpEutQ9aDMHEnuKDaCNYKVzMf44o/9tj6QEOsYHYhJSG92KUR
         o9dtcuLOHYmXzbHE0Hm56KmMTcvDmHN3hl/Ugcjmr9tmVBcH91uUr2Y3jqaephb4D1GJ
         tFxsL9qLMRMU5fJBarCfyyXvHH5YgyjU91AcRVCkgnuFYTZQZFbhsoZBRkXY2+VD1Vxt
         u1JkGDVxc2yuWAQROLeKPAj3A84qY4XlJkpXmE8STTp/4dakVrSH3al4GTfiwsDViWw9
         Y/JJD4fBIVEnqkPwPc0H2VKCzQJP0XPtIwVNwqWzujfLrt4a+KpukjO8yIf5TTc42JOX
         4aGQ==
X-Gm-Message-State: AOAM532mDPJhjTQYLNJDqap5NoxkPvyDCYfqR77VaMBE4AV/YSv9ljq7
        PNAF7JNs0VP6Lnc9rvyfztM=
X-Google-Smtp-Source: ABdhPJx/BHdfErbS4aGbLcpbV/6O2kYX1NDUjP9jmg0+v1NJQfzAbnjmSTw+QUu740UcVY4UPOKjRw==
X-Received: by 2002:adf:814f:: with SMTP id 73mr21352189wrm.368.1610968537673;
        Mon, 18 Jan 2021 03:15:37 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd2700989047bbcea0de57.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9890:47bb:cea0:de57])
        by smtp.gmail.com with ESMTPSA id b132sm26778440wmh.21.2021.01.18.03.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 03:15:37 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     shawnguo@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: arm: imx: add imx8mm nitrogen support
Date:   Mon, 18 Jan 2021 12:15:29 +0100
Message-Id: <20210118111531.903154-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118111531.903154-1-adrien.grassein@gmail.com>
References: <20210118111531.903154-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nitrogen8M Mini is an ARM based single board computer (SBC).

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2ae66407e2aa..30e126c421f2 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -674,6 +674,7 @@ properties:
         items:
           - enum:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
+              - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
               - gw,imx8mm-gw71xx-0x       # i.MX8MM Gateworks Development Kit
-- 
2.25.1

