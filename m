Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5594F1A260E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgDHPsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729686AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB29F221EC;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=yAOsXbL7fg020jSPFmIR1e4J97xQZcJrrPalm0wfW+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/sb8b09rd+lmNDr5/l5llwPOyWVGz0nsjaHvCrJBq0H+Vzr6lISTG+mmfGhiH4a6
         ZrI5WCOp6tGmS0KKS5PR+k1AGSaiSGQ2L1VUxgT7EEDrOP8LzZzH+2Q9vajqYATQ2s
         GvZwN5REBGZ5NY7NnhFS2wdKsbHQ6JlD4gCojYsU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuM-000cCa-5P; Wed, 08 Apr 2020 17:46:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 29/35] MAINTAINERS: dt: fix pointers for ARM Integrator, Versatile and RealView
Date:   Wed,  8 Apr 2020 17:46:21 +0200
Message-Id: <d8b0656cb3f1eacb10ca6168babb235d59a853a1.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a conversion from a plain text binding file into 4 yaml ones.
The old file got removed, causing this new warning:

	Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/arm/arm-boards

Address it by replacing the old reference by the new ones

Fixes: 2d483550b6d2 ("dt-bindings: arm: Drop the non-YAML bindings")
Fixes: 33fbfb3eaf4e ("dt-bindings: arm: Add Integrator YAML schema")
Fixes: 4b900070d50d ("dt-bindings: arm: Add Versatile YAML schema")
Fixes: 7db625b9fa75 ("dt-bindings: arm: Add RealView YAML schema")
Fixes: 4fb00d9066c1 ("dt-bindings: arm: Add Versatile Express and Juno YAML schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67e52e9d630c..72fb84483a23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1296,7 +1296,10 @@ ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/arm/arm-boards
+F:	Documentation/devicetree/bindings/arm/arm,integrator.yaml
+F:	Documentation/devicetree/bindings/arm/arm,realview.yaml
+F:	Documentation/devicetree/bindings/arm/arm,versatile.yaml
+F:	Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
 F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
 F:	Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-versatile.txt
-- 
2.25.2

