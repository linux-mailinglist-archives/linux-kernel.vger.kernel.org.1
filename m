Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D272928E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgJSOHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgJSOHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:07:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80F4C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:07:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so11604349wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWLN3YIMsxR1iGy7rW1d21liH/vLTaxscqX6iA3EebA=;
        b=Ixfn+4ugrcnS0mcW3BpGq5osRpI/rGY/CpMOsUqua/hbUa+kFr/ArHc10T2Dxc99gw
         m9g/xwwtm8YQsVgMYeGuFEMDGXwN17ZEDGoWyeaPfZzQHcMrJF0z6smN9CjY0BC6h3kB
         gyKQesVJMikHoAQiI+3NW1VsGkrKqQHi/NcEec7KYt+Mqgf9AyQXzlYvCeXOEJeYkeSn
         slON715WIhocdH5j8IPKbVCYrfsglhtXQX8TwBxEY1iB10d/Wzi2TJY8yranDGWHLlqS
         xRUNyjec1IBAB8zs3SaT9ttqc3YJhecUHYOjNDIc2m8PZODMC9+8yHId0iTorspZQFLZ
         bjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWLN3YIMsxR1iGy7rW1d21liH/vLTaxscqX6iA3EebA=;
        b=DyvPSaXk8sd9C/0y3G0zXe17zBXwEjmcvKvoiuPO6C607t2eDKqz6wqAcrjbOudtEE
         mnpWM07e4/4P6f9GNz7bANXZXd+DrgADPuekvHHlD6nPDFrpE2SQ1F8+tqnfXkS36Aqa
         5tBey0fAX46KybXYCAT1NDMTVv7pyWGqGiuJcU81bbYRMbdmpPg9QihNVPiH9iW6yloW
         3Xkwg+Z93hZksPKrIA1p2VZsUWvwnAoxWbfYKeKyqZGxHXzg5dlVmtQXKw3yxA8fhXl5
         CjImOTAAmgdbFaf8Qp4rXimZ7+TVi65zJsSZul11VjQDm2A/u7XG6fEzRCQ9qsvli9Dr
         rMWg==
X-Gm-Message-State: AOAM532+EOu6ez1rCyS6qfi6qyJsVkZXI1npLOIRy0s5e7MUYCYne57o
        C9+u/CDzmkFGdpoB3XHSUVXBIg==
X-Google-Smtp-Source: ABdhPJwUZdiAJQZSzWLvRRrWeMnEjALHfBudLnha4o6MOrkzvyGZ8EKUQGdLBDYORfWVRnYqKGuLsA==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr20998755wrw.132.1603116431423;
        Mon, 19 Oct 2020 07:07:11 -0700 (PDT)
Received: from localhost.localdomain (26.167.185.81.rev.sfr.net. [81.185.167.26])
        by smtp.gmail.com with ESMTPSA id a3sm114182wmb.46.2020.10.19.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:07:10 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/5] dt-bindings: pwm: pwm-mediatek: Add documentation for MT8183 SoC
Date:   Mon, 19 Oct 2020 16:07:01 +0200
Message-Id: <20201019140705.1518822-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019140705.1518822-1-fparent@baylibre.com>
References: <20201019140705.1518822-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the MT8183 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 29adff59c479..25ed214473d7 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -7,6 +7,7 @@ Required properties:
    - "mediatek,mt7623-pwm": found on mt7623 SoC.
    - "mediatek,mt7628-pwm": found on mt7628 SoC.
    - "mediatek,mt7629-pwm": found on mt7629 SoC.
+   - "mediatek,mt8183-pwm": found on mt8183 SoC.
    - "mediatek,mt8516-pwm": found on mt8516 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
-- 
2.28.0

