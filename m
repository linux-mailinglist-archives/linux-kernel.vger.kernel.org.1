Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCDC216A61
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 12:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGGKeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 06:34:10 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:41093 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGKeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:34:10 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 067AXOKf031702;
        Tue, 7 Jul 2020 19:33:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 067AXOKf031702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594118005;
        bh=WeGq8eUax7a2wHYJwYuS94yJujli90DNZOOxeVWUce4=;
        h=From:To:Cc:Subject:Date:From;
        b=Jcm6TQbTSTKWjfMYadQjIptwBfV99dq9eBCjhkovTFG+2ExkyqTsCqcLmPNZk0RZi
         1Oyje/LOKYaa77WHw8fDK1Eifv1EvY6HvknkBXDmabMKSXmnNhTRmU4F7kKm+1dnxk
         R47BCDQyppEUwvexrtloNEmKjsjLTBYiTdsS/okOMF5nn1JOEAS2JADr9aKRiosTEA
         tM2KdWgZMqOnDAZzbkS1VCWI8gDeXtmDln81su418ChU+/FlvXPK+98NSK6+8J0wy8
         O8aXd5SzH5A0bUKva0UzWZeXFx1kSJkqZZZK0c6zp5cMdQvX/ru58BKu3YEGCyA6pz
         wR2gnOJh6SjiQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: uniphier: give fixed port number to support card serial
Date:   Tue,  7 Jul 2020 19:33:22 +0900
Message-Id: <20200707103322.991265-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this to the aliases node to make it more convenient.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index d07401fafffa..89d290c9bfc4 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -20,7 +20,7 @@ chosen {
 
 	aliases {
 		serial0 = &serial0;
-		serial1 = &serial1;
+		serial1 = &serialsc;
 		serial2 = &serial2;
 		serial3 = &serial3;
 		i2c0 = &i2c0;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 709908d5812b..6dc19695136f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -20,7 +20,7 @@ chosen {
 
 	aliases {
 		serial0 = &serial0;
-		serial1 = &serial1;
+		serial1 = &serialsc;
 		serial2 = &serial2;
 		serial3 = &serial3;
 		i2c0 = &i2c0;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index eca60e02e85a..b51188a043cb 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -19,7 +19,7 @@ chosen {
 
 	aliases {
 		serial0 = &serial0;
-		serial1 = &serial1;
+		serial1 = &serialsc;
 		serial2 = &serial2;
 		serial3 = &serial3;
 		i2c0 = &i2c0;
-- 
2.25.1

