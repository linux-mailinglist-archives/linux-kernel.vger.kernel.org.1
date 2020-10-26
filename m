Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C2D299A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395189AbgJZXDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:03:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51586 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395069AbgJZXDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603753404; x=1635289404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AVRSSDssQdWbrcRKwBjC+hUtmkwJEL8J+eqHnYnc5QE=;
  b=r2AhIzcWll+90CsWnN/W2UGo9b3Dn3474kkAetAHhGdeiWmaTSd33sZd
   WTLQdv7atnGEd+65AhInZMX6YJPEaHYFasVl1M7PfVHLjPrDSpwVBKztC
   vtKgyJuCDbIRS3rEl1RX3wh049NHzTXKxGe05LUL+ycKRzYOh4+wk8xgj
   1uMl7kcFs0GJyNsYI+NxkD57VP2GlMbr90U/B4/tXlL6Fb6ywjR17mvpe
   gocHDhKmjCvByhFEzwW6sN5p/WjPOlD+Y2UXjVIcqt2z1rC28b281xLh2
   U53R1Zii7njyLe4LwCqvJHhrLxScNYGXDFPxUa0UeP5oVyiaXE67trtA4
   g==;
IronPort-SDR: cT3oV3UKOX8CaiVw1DaWDTSpv5MCQNCXRIRDtyG6Jgmv+J4pdPXe77lYh7YCRTf3ab/ZcytkXx
 +bgyQkygCCzHZXPrUZgRQa+zbITTkxWCZ3Adi9Jc1YHgk0/NwbGFFvTD+aEveMo/dc8TqH4oDU
 PFip1ykJh3VR+vWmRlqzO67LBEGhC4DOq8bGG356HvWS1e6mRQSoW9qvMFfzJUz6AgUFSU1ZaH
 +sbK6VxGk0n6VcYerwUhOkpQBG9RNDe4VhCdyi6ZgFbxEk4Aqkrd4j5Bh88zQ1KipmZny55B5E
 RVc=
X-IronPort-AV: E=Sophos;i="5.77,421,1596470400"; 
   d="scan'208";a="151009476"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2020 07:03:24 +0800
IronPort-SDR: vrtE8q1wdpggUZs3ZrUwKb03h1xruHToTM+wP6fGBJl32hJSpNLvt5goxAXHhIyJSnFLdnoZmB
 04k9rZY93dUYBiawu9n7S7DjowZEUhcbhtG7ye/vrMeiM+eZZz4GtWJ6LNnU0ufpvYI8OkKrYr
 7EWLem1JICpy5l8xac0IW5kpEV1XpoS6PbwocIQO+fMbPRUJYML1Fui+f49BCZP2fA3WhpryvN
 b7mh40semdXkyLcgu5MxQSKTCXr7LQ2HPbKkAI03cNksW+XcN7d3a+H+6waaohLXxhp4hGYMMd
 KyYACg20/7mhWaqPWRNNITqh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 15:49:42 -0700
IronPort-SDR: 3Ij9aVJeppLgiNBWU3i6/X2lSE43Hhk1vz4ATQcxpjVCxcKhKrhmo10TYjsLHqnNpODk0WtNen
 Jk3krrwCqPcL89Wud7ibOl0NwE8tiPXGwsV+VOBu7+XKdtCGk/wxHi26nHu4oq3DgH1BoSgD/M
 yerK255lPug90GLaMc/tBilGkgTn2lyb38VH4Cd9zyBbfIniEjmkrpqFWHyXEDr+ZTPAFpzKMm
 x+t6xCJh33r7HlknIojBzHJXHJZ+dw0Lj9+d9N04W6lg2IfrWFFKMUVNhjjU6p4QVZ/yqZzPjo
 I/U=
WDCIronportException: Internal
Received: from 8223p12.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Oct 2020 16:03:24 -0700
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
Subject: [PATCH v2 2/6] RISC-V: Initialize SBI early
Date:   Mon, 26 Oct 2020 16:02:50 -0700
Message-Id: <20201026230254.911912-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026230254.911912-1-atish.patra@wdc.com>
References: <20201026230254.911912-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, SBI is initialized towards the end of arch setup. This prevents
the set memory operations to be invoked earlier as it requires a full tlb
flush.

Initialize SBI as early as possible.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/setup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index c424cc6dd833..7d6a04ae3929 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -89,6 +89,9 @@ void __init setup_arch(char **cmdline_p)
 		pr_err("No DTB found in kernel mappings\n");
 #endif
 
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	sbi_init();
+#endif
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
 #endif
@@ -97,10 +100,6 @@ void __init setup_arch(char **cmdline_p)
 	kasan_init();
 #endif
 
-#if IS_ENABLED(CONFIG_RISCV_SBI)
-	sbi_init();
-#endif
-
 #ifdef CONFIG_SMP
 	setup_smp();
 #endif
-- 
2.25.1

