Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF12A8627
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbgKEScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEScl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:32:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E283C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:32:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b8so2938851wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BsVx0tqKa5RJACoTi7hCHH0q4zK+zFVU579TR+p2CVA=;
        b=TA5xW78ihacMUx/Y7YaIwkfRvmRFWRJlfZE0c2d3nH+QM/km4Pp3LIpJDBh5YihsYD
         F4hgWHmKqsGjgcWRML71iTNaGzaizgYDLwij9ZuFYKNORVMAybc/dwXHYn0xr5PeXx7a
         eP8KOOOqVy6+z23vpGmADyfldV+L+yu9B+HZ8DwUOsTrBu9VlMQKbBlsN1mdKNdlNRU/
         seIIb1AXcPTrTD9YzghyasxzpSuo8/2P+ocLVgyw16MJQKVuI4Imf28TxPwWB5EzPqC/
         znV32CrridUd6frzL9gP2JQdGsld7fOxV0Vr0dMTearFF48JS1p8/opR9m4H3LsHPv2+
         gllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsVx0tqKa5RJACoTi7hCHH0q4zK+zFVU579TR+p2CVA=;
        b=mBm7VDcvRHqimHDpTRYk1XLGvLrlg3U0rD+X23q5mJgndxbtYznK3+n9k9k0yL2kAh
         2g9vwknrM4Qj1j66wr2MSlsVA+ofHlPsrv/JYOqFYPme3qHDE4NaBH4Gd1fhC2v0ygqz
         0oCrv6UvrXxHlN9lSJO3fsV2IuLXFzjzcdiZPUts7wmKfl/LHOVxginMBCkd0dUNpS2L
         WfOjXRtlyNCgK0aD2PKhtad+abwk6b6IVRbjsY5r7saG7HLcKBkjaFa1KT7Dq63n9XsA
         q2yrpjkW7Vjnx93Y7+ZhLX40/a32LLtyyBOMdJIdtuZozILj+dvzmHTaVa1+FGi+Sqnw
         /E+w==
X-Gm-Message-State: AOAM530s/2q0QGyRG6+KAQYcUJwjb6Z07KHDemOWMrYiC8A2WNpjlaFB
        wrMF4EWm2zhMmCvlCWRV2gY=
X-Google-Smtp-Source: ABdhPJzzCSpiuJxc0EHrxrImMABjkjMll80+raaVBm9BC6fo3/zG0kJq5+Y9Te8hDVaGtk4qpY5s3A==
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr4316069wrt.141.1604601160091;
        Thu, 05 Nov 2020 10:32:40 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id h8sm3569601wro.14.2020.11.05.10.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:32:39 -0800 (PST)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v4 2/3] dt-bindings: arm: sunxi: add Elimo bindings
Date:   Thu,  5 Nov 2020 18:32:30 +0000
Message-Id: <20201105183231.12952-3-matteo.scordino@gmail.com>
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
 Documentation/devicetree/bindings/arm/sunxi.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 0f23133672a3..ef2ce3bd2bed 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -201,6 +201,19 @@ properties:
           - const: dserve,dsrv9703c
           - const: allwinner,sun4i-a10
 
+      - description: Elimo Engineering Impetus SoM
+        items:
+          - const: elimo,impetus
+          - const: sochip,s3
+          - const: allwinner,sun8i-v3
+
+      - description: Elimo Engineering Initium
+        items:
+          - const: elimo,initium
+          - const: elimo,impetus
+          - const: sochip,s3
+          - const: allwinner,sun8i-v3
+
       - description: Empire Electronix D709 Tablet
         items:
           - const: empire-electronix,d709
-- 
2.20.1

