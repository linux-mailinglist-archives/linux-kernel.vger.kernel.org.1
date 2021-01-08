Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA97B2EFB2F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbhAHWYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAHWYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:24:03 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25796C061793;
        Fri,  8 Jan 2021 14:23:23 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w1so16450596ejf.11;
        Fri, 08 Jan 2021 14:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f5HlVwGmEaxhTQyG4FNbXTgYnZHiHajqT5VVUSQdd/4=;
        b=cUenYSvKiZVEllkpPl1aeRmd76kOwmbPnluHHIHb5MJxrnZMsIw+Pppe7tPSC7+E5Z
         zCfFTCPxKKgHn3B1rFQPaD34gRw2v30Oc5pCCyko1+qhYsDQV8FEmwWxubNuWeMPaR4y
         SXEC8Jlf3wBYVWFRV/hOUg6Ro035HKQ/zkQemkC8i+d730x/v+w/mtfWZI4zQ2r+z6e7
         wsSxu1DjUUby4sIGWkHY0o+qMcD942dwUKIUc7Mh2hwib2mguLvsVJpeIej6UH3A2beJ
         ZTBQlYUXUnU3SY7JUmFz9NnGfkugcxlKaPkTZKtoz7tATxvxeKRG1luAAH5OkEph05Vt
         yZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f5HlVwGmEaxhTQyG4FNbXTgYnZHiHajqT5VVUSQdd/4=;
        b=ib65j4psopE6LyBqFG2D6U9CnPMZ0G9KQzS01IRnHei+aCS5CAIj+x7RGRrbcRdiI/
         Itn+qXuyWaeKLnY0ak+tbyck4fjIEBTZhzumEvtQve0kUb5Zt8SGgvceJAdY5tED8vcc
         04px9ZSt9PE+H4Iqyx7fZ46vz47piOn0SNyHnDDCS7UEOLoaEYxIz4qXWkZ5S0jjiA6Y
         X2xXFiCcEuF2TDEq+RwJ0H40sN2UjI6e4tUCTBh8ZRnhtR+AA5B36mtBV4imsY2cTtNH
         w39pDIbmQfYZHpQ9rusm722U0d9L+DDR1vDm5HOkxdK5O51A2B7/yQUOMBQBuT++zToA
         rbdw==
X-Gm-Message-State: AOAM533sr+96/4kbek8MEYXNWogNwJIrYGhQH78MPUGchGMserbRO9yM
        GqY7JysKxJvhMT1WXfcEeOU=
X-Google-Smtp-Source: ABdhPJzq1egExRS/sXEbYTW/ThPQDaDiRP5Ulpo+VCbyu6MotPWMN/2BXjRaoIo+YVacr554Iu1w0w==
X-Received: by 2002:a17:906:3881:: with SMTP id q1mr4069379ejd.490.1610144601832;
        Fri, 08 Jan 2021 14:23:21 -0800 (PST)
Received: from localhost (ipv6-8dfc3ce26bc50b06.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:8dfc:3ce2:6bc5:b06])
        by smtp.gmail.com with ESMTPSA id c23sm4254426eds.88.2021.01.08.14.23.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 14:23:21 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     m.felsch@pengutronix.de, narmstrong@baylibre.com,
        parthitce@gmail.com, Oliver Graute <oliver.graute@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Michael Walle <michael@walle.cc>,
        Robert Jones <rjones@gateworks.com>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/3] dt-bindings: arm: fsl: Add Variscite i.MX6UL compatibles
Date:   Fri,  8 Jan 2021 23:21:46 +0100
Message-Id: <1610144511-19018-4-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610144511-19018-1-git-send-email-oliver.graute@gmail.com>
References: <1610144511-19018-1-git-send-email-oliver.graute@gmail.com>
X-Patchwork-Bot: notify
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibles for Variscite i.MX6UL compatibles

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
---

Changelog:

 v3:
 - rebased

 v2:
 - renamed binding
 - removed superflous "

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05906e2..5f74d78 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -240,6 +240,7 @@ properties:
               - technexion,imx6ul-pico-dwarf   # TechNexion i.MX6UL Pico-Dwarf
               - technexion,imx6ul-pico-hobbit  # TechNexion i.MX6UL Pico-Hobbit
               - technexion,imx6ul-pico-pi      # TechNexion i.MX6UL Pico-Pi
+              - variscite,imx6ul-var-6ulcustomboard # i.MX UltraLite Carrier-board
           - const: fsl,imx6ul
 
       - description: i.MX6UL PHYTEC phyBOARD-Segin
-- 
2.7.4

