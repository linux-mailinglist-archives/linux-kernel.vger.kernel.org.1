Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52E82BC1C9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 20:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgKUTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 14:38:19 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53626 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgKUTiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 14:38:16 -0500
Received: from grover.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 0ALJawZE029948;
        Sun, 22 Nov 2020 04:37:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0ALJawZE029948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1605987421;
        bh=1h+SziFamFq3LykQmarKbE8G+YUzBgaGe54/2+YrZwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1v/i7VHRh8dM3u6c0dJ3qzOE6tsqrSvmNZZEEeq6FgNMfc5lcrbSPMofvOANEPp6
         FW7iWscKXNVfOqSESuqJXCpF3EG9wsG5LEZH7kZyv13X34Cg+jreHXM5NhgjJyjP4N
         sYrsZYPJnOUn08KuuBd1KDQ1lTVem1Ug51S+64qYo/7Xho4wYszqTYDb952AgWHvmu
         VXPTPQb1uR7qaAtNz2Q+13TFrrF8te513a1rtkBL3bDNmKv67XtlNMrP5X4wGuGgxS
         BWPtukllZyq9rpq2ceBU1XL0VbPggUPwEiTOj/Wqm4reUeGLyIWcCprLnwCN9P5aRt
         BcH+620rWnl+Q==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ARC: build: add boot_targets to PHONY
Date:   Sun, 22 Nov 2020 04:36:54 +0900
Message-Id: <20201121193657.51441-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201121193657.51441-1-masahiroy@kernel.org>
References: <20201121193657.51441-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top-level boot_targets (uImage and uImage.*) should be phony
targets. They just let Kbuild descend into arch/arc/boot/ and create
files there.

If a file exists in the top directory with the same name, the boot
image will not be created.

You can confirm it by the following steps:

  $ export CROSS_COMPILE=<your-arc-compiler-prefix>
  $ make -s ARCH=arc defconfig all   # vmlinux will be built
  $ touch uImage.gz
  $ make ARCH=arc uImage.gz
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  # arch/arc/boot/uImage.gz is not created

Specify the targets as PHONY to fix this.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 61a41123ad4c..cf9da9aea12a 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -104,6 +104,7 @@ boot		:= arch/arc/boot
 
 boot_targets := uImage uImage.bin uImage.gz uImage.lzma
 
+PHONY += $(boot_targets)
 $(boot_targets): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-- 
2.25.1

