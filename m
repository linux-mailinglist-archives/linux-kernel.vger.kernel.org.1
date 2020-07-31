Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396D62344FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 14:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbgGaMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 08:00:37 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:47908 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732669AbgGaMAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:00:35 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 6A8F6A3712;
        Fri, 31 Jul 2020 14:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1596196832;
        bh=HixAxNLOHps9KDOFAUU6bFxaerPncEi8pNCovZFR9LU=;
        h=From:To:Cc:Subject:Date:From;
        b=rEeyRbAXV3wGp/qUbpc4X+5dsWFo3htjCQLY3RbHCgsdjgiKs8btrWuU8YxIA0MTd
         1BdVLjgC5uKIxT8hL02/9oIN0w/NPIHQ9Kg14T/ek9kKX8RuXG/PfljjXMo84fi3AI
         3Y4/NOpW/GvNdCc8nXuXbHFMB2IDmQ5KDHRxpxLM=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 1/3] =?UTF-8?q?dt-bindings:=20arm:=20fsl:=20Add=20Y=20Soft?= =?UTF-8?q?=20IOTA=C2=A0Orion=20board?=
Date:   Fri, 31 Jul 2020 14:00:06 +0200
Message-Id: <1596196808-5067-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Orion - new board variant in the Y Soft
IOTA family.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f63895c8ce2d..63dec2fdbf89 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -188,6 +188,7 @@ properties:
               - toradex,colibri_imx6dl-v1_1-eval-v3 # Colibri iMX6 Module V1.1 on Colibri Evaluation Board V3
               - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
               - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
+              - ysoft,imx6dl-yapp4-orion  # i.MX6 DualLite Y Soft IOTA Orion board
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
           - const: fsl,imx6dl
 
-- 
2.1.4

