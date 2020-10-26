Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7B299A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395178AbgJZXDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:03:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51595 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395133AbgJZXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603753405; x=1635289405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BXRrXHASEZw+q5AEH6JXn4IG5K15cGG21TkLjxF25TY=;
  b=XpR4HV+vKwsRWMomER5IoV275VYlQPQKmgZnHHj6YQ2eEAfpHbPDJG93
   9OlpJRwMJPj6cqo/fQNZ5tuVP3bPaLHhimkPYpsBtef/xuEixXI+W+kVf
   Edk1sFNnzhwJXYfNbgXXdqn2dcmqviXkJhG8Y0vqJzSLHgNxXWPhe92jx
   8zxRI6zRHzI+rWdYwhvE9LBiko28QpZqhYmFMioGOqddjX6A5y+NLL/TS
   5fqygZz6GwRJBxhAcukR+SlK4UJhg73cY0Zd064f8hCO4FLnKUItH5HHl
   Vr+4JyA+Baz7xn+BHjVeTWBF4f5hh0aBzQjRE8kUBESHy4JeeCBUCNbqp
   A==;
IronPort-SDR: HhEM0AWuC19iAv+hAVBa6eQFRsRDMyEH5tMqXkevv3v1Silk7ZQMGbos185n8FBO9Bs9fhMliq
 N7qEWRmYw9v9rSEizoBUg3FpkDiI9sB4ho2dihLGeK+Nzl7XyX0i3wNt4R4dzVPDv/cDGPQeQy
 qYhUeLwRY7OHE2n94hIaKdM9Ly9nnitffhNaP9eAmI399Idannl2HBTzqBQuggBz9n2il7nKAB
 7hGvaSJQPuVZQK+C+p21z0PAif7UM9nE9XV7OVZxEuO/s2Q5sVeoxgM3jbLEDcQWxhdwtZp1qV
 9qE=
X-IronPort-AV: E=Sophos;i="5.77,421,1596470400"; 
   d="scan'208";a="151009487"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2020 07:03:25 +0800
IronPort-SDR: OCESYoXJn5rz8QQTL95tEfE6p7dZH/BgfvTCDoBzkKBZyDn34DOS+jBNJOYyQBle2FZe3IscAS
 iYLHEaNe+qfXfILQO4YAlUb5nfgQheVTdhQH4yYXcnnsvCL2mFuTsXgAUPnZYJoe9F2+xGZLsm
 OAbRebT6mtkpEsi8ceXSitCJ7rlt2L1B0kDjMlq7+oZGClfeR8gHIuX6L5/hAbTRA0m5rxadiW
 F9TRFHwUxHdzOAN6pSGrouvMz9ERbuu/wB+Yb4B5v52wtkl8o5xkx5m62dvpsL1AVBms6kIVQW
 Lc9Ymop+xL0zG4MTIsEgOUiA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 15:49:43 -0700
IronPort-SDR: nc5o0tmxjzldhTvYndCLRMxDkR7DVB0Qk9xsu3nOE77OHiF++vF7uzB8dkN6FOL63EaQPgW6vg
 32Ps9rMRe6NjHIcHRp5jbx3Fek2i+PHg9bgM/sHhvhKm4Md89MmIf3oyZeyDszhniw1Vs1X25M
 OlI0GIJkCqeeclxiq3vzCN9bZC15BwvNL5vcbuD1e7UMTO2rDsIYlNsUJfTOQ3loffL7C1jBXK
 u9QjFn66K/qD/FBZsbsXUkxk7teb0SZUKmIJ96W9LgSUVq77xPrfBzq/ABINxmwTYilVzPaYOF
 RYQ=
WDCIronportException: Internal
Received: from 8223p12.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Oct 2020 16:03:25 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Jim Wilson <jimw@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 4/6] RISC-V: Align the .init.text section
Date:   Mon, 26 Oct 2020 16:02:52 -0700
Message-Id: <20201026230254.911912-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026230254.911912-1-atish.patra@wdc.com>
References: <20201026230254.911912-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to improve kernel text protection, we need separate .init.text/
.init.data/.text in separate sections. However, RISC-V linker relaxation
code is not aware of any alignment between sections. As a result, it may
relax any RISCV_CALL relocations between sections to JAL without realizing
that an inter section alignment may move the address farther. That may
lead to a relocation truncated fit error. However, linker relaxation code
is aware of the individual section alignments.

The detailed discussion on this issue can be found here.
https://github.com/riscv/riscv-gnu-toolchain/issues/738

Keep the .init.text section aligned so that linker relaxation will take
that as a hint while relaxing inter section calls.
Here are the code size changes for each section because of this change.

section         change in size (in bytes)
  .head.text      +4
  .text           +40
  .init.text      +6530
  .exit.text      +84

The only significant increase in size happened for .init.text because
all intra relocations also use 2MB alignment.

Suggested-by: Jim Wilson <jimw@sifive.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 3ffbd6cbdb86..cacd7898ba7f 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -30,7 +30,13 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 
 	__init_begin = .;
-	INIT_TEXT_SECTION(PAGE_SIZE)
+	__init_text_begin = .;
+	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) ALIGN(SECTION_ALIGN) { \
+		_sinittext = .;						\
+		INIT_TEXT						\
+		_einittext = .;						\
+	}
+
 	. = ALIGN(8);
 	__soc_early_init_table : {
 		__soc_early_init_table_start = .;
-- 
2.25.1

