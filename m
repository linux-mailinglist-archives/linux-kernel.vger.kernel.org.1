Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB242FB745
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404035AbhASKdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389814AbhASKRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:17:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A15D2312E;
        Tue, 19 Jan 2021 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611051267;
        bh=nEeEvrRLh9lNcaUoTdN+s8gNyA0TJfHuL3xy6iPuWW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVhzSyvN3BHid174PZAImoA11IYv7/SgGp5/cHCmuNEjHdSv9uwsUn/k6A7HcVWpU
         WbSwFMWIEGzv1gl9a1hAu+9x3oHpldQ/d2mnisj1SGmHZNlMqE64dqND12MzjYfJA+
         /rrsDznEpPxGJFJWlOIW2sjLmlGO7xBg+Ycip40btCsrsRlg6rIEQlmEJQ3fi5YdAp
         /vLq/TWWNDWIF/2AxO+lgvOlTuYl2Patfs4DcJqnAUUifhe7PTc/qZ3cXpwTRjmJoN
         jpGS7vFh+xFP7Z69JgGs8o99alva4hBODWdbv1cJsrMfWEnnsRVH9fBHYWxlDhzguy
         TTCgxhJwELeHg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1o1o-000tOc-Gm; Tue, 19 Jan 2021 11:14:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/18] staging: hikey9xx: hisilicon,hisi-spmi-controller.yaml fix bindings
Date:   Tue, 19 Jan 2021 11:14:06 +0100
Message-Id: <226ffb8b47818fc08885f344e7213a5f71be2ada.1611048785.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611048785.git.mchehab+huawei@kernel.org>
References: <cover.1611048785.git.mchehab+huawei@kernel.org>
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

