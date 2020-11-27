Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CA32C6316
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgK0K2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK0K2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:28:48 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D968BC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 64so5003587wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUW9IjC/h6SM9IIhtybKUfo5jN6fum8ClPXJKw3+X6c=;
        b=fSpLziPt6HcskUrKSMST5o0Urg1bf73KamBVOTvtsqded0XaF/GHBXGuKyN5eD6OgD
         kRxy+K2WXkS4lLO22+Gc7jmvemKnRAjDKw3szuljYuEnnHrPrV2wwIDbWsZGppqK2cXT
         D7lSs7t4u9pwHemjYrGoWIVkqLSP0b/L8J9Yl6qZ8gTlGI7ePpM/OpytN+ULAy+zLcIR
         vpEsCuD7mO9j3iqKYEcxgkNL1sZ/DzTtgSH0mE3WLNd5IClhnTzm+LflvIiOjt85/zlX
         XTdNOpsnpr+dAwKDDmB9/+8n8IfdoZjZrLXAJpUBMHZ7o0cmcD4t/MaG/06aKX6wzoa/
         01mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUW9IjC/h6SM9IIhtybKUfo5jN6fum8ClPXJKw3+X6c=;
        b=PrrxJPJOHKFVDAk9HGc9UTrqJMuowNZS32Jbl1OT53Zgxb4nMplDubLGG5GIKdY9e8
         D27KtxaLFOApGYEk1iwdzmcq+n+yeI0Iwc+AvRhfi/5FGYvFMQeagVKWBqoVKTlXIpqq
         qTKQgMC46mTfZqOO7VxpxJX5TBSW/xVV3ho4P+3vjcLjv83O10eH3RzabbJP64zXGigs
         os5yVwqWEs/G9jNYVwGWKa9Gwk5xE8k53cLjZrSldXvHaW09A3WqP7iYwdCv+lNAvNqH
         YGD9x1XjfnKP8xb3Tf2v2MX3RadEU8yc/B//7IJzi7SWCWL7taurqbhmXn4wryBgNUIR
         ELjA==
X-Gm-Message-State: AOAM531H976Rtmf9NPgOEw80yLeci0nkonyuK2l+/GQbF5mI5ZM4fVm+
        lOV7yTOAjt0JH4X9bme6EbkD2Q==
X-Google-Smtp-Source: ABdhPJzTTkdbtsCvwVwDY3aBBE+xxhnWE+V46AKVzAlL4kGpl9+A0u7eQc5/XGHnVs2coJQeX1XWCA==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr9637024wrb.228.1606472925681;
        Fri, 27 Nov 2020 02:28:45 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d8sm14073051wrp.44.2020.11.27.02.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:28:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/5] dt-bindings: nvmem: mtk-efuse: add documentation for MT8516 SoC
Date:   Fri, 27 Nov 2020 10:28:33 +0000
Message-Id: <20201127102837.19366-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
References: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for MT8516 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
index 0668c45a156d..ef93c3b95424 100644
--- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
@@ -7,6 +7,7 @@ Required properties:
 	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
 	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
 	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
+	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
 - reg: Should contain registers location and length
 
 = Data cells =
-- 
2.21.0

