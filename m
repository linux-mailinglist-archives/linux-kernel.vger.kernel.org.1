Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5F2BC1C7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgKUTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 14:38:14 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53592 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgKUTiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 14:38:13 -0500
Received: from grover.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 0ALJawZG029948;
        Sun, 22 Nov 2020 04:37:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0ALJawZG029948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1605987422;
        bh=alXBlMLWLCUCyTEUF8p/qc+ms20133bsRLbmR1w39mU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0PoWRkch++wYopNCK7hJOVS2Ub0iw9gbr9sysU0966vxs2mQehozeuQqq3DpqhDBp
         GxDg1vPVFUP3THPlWMlPrOO7BkbW95ljIecZQ5S0Nec2Glc5es3kD8RR3LZ/YRm2BX
         K2lzf3dNt3zvLzI3Upje2h1f+wPZcIN6f+3CkMCkQgGrgIhSlTHrqRUim/MZiDRN5M
         zGqpegfpBbN1KFqn/6a+YqZlFVNMioihaBEAOwTuyDEEzn9jaRP0AFvQ+6vot4GnSh
         U0ETIv59V7nImQ1pwT4g9pVGeswRsJs85iUq0Svk8Z9wkVxEhpYLntv4UXb1S0Ej8r
         XJJMFOmvdNfBQ==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ARC: build: remove unneeded extra-y
Date:   Sun, 22 Nov 2020 04:36:56 +0900
Message-Id: <20201121193657.51441-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201121193657.51441-1-masahiroy@kernel.org>
References: <20201121193657.51441-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding vmlinux.* to extra-y has no point because we expect they are
built on demand while building uImage.*

Add them to 'targets' is enough to include the corresponding .cmd file.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arc/boot/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arc/boot/Makefile b/arch/arc/boot/Makefile
index 3b1f8a69a89e..b3870cc100bf 100644
--- a/arch/arc/boot/Makefile
+++ b/arch/arc/boot/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-targets := vmlinux.bin vmlinux.bin.gz
 
 # uImage build relies on mkimage being availble on your host for ARC target
 # You will need to build u-boot for ARC, rename mkimage to arc-elf32-mkimage
@@ -13,12 +12,12 @@ LINUX_START_TEXT = $$(readelf -h vmlinux | \
 UIMAGE_LOADADDR    = $(CONFIG_LINUX_LINK_BASE)
 UIMAGE_ENTRYADDR   = $(LINUX_START_TEXT)
 
+targets += vmlinux.bin
+targets += vmlinux.bin.gz
+targets += vmlinux.bin.lzma
 targets += uImage.bin
 targets += uImage.gz
 targets += uImage.lzma
-extra-y += vmlinux.bin
-extra-y += vmlinux.bin.gz
-extra-y += vmlinux.bin.lzma
 
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
-- 
2.25.1

