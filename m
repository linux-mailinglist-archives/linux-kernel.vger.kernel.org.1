Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494422BC1CA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 20:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgKUTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 14:38:19 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53643 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgKUTiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 14:38:16 -0500
Received: from grover.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 0ALJawZH029948;
        Sun, 22 Nov 2020 04:37:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0ALJawZH029948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1605987423;
        bh=99oE6i2R2oSYJfOZeL3BoDQJFFm9KeclhptfXWwG3fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uq4W7h5v8AWv3KkI0SgoqrLmL45db2IR3BrNlQsFjnJcfJ3fssIuvgFBPJl322xEB
         YpOlqKV8M/Ux3XYMDKnwyCCRHqDd+0keCXj6sdt660f8YqXGGLNyXmS4Ojovbbl3r3
         jpcVWmMPH1fTx+/TSvJ+mk+nf8JkgX7zJwMmelVPI4DfRBsA0xSCblo4QZjXrNYvBS
         vhftL4QcM+RYdAFwcV56bxYdry9l8K0kRGXCPeRkxUo0rldbDhNVTh8bXxTu6Ii+Bp
         9ECj6MyFeGcqCd7BebNWkiBo+iy7Acrzb4lz/WK4KOXjkSfHg2+aOFKtPjnGsqzfM9
         LvPJvJyJ8KE3A==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ARC: build: use $(READELF) instead of hard-coded readelf
Date:   Sun, 22 Nov 2020 04:36:57 +0900
Message-Id: <20201121193657.51441-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201121193657.51441-1-masahiroy@kernel.org>
References: <20201121193657.51441-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top Makefile defines READELF as the readelf in the cross-toolchains.
Use it rather than the host readelf.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arc/boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/boot/Makefile b/arch/arc/boot/Makefile
index b3870cc100bf..5648748c285f 100644
--- a/arch/arc/boot/Makefile
+++ b/arch/arc/boot/Makefile
@@ -6,7 +6,7 @@
 
 OBJCOPYFLAGS= -O binary -R .note -R .note.gnu.build-id -R .comment -S
 
-LINUX_START_TEXT = $$(readelf -h vmlinux | \
+LINUX_START_TEXT = $$($(READELF) -h vmlinux | \
 			grep "Entry point address" | grep -o 0x.*)
 
 UIMAGE_LOADADDR    = $(CONFIG_LINUX_LINK_BASE)
-- 
2.25.1

