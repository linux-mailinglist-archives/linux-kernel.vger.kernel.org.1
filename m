Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7816299A19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395167AbgJZXDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:03:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51600 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394354AbgJZXD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603753406; x=1635289406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ySjO0ROtxsgulKuASejfUOnFI2wPdTDF4D2jhNgjeiY=;
  b=WHM/fI9wJJ1KuXLzi/czcdwZFRXQTqM5nKumh+itCNqt2LaoWCKnNCyw
   jg9eWoMQgP+l4EyJXuNPFM09pdmdldEWQgr8yVqr9XbkOBUbWxLZW82z7
   ZRyUIvpFSuzuNTKDyV/mYtvFDeiVPTl1vQnSNK7VqvWSH1JgaUykrSrG/
   TlOlJQxX/bwa2ynVbHgxaNoiWYqHkQNor0oChsD1E2G39WA8WkvSpsnSB
   XkzagkWp3W8zPuHC2K6OpMgYg/FU9C9IPITHwv49ccReFAAF79VbcZkep
   fbqHNKP0I9GeYfzWXQrBDxqQV5GjBEdf6DkAEupjSNRamCdD5jAlGYXjI
   g==;
IronPort-SDR: 05ytkyeoNBb6QyjMn6j3p57rCFCRmk4JjWNmdAZu6k3EnbvhqGCzTnYAIsFLFS/LrfxUKQbe5t
 Nf47xOacB5MZD7n4L0Lt2rn8/naYRdITRxmzs9pe2A/EA2bpYgxeWpdIKFEDSWln3WvK7Wmm1d
 dcQ3vCXvSln447hIpc3dePm38WlJbPAxX1QV4inze/DfSsYrbExoEyf5+vog9eFdBHcu6YOd0b
 bjF6sUnvVqQuk+jflaXXymX23/nA+W420soSLJgv6GMccjhHuNq/m2EABLWs9YpgQElore43dq
 6r0=
X-IronPort-AV: E=Sophos;i="5.77,421,1596470400"; 
   d="scan'208";a="151009499"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2020 07:03:26 +0800
IronPort-SDR: 4ETe+jYECK3yvsIuWMC8Q1eSBVfBI7YsVmvYLX4T3L4rAYINuas2udqZGJLwOqwvrhuUe2bKza
 +AbJ0Gso0dX2J1GyhN81Ct4XkaLnlDH4vC/zmBlbanSMO3vdHMGNvxM0Oh2VRQqy3o2Qs6Ladu
 cyz1jBGv3WPmzRBIU79pDANzfhTsvlm9jWGfBnw0gIX3HTNEgkeM1DksZoreLyS3k1rgGuD78A
 Y6rBqifqQ5yc9uhEku9p277kgheevMtyqJcpigBJ0KTK6UuM4T1lPYm0qVMKYCTI6/stij/M+W
 oZIqh97G0nM/G22oEEYIATPR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 15:49:44 -0700
IronPort-SDR: ZIK6pBlHow57hiV8D7ho7M4zJo6JZXmXc68rJru36zg2zepGnFLYfk0rMM063VRf2xcII5Vlm6
 k22KEvndaC4UkvZdmPy7PsVD3hmZnU/emkdOcOh9ZfogHtkgStZuny0fTzU6a6UKM//grYrAnu
 g2DxU2TKr9SHf2reP/hg81Iij6L7dTzG1xKtuyPaToFyfsS8Ud3UlSpzrBY8RZEc9935R2b6nJ
 OLPJbTTgczk/7d57STXaSaoAVH2omOc9iwiC6afLAGgmwM3l5XwA5ZkyLRltkHkbZ7/aPO0BEN
 FHg=
WDCIronportException: Internal
Received: from 8223p12.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Oct 2020 16:03:26 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
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
Subject: [PATCH v2 6/6] RISC-V: Move dynamic relocation section under __init
Date:   Mon, 26 Oct 2020 16:02:54 -0700
Message-Id: <20201026230254.911912-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026230254.911912-1-atish.patra@wdc.com>
References: <20201026230254.911912-1-atish.patra@wdc.com>
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
index 0a1874e48e8a..64c5e74008b7 100644
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

