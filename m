Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5D29C93C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830526AbgJ0Tsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:48:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37193 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830517AbgJ0Tsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:48:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id c16so2669623wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hLsmVRD6KI4G1EA4PKVGyaEE4muIeMLkXJ8Hxgq8zc=;
        b=g6+x/GLt8CwpScbwoNFsJjQgHbjy/vmJ0KLfnp7JOvlw7H5ciaP1xUfOUr56UGQLU+
         4FvhCOwGz7hcuTqpS+eXI8v1LAKua/OuswV8sSwejLwgEwYCYcX/iko59ZMbBa6biz2Q
         li2JAqYpA0rDKK+HKbKp+fsU5SwTjfqgNAy7i5vXsXzFA4q5XUMg+vp4tAUArnT+Ece7
         XuC0xWi+xFnoOu+yPZzEPWEjOhPScdJXcpd7tzWu9+ZeX5S58y9ba3LvfiiyFeBtgADw
         5+NbUZ4Cn38mlCfsbpOPacdWoOnEBiAJfcbQngrBh1YWFBIP/9b3zcsq8TM8MZhmssCm
         /nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hLsmVRD6KI4G1EA4PKVGyaEE4muIeMLkXJ8Hxgq8zc=;
        b=R6LRfCZ+PjlfeiQhuhMGm7Sf3Kqb9guXSflluhHpOhBA7cHXzwdJcbJRYoc4f4E8AH
         ldGj6Fg0++0xX9zt/26eQUSG4T84k4AAwzMgt4WmkBKaEEr9RhMk1k1CnUOnjy5kixry
         Qwd8F86ye7Ksyf6nvBQiteshvE9zHBreGEd3WDHU2Wi79AIILNU+4jFdqi986HZnyDnj
         +bgH+2MmFfJZGfI65IVbN696VQVV6Ayz8JDD1EzCfbiYNkkKJle7hQMHcIrSrMTAY4iT
         g6Oz3mnwkdLJaRrftf++tHYV1PAzt+sYhoEqfUcYfQ7kQCYyFpuHNrOe17uem53NloeD
         yMbA==
X-Gm-Message-State: AOAM533m7G1XCqOy2c16oWYPW+qrflorjKjIlpMbJ5AkhljQq/mfQn8B
        vUYbDjDzkiPUb53sNLcC4sjz3A==
X-Google-Smtp-Source: ABdhPJy5s4X3sTXQBhl4W6qUJ0tqu7xQOd7uQPKTN+jIC2MCmU8BspUNsMBu9GxI3FEqt4cJZB0+qw==
X-Received: by 2002:a1c:9c51:: with SMTP id f78mr4608115wme.189.1603828115582;
        Tue, 27 Oct 2020 12:48:35 -0700 (PDT)
Received: from localhost.localdomain (159.174.185.81.rev.sfr.net. [81.185.174.159])
        by smtp.gmail.com with ESMTPSA id h62sm323222wrh.82.2020.10.27.12.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:48:34 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: arm64: dts: mediatek: Add mt8167-pumpkin board
Date:   Tue, 27 Oct 2020 20:48:13 +0100
Message-Id: <20201027194816.1227654-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the MT8167 Pumpkin board.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 30908963ae26..5c772b937efc 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -84,6 +84,10 @@ properties:
           - enum:
               - mediatek,mt8135-evbp1
           - const: mediatek,mt8135
+      - items:
+          - enum:
+              - mediatek,mt8167-pumpkin
+          - const: mediatek,mt8167
       - description: Google Elm (Acer Chromebook R13)
         items:
           - const: google,elm-rev8
-- 
2.28.0

