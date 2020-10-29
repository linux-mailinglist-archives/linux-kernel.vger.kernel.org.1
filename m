Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBEB29E8C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgJ2KP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgJ2KP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:15:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5580C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:15:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k125so120847wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYyCEb9n1uW/GtO+Icma9ul0k8OoUNEYDQcb88XmO5g=;
        b=O05Zz/pdl27ZIwt1YVkKcFWRvvhrwjPNE9cxeiuglOIbnH6BjoHV2zF/AvOHpPrqMh
         QNF0RzQjv4or6DnHhQOvxDJJHM449xfcFJxz1c2+CdNZCfuCphKAWVdfze7oCrduMIDb
         mGzE1XM8UXj389iex1BSebqeI/cnM/O1Ta8s/d5URElFfu3LRwMD7jLiYbNQvKX6FVd6
         UXz0x9odecvYPlkkU1EBaZfRvl7nhHhsj2iED9sWxKabnR63wh/OHRZu2OPaEng9gGYm
         /srhE/3A5TXmq/aNtps5sxRt+kAfl/SJL//AUDxuEwMD1DB1efMowkg5uELz6iKUi37U
         j5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYyCEb9n1uW/GtO+Icma9ul0k8OoUNEYDQcb88XmO5g=;
        b=h2WtXKZva9hch80tBpw3TbN7+zzzRCo2x01f16IY4znoaDbv8k9n19DXP0vfB/yOXE
         dcTyj0xGcsrL4o1MSaYlCvdDM9YIlN4GF/7Fcb7gtYUrdK6/YvcN4kF7fuLb03q9TLhB
         GALcbA5T9f1jcmMfUvVuvA1s1spNvTOfP3zLHe94dvlGFF4jd6+xuUWUBizIWUoYdBV1
         Ms3AOVhOs0XCimjX/GE5xkF5X7dHMXFs8ojI0BtphbUtUe17PalQ4tqeNgUWTl8TBI3g
         wXKUzM3nzw4pInp7lzFmJsXmwzYrBjgE+jTBy188LDZymbQPjAkX5qL9GINUfV6aV0hY
         YOag==
X-Gm-Message-State: AOAM530BgYSAr7LIFM2/ppxo+fJZmVJex6xNuFySKC8SikSrrc5A5f0j
        uddS1BxirV0ZDI3FW7EQmv6oKQ==
X-Google-Smtp-Source: ABdhPJwNELU/1Cf7kaWKDnW3VeGHFj4v73i/xYmaOjqFZoHSRmwDNjXa9Dz3BF4lx+TaAOpHlYdA2w==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr3493931wmj.52.1603966557351;
        Thu, 29 Oct 2020 03:15:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id 32sm4222495wro.31.2020.10.29.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:15:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] ASoC: qcom: dt-bindings: sm8250: update compatibles
Date:   Thu, 29 Oct 2020 10:15:49 +0000
Message-Id: <20201029101550.31695-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update compatible string as board compatible and device compatible
should not be same!. New compatible is now suffixed with -sndcard
to be inline with other Qualcomm Sound cards.

This also fixes the warnings/error reported by dt_binding_check.

Fixes: 765c37598494 ("ASoC: qcom: dt-bindings: Add SM8250 sound card bindings")
Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index b8f97fe6e92c..72ad9ab91832 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -16,10 +16,8 @@ description:
 properties:
   compatible:
     oneOf:
-      - const: qcom,qrb5165-rb5
-      - items:
-        - const: qcom,sm8250
-        - const: qcom,qrb5165-rb5
+      - const: qcom,sm8250-sndcard
+      - const: qcom,qrb5165-rb5-sndcard
 
   audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
@@ -83,7 +81,7 @@ examples:
     #include <dt-bindings/sound/qcom,q6afe.h>
     #include <dt-bindings/sound/qcom,q6asm.h>
     sound {
-        compatible = "qcom,qrb5165-rb5";
+        compatible = "qcom,qrb5165-rb5-sndcard";
         model = "Qualcomm-qrb5165-RB5-WSA8815-Speakers-DMIC0";
         audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
                     "SpkrRight IN", "WSA_SPK2 OUT",
-- 
2.21.0

