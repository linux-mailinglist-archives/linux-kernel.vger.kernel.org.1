Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0A22A8660
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgKESsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:48:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKESsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:48:17 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6491206C1;
        Thu,  5 Nov 2020 18:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604602097;
        bh=hiaJ+qpS2C8Kci86edeTVYPHnM6sAzoq5PKiZ3w8AJo=;
        h=From:To:Subject:Date:From;
        b=T9StjDGIKAy3SjDb7JV+xEROPu/6sKNVbvNE46WjAXIlApDlBxWcnbtD2+Jm3ysAy
         iFZNLQ8V2I+3wNjzR4py2/s00iwwXEn/k8G+9/LDPz2cEU5Gk1RRMlbeG1aYnvu9VV
         1DM5MFlBNAdAI4x11193dZ+a1dmxxaQxMVhwMwro=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: fsl: document LS1012A FRWY board
Date:   Thu,  5 Nov 2020 19:48:07 +0100
Message-Id: <20201105184808.216384-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for LS1012A FRWY board.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index e4db0f9ed664..325fee3c1900 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -794,6 +794,7 @@ properties:
               - ebs-systart,oxalis
               - fsl,ls1012a-rdb
               - fsl,ls1012a-frdm
+              - fsl,ls1012a-frwy
               - fsl,ls1012a-qds
           - const: fsl,ls1012a
 
-- 
2.25.1

