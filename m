Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA81C2D89
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 17:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgECPme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 11:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbgECPmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:42:33 -0400
Received: from localhost.localdomain (unknown [157.51.190.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276C3207DD;
        Sun,  3 May 2020 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588520552;
        bh=o8sRhaHgWPSPd3P6mFJsQFZFuiL8sjkixOve0V/XQ7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATJoA/U+2a4/VWsRvwZfgHEx0Yo+tJVM8MJ/kgIWWd2rtd6dt/bvLaIn15YJ1WS9i
         nVJC7tvOyD+ie19Rx3PGAUzHdON/esi4xr0/d9Szg8VDacW4HCKkvVu5gQC0WaOjoE
         CFi96PoNLl6iKI2QJJFoxbld+Li54c74ZBNHgce8=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: Add vendor prefix for Shiratech Solutions
Date:   Sun,  3 May 2020 21:12:10 +0530
Message-Id: <20200503154215.23654-2-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200503154215.23654-1-mani@kernel.org>
References: <20200503154215.23654-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

This commit adds devicetree vendor prefix for Shiratech solutions,
a SOM/embedded board manufacturing company.

https://www.shiratech-solutions.com/

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index e3f1b06d12ae..48ad8f954f33 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -902,6 +902,8 @@ patternProperties:
     description: Sharp Corporation
   "^shimafuji,.*":
     description: Shimafuji Electric, Inc.
+  "^shiratech,.*":
+    description: Shiratech Solutions
   "^si-en,.*":
     description: Si-En Technology Ltd.
   "^si-linux,.*":
-- 
2.17.1

