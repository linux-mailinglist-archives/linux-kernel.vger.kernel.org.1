Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6186226B7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgIPA2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:28:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34976 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgIOOFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:05:48 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 82554200481;
        Tue, 15 Sep 2020 16:03:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D77C72005C8;
        Tue, 15 Sep 2020 16:03:43 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D6B37402A5;
        Tue, 15 Sep 2020 16:03:38 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] ASoC: dt-bindings: ak4458: Add dsd-path property
Date:   Tue, 15 Sep 2020 21:56:59 +0800
Message-Id: <1600178220-28973-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "dsd-path" property, which is used for ak4497 codec
to select the DSD input pin.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
index 8f6c84f21468..0416c14895d6 100644
--- a/Documentation/devicetree/bindings/sound/ak4458.txt
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -12,6 +12,9 @@ Optional properties:
 - mute-gpios: A GPIO specifier for the soft mute pin
 - AVDD-supply: Analog power supply
 - DVDD-supply: Digital power supply
+- dsd-path: Select DSD input pins for ak4497
+            0: select #16, #17, #19 pins
+            1: select #3, #4, #5 pins
 
 Example:
 
-- 
2.27.0

