Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD627D966
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgI2U6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgI2U6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:58:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F7BC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:58:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so5928044pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYwUUIH7aJo21VgV3kgkXoXamfeVgQGrVjUeWz8T8IQ=;
        b=M3Ny7Z/sGhjTesPn/YjzXX72aY0MxN4FZy6Hj5AffcDREtgNIo3KmqvRln8lXny7Eb
         iNvR0Cl3M7dIB6romwqCHM70uX2UQkCMTSh/h3COyRF5TmBfktOvbQa1WFFa/mCBDKo8
         jfP3E6NQSLUdouEPzOGMp9fxhkTwjJNSNeVcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYwUUIH7aJo21VgV3kgkXoXamfeVgQGrVjUeWz8T8IQ=;
        b=P8mnaPxfx7sIkUV+Chwb23jDvFIElnzVuTSFJf1fyN/7cbmH8JE59e64Kw/Ua7C6+4
         QQrD8xwB5zHkxbaQ6pYntbeV+1qc9+mk9xHg/8skveSNe1EokaNwwnswApYXA1Hoy3oW
         o102qoPwobmVuYJ2PJvt/EjayV+0bxqkE7cpOyr8Qrx2Twk9TEPVLt3xfWlhjqnR2GbP
         f189fl4DxUfxHF0x+vPxZ0X8ExeEakdns+gdzdTfTuEcbRRJfVzMuoAg0W6D9kVxEv6S
         1zs6FeRM1aUBjP0646ARHlWkiGEy7RKFoS9PxtgTRr0Q9nYr5f4qKuPRsCIsBTMX16N2
         8a+g==
X-Gm-Message-State: AOAM531V/NjUUOdfaBcQPv1/WA7zWYxWKnol03W+JcBnb+jMhd8BkMWn
        8PXNn/xDT/uLhLeH8PnMQ/cQuw==
X-Google-Smtp-Source: ABdhPJz2dtPncP4/ej/nFRinWGUWYUYH1JXIcyiRGj5WBVMoJc3KZYjR2Eq3acknOxlPe4fZLgOGRA==
X-Received: by 2002:aa7:904a:0:b029:142:2501:35d8 with SMTP id n10-20020aa7904a0000b0290142250135d8mr5627145pfo.56.1601413103304;
        Tue, 29 Sep 2020 13:58:23 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:a2ce:c8ff:fec4:54a3])
        by smtp.gmail.com with ESMTPSA id k7sm5488101pjs.9.2020.09.29.13.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Sep 2020 13:58:22 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: nvmem: Add qcom,sc7180-qfprom compatible string
Date:   Tue, 29 Sep 2020 13:58:05 -0700
Message-Id: <20200929135741.1.I8b447ca96abfbef5f298d77350e6c9d1d18d00f6@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929205807.2360405-1-evgreen@chromium.org>
References: <20200929205807.2360405-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an SoC-specific compatible string so that data can be attached
to it in the driver.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 59aca6d22ff9b..b16c8e6a8c23d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: qcom,qfprom
+    enum:
+      - qcom,qfprom
+      - qcom,sc7180-qfprom
 
   reg:
     # If the QFPROM is read-only OS image then only the corrected region
-- 
2.26.2

