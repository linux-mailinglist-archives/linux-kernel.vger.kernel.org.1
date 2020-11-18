Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C332B7B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgKRKV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKRKV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:21:28 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1265AC0613D4;
        Wed, 18 Nov 2020 02:21:28 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o21so1990696ejb.3;
        Wed, 18 Nov 2020 02:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ut+VpNoLjXKM+Fs+9dC2stRQX/oeSGlb3R9x1V3q9Bg=;
        b=s/QsXjTG4cCDIyjCgC3Ghr/ENxNHInSpeJtBGW7e5NQuQADP5q6I9yWBXZgpINEHR2
         B8XBuyIerkw+AGUuEu5C8H1bSeLc+Q2rVymTirX1xHYuVjhnMMaT6PiiWYEcDw1BMsvq
         eqbs0VfR432r2wEBWmjDwMFFgU0XWA436KnpED8NocWmTABYOjsVt10fZYURcO8CN6AC
         vkFx1zNhqlZiZG9vkCE+GV//rXDx4LkhTn382X3StkPl/uwa0m6rpt5/3YRFLYdhXkjr
         YHWSPKThepdm6m/v/QvVhj6FsKeSHrSf6AgyisuCjUxIHHOLaSMvY2LyVqOmzsW5hdX3
         A+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ut+VpNoLjXKM+Fs+9dC2stRQX/oeSGlb3R9x1V3q9Bg=;
        b=BZny8/XngLXu8AQ2OKzgyyu2uTc4h3GtGxO4cjlBppUNnCGFByAdna2N5/7tYUhbRV
         LrebHqULAaoQxg46DxJYIFYeWPBS8E7Bt5MYVlpoJ3kX+4ZH/p/C4CFLpeKilF+x/jGe
         uQOtJsWwL1G/NhDxnfGWpB4DQ2eudEgiCTxsEiQhJd0PNC24CqVfs2T4zEas2SWJJc2/
         LvMuW1FZ5ZBmajJijaEj4Uc++LLPJfz9g21uwpvqqKBLHEMrWjD/fXB1AD9sXGizBchV
         HsaoOpCZesvu5cPYzua9JR4KJ+yTPemxTCp/iufslgXvbwz5SDgEEhX8SRAgpUDSCebz
         Y8CA==
X-Gm-Message-State: AOAM5328ugR7n0mynW2Ju01wN1C4wlJYCvErvJ1eEPiXXSApal8doMnQ
        jHBb4rHNrdTN4Szmk48LX6K/f34Z1MRoyg==
X-Google-Smtp-Source: ABdhPJz1Fs5HS3L+GJxaLFmsIuNLbw9OGL2yzki1ZZCNGdlT4BtusPJ/To8B0kXyixYuoBq83o/Lyw==
X-Received: by 2002:a17:906:a891:: with SMTP id ha17mr23697340ejb.116.1605694886463;
        Wed, 18 Nov 2020 02:21:26 -0800 (PST)
Received: from xps13.lan (3e6b100e.rev.stofanet.dk. [62.107.16.14])
        by smtp.gmail.com with ESMTPSA id jw7sm12868389ejb.54.2020.11.18.02.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 02:21:25 -0800 (PST)
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: fsl: add kamstrup flex concentrator to schema
Date:   Wed, 18 Nov 2020 11:21:18 +0100
Message-Id: <20201118102119.3254-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.28.0
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
Changes since version 3:
- Rebase patch to v5.10-rc4.

No changes since version 2.

Changes since version 1:
- Patch prefix renamed to "dt-bindings: fsl:"
- Added acked-by from Rob Herring.
- Fixed typo in commit message.

 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 934289446abb..a5eb9fb68209 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -362,6 +362,8 @@ properties:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
               - fsl,imx7d-sdb-reva        # i.MX7 SabreSD Rev-A Board
+              - kam,imx7d-flex-concentrator       # Kamstrup OMNIA Flex Concentrator
+              - kam,imx7d-flex-concentrator-mfg   # Kamstrup OMNIA Flex Concentrator in manufacturing mode
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
               - technexion,imx7d-pico-dwarf   # TechNexion i.MX7D Pico-Dwarf
               - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-Hobbit

base-commit: 09162bc32c880a791c6c0668ce0745cf7958f576
-- 
2.28.0

