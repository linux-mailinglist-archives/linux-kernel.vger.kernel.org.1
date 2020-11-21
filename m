Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F592BC1CC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 20:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgKUTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 14:38:26 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53644 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgKUTiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 14:38:18 -0500
Received: from grover.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 0ALJawZD029948;
        Sun, 22 Nov 2020 04:37:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0ALJawZD029948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1605987420;
        bh=nAxcOdJY1mvrwExMzg4hS+b5OlfAmMuqUYSTfMiExmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZPsV4qudX33UralNq72zbDm/DGpw8VcC9GxyU5KnUZsunhaeRFN3AnCz3Hn55Cru
         6YEfw4BWYUiluiJq2bQUcR+VPlT+wdUS7OMkoJD40LptWO3AzxihRviK+tGEBzTqCq
         nuEkRVoEKAdtBD+5oT2d31SVGGNVpLT7PSvV/ShkPaS/C5y50Vt1kep5byoBs1+oDQ
         foORTZlzcHxJeRJGJTm6s4gEfc8wq5MrFSNPdX/n4hC/DYjGarh6/CAmNBXSJnR1wD
         f6zQ3T8mN09XML5nG+q2nFP/Ps2WZ81JqfwQlCKE1KIrkgcvu3/TD1+gmRfRXSAmAK
         /BVPDUvWBbVtg==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ARC: build: add uImage.lzma to the top-level target
Date:   Sun, 22 Nov 2020 04:36:53 +0900
Message-Id: <20201121193657.51441-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201121193657.51441-1-masahiroy@kernel.org>
References: <20201121193657.51441-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/arc/boot/Makefile supports uImage.lzma, but you cannot do
'make uImage.lzma' because the corresponding target is missing
in arch/arc/Makefile. Add it.

I also changed the assignment operator '+=' to ':=' since this is the
only place where we expect this variable to be set.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index acf99420e161..61a41123ad4c 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -102,7 +102,7 @@ libs-y		+= arch/arc/lib/ $(LIBGCC)
 
 boot		:= arch/arc/boot
 
-boot_targets += uImage uImage.bin uImage.gz
+boot_targets := uImage uImage.bin uImage.gz uImage.lzma
 
 $(boot_targets): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
-- 
2.25.1

