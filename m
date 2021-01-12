Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421C42F3A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406747AbhALT3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436981AbhALT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:29:19 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10640C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:28:39 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 81so6433095ioc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDUOxqEMBpU3sxt2xm5/+EtNoZZXuRmex+msJQtfVTk=;
        b=DdOGsJiq/GNjsLUoQrt7cXvifJjuBJZhTDX64eJTpFULeuNr601/wpxaUL7MPYpTXH
         EXQJcQqTVE0z7DvCCZE3T6lxeZ5wOHKu3mtQIGggW5/uT0TmSjuHl5xZkpyKwVKzQ4kM
         o0YwL+vHI+gMFsmsXP9h2ScnOGncJdAHyN0S5ilV9GejZb1cNiMYATefvdof/zS9JRC/
         ehrky/wkTE+UmC9MZkfag2+/U7YhHHNm6zUmDvPQOxxrvZyjrsv/l1BggOamg6VIBsQ3
         94J5IiDcpi+NNXQB+pD8OYkhJmPG9PrtXq022Pi0pNnuRK8g8PMf0kHFbf74l5gujzR2
         6a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDUOxqEMBpU3sxt2xm5/+EtNoZZXuRmex+msJQtfVTk=;
        b=cpxGrmT19jATZLbd4IvlBfz4C38ojBqsPa4hAOoNoRSM4UsCkkhVgVQ3Sa3B5+N6Su
         PRGmlhWDzJsdApjp5yP78bM62WPBDduk8xFNexkbXChcgdBsnXEuAXTsOyHjIj/6YyWE
         2c6BHApLEHTMQfUZxPS/MUSSXVMuUzS4WQriq3WiuXU1ARBOSL5444PXxutnbBE+s1FI
         ZpHb2kFAswpgfM652edjkyylexdF+yu3MT3WdxLHlG/180aV205kegKXz8W+NlpTT0gM
         FnsEKyYlG4UtxKf5odF8cxpVgby8aIbbwyY6YI6p/GmUUv+9MfBCsRV+SNyxMyOSn/TI
         8EAQ==
X-Gm-Message-State: AOAM531wGB6+8C9Msu3lrB3eeyCY/P2+FhxtlclSdhMBv+I3dLAuSzyp
        UbU5cmOSpkhAYqWA+5xNeGuLRQ==
X-Google-Smtp-Source: ABdhPJyZfHZaJbNg5oOL+A7v3B+XicEWh9QqqGkT8GkfuYe/+3mxG2rbVIuSJHv0Vl+d8qARCtnBOw==
X-Received: by 2002:a5d:8405:: with SMTP id i5mr443652ion.164.1610479718456;
        Tue, 12 Jan 2021 11:28:38 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id q5sm3191892ilg.62.2021.01.12.11.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:28:37 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/4] dt-bindings: net: remove modem-remoteproc property
Date:   Tue, 12 Jan 2021 13:28:29 -0600
Message-Id: <20210112192831.686-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210112192831.686-1-elder@linaro.org>
References: <20210112192831.686-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA driver uses the remoteproc SSR notifier now, rather than the
temporary IPA notification system used initially.  As a result it no
longer needs a property identifying the modem subsystem DT node.

Use GIC_SPI rather than 0 in the example interrupt definition.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 8a2d12644675b..a8cff214ee11f 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -113,13 +113,6 @@ properties:
       performing early IPA initialization, including loading and
       validating firwmare used by the GSI.
 
-  modem-remoteproc:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      This defines the phandle to the remoteproc node representing
-      the modem subsystem.  This is requied so the IPA driver can
-      receive and act on notifications of modem up/down events.
-
   memory-region:
     maxItems: 1
     description:
@@ -135,7 +128,6 @@ required:
   - interrupts
   - interconnects
   - qcom,smem-states
-  - modem-remoteproc
 
 oneOf:
   - required:
@@ -168,7 +160,6 @@ examples:
                 compatible = "qcom,sdm845-ipa";
 
                 modem-init;
-                modem-remoteproc = <&mss_pil>;
 
                 iommus = <&apps_smmu 0x720 0x3>;
                 reg = <0x1e40000 0x7000>,
@@ -178,8 +169,8 @@ examples:
                             "ipa-shared",
                             "gsi";
 
-                interrupts-extended = <&intc 0 311 IRQ_TYPE_EDGE_RISING>,
-                                      <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
+                interrupts-extended = <&intc GIC_SPI 311 IRQ_TYPE_EDGE_RISING>,
+                                      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
                                       <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
                                       <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
                 interrupt-names = "ipa",
-- 
2.20.1

