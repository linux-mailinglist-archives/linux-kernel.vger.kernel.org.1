Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8F291B3D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 21:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbgJRTaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 15:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732154AbgJRTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 15:30:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87BC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 12:30:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n15so9057379wrq.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiO/CbYiErh+VMCoZF8e42eNV4rVIWemGcIMMY1+JXo=;
        b=NO4BBseFZMaLr8Ping9guGMNWZ1CDpYUAPxPRADAuwkhBTiCKXXny83bHqMUO4pWHp
         Cb7yex3BZ8LvGX/cOXX101giFa0IVT/1ZaVCjJelWjS/u1jDcxX96OZwmUfGTuj4feQ+
         eIRwxPqkGXyVHPScYlmqJYOGX8lkUD9NKIqKqnykzjy7guTsquwJgQqOE5GLVAXwjhnd
         aJazSik69uPmb5OZk2jvnmiJTVCB7PYCvUsUeXtaRSuG+H0ZHW7pEZKnKkLvIu4/fiWr
         QZc18ABP001JKDv1CDH5APJsH4sCP2NIkr38QBNYXXwQRpRgzocDlC3nwAgTliYvDrjy
         911A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiO/CbYiErh+VMCoZF8e42eNV4rVIWemGcIMMY1+JXo=;
        b=B0C2k7r8Ybf9hupmN/mMx1FYyMSN/qTpriujjHJRgf9m37W5g4vjM4PEVw3i2bYr1a
         lQ/7AX2ALWCR2LasfFTQ8lKUc2bvs6mPGxhfpjSOXqJhdlputT5z2GTN6cj10WmWD+0S
         dFO62vdhXJQsNuEVNuUvil2bzWQ2uHyW1Ja9jVJYeoyYUCHXXww8tU7yZmCRk7Hvj2Ks
         Y3b1qDedj0FuY3b0gkN1/zjlk1tNWhvPULG/ZFIQ1y5Ipja7Kff5kLMOKnE1Jxziwy07
         lx3UC7u7KT5MO/0s7Qz79pJRpwswHvq1KyAT2da0C2D6KBUn7sNR/U1hR00XpGKXMEjQ
         dO5A==
X-Gm-Message-State: AOAM531XTmJcPVh+IfpE2yp3h6rDCffXhNmaYOwV5jXFU9W+W1od/o70
        rzY8SM+SlxN+N6exNmHeHD4LEpXuvKS1fw==
X-Google-Smtp-Source: ABdhPJxjk2lJO5ut9RfrL95tkil3NUyCvwqdq6rPg6tJq6126c2Etcp0yxa8XlIz5XjHq8J8lTbXqQ==
X-Received: by 2002:adf:e589:: with SMTP id l9mr15846465wrm.110.1603049419718;
        Sun, 18 Oct 2020 12:30:19 -0700 (PDT)
Received: from localhost.localdomain (124.171.185.81.rev.sfr.net. [81.185.171.124])
        by smtp.gmail.com with ESMTPSA id v8sm13571628wmb.20.2020.10.18.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 12:30:19 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     dennis-yc.hsieh@mediatek.com, ck.hu@mediatek.com,
        bibby.hsieh@mediatek.com, jaswinder.singh@linaro.org,
        matthias.bgg@gmail.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH] dt-bindings: mailbox: mtk-gce: fix incorrect mbox-cells value
Date:   Sun, 18 Oct 2020 21:30:16 +0200
Message-Id: <20201018193016.3339045-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the binding documentation says, #mbox-cells must have a value of 2,
but the example use a value 3. The MT8173 device tree correctly use
mbox-cells = <2>. This commit fixes the example.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
index cf48cd806e00..7771ecaac586 100644
--- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -47,7 +47,7 @@ Example:
 		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&infracfg CLK_INFRA_GCE>;
 		clock-names = "gce";
-		#mbox-cells = <3>;
+		#mbox-cells = <2>;
 	};
 
 Example for a client device:
-- 
2.28.0

