Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC862F496E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbhAMLBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbhAMLBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:01:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BA8823447;
        Wed, 13 Jan 2021 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535570;
        bh=usBYgqfS4umIzINtxT4Nu+/0pMkIB1VBJg8Hcuu4a4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D0kQMvh+6xU4pn8wdIY/LKaWRNZRhq66KAxXllJtJRZMjpaqRVBu1cJM8r76AXOda
         OdEujvrHbK2tzLM5FSMUhiQzEMaEOUHZij27aKs/aErdNyvGLGWrdyT1dLux3P1MI4
         xuSk+i03y/oIjIkJ26vevI22vI9BOajrOkvWabA1GpQ+XCZ1k/ZoxKHudaHl3ZnMJF
         iyg9jDsJDBsRoJHGtG2galUihyg+hifG2ax1szo38hTgiw4BWPgjLRYtu4yDFYcfRN
         IAe+b9G9Gsm+wYFWFAwzh/YpQ+h+m927kE2GwubcxZ+/XK63Sx0dsI528IaUj5wqtd
         L2QbpWf9GQ1Cw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGu-Ux; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/24] dt-bindings: phy: update phy-cadence-sierra.yaml reference
Date:   Wed, 13 Jan 2021 11:59:25 +0100
Message-Id: <3550b08d4e8312e7d4a247a3515a93a5f0fd04c5.1610535350.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset ba2bf1f090eb ("dt-bindings: phy: Add Cadence Sierra PHY bindings in YAML format")
renamed: Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
to: Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index c33e9bc79521..bbbd85501ada 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -151,7 +151,7 @@ patternProperties:
       WIZ node should have '1' subnode for the SERDES. It could be either
       Sierra SERDES or Torrent SERDES. Sierra SERDES should follow the
       bindings specified in
-      Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
+      Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
       Torrent SERDES should follow the bindings specified in
       Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
 
-- 
2.29.2

