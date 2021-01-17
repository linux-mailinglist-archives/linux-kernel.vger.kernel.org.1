Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454002F91E9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 12:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbhAQLS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 06:18:28 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:54988 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbhAQLSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 06:18:00 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 10HBGXEL004053;
        Sun, 17 Jan 2021 20:16:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10HBGXEL004053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1610882194;
        bh=mDGcqBe4GubK8SZYhFUOU4mOtTxrvJNR8QEIK9mA4JE=;
        h=From:To:Cc:Subject:Date:From;
        b=uRubQVESizv1JcVWK18rxQkxwW78tBZRJDjRU0UFjLbxoa1DYXdwKW3T1mKXMxAmq
         s4aXJatVgTlsnGJQ0vm2pAYmIxsEO4aq9lFOz0yFWk2CQAMCVeItDaCBiktG+Hnqwj
         TL9PabmCM+6k023E6MEmxLiqunWGQ/t+Z/2MkLfAmdZwXV12Ctib6umZtOpLON9TLP
         LtioelFOAdQFvxZRcLeB9apa17iqqNLC5D1yGirLvi6uvBivA42APJfXW6DFC4uWFG
         dUMZOyRT+Fy5bCiL7J9D6LaJgSNAzym+r+gNzB7LoG3sbqHWuV13BvCNymICirA+3Q
         ti1sV72NTQtqQ==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sh: boot: add intermediate vmlinux.bin* to targets instead of extra-y
Date:   Sun, 17 Jan 2021 20:16:31 +0900
Message-Id: <20210117111632.2392635-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You do not need to build all of vmlinux.bin*

They are built on demand as prerequsites of uImage.bin*, hence should
be added to targets instead of extra-y.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/boot/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index 58592dfa5cb6..dded61296c9a 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -27,8 +27,8 @@ suffix-$(CONFIG_KERNEL_XZ)	:= xz
 suffix-$(CONFIG_KERNEL_LZO)	:= lzo
 
 targets := zImage vmlinux.srec romImage uImage uImage.srec uImage.gz \
-	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin
-extra-y += vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
+	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin \
+	   vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	   vmlinux.bin.xz vmlinux.bin.lzo
 subdir- := compressed romimage
 
-- 
2.27.0

