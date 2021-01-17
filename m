Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2F2F9152
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 09:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbhAQIKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 03:10:35 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:17244 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbhAQIFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 03:05:44 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 10H83ZJT006716;
        Sun, 17 Jan 2021 17:03:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 10H83ZJT006716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1610870616;
        bh=KxxLfsj//Y08AAlVQEh12t7SON+ohmx3H8rw17177Yk=;
        h=From:To:Cc:Subject:Date:From;
        b=iLRoaChdyO3pV3Rz7HT7gR0qLZga5XhwwO8VgHC4O2dx7x+3OEcUmCcFI1y1DVYIF
         HCe9vRsx9ZwVZtUSiQAlxKJhgdlwh+MmJNd5VOVfSkk8xHiJY1C1yBNgc08D68b20+
         eRN46c2Qfq3wwitlfTiDVuXSJCZSqw39sM5batPLCrKEmuvITQR/r4TppiGIkhX3FJ
         OBynvbbw14kb/K5LFhdPLc8ReNVkuxLa2vxn7kAwTDBa1QfAj4UHAz/SFLTq9XOXdr
         cWB3PXjdVUSWnyC12pdUqGWQUrz48DQ2rXaZ0ZeADa9VAzTZnKNaeJZtuKr3pfgGAK
         Zp56ON7DcfHgw==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] openrisc: add arch/openrisc/Kbuild
Date:   Sun, 17 Jan 2021 17:03:32 +0900
Message-Id: <20210117080332.2289077-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the subdirectories under arch/openrisc/ in arch/openrisc/Kbuild
so you can use the standard obj-y syntax.

I removed the CONFIG_OPENRISC_BUILTIN_DTB conditional because it is
already controlled by arch/openrisc/boot/dts/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/openrisc/Kbuild   |  3 +++
 arch/openrisc/Makefile | 11 +----------
 2 files changed, 4 insertions(+), 10 deletions(-)
 create mode 100644 arch/openrisc/Kbuild

diff --git a/arch/openrisc/Kbuild b/arch/openrisc/Kbuild
new file mode 100644
index 000000000000..4234b4c03e72
--- /dev/null
+++ b/arch/openrisc/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y += lib/ kernel/ mm/
+obj-y += boot/dts/
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index bf10141c7426..44e63fa35e04 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -38,14 +38,5 @@ endif
 
 head-y 		:= arch/openrisc/kernel/head.o
 
-core-y		+= arch/openrisc/lib/ \
-		   arch/openrisc/kernel/ \
-		   arch/openrisc/mm/
+core-y		+= arch/openrisc/
 libs-y		+= $(LIBGCC)
-
-ifneq '$(CONFIG_OPENRISC_BUILTIN_DTB)' '""'
-BUILTIN_DTB := y
-else
-BUILTIN_DTB := n
-endif
-core-$(BUILTIN_DTB) += arch/openrisc/boot/dts/
-- 
2.27.0

