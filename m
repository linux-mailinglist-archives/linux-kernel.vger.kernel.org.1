Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C799E1E220B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 14:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbgEZMit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 08:38:49 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:39651 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbgEZMit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:38:49 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 04QCcC2s029236;
        Tue, 26 May 2020 21:38:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 04QCcC2s029236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590496694;
        bh=QQ0LDFqwk5a1GBFflDgp6jJzS+0nKYsmdcRpECdm1nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vd1QlNvi7n7hhztG0j6gz5hboZVjnBuQKQPRKZK+FU19s3E4LOUSYcIAgC66XA4Br
         q7ECj1wGypcGRmObv2BOA38c0YR1o02wK4IuY5yOsX6R/mnrUzDpmHtdxAT/nDw8g3
         yzp6AxS+Y+mmOjX66YNsNOVGTZxHbfp48+kHLTHrd6bEcWKC71QrZzuXS9gFM1P3GS
         IvyO9mXrz37bzs15bxMUzacQFfhruwb+WSL1kq+aTEfyV25A94Exv57Q9F4HsTUHQ8
         wTtyG12OHTBL5pUAZCaEoXSj6IHUNtQgOQ7g0AHGiIyuUnDkHwFQEYCKeQAgHsmS1y
         67GPjquBWdRCQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Sam Creasey <sammy@sammy.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] m68k: descend to prom from arch/m68k/sun3
Date:   Tue, 26 May 2020 21:38:08 +0900
Message-Id: <20200526123810.301667-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200526123810.301667-1-masahiroy@kernel.org>
References: <20200526123810.301667-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move prom/ to the more relevant Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/m68k/Kbuild        | 2 +-
 arch/m68k/sun3/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/Kbuild b/arch/m68k/Kbuild
index 7dc1398dd188..18abb35c26a1 100644
--- a/arch/m68k/Kbuild
+++ b/arch/m68k/Kbuild
@@ -10,7 +10,7 @@ obj-$(CONFIG_MVME147)		+= mvme147/
 obj-$(CONFIG_MVME16x)		+= mvme16x/
 obj-$(CONFIG_BVME6000)		+= bvme6000/
 obj-$(CONFIG_SUN3X)		+= sun3x/ sun3/
-obj-$(CONFIG_SUN3)		+= sun3/ sun3/prom/
+obj-$(CONFIG_SUN3)		+= sun3/
 obj-$(CONFIG_NATFEAT)		+= emu/
 obj-$(CONFIG_M68040)		+= fpsp040/
 obj-$(CONFIG_M68060)		+= ifpsp060/
diff --git a/arch/m68k/sun3/Makefile b/arch/m68k/sun3/Makefile
index 9960c46d303c..4e99e17d82ea 100644
--- a/arch/m68k/sun3/Makefile
+++ b/arch/m68k/sun3/Makefile
@@ -5,4 +5,4 @@
 
 obj-y	:= sun3ints.o sun3dvma.o idprom.o
 
-obj-$(CONFIG_SUN3) += config.o mmu_emu.o leds.o dvma.o intersil.o
+obj-$(CONFIG_SUN3) += config.o mmu_emu.o leds.o dvma.o intersil.o prom/
-- 
2.25.1

