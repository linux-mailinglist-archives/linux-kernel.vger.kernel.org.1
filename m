Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300201A866F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440301AbgDNQ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404908AbgDNQtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:07 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722CE2085B;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=ftdzGG92AJu0MB3OTd2YxsGzGZ2H+4UraUBv4G7jloo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=titCjmfCrIwVlM7lzs0W4BdbK0Kjuohl6gnGlyZJ1eb6sqp4Kfw9/U5C6AuM8TkG4
         pWxnMKdkiYg9l0lfBygngiEtYvxtXGja+5nfSj06CsE64wAJ8/QScvMXmLoW6YaE6L
         uzKFIzszhQkykcjaw6GdS7W4rEeXaypQIEbXpKW8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068lR-Na; Tue, 14 Apr 2020 18:49:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 07/33] MAINTAINERS: dt: fix pointers for ARM Integrator, Versatile and RealView
Date:   Tue, 14 Apr 2020 18:48:33 +0200
Message-Id: <eae3440fb70c1b1666973e34fd3fd6b8ab4a3bc7.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
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
index 86f98c3e6cfc..82e4b0a0c921 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1323,7 +1323,10 @@ ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
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

