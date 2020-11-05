Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE42A7395
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbgKEAFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:05:00 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35631 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKEAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604534699; x=1636070699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qmlk0Pnoc73PLeMzxCGZ41KUAZ0XJ8ZZaWUmbVJfPT0=;
  b=pC/xQOZBdBiEz5MxSYDRRZKvAS7DxR/qQ9DCU9vAB4Iyh0voX6hShKiC
   P+zZqF3M8tQ//dGs3waCMjFcBsjzW/jTqtO6q5J5BMyPAs02nRKf2qhsE
   603QOX2xH5CfOmWCkgVu1EAXbWjQy8gprzG7+o4t6nz02UkNlCbw+2Y99
   XqE8kxVqQ0xf+PSu1PZMV028kb8TuA7/hSNVCRSXu0cJDH3Gv3LJJNRHi
   BhonzJ93PRSC3JubVEMT3vIuVV7jrCQ2MVEly9aWS9Ab6iQqQK15da5yI
   PTFsvyMuF+b8SeHlyDQogflTrvvS+O/B4hxGKRcuau7Bt5Z/Jcz2Bwwn3
   w==;
IronPort-SDR: eIPIpBt26YBMDcUOfqxT0iDAGZzVIEAofj1rKI+0riLnBAd+QsRuWs2LRwv5qXaZTxGsLiaNc5
 SufKhdLH1hnJ418BB8Wo6g4RSE9Vamig3CIQNo5nceckT/RdvP2P6M7o7015FNuBTspKxyzDH6
 SwHlvBx6lDdSVUqICjrjSz1ttr6SwJ6aAU8BFVoHThZUd2eh8mX2K5R4hs3Uihcr7IiTww/D1z
 MXh5ifotcnepZMBF8OO/61DZn9jlv6YZfj79UpxDSDNoAKjTDWvYIu5TNC4qzrCQlDKqIZZZdk
 8G4=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; 
   d="scan'208";a="151945102"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 08:04:59 +0800
IronPort-SDR: 2KLBc1ltz7S1M4GPGBHn82DsM8qpC+wxcx18k+SMrDLoyViZpYGUQECmQDp6pckO8gm6PxX0ho
 0w2oCiAzJkhQnpF7Ozgplrhb3X9KLzQ28c51BOWdbyt5B7ntYJ8xaDejKGgzkUUJk/hcIarRaN
 ZOHDBgvStPQyZnbyMR5uzsqq6MvhO5fBLjsCfoP9br4YNeCLMUgCoK8oFKUNrm9mDlKVpM9vux
 bFW7Tb4NAg96D3jj6vzSw5XlihB500ekRNCYqvqUYOjdaKBSK5U+No/YFU4uxl8OV2ht3ZM52C
 xPbcRuAlkuGf8qYLV7Wc/3TC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 15:51:07 -0800
IronPort-SDR: yNvnMjXW346K7U6jCdqqm43ZAUXp9tQ4/5PWfGi0t/hoOXEOkeWMH2sqmoF9MWr15T9IecUil5
 +rIn45F+wDZ1zPspKPZR1OgHnNlozCSwSnYV9jmeblvU1tlIro7n4fjvb9uDQVgiRLZK780H8R
 ELgikQw7yv+uSv8qijoCDDSAvDaENigKnr5VKSba21lUMzC8nK5f8mBQ3dPB2a7dSMlbOV8qkE
 B6ArTygPgNdOdvhW5m054E/h+5+TA0FS6XAi1PB3rQaHPRTVd3AjgiG1vKojnvnJbm+HBGh5Gc
 J9c=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.117])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 16:04:59 -0800
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
Subject: [PATCH v3 1/5] RISC-V: Move __start_kernel to .head.text
Date:   Wed,  4 Nov 2020 16:04:35 -0800
Message-Id: <20201105000439.1491243-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105000439.1491243-1-atish.patra@wdc.com>
References: <20201105000439.1491243-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, __start_kernel is kept in _init while _start is in head section.
This may result in "relocation truncated to fit error" if _init section is
moved far from head. It also makes sense to keep entire head.S in one
section.

Keep __start_kernel in head section rather than _init.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/head.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 11e2a4fe66e0..45dbdae930bf 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -177,7 +177,6 @@ setup_trap_vector:
 
 END(_start)
 
-	__INIT
 ENTRY(_start_kernel)
 	/* Mask all interrupts */
 	csrw CSR_IE, zero
-- 
2.25.1

