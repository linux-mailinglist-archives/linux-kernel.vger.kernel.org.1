Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E932847E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgJFHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgJFHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:54:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB2EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 00:54:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so3713572pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Q13U487Cjn/+nOLZsCBKdKKLu22/BXGrY05ryfIEBw=;
        b=oes1kxMCC8je1dieaMVGyJ+c2mM7MFn93B+vWCiUBkL/EvgtDX8MTmTCzeGycxtF0R
         RCTefIVFrP/q8E+f9HXTtp8l3vv30vuiPgccF5IL+8QfE+MxJR8uvvzhcDIkBuTxFail
         EtjmgXQ43yS5Uy0NX6L84iN9LHa14KzE6aI2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Q13U487Cjn/+nOLZsCBKdKKLu22/BXGrY05ryfIEBw=;
        b=o8BsmDGqOv9Q5bWNQZLqY6u5KdWlUKLYsxPSnr56G2HSPnwdfeLWEuEeAHE1Ar3rVu
         CFq4TqRevlmHTPlLNfEZQUxuIQabgy7UGd4EkIXCVVWusWQycds8gqsz5EaAs8FSnbAU
         ofjSyYEXnmuj9OVp/pXmZ+uS9uxDHhhu4HqRJ3Yz/wh2Fxo/CMRzbrCLa96+RLngV5ip
         nxFj6Kg9l9FAjHHd0Iep2A68gbvghbklXEOJWqC058cec91+NCbLB+Jv8iPluHaOLYPP
         zYJVOCeS1EQjw7wTR/XrSOHZt953bDZd7LHAgJlIoo4sEZfsfcFjZ3yBjf6vP0f2/6Lp
         B8gw==
X-Gm-Message-State: AOAM5316Qka667N3bHThfs7Nn5nCIlmEp50MM7zPjrC5UjTsM+NO2y8E
        BYAOJn7Fk9n8SBYYu2OWWEf6vg==
X-Google-Smtp-Source: ABdhPJwlzXHvhSPQRbddkUP3BLbK8GixVJDMkV84qDw7iNlY99VclXQGU9+CQZVYIPvyq9d9G0DRSQ==
X-Received: by 2002:a62:7894:0:b029:152:279f:5dad with SMTP id t142-20020a6278940000b0290152279f5dadmr3541300pfc.67.1601970856096;
        Tue, 06 Oct 2020 00:54:16 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id r6sm2545147pfq.11.2020.10.06.00.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 00:54:15 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>, Rob Herring <robh@kernel.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 1/4] dt-bindings: spi: add mt8192-nor compatible string
Date:   Tue,  6 Oct 2020 15:54:02 +0800
Message-Id: <20201006155010.v5.1.I4cd089ef1fe576535c6b6e4f1778eaab1c4441cf@changeid>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
In-Reply-To: <20201006075405.11658-1-ikjn@chromium.org>
References: <20201006075405.11658-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8192 spi-nor controller support.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>

---
 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index 42c9205ac991..55c239446a5b 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt7622-nor
               - mediatek,mt7623-nor
               - mediatek,mt7629-nor
+              - mediatek,mt8192-nor
           - enum:
               - mediatek,mt8173-nor
       - items:
-- 
2.28.0.806.g8561365e88-goog

