Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B49F2A7399
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbgKEAFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:05:13 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35631 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgKEAFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604534699; x=1636070699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2o/pSqwZIsTAsEbERDtmvi4jQRx0V2hQUyDY+mRsz0s=;
  b=bDqUYPxZueLEpCXTCAJBa+A33vPxyx2W3K091BGDvZh/0ixJeOWYbLUx
   M03ngTJNEKVQkJug1umlS4k4/y9cHFgpGkshdaPp4gIXqQNJeBEvMBDCt
   B9V1zZvnN3RwQB6oOg9REGDm6oLAax5tZNLnGd4/0veIu8wxYRpYYQH3F
   GlNjG+ISvq98ntioi87+sv48uV2d5hLxPG7jwwOoD8kXXdKVcq9ZrL5ly
   ETsac/JrAmXQucQsz+XgsXCCmhlyLP7fwS/GCPz4EuURDKGYAONMbbwJv
   +kPLz/ZPVwqo3NAgj8UfPYuvY2vlZQhkguB57UlPk6XM//n9iWPAcSRBE
   Q==;
IronPort-SDR: fvUFwTnL9HjGyjJ3/LhjtOntmt0TBAWaZrvb2DnEg8N3EvZgVRwXsZj4nQc4Vedv5wmN78KKff
 ag4r5WKBdXYxDGwjF7MGD/X4ClsKJ1EwwsH5SH1PB4ctP+zJe1tQN5n990luMeO1F5DhDz4mJR
 U11hyIZR/51/W8tTcWs2d0OKCCOAaMft552n57ZLEhsLXWHFHwosaIPh7PVZwuIfpboQwAIAm9
 22HdP4MN6EXAZjP6xPskiY8lkAfkueTwvgI+O6rqGPmbRU4Jw6FCmKhfdT5vEAEwcNlxyTvzDU
 c7U=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; 
   d="scan'208";a="151945107"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 08:04:59 +0800
IronPort-SDR: a4P3bC+FmsMVT3P4qTCSK8RajDqx6U4De0Jbs2/StbeN8sDVtYF64pphQben5ApEPGcDyPpdyv
 1rejacRtLOtmtsV8l23iEwLKW/1oPB3dzYo44UXcL0VASbZyZq6Ir1NzDNmofaVm/a/A/V0XQi
 6FGQ12BN2asEFHe+wWBM73BMkzsNimWJm4xl/dyO40rwm5eC/fu0WTixjqXyWkR2r/FFqMD7pf
 HI6Eaq7tjCHXN9jLahYBv8BBG+9S6OU+t5D6vV3AcsHKemsUmTL5QOR810xyy3YWeJjBtULmkX
 gydmN4z30WWdSZ1wsNiRtRpY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 15:51:07 -0800
IronPort-SDR: CtPiSoKUeSrgYaq6D8avvUoNBth1SV31qkH08edSmw/qTywf6d2WcIna1XWhLHD8+R/7DaMQZ/
 ETOVXtFpxLKPetK+qushwOtnkHBtD+XkJUFZD8Ns+1hSSyfpKf05rbG7b4WR1JV61U1Wc7fn7h
 cfdTHuA1bzwDNReFgqgBlp7D1jb/ItXwtfyy25i5RJh6e1hI4wLnqggQc8QpdYVxIk4lcVJazD
 VyCuRnB4CN+6EJwnyLZoRgSiQ15DYdXaZRJVDbVX5ae86tlphk9bNEF5roGpH43z+FnpKhPSPj
 pto=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.117])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 16:05:00 -0800
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
Subject: [PATCH v3 2/5] RISC-V: Initialize SBI early
Date:   Wed,  4 Nov 2020 16:04:36 -0800
Message-Id: <20201105000439.1491243-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105000439.1491243-1-atish.patra@wdc.com>
References: <20201105000439.1491243-1-atish.patra@wdc.com>
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
index c424cc6dd833..b916f4a904c4 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -89,6 +89,9 @@ void __init setup_arch(char **cmdline_p)
 		pr_err("No DTB found in kernel mappings\n");
 #endif
 
+	if (IS_ENABLED(CONFIG_RISCV_SBI))
+		sbi_init();
+
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

