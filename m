Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9A1257294
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 06:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgHaEKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 00:10:09 -0400
Received: from condef-10.nifty.com ([202.248.20.75]:64530 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHaEKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:10:06 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Aug 2020 00:10:05 EDT
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-10.nifty.com with ESMTP id 07V3wbus021302
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 12:58:37 +0900
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 07V3w5DR030876;
        Mon, 31 Aug 2020 12:58:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 07V3w5DR030876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598846286;
        bh=212Tg8dRQHTXyhLJhNGYLVujbS6eUdp8Ts6+PMHJ4NQ=;
        h=From:To:Cc:Subject:Date:From;
        b=de8chDCqq0s0ri+Gg6fRGxHFm6Ex2K7a1IpiYI13Zj8Dpfr00DQxAoxPCr8w+RWJ0
         a2RSmnSPdfwpUAjz3bhFI7KeK1vETMWvTgTTbeWr7tbG+AhOxNaoX9pr0Z18eOFt9x
         4xO087gyYvPEgBw5MWKcrBdYvc6SN9SVY/hwxWnX+pjghCyp2kotbcDYW18BbQu2lb
         foxOB1gcJqWoJ/FIUrreP4iv7IV5ze9YolMvq7iBK5EBoKavPtFiOBXM/irs4KGWcw
         EOQsC/sS5M7yREeb3LJBTiI8Mka4ji3De/FMu7Ba6di1m/B/WoELwyfvOPB9H3wDSM
         A2LU0L8eMX02w==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] MAINTAINERS: step down as maintainer of UniPhier SoCs and Denali driver
Date:   Mon, 31 Aug 2020 12:58:03 +0900
Message-Id: <20200831035803.96852-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am leaving Socionext. Orphan the UniPhier platform and Denali NAND
driver until somebody takes the role.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I hope this can be applied to the ARM-SOC tree.

 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b186ade3597..33aa482fdf47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2652,10 +2652,8 @@ M:	Dirk Opfer <dirk@opfer-online.de>
 S:	Maintained
 
 ARM/UNIPHIER ARCHITECTURE
-M:	Masahiro Yamada <yamada.masahiro@socionext.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
+S:	Orphan
 F:	Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
 F:	Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
 F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
@@ -4955,9 +4953,8 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/platform/sti/delta
 
 DENALI NAND DRIVER
-M:	Masahiro Yamada <yamada.masahiro@socionext.com>
 L:	linux-mtd@lists.infradead.org
-S:	Supported
+S:	Orphan
 F:	drivers/mtd/nand/raw/denali*
 
 DESIGNWARE EDMA CORE IP DRIVER
-- 
2.25.1

