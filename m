Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4520429E28B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404351AbgJ2CUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbgJ2CUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:20:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D16FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x7so1119653wrl.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HGVEMETkJOr4+FN6VCkN8y63pJyvuy45XkhfzNqdBII=;
        b=qPT2O48HoziCQ2Td21OWy7J9lNVCDvlTkyQoFUqMsDtNBbpaGyo+PQGXgxtsdHEPVo
         DjfXqcsYguO+z7PkM7bL8OaKCGhAjOyZxWM8OUCSYN5QQ8f/18+/l6s2wjRV5PV0UBB1
         J4+kt/LoQLA7mKrz5KD5j8oN3H/H2v03L2o8tFTaT4wDTJMFmbM3UjSvse50nyEdKDR8
         Ld/nCsdyLCTOsJWXfBZ9hekQDtQyz5x4y+O0AOUIZP79VjBOh0HPjYUdjTIhNkUB2oxJ
         2UAFdcFPPf548DlW0Uy9b0gBlgutlNsafIR5XRlc8VaHfLs2nomgJze0vDayV97LMqX/
         xhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGVEMETkJOr4+FN6VCkN8y63pJyvuy45XkhfzNqdBII=;
        b=em5nMGDGKVQqBUiCElMMdq7zw+fMa0165YV3n3OrvuCrIm4G2JHy8lHWf9FUVqztdp
         VDh6nrNwyuxmJyPXAG4mFpw8KZmILu6XVnFS1+zuRUezUUy/BV/VCwTnF2eTvsGoBYwY
         MB+HdmbOugifeile50E1Vf8Cjzh/guT93KJbMf8QPsdGPQWgWwbLqaQGaPys0rpvZX2g
         jN0bWzyqxh9UH4y/VAg6NpU1g9V5EKIGvmRURUoDiIpncm2NhS/ZNN0XnbnCf6/yEEm9
         hg8HhggEIMEetTcs/ou4d/IlzwVHmCgDGOdgtxG4lDKKeZSGcg5F1SZWrwLnNMuwNs8N
         R8VQ==
X-Gm-Message-State: AOAM53333vHR3+CGi2sP64ZhkH3FYP+V5RzD8/9MsWpLUJ61pct4vAk8
        OQY2M4PKhWMAZV9movRb9CQ=
X-Google-Smtp-Source: ABdhPJxYtXQDc2yquQfXhLJGlEJcD0MC61Yz063I5cWu+IbUhXVlbANonqozxUjPrnQah9X1ECYP4g==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr2683728wrj.410.1603938032307;
        Wed, 28 Oct 2020 19:20:32 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id m4sm2138937wrr.47.2020.10.28.19.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:20:31 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH 4/5] dt-bindings: arm: sunxi: add Elimo bindings
Date:   Thu, 29 Oct 2020 02:19:59 +0000
Message-Id: <20201029022000.601913-5-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document board compatible names for Elimo Engineering Impetus and Initium

Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 0f23133672a3..55405809ec91 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -898,3 +898,13 @@ properties:
         items:
           - const: xunlong,orangepi-zero-plus2-h3
           - const: allwinner,sun8i-h3
+
+      - description: Elimo Engineering Impetus SoM
+        items:
+          - const: elimo,impetus
+          - const: allwinner,sun8i-s3
+
+      - description: Elimo Engineering Initium
+        items:
+          - const: elimo,initium
+          - const: allwinner,sun8i-s3
-- 
2.20.1

