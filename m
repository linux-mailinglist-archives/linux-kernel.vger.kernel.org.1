Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1CF22E9C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgG0KFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 06:05:53 -0400
Received: from mailout08.rmx.de ([94.199.90.85]:40597 "EHLO mailout08.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgG0KFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:05:53 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout08.rmx.de (Postfix) with ESMTPS id 4BFb6P6jBSzMngK;
        Mon, 27 Jul 2020 12:05:49 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BFb6323yVz2xFY;
        Mon, 27 Jul 2020 12:05:31 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.121) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 27 Jul
 2020 12:05:31 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH] dt-bindings: at25: fix syntax error in example code
Date:   Mon, 27 Jul 2020 12:05:05 +0200
Message-ID: <20200727100505.23908-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.121]
X-RMX-ID: 20200727-120531-4BFb6323yVz2xFY-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing semicolon.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 Documentation/devicetree/bindings/eeprom/at25.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
index fcacd97abd0a..fe91ecf1f61b 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.txt
+++ b/Documentation/devicetree/bindings/eeprom/at25.txt
@@ -33,7 +33,7 @@ Additional compatible properties are also allowed.
 Example:
 	eeprom@0 {
 		compatible = "st,m95256", "atmel,at25";
-		reg = <0>
+		reg = <0>;
 		spi-max-frequency = <5000000>;
 		spi-cpha;
 		spi-cpol;
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

