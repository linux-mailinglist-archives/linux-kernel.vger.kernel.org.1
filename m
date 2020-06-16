Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED21FA92D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 08:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgFPGxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 02:53:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36310 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgFPGxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:53:52 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D81D7200406;
        Tue, 16 Jun 2020 08:53:49 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DE4E20046A;
        Tue, 16 Jun 2020 08:53:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 38AF6402E8;
        Tue, 16 Jun 2020 14:53:38 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: bindings: fsl_spdif: Add new compatible string for imx6sx
Date:   Tue, 16 Jun 2020 14:42:40 +0800
Message-Id: <1592289761-29118-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string "fsl,imx6sx-spdif" in the binding document.
And add compatible string "fsl,vf610-spdif" which was missed before.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,spdif.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
index 8b324f82a782..e1365b0ee1e9 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
@@ -6,7 +6,11 @@ a fibre cable.
 
 Required properties:
 
-  - compatible		: Compatible list, must contain "fsl,imx35-spdif".
+  - compatible		: Compatible list, should contain one of the following
+			  compatibles:
+			  "fsl,imx35-spdif",
+			  "fsl,vf610-spdif",
+			  "fsl,imx6sx-spdif",
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.21.0

