Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49482603CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgIGRzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgIGRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:54:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D47C061573;
        Mon,  7 Sep 2020 10:54:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so16616432wrr.4;
        Mon, 07 Sep 2020 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FbRc5khqS8fj5sPJsPlmiUlETyEoMORWYslwTB7qr70=;
        b=fDz8WphjtGoceLUkrGnnfBAOwDy5R8rTqCFJt4PTP+rBKl/C5XoRukYIkF3G2w9elx
         PUVLJejK4SzQ1ZTR2pTmWD5lXLdGtREDcihYsHauYv5JcWGJVGgsm5R1GYZzAcqiyIDY
         3Q0NdERNA8RYIyQOUcJgMPbzEL0UY5iYojbeYCK0cxWshQbnGuYTE3N1bT6dviE2kz5Z
         zTHwoeoMIgvH7wk25c8sP2Mvqn9yz9F0nPn8jjADAbpHgcKEiF3qH/dKpN0xhcKwYKVa
         CcUSK8s8myoplLJskSpusJcfIODFVnjlx7CAZPakyHWbCVmCt1dXr1HtLDUDpB82i7q+
         TMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FbRc5khqS8fj5sPJsPlmiUlETyEoMORWYslwTB7qr70=;
        b=VExl44I8++okZ87a7TkqakrZWyoPKvIzVe4qzbQM6KOVNaWytbw4DbvYxGJENa69+C
         FNltfkaehuxWlZIv6DFZztDRPuvibWBniAW0eeizg1ktQHQom5g/UXx+2vdGb/22XfFt
         +bWz2iSprLVFch4Fo7ZnyvqNGWIWLR251BFt7QjYuVCE4u+nSaumQQOegGkkStxObENU
         ROFSVAV7Lh14kFQiXJUsBiZSlHlFDf/BMsUdko1bum8Vt0ARY5gMuuM9JK0N0Ymg7RYe
         i06g/SxFRUZn6fUIq5xcoPEKdJA8obSLTa4swH/sO9rh0bpawx7ho9rizxLCbMOhwwwt
         6jQA==
X-Gm-Message-State: AOAM533hB8OHNElj3wx2K5Y4Vz6BtToSDekSVJJ6hJTho6ediKJO2E3J
        sHEOgTeh4dvj3aE5Z7maHiU=
X-Google-Smtp-Source: ABdhPJyJbIrC0i02kkLyImI7fa2gKNv0JlxUJcUkpnOxEI7wSgKZ5W7ljdSo3sEUeo0nn22qV5Ktcg==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr22359726wrs.230.1599501286489;
        Mon, 07 Sep 2020 10:54:46 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id f6sm29049995wro.5.2020.09.07.10.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 10:54:45 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, m.cerveny@computer.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v3] dt-bindings: crypto: Specify that allwinner,sun8i-a33-crypto needs reset
Date:   Mon,  7 Sep 2020 19:54:37 +0200
Message-Id: <20200907175437.4464-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding allwinner,sun8i-a33-crypto, I forgot to add that it needs reset.
Furthermore, there are no need to use items to list only one compatible
in compatible list.

Fixes: f81547ba7a98 ("dt-bindings: crypto: add new compatible for A33 SS")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
Change since v2:
- fixed enum syntax

Change since v1:
- use an enum for adding allwinner,sun8i-a33-crypto to "reset list"

 .../bindings/crypto/allwinner,sun4i-a10-crypto.yaml        | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/allwinner,sun4i-a10-crypto.yaml b/Documentation/devicetree/bindings/crypto/allwinner,sun4i-a10-crypto.yaml
index fc823572bcff..90c6d039b91b 100644
--- a/Documentation/devicetree/bindings/crypto/allwinner,sun4i-a10-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/allwinner,sun4i-a10-crypto.yaml
@@ -23,8 +23,7 @@ properties:
       - items:
           - const: allwinner,sun7i-a20-crypto
           - const: allwinner,sun4i-a10-crypto
-      - items:
-          - const: allwinner,sun8i-a33-crypto
+      - const: allwinner,sun8i-a33-crypto
 
   reg:
     maxItems: 1
@@ -59,7 +58,9 @@ if:
   properties:
     compatible:
       contains:
-        const: allwinner,sun6i-a31-crypto
+        enum:
+          - allwinner,sun6i-a31-crypto
+          - allwinner,sun8i-a33-crypto
 
 then:
   required:
-- 
2.26.2

