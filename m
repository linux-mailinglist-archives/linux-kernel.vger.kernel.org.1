Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37F72A11BB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgJ3XoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgJ3Xnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:43:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF99C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k21so4324274wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BsVx0tqKa5RJACoTi7hCHH0q4zK+zFVU579TR+p2CVA=;
        b=b7oB4rkCZM9z1pWx9XAQE7V2pr2uGL1qY9y6G2djwPv15C3Iznwq1oTR8X34dDd35I
         Mqeuv1ogUHe24z8shG0gc7ng4wRPMI3Tsd3antnhFbVqBnMW9buuVGJwwkDIOGDxiSfd
         N9s2KV4qYp+sZd0nqvx3xCEfLxeWxMUifre9sdT1nXje5ueCyfhc5b618I0ZwNKSfRk7
         xzln0t2QjMJsTPjxRa24+CafM96pCPq8Xp1sadjzIF7q9eftfUx+SmcctsxU6X5/lAuA
         aQn08zHkve9RqhsWxUVNkXP+oCjo0/24DSeeXlr1myZQ49Y0hnu5roWDX5MKJ3gr5xJ5
         Rwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsVx0tqKa5RJACoTi7hCHH0q4zK+zFVU579TR+p2CVA=;
        b=pTMOgSPrdvKlseMlcJyVtotAts9Z2Jl2PaZtGCGbaeviEjP866TFfaVcjQFvEp0KXu
         9zhT0Ryjv9XFbYOeM1ndjgiP6gd7EdRVgmxJzoYCP6GkhSM/Sk7Xt6U/zvyk7dtCwHA4
         SjcLwvZ0D0pEDuNyJyP6EDDHJjViX4MXB9p8fTlow1XeVZQ/qIxtILIsidY8tT3Pwf+o
         QCrOvWtzFrxU3jEEopQBU/0W9k33TWb8bwKrkoecmXDb22Tc63Vboo2iLMoA8I0CgZ2H
         XoXXJMWz1CvW+9Tdkh45M/1Cp/w1djaTrfvxFrb1rYRO+T3VJx/7DEMFp0q/Hau57UCR
         iagw==
X-Gm-Message-State: AOAM5327vamHIIumwp5DqvNFM4l2crrBJj7vFs8G0cEQTSZkyBp/QFad
        LdaxT0IRUh2QWI3J3c5CVXM=
X-Google-Smtp-Source: ABdhPJxu6ZA8Dyi1wn1KNYI6gi2H7UH0pLH3E9YKfS9ETJg+4Z70j2UivJCLqel67SzW7LE1EgCwCQ==
X-Received: by 2002:a7b:c418:: with SMTP id k24mr5551767wmi.118.1604101431038;
        Fri, 30 Oct 2020 16:43:51 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z10sm4702381wrp.2.2020.10.30.16.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 16:43:50 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 4/6] dt-bindings: arm: sunxi: add Elimo bindings
Date:   Fri, 30 Oct 2020 23:43:23 +0000
Message-Id: <20201030234325.5865-5-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document board compatible names for Elimo Engineering Impetus and Initium

Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 0f23133672a3..ef2ce3bd2bed 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -201,6 +201,19 @@ properties:
           - const: dserve,dsrv9703c
           - const: allwinner,sun4i-a10
 
+      - description: Elimo Engineering Impetus SoM
+        items:
+          - const: elimo,impetus
+          - const: sochip,s3
+          - const: allwinner,sun8i-v3
+
+      - description: Elimo Engineering Initium
+        items:
+          - const: elimo,initium
+          - const: elimo,impetus
+          - const: sochip,s3
+          - const: allwinner,sun8i-v3
+
       - description: Empire Electronix D709 Tablet
         items:
           - const: empire-electronix,d709
-- 
2.20.1

