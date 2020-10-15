Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E7128ECB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 07:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgJOFdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 01:33:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48148 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgJOFdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 01:33:47 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C0F31A06CE;
        Thu, 15 Oct 2020 07:33:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E1BFC1A0693;
        Thu, 15 Oct 2020 07:33:39 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6335540323;
        Thu, 15 Oct 2020 07:33:33 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: dt-bindings: fsl_spdif: Add new compatible string for i.MX8QM
Date:   Thu, 15 Oct 2020 13:28:47 +0800
Message-Id: <1602739728-4433-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string "fsl,imx8qm-spdif" for supporting spdif
module on i.MX8QM.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 2ac671f5cb9b..50449b6d1048 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -20,6 +20,7 @@ properties:
       - fsl,imx35-spdif
       - fsl,vf610-spdif
       - fsl,imx6sx-spdif
+      - fsl,imx8qm-spdif
 
   reg:
     maxItems: 1
-- 
2.27.0

