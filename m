Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267BB2E1FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgLWROl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:14:41 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:22612 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLWROk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:14:40 -0500
Received: from grover.flets-west.jp (softbank126090214151.bbtec.net [126.90.214.151]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 0BNHBjDJ029748;
        Thu, 24 Dec 2020 02:11:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0BNHBjDJ029748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1608743508;
        bh=F4eygMIL/heychEdy4AUgBnfOqgJupp0qUMNlr5k7z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1im/Q9wt7wMKJkT2ai+kxcbSSB4ooSml+4uTOMZF0HAKq/G3hIqQyCzqgR/67xJd
         etw4HCJd21di4Cp+ii9FicPoqn73/f2JrPrBaFR3BXLspbpnSjwO3eZO9HzZ4nzGlZ
         3riWteY7tUS5XgjvRMf9E2lZfxqDhzOV6VpcQmCQ/jSuqWe2e8vWZQ/94jBFLtEfqj
         5+WYqeE30NLgVQqLQ87TK7NwnBDALpKK2x24JM5v8aZgXvSBFmFXAlhTqQyta7RK11
         u5iwIqcoMhYoTLtIhsKB9VZvDWQAQqRlj9wOTM89Ij7LtoTt0P7Hr/lwZTdfYcHm1h
         Lg3/e8PRqL4ZA==
X-Nifty-SrcIP: [126.90.214.151]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/vdso64: remove meaningless vgettimeofday.o build rule
Date:   Thu, 24 Dec 2020 02:11:42 +0900
Message-Id: <20201223171142.707053-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223171142.707053-1-masahiroy@kernel.org>
References: <20201223171142.707053-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VDSO64 is only built for the 64-bit kernel, hence vgettimeofday.o is
built by the generic rule in scripts/Makefile.build.

This line does not provide anything useful.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/kernel/vdso64/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index b50b39fedf74..422addf394c7 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -32,8 +32,6 @@ asflags-y := -D__VDSO64__ -s
 targets += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
 
-$(obj)/vgettimeofday.o: %.o: %.c FORCE
-
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday.o FORCE
 	$(call if_changed,vdso64ld_and_check)
-- 
2.27.0

