Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ECC2CBCA8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbgLBMOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388759AbgLBMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:14:38 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D3FC061A53
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:13:34 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v3so997837plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQr5ccaZgv0zXC1QijecfzErZfDT23xUiGG1fotszzw=;
        b=Xm9WsQa5eaKV4VZZhQcSfyoL3LcYmruqRsmfTm9azWY6iks2s60BjxbbCDmRu95Zqx
         W6Jl0MQoEr5+iy+niasJUG5uAtc4t8BYCNevX9HLUqTS+GagiObefMv/yynJ3cg8u7j6
         Hofiung7lZXuNROcMF/gcydRcNlUcZNRPgUDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQr5ccaZgv0zXC1QijecfzErZfDT23xUiGG1fotszzw=;
        b=lB2o2aEGfUJgUtCrn0c64o6p4cgkvwI+suTJEVYIru2dSlBWCnOlph05/Wh30JexuK
         Ig8Nw6Jkr93k/HL8csyJO/Vz62qMXuxKh52D4pohHfcQ5O2etRtt3Q0km/3xV87WnjL0
         jrSQA4TpiGCP3BpS0Em5rLhpJGW5gkce9KRJXkld4dDtyP8araYxx6hWOkSvAXwZwEQM
         IkVk9YkY3jUqjNxySLp78jUVlfq7te2HVEGvf7Z4CxoJbDigexpLy2m09BjotpHwDgJx
         D0eklO20OyZeDmCWmcpAxQNA2H39D1Ly0Fj3/Zw1G8kajc8rk5kVhXjCGf1rDM17TI9c
         1oJQ==
X-Gm-Message-State: AOAM5322LB1fGKe1y29MwYAptuyXy5SdFrYMFBCzIctp4lAPi5JVEVtx
        BHi8Q5KDfWno9Ao+A8cmf0CeYg==
X-Google-Smtp-Source: ABdhPJx5jJYDFWRfn9shUcmJctE13a6bTwhV2SeAsCtFcCa7AxAbmGnaw1v7S1JZSr4LI7GXQbV45g==
X-Received: by 2002:a17:90a:a595:: with SMTP id b21mr437530pjq.206.1606911214161;
        Wed, 02 Dec 2020 04:13:34 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:fd53:e9ba:b313:1b1d])
        by smtp.gmail.com with ESMTPSA id b37sm1951315pgl.31.2020.12.02.04.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:13:33 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Matteo Lisi <matteo.lisi@engicam.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 07/10] dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
Date:   Wed,  2 Dec 2020 17:42:38 +0530
Message-Id: <20201202121241.109952-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202121241.109952-1-jagan@amarulasolutions.com>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

i.Core MX8M Mini needs to mount on top of this Carrier board for
creating complete i.Core MX8M Mini C.TOUCH 2.0 board.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2e520733ce4e..8c8f7728788d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -668,6 +668,7 @@ properties:
           - enum:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - engicam,icore-mx8mm               # i.MX8MM Engicam i.Core MX8M Mini SOM
+              - engicam,icore-mx8mm-ctouch2       # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
               - engicam,icore-mx8mm-edimm2.2      # i.MX8MM Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
-- 
2.25.1

