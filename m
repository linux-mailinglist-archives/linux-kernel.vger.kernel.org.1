Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404BE2F871B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbhAOVC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388653AbhAOVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:02:20 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71638C06179B;
        Fri, 15 Jan 2021 13:01:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l12so5375849wry.2;
        Fri, 15 Jan 2021 13:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfibYL5xNahX8LA5CAFj5sU2ovXxAFSThLjIDqOxaPY=;
        b=rA60KlIhKOzTBmP86uDmhv8WygC91158Qmb51GkclM0oatiLUs1RJJhVifO7hvNMrq
         LM864x76r9DdHOy05IsedYZdAIYtTKPey6w3XOgFA5hDE+F43NtFyZKdbXvXvFs+ZNcR
         Af817Ck6vEDNdaXp/p29ApHUcvrw7LrMAQsFA4OBjxaXKeCD6ibtk6BaQutq3uhovpWB
         uaWjMgfNPbUZqOS++MUvgWVAiQNi3G5rneghX5dlcvy7o+HEH+yCCQ4sHTblF5jbLagj
         3+GA6s3Ggb50sUkS3UhIOz5ZBeR6qNua1SMsOd0VgHkkZcmkrrs1TEgzRPpIvGTKRdg6
         XqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfibYL5xNahX8LA5CAFj5sU2ovXxAFSThLjIDqOxaPY=;
        b=Pj1hyoDhT2nnNjGzuzDacFIQ6Tz/62d62YyMcSaltKupJn5NfA4Hc/NB/ndLqNg2ah
         1Vkmr8lgqBSmUKjrR1iwcoTBzRuEXZ/RYdCOF3slwlbir5YQM/ze5C/tErmczTNnpDuI
         x3MjYdm2BNCZ63pBZjw7PIqgVR1V68VeTnra+m8039ie7TnTE4bh00XzYn+sEoR8ff/H
         RX3V/sPmb2kLiH2+LPsBJpcI14LqBzRUIQxgsmdnOS9MzC7LrEnhE9LHbKg8UwOi0o1v
         C3ZbdYq39ryOwxaN1rVfXgBGBcuYNucQrb+hrrl1xcJrpSo48RBS0sqh3qx1X60cxsyh
         1aEQ==
X-Gm-Message-State: AOAM533BlLQ10ErTzUc9A0asC21WOuHTrPppelWBasJB6QD9CY96KL24
        ejB6Eouy09UbdTCAvy2klec=
X-Google-Smtp-Source: ABdhPJztA5WpQlPCB0XMVSoCocG3bBFQ5htNLRg8cH0zK1pfUyg0Ow/xSc+c7X6xNMLrtYoUShBzdw==
X-Received: by 2002:a5d:5917:: with SMTP id v23mr15481989wrd.308.1610744488194;
        Fri, 15 Jan 2021 13:01:28 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270090311bc0a820c7e4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9031:1bc0:a820:c7e4])
        by smtp.gmail.com with ESMTPSA id l7sm13414853wme.4.2021.01.15.13.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:01:27 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: arm: imx: add imx8mm nitrogen support
Date:   Fri, 15 Jan 2021 22:01:22 +0100
Message-Id: <20210115210124.507282-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115210124.507282-1-adrien.grassein@gmail.com>
References: <20210115210124.507282-1-adrien.grassein@gmail.com>
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

