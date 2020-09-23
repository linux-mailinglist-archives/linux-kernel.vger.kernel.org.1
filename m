Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3A6275C29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIWPkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIWPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:40:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08502C0613CE;
        Wed, 23 Sep 2020 08:40:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so570739wrv.1;
        Wed, 23 Sep 2020 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdNOZjxmYZxY4grrZxCVN6KJEz1EtluGEmYNEZcTomY=;
        b=ACM2YoaV28iao016ZPZqyMNhH8sFRSFoXu8tqP1vn2JpZRzf7Gh58nzQ8AdzT2a9M4
         p8qm3lXOAhgR4fxWeW11e8qdSB1PoOtBHzDX5n+f8MZt4QTYlsnuxUADeGk+CQIoD+ez
         kFx1TDOWdYBq4wx8W3rID5Rp4Epk2LZSldeDSwEVUdfonB0rz4iL0Sf5k0+igT/EtXBR
         vmJoxEeoo9IoFcqVErdsUB8ShzS50xSrlNsLuRzFy2MgRR8+/mO/jtxWr88+oXye0f2T
         szKPi/DuYQNjH7jPjCrecyQkE0DKbg7zHxyPJg5dRA3VfcTa5lqrcpWlUA5uwyijaMf+
         Uidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdNOZjxmYZxY4grrZxCVN6KJEz1EtluGEmYNEZcTomY=;
        b=Co1IEkOHme836nEOFTwwQd25LfqfaAiV7cP6i8YwNS9JmG/uT6Vyyc2Jn7YPb7TDMD
         mDT0K+RtTFk6tq8tv9TwmBIm/P35VkLnIlHBYwtRJ4ioq0TsKiMo8ocodZzNXoMr83RM
         dOf1JlMQdsIFb6uLdQ6O/9WR1YtEs0392H+kiGG0YmsTof8xM/dmkVfBzIuaU1vpysWO
         1ZVNHDyCo9kon5JldshkMK/MXkIde//+VgmAloF89gSsemuHCSCj/6w3kph1Lcg6RejG
         OGcQvA46GTlqsQdsXO1iAPmFGmZuxU62kufHrEysMqHTZfFRr+0HUH+S/MxSdpiu5Zj2
         VYAA==
X-Gm-Message-State: AOAM53193jMNnobGD67Q9T/jJXUNs2HIipp3KjTaqRQZiaaYuu44vqPt
        FU6MUPv6pTSmZzHh0/4I/qmVN2eSXoBPjg==
X-Google-Smtp-Source: ABdhPJwxr8n19OjjBxhQM01RXeYxIjDZt23i0Lb42cMeHGuMzXHUcNwIMRbp+6GsqdSHG+nbSp3gvw==
X-Received: by 2002:adf:9e06:: with SMTP id u6mr284224wre.208.1600875634451;
        Wed, 23 Sep 2020 08:40:34 -0700 (PDT)
Received: from xps13.lan (3e6b1cc1.rev.stofanet.dk. [62.107.28.193])
        by smtp.googlemail.com with ESMTPSA id t203sm160066wmg.43.2020.09.23.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:40:33 -0700 (PDT)
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: fsl: add kamstrup flex concentrator to schema
Date:   Wed, 23 Sep 2020 17:40:23 +0200
Message-Id: <20200923154024.11417-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kamstrup OMNIA Flex Concentrator compatibles to the schema
so we can make use of them for the validation.

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
No changes since version 2.

Changes since version 1:
- Patch prefix renamed to "dt-bindings: fsl:"
- Added acked-by from Rob Herring.
- Fixed typo in commit message.

 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6da9d734cdb7..8e9be78f3d68 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -304,6 +304,8 @@ properties:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
               - fsl,imx7d-sdb-reva        # i.MX7 SabreSD Rev-A Board
+              - kam,imx7d-flex-concentrator       # Kamstrup OMNIA Flex Concentrator
+              - kam,imx7d-flex-concentrator-mfg   # Kamstrup OMNIA Flex Concentrator in manufacturing mode
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
               - technexion,imx7d-pico-dwarf   # TechNexion i.MX7D Pico-Dwarf
               - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-Hobbit

base-commit: 805c6d3c19210c90c109107d189744e960eae025
-- 
2.26.2

