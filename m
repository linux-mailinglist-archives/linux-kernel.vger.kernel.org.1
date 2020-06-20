Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EE7202406
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgFTNr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgFTNrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 09:47:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4864CC0613EE;
        Sat, 20 Jun 2020 06:47:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x25so9975368edr.8;
        Sat, 20 Jun 2020 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H2ID2fGwkugGQwDPqZjtWoCLEB9/5e1tlaFputOTEeY=;
        b=pLAUXQfk6RuczjJ8WBsEBqLFtMlXBq44qFmjvrXpUGKLKa405OLXNm0eiuXzFquYLp
         gSDwUJs/+SWrFUCbo+aCO5Xs1jFIYyISGQDkpP4tfJMoo+xklUtD1o3A4UzYeVge4Mke
         QZe/YP7bAjJ3wzVj0fVOYBNaT9cSBa9YrXM9ZYh73BGpN8YsOvJVmQpgsYGl4lyzeMnD
         Ij1rrYTd8mvfVnI7ChQpx8dEgbo8LLyQhusbU9IWQXjGPiFRXtqWnrSyc9lqKurWn8iK
         tNmAtP0anejlEXCwe1ikY8/n8W0l7RQzhyDCqlrm6NGlpL0bTpOUHKCNop9Rq9SD0Q8/
         Un7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H2ID2fGwkugGQwDPqZjtWoCLEB9/5e1tlaFputOTEeY=;
        b=HbzbC26+MZmeHakILKhgv193QWbO8bfXCAFAC9iAuTOUzUbPKf8GIrZrnz0lWmExTx
         R+rNK4BigKuLXL/P9K4ecfuMkJoLsmBmbdAr1Ky0cA/XeJI0x6SGwLwkw3aFY0FnKjcL
         VcgSYFsbCmKOEESmKum/thlF3tBwCbGuOOUBsRiR6NaNL6mBSdhnfSNomBsgY0PGaSLK
         e5arGnz4weD/l5Jy+VovQQ+FsKDhouAf6DhHEt7pGPPcjUI7bsspzaXywYNWfDojgJY6
         dOoJPExoP6htaFoJKQOdk8IRK/h8JAsCxKo1bWRZ3XQVeBgG2MI4+PE5w7VEEXXPWxvz
         Tysw==
X-Gm-Message-State: AOAM53206Y7WbL9ztuuTHkxoaVLLWuJg4v0Kh5vYWJ6Pxk3edUvqvg+0
        mAeAt8W1ybunhw8DFy+pHXs=
X-Google-Smtp-Source: ABdhPJzCl74SXvEQ4HCzy32o1R7AhFnWNWfGky/p5usTupGOxs2lIGa886Jg3F8fmFR9ibThxbyopg==
X-Received: by 2002:a50:8e16:: with SMTP id 22mr8292214edw.273.1592660828129;
        Sat, 20 Jun 2020 06:47:08 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s17sm7192368eju.80.2020.06.20.06.47.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jun 2020 06:47:07 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/2] dt-bindings: arm: rockchip: add A95X Z2 description
Date:   Sat, 20 Jun 2020 15:46:58 +0200
Message-Id: <20200620134659.4592-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200620134659.4592-1-jbx6244@gmail.com>
References: <20200620134659.4592-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add A95X Z2 description for a board with rk3318 processor.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index d4a404509..3d44b3cf0 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -25,6 +25,11 @@ properties:
           - const: vamrs,rock960
           - const: rockchip,rk3399
 
+      - description: A95X Z2
+        items:
+          - const: a95x,z2
+          - const: rockchip,rk3318
+
       - description: Amarula Vyasa RK3288
         items:
           - const: amarula,vyasa-rk3288
-- 
2.11.0

