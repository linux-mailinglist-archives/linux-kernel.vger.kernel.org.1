Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164F21F0684
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgFFMhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 08:37:51 -0400
Received: from mout01.posteo.de ([185.67.36.65]:55306 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgFFMhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 08:37:51 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EFB15160060
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 14:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1591447069; bh=dv5T0Nu85sCFcp4DDXUhHLS/zB5gqD82drGqHfZ1sOU=;
        h=From:To:Cc:Subject:Date:From;
        b=KIeNodJMKJVlN8vYCm38jhLRSwnhax/LesGmSLrQYjNTrhlez63z6SRwQKU5dmxoW
         k28zSUjd5ppguevrcDYdZ5Puv4VfiChlasZUlcRK6NTUbLiuNyE9CiXgLVMKcZDJau
         BjqS+ZLtRNMC4U7umGXzG5NXvpTmL7D/MG2p1r8Le+hoNc1r77XCnWiOoduK8liiZC
         m5ERBKyF1xgENimkagFA83mgBgvP2Vv4jBhutSIgkEiE6Z884x3hK5FKhLqXZCMgHU
         55gs15walhCBXwi598/j4hdVMvtY3GBLbAu/QRgX2YPVuHKcgASeSO/HhCyqAgvxbm
         ORC/iQ0hQqr7g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 49fJvJ2ZfDz6tmb;
        Sat,  6 Jun 2020 14:37:48 +0200 (CEST)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     x86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/mm/32: Fix -Wmissing prototypes warnings in init.c
Date:   Sat,  6 Jun 2020 14:37:43 +0200
Message-Id: <20200606123743.3277-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix:

  arch/x86/mm/init.c:503:21:
  warning: no previous prototype for ‘init_memory_mapping’ [-Wmissing-prototypes]
  unsigned long __ref init_memory_mapping(unsigned long start,

  arch/x86/mm/init.c:745:13:
  warning: no previous prototype for ‘poking_init’ [-Wmissing-prototypes]
  void __init poking_init(void)

Lift init_memory_mapping() and poking_init() out of the ifdef CONFIG_X86_64 to
make the functions visible on 32-bit too.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/include/asm/pgtable.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index f51d8997ed00..741029e867f8 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1069,6 +1069,9 @@ extern int direct_gbpages;
 void init_mem_mapping(void);
 void early_alloc_pgt_buf(void);
 extern void memblock_find_dma_reserve(void);
+void __init poking_init(void);
+unsigned long init_memory_mapping(unsigned long start,
+				  unsigned long end, pgprot_t prot);
 
 #ifdef CONFIG_X86_64
 /* Realmode trampoline initialization. */
@@ -1079,10 +1082,6 @@ static inline void __meminit init_trampoline_default(void)
 	trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
 }
 
-void __init poking_init(void);
-
-unsigned long init_memory_mapping(unsigned long start,
-				  unsigned long end, pgprot_t prot);
 
 # ifdef CONFIG_RANDOMIZE_MEMORY
 void __meminit init_trampoline(void);
-- 
2.20.1

