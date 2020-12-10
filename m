Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD06A2D6593
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393192AbgLJSvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:51:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35216 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393184AbgLJSvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:51:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id s2so6883955oij.2;
        Thu, 10 Dec 2020 10:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TPxR1vthDtXH6neeu5qep54SJaMZ2V+xRx0pNvjops=;
        b=AlrfiCwASBuet85OoZYPPF1zWJ7Ei12GJX8IwvId87BGGVSmo0Pz/Y+Ahn0hS9a4wL
         gl5JiHvmELM/o/WTRoYnVtODcoVbXXOPuvcQc+xi2ntufX3KdF5VeKoBuD5Zp9ju8+Xf
         WSC1Et6JHjp3L+pSN9pw/6TApeTrL72Re5JdxLoMuZfld2Wsp1X+Urex6DkGQkg/nMsz
         +CeOkOvdysO7ONJN6YsO21RGPw1XVtnijK9c8AwldF/HuW5C0ZmJlG80pe3EzH604lWX
         XePocVNphlfJH+51usC7CJbXAGLQZY42JUW/a5U4yA7yEjBKn6vrZwOgvRLRrvuWY3mS
         QeIA==
X-Gm-Message-State: AOAM533NSX0ULMPIvC6Dus8sUzx0H4/9XBRS40vRj1TfXKtZAlSLHTlw
        LPyHMo+6RYD1YoJQTFhsezL41gTQCg==
X-Google-Smtp-Source: ABdhPJw9Fo0cj1YiB5dXR2HVsMZeuwv+dxK2OhhO4XYPXujtVU8Tp4QBfOlcDVERHha3oRVrTxfnhA==
X-Received: by 2002:a54:4d06:: with SMTP id v6mr6255851oix.91.1607626238979;
        Thu, 10 Dec 2020 10:50:38 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g30sm1184357oiy.57.2020.12.10.10.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 10:50:38 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: vendor-prefixes: Add undocumented bm, gpio-key, and mentor prefixes
Date:   Thu, 10 Dec 2020 12:50:37 -0600
Message-Id: <20201210185037.2796992-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bm, gpio-key, and mentor as vendor prefixes which are in use, but
undocumented.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c0c21be520e9..0b52b58aedcc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -16,7 +16,7 @@ properties: {}
 patternProperties:
   # Prefixes which are not vendors, but followed the pattern
   # DO NOT ADD NEW PROPERTIES TO THIS LIST
-  "^(at25|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio|gpmc|hdmi|i2c-gpio),.*": true
+  "^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|hdmi|i2c-gpio),.*": true
   "^(keypad|m25p|max8952|max8997|max8998|mpmc),.*": true
   "^(pinctrl-single|#pinctrl-single|PowerPC),.*": true
   "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
@@ -659,6 +659,8 @@ patternProperties:
     description: MEMSIC Inc.
   "^menlo,.*":
     description: Menlo Systems GmbH
+  "^mentor,.*":
+    description: Mentor Graphics
   "^meraki,.*":
     description: Cisco Meraki, LLC
   "^merrii,.*":
-- 
2.25.1

