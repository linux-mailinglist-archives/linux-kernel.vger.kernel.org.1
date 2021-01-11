Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7676A2F0DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbhAKIWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbhAKIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:22:46 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2016EC061786;
        Mon, 11 Jan 2021 00:22:06 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A195A22ED8;
        Mon, 11 Jan 2021 09:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610353322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z16DerIaeIQb7u36oALr+3/maDGK44yawY1L6TYmiWQ=;
        b=dXoUjx1oeN1q68466J+xSQq/T46Yz5j3XiOtP6HEvBWXShxcjHUxZf9BoZEOUy5lenfAY2
        846Hlb5fMI1ZVWI09RO5cOBXX3ln4PKcsRX//tRdXc5W6Dy8w06CQeiBqNS2dcefGSKnI5
        9ykDvHTUSuGZuRyhAVrbgTVhhef/ILo=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: add Kontron sl28 variant 1
Date:   Mon, 11 Jan 2021 09:21:33 +0100
Message-Id: <20210111082134.24704-1-michael@walle.cc>
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
changes since v1:
 - none

 Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index cee74fc0c115..cbb531ad5284 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -835,10 +835,12 @@ properties:
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
@@ -849,6 +851,7 @@ properties:
           Kontron SMARC-sAL28 board (on a generic/undefined carrier)
         items:
           - enum:
+              - kontron,sl28-var1
               - kontron,sl28-var2
               - kontron,sl28-var3
               - kontron,sl28-var4
-- 
2.20.1

