Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15222A7398
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbgKEAFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:05:06 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35644 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbgKEAFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604534701; x=1636070701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ttVV2l8xgC8cKeR325K+BCZa+k2eu3E+hvY1gbVjr5M=;
  b=ApdFA+jJYtnt22Omlci4Mj9FGiG4YjaP+pX3dN3Ps5zReY8oBEn950qo
   2maWb7edR78Wru5WHAzES2vztUuvvl0AJcZcI97DtyrH7k9ZVza7A27PA
   93MnGOtINvQAFi4BIENl8p/6iDMgnILIV3UT16YqnTvxUhvCqmOoRY7RG
   MvA9sBlqhcMdChd85/OSR1pjF0bf2ahlBQwyv197v+JSwr1Q07igbTa+w
   tIT6iPyCO1TXKNYi4DbAPKefk6gogas9sFusLEfpcWDfBBr+PAYLLY+0P
   Sd9e0dsShq4za90glues0QoHlCWAIc41gt8QWs39MnEdMmEEZ2sOtQrcH
   A==;
IronPort-SDR: VHJHMLAGRguRpJLgcqWvCHHSHlO3q0gzyJG++dGgVD6KULTqzHfYhUB0ZgV9Elr/3GYSqvN/Ji
 zLAABv/zE6KfLVIoNTR3eMpDVqgRm7c1gYsa1MiGCo52mEeJqRyxAGpik0tZvC3ODm1JzHfwKB
 B+o9DeKiqQjohGsljPIHkbi3J5eYjnYACYiSGIpWw3DuhVgplIzThJMpwing0rKnyeufvt5w/J
 jOTq4lFObciAuInVioU9NTHwXHp3caGitZRvCLh9n2SaRp7SRLRDhjXFJiuLZY9kyIxrzsYL2i
 kSw=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; 
   d="scan'208";a="151945123"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 08:05:01 +0800
IronPort-SDR: QZkZStu+ZVz3X3Kr8CFpJpqIGmq7jj0G+Zit8r0YnFyCESVJBWETbJ6+WbCKN5f26SX0vA8Xoo
 vs5F2oAD9K9d0XUaNN4h9PLTwH97J7XkkbETmN1cCIjy37muwERduS+Tt52lHKwRlnaetH7eKn
 yCCJxuIgeoTuVUZX0jp7PiEUAP2IxYmTlRYAwAsmwXXBnmpBAY5RnZE8rJysVSmB1qmfRFX2Vl
 wwxU7xlgoTr0Vteo3WbFD2qBnqL0wBwR1a2OCU2CtQW+gJeYDIngaMH+B221tOeK1kUYr27T3N
 zvUJCWoxA3muUF748Eg0fUYn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 15:51:09 -0800
IronPort-SDR: wyMNVYV728fyoW/gmDgVHH2wpGT4PFymlkeJ/1nIAqM/+kcHUw2irYtuuYStoMjWTgbPMT+1BC
 c477GyP6me2NQe9sScODAfQyhkTMiNu6JDL4PmMHsiA2YjCxBQ9G3qLk84BOCP3HsYWweotSso
 7w06B4nZ5fynamnfg4mBDAY/8VhghC51TRZENylZDQW3lg72x1zVge0zEOwOCXnXtc+5EPB/SE
 sPnQO/UaMgVggSj3CXZgfViJfvzvqvMjyAqA7zBP6K3x/LYavGbjhSZ/OD9cVcNlEM9aT7pD6x
 ERk=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.117])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 16:05:02 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <ren_guo@c-sky.com>, linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 5/5] RISC-V: Move dynamic relocation section under __init
Date:   Wed,  4 Nov 2020 16:04:39 -0800
Message-Id: <20201105000439.1491243-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105000439.1491243-1-atish.patra@wdc.com>
References: <20201105000439.1491243-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic relocation section are only required during boot. Those sections
can be freed after init. Thus, it can be moved to __init section.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index ca19ee5acd0a..de03cb22d0e9 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -85,6 +85,10 @@ SECTIONS
 	}
 	PERCPU_SECTION(L1_CACHE_BYTES)
 
+	.rel.dyn : {
+		*(.rel.dyn*)
+	}
+
 	__init_data_end = .;
 	__init_end = .;
 
@@ -116,10 +120,6 @@ SECTIONS
 
 	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
 
-	.rel.dyn : {
-		*(.rel.dyn*)
-	}
-
 #ifdef CONFIG_EFI
 	. = ALIGN(PECOFF_SECTION_ALIGNMENT);
 	__pecoff_data_virt_size = ABSOLUTE(. - __pecoff_text_end);
-- 
2.25.1

