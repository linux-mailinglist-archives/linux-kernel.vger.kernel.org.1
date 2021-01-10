Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBFE2F0A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 00:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhAJXZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 18:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbhAJXZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 18:25:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6CC061794;
        Sun, 10 Jan 2021 15:24:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w5so14550624wrm.11;
        Sun, 10 Jan 2021 15:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCFy7hoTUYR47f5IbB9wmHnZYO57l3ZL44UzRqkRxj4=;
        b=QoXrCZyCKbNUYIIeQUX+7hVNOjmGVI6Gdfw36YjwhBPWHtmAU1U+Vqh6YUErMcY4FF
         3DSRpZFECXg5seFQE4DALVzIC5GzQeu3KVUp39zLRfN9LqM8wrGch+Tguo2LykLj6gC1
         vNvdToR9Nc9BiUFsqjgXBJfKdbPnLxP5+SiJ0Ax0Eaor/fqj74U3Vi+364iaeaNF71K1
         YQ5n0pmC9woK9k65uer4J2bHPg99jAmXajDige8rE0N7yZjzcjpKD2Cf34JIqN3ZzFCg
         t/tFAzUCsbJKi6JeCLnJdG9crXmbBv6WNYv1h6SljW3+bDPcy+nW2jeZFdBfLQ85GijE
         nwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCFy7hoTUYR47f5IbB9wmHnZYO57l3ZL44UzRqkRxj4=;
        b=epT5DG+cZQixboX9fjEX5d2GvLeMSfVCfnPhQ28K8MZJAmiF7+iaCtItsiPQ+xj0hf
         QMkjDK9xntJe9ocz37TRtRy2D1bsRH9HrfMmZouXze6Uz7RoNMcvPnP2B6bv3F/p0KEf
         4c9TL3PNr4iyYxvBns4ck5ieWNLrdV+epHFjqrgeL3QDNn2zIFzqtxVRxwAA/qybdOzP
         11RXd8YdXfhmG7qIRkkI/pGAIChe6En+gw/aZw9+DIYU5PHtOvUsGcNxGUeCWVN+swoa
         Uhv6Up1ArNqXhSD3W/U/rquXOXwVhhJZ9AoESD/9Jr7dMkDqFw5C5rcz+omyUFgjoNUG
         hEUQ==
X-Gm-Message-State: AOAM532TAcT0gXcnkR8bdo94P5MlhM94eJilKn3zTIKuVqfVw20MzQrR
        6lc9QuH8BNoQNhDSV1U+X8w=
X-Google-Smtp-Source: ABdhPJyenD7MpPt2ttxyj9za2ZIXQxqfZqjHJRCnXnLF0Oz+ToG3ti9QjBchKJgjf6N6FmE/zoommQ==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr13906734wrq.19.1610321059345;
        Sun, 10 Jan 2021 15:24:19 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270029536a450755141e.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:2953:6a45:755:141e])
        by smtp.gmail.com with ESMTPSA id a12sm23426104wrh.71.2021.01.10.15.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 15:24:18 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 1/3] dt-bindings: arm: imx: add imx8mm nitrogen support
Date:   Mon, 11 Jan 2021 00:24:05 +0100
Message-Id: <20210110232407.1666059-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210110232407.1666059-1-adrien.grassein@gmail.com>
References: <20210110232407.1666059-1-adrien.grassein@gmail.com>
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
index cee74fc0c115..2247dcc37331 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -670,6 +670,7 @@ properties:
         items:
           - enum:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
+              - boundary,imx8mm-nitrogen8mm  # i.MX8MM NITROGEN Board
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
               - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
-- 
2.25.1

