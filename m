Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC4C289A7A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391430AbgJIVOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:14:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50454 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbgJIVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602278543; x=1633814543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CEOo6JngBKtDuR3zNiPVEE237ISONrVcfU90kTdl4dc=;
  b=XzPdqwdeZHuid68XrOIXtLpb5bEn5wzuTm7kEBTX9+tQgpruXCWGWGN0
   WDMGBC/Sn6fALxsLvnKVhQo8fR4h7VVBeZh94z6cjPjyNyr2CD3gzKCs4
   lCo+azXh/BT/PSEWQXzNo95E9UTmwyYwM0CtsnFvEPsvligG0t/OoeEm3
   JgjYcflDVQevpo5iNXEHJ5fabe4vkpoeFY6qp0Cbogmc/lBoqfLaLk8LN
   234ncGUdrqdc4zHy76Csxk4vH5JxuU2uNggPB8NVivVAEZAvS/Iegi6oq
   QvtXaZZbRiHAQiW3LZDkN3udyKR1+leJq+DWe0XSFETcSDcZvmJQEqEUl
   A==;
IronPort-SDR: RBmjKIupAAJtDt9f00sOOVvzMP6JMPJcMYRTYKmQy/ZDlQjz8eJu0Xqm26greURrLajlXneM34
 6vVXkmKgDAOrWoo0OjeMFziEllnKUQboLLFqf3FvmTVjeGae1oAYXMTOYej8TIvP5KjCO4TCxV
 cLM4TN8V4e5/O/UT2PFkPO466aUHBj9dLVRZXdRKIgH7xggEGdn42rRQRUgr3WzHjqcGe6YWN6
 ZX//zsIcZpO/kZes8hqJF8K22KgnuTzApb4oa+JRXLHCeWL7cBum/mSPPkdvnlzmECwIbAfLOH
 L8E=
X-IronPort-AV: E=Sophos;i="5.77,356,1596470400"; 
   d="scan'208";a="252936946"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2020 05:22:22 +0800
IronPort-SDR: MFIAy8+xtYwwwH366xo/q6+SsexA5g9OvHnOuhHfNtFxAKrbRE6GifPkzzOQw1Ezz1rmKlPM0D
 SUP2+YEve1FP7LtUCXtNwutykfq0YR7STrJWbn38ovCwiEJlzcecRpcSinlguJKd5r6EhzaVFN
 yWf2MwCWi2FQDC/FSh+izc4E54a1u6TY9vRBsKt+cSNOViBEcGt9tG18/umxE2AXN5RIuBILJ8
 5H1Hxgg/ROtR0k3tngL3JkMkCm9yvF+eaFAaN6B3DxX9QcVpridPP9/H1EhzFcIu6RcL7pxug9
 jE+1NnUYWmpS6N7vN5N9+jvX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:59:43 -0700
IronPort-SDR: xXNYNpuECda/K0oZVXImx5r+Kibd3x1J+MzfXjxi413udaVCYh0GU2b9kRFOJQn6wk7UK+WREx
 6re5MRNGaGLYrVcdHJ4myYpM6ZmmwsiDeRlg1H1HDTmFSL3f4U/rI3hhlrx4QDGErN2QmVAO8g
 W30shVY2Tf7Pa4N3JshPtZyShOaRH4PWQRuUxGcwO/q8e0ZkuccrWJFe3QSBV55xw/1B6xWNps
 X2UT0lQgjuSXucitoPhpWdZf5ZcYabUQQrMLWzxL3t448DGDaNz9ugmCJChIyzUCsf1OD8dx9v
 Odg=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Oct 2020 14:13:55 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH 5/5] RISC-V: Move dynamic relocation section under __init
Date:   Fri,  9 Oct 2020 14:13:44 -0700
Message-Id: <20201009211344.2358688-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009211344.2358688-1-atish.patra@wdc.com>
References: <20201009211344.2358688-1-atish.patra@wdc.com>
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
index 15b9882588ae..4aedb4fd79e5 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -60,6 +60,10 @@ SECTIONS
 	}
 	PERCPU_SECTION(L1_CACHE_BYTES)
 
+	.rel.dyn : {
+		*(.rel.dyn*)
+	}
+
 	__init_data_end = .;
 	__init_end = .;
 
@@ -112,10 +116,6 @@ SECTIONS
 
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

