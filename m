Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210D6228388
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgGUPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 11:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbgGUPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:21:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F69C061794;
        Tue, 21 Jul 2020 08:21:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lx13so22054073ejb.4;
        Tue, 21 Jul 2020 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnSVvBPLgxOr7Okxa4+yFdbMwIKkVndKbRuepRfY/Zs=;
        b=Wda03GT1kLUZKx6XiHGQWkJ8oovNFoSvac/RNxLY0dRCc9Ex7MFTykiVGOr6g1cYIz
         8W6P/7J5zILoKpIDFBn7/tMyrlVP4KVZIkpRiCotzXU39lP8i6VstOJIq5YrNxdcFBff
         nE5eQg8k2a42+icZuLTufOsfcJjDfOA974arJ75VBVDFblqAE0DvEVwQVz++9btRFtCn
         BSRSNIEVDK6tY1iGQCqMPQi7YmvoCboaHs4ODrt10KPx3lTizXg6JKAkfvJ7Edtd5pPK
         nEjRrvomS1rrLAFD0St4GFU9yseLSBQgEt8VGYjqMsm//6ml0RhorAov+cTFcoNT44sA
         OZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnSVvBPLgxOr7Okxa4+yFdbMwIKkVndKbRuepRfY/Zs=;
        b=YuNQ/YwHHu1WvYgxoy5lGod9dmv2NeetxC7d4Fa5hKq9moNcFY0TlNYWtbAu7Lyzsu
         e+sHkySjL+WAuT85W1J+PkYkeOEvjlBSTcYgV1Eb00gUV2DoJHut7bxipEesBTZsTWq/
         oq8s8d6TNqj8KZKPnRRbY6Pl3gcbWOuMu7XWuKKjs3JwIFsbNgzzB0e6a+jb3IoLnGgK
         4lJBoX+Iz8aWPjh80TU4wm4QqyuKnwsZOXIcW0PZLvjhj3iATlP1HVXh2p36oSm+cSKS
         ycVw+Es3HpZ2vT6Yg8xFRp9i7u2Xr0H1t02Yb9Iql/bZe1flqSRzVRFhINQ0PVkamWdG
         yFyg==
X-Gm-Message-State: AOAM532kCz3s5MDD2hdi5W+hrFK4eH+v0cgEeq3IzQgx3lcFIKAB+tOq
        LLdKGFHMncAOujRCfsmPZXI=
X-Google-Smtp-Source: ABdhPJyrp6isiaaIr9nG0cnRhonPmQ5H1ZVfdtX2W04YIAlxyAxj8uwojDguD+DjbG+cG1Ouhgfc4A==
X-Received: by 2002:a17:906:abc9:: with SMTP id kq9mr26310856ejb.493.1595344862703;
        Tue, 21 Jul 2020 08:21:02 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id se16sm16802826ejb.93.2020.07.21.08.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:21:01 -0700 (PDT)
From:   Marcin Sloniewski <marcin.sloniewski@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, mani@kernel.org, a.fatoum@pengutronix.de,
        marcin.sloniewski@gmail.com, sam@ravnborg.org,
        linus.walleij@linaro.org, heiko.stuebner@theobroma-systems.com,
        stephan@gerhold.net, lkundrak@v3.sk, broonie@kernel.org,
        allen.chen@ite.com.tw, robh@kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add Seeed Studio
Date:   Tue, 21 Jul 2020 17:20:13 +0200
Message-Id: <20200721152015.11608-1-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "seeed" vendor prefix for Seeed Technology Co., Ltd
Website: https://www.seeedstudio.com/

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85f..7dd03b3e9d3c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -902,6 +902,8 @@ patternProperties:
     description: Schindler
   "^seagate,.*":
     description: Seagate Technology PLC
+  "^seeed,.*":
+    description: Seeed Technology Co., Ltd
   "^seirobotics,.*":
     description: Shenzhen SEI Robotics Co., Ltd
   "^semtech,.*":
-- 
2.27.0

