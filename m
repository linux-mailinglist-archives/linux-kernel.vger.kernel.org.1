Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B852FE3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbhAUHTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbhAUHTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:19:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4A3523788;
        Thu, 21 Jan 2021 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213508;
        bh=nEeEvrRLh9lNcaUoTdN+s8gNyA0TJfHuL3xy6iPuWW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7VodgQ8cHSMlTtAH60Vnb73K41lCtUctj1PFZLp5cCMJVJDj+5BjWT5V2pOqYMwn
         kASWNJEsL5s/mHGiwjs71DEz1uhIOi5Esb3bcZ+QxIH1Ep2JsoVYF7KJcOcKWQ39T8
         l1XVneOLJrcmkETMO2lA3kR0DwB2QPllWvLOwo5NIDbQbnDgb1cj6m7NlGuNtIuBaw
         oMyu3gl8TARhZyt2lhI4HahrSSuktj6yrXk8fM1x4u9K4PCi9wySjbRv3SI/cQRz62
         eERZlO7u+GWI7I4DqjAmcqaT/ZM0xP+cl1s4++lIsvasTNm0FWZu3nqkjep3D12PFI
         Iv5gwbYy0IF+Q==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l2UEb-004Brw-AK; Thu, 21 Jan 2021 08:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/21] staging: hikey9xx: hisilicon,hisi-spmi-controller.yaml fix bindings
Date:   Thu, 21 Jan 2021 08:18:03 +0100
Message-Id: <fca7260e7c61f073ae376ab23f58856ba5a87a7a.1611212783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611212783.git.mchehab+huawei@kernel.org>
References: <cover.1611212783.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few warnings produced by make dt_binding_check.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../hisilicon,hisi-spmi-controller.yaml       | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
index f2a56fa4e78e..21f68a9c2df1 100644
--- a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
@@ -26,14 +26,22 @@ properties:
   reg:
     maxItems: 1
 
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 0
+
   spmi-channel:
     description: |
       number of the Kirin 970 SPMI channel where the SPMI devices are connected.
 
 required:
- - compatible
- - reg
- - spmi-channel
+  - compatible
+  - reg
+  - spmi-channel
+  - "#address-cells"
+  - "#size-cells"
 
 patternProperties:
   "^pmic@[0-9a-f]$":
@@ -43,6 +51,8 @@ patternProperties:
       are documented at
       drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
 
+additionalProperties: false
+
 examples:
   - |
     bus {
@@ -51,11 +61,14 @@ examples:
 
       spmi: spmi@fff24000 {
         compatible = "hisilicon,kirin970-spmi-controller";
+        #address-cells = <2>;
+        #size-cells = <0>;
         status = "ok";
         reg = <0x0 0xfff24000 0x0 0x1000>;
         spmi-channel = <2>;
 
         pmic@0 {
+          reg = <0 0>;
           /* pmic properties */
         };
       };
-- 
2.29.2

