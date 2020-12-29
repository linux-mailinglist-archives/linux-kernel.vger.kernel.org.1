Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9112E7075
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgL2MEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:04:11 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:40271 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgL2MEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:04:11 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DB42C22EE4;
        Tue, 29 Dec 2020 13:03:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609243409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XSIZsr8oSyCNxcmTGKv32nEtXWd0MZMGzvWWRQ3+zW4=;
        b=D/eu5ZrFvhJkP7l4V6fr4sn9WCLEFKfoDBOfoq5TwiqN4SBXWJ/Trh7wklR1chjF4xf3/t
        yoTwmGO+9CzaPwJW2IRywVPfoyE1tV3qx57EuhvsJwhiV4yO9Y4HmnjBUSoG7pauNg1+wk
        1z1WuASy3Sx3PdBxNvXRA88rEZ91H8o=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: add Kontron sl28 variant 1
Date:   Tue, 29 Dec 2020 13:03:20 +0100
Message-Id: <20201229120321.17103-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the a new variant for the Kontron SMARC-sAL28 board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 34000f7fbe02..7769a72ab9b1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -834,10 +834,12 @@ properties:
           Kontron SMARC-sAL28 board on the SMARC Eval Carrier 2.0
         items:
           - enum:
+              - kontron,sl28-var1-ads2
               - kontron,sl28-var2-ads2
               - kontron,sl28-var3-ads2
               - kontron,sl28-var4-ads2
           - enum:
+              - kontron,sl28-var1
               - kontron,sl28-var2
               - kontron,sl28-var3
               - kontron,sl28-var4
@@ -848,6 +850,7 @@ properties:
           Kontron SMARC-sAL28 board (on a generic/undefined carrier)
         items:
           - enum:
+              - kontron,sl28-var1
               - kontron,sl28-var2
               - kontron,sl28-var3
               - kontron,sl28-var4
-- 
2.20.1

