Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB89E279384
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgIYV12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgIYV11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:27:27 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D440221741;
        Fri, 25 Sep 2020 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601069247;
        bh=rsHa5G5XUTWQrB0dTJW/DaW7JfBwwh/edaPi/fi8Cdg=;
        h=From:To:Cc:Subject:Date:From;
        b=so1WgW4A41kEgBXmlZ983DIIRJZ8dQ+xNADsEZ9Y9klOPzZvX4odBIAJJ9GKcYSRj
         XDloJBJv8TMRc0w+s39dfqjhAgNWAFBLzXNb4k5rRdsNgJY0tbepIlKjmoI0JTFgoi
         8Los6f3Eya1a5C0XBa7b4ykutdNHeSEJBjTTpkdU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] ASoC: dt-bindings: sgtl5000: Add common clock properties
Date:   Fri, 25 Sep 2020 23:27:19 +0200
Message-Id: <20200925212719.23286-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (assigned-clocks and similar)
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dt.yaml: audio-codec@a:
    'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.yaml b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
index 4f29b63c54d3..d116c174b545 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.yaml
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
@@ -19,6 +19,10 @@ properties:
   "#sound-dai-cells":
     const: 0
 
+  assigned-clock-parents: true
+  assigned-clock-rates: true
+  assigned-clocks: true
+
   clocks:
     items:
       - description: the clock provider of SYS_MCLK
-- 
2.17.1

