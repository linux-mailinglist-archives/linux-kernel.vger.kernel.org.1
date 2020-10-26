Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B6F299A17
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395146AbgJZXD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:03:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51595 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395115AbgJZXDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603753404; x=1635289404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qmlk0Pnoc73PLeMzxCGZ41KUAZ0XJ8ZZaWUmbVJfPT0=;
  b=ZfcHxto3f66cAfv5M0gG7sY9U9sn73O/CLTLIhXWtcWIgpwIu1tivvsd
   gxVe8o9Mu2ZooRJa6Y8c88PYlBf7plKs0IjJpU6kBeyJQJ+Uga+5fqNBz
   IYlERS08DkdF+sbRIRDFeg45iv3YQ3/3E9yzBuvU+oc/zrAhID5cdfGzZ
   eB0lBNlcOPTglUI2khX4RLJW9iZDRZnuP0gqe0YIDu7gV7LSJni4F7ktB
   2LuSXE1J/G5N5bRiw9LAkoFtOWuw361Kgqd7e5HkUuq+OwXVA+2mwefgN
   y23pArYr9UGaNfdlR5NrqGuijtI7sZyNgOxynZkz1TSEk/KHqXQQYG/v/
   A==;
IronPort-SDR: yzXHv+O9gzFvuLnI0xPs1J5+vpCCPATI1RtiPi9jpFm8FyN4qZA9LjqeCgCo3jbWqFP4b7SXYf
 9qw2z85MxmXiVa+AkAvmnOkXEpFNPa43GOTyVIi/dV8A+BpjiBXsKlfAiY0L0V9XJ6W6ttOSPo
 QwhDxEOO2Q992mD3dgiJFjqlEaWponmdXejouN47XBSBE+ALPgyxDaN3c4nJBc1uIcJ6z3nF42
 6zrEJxK0IeFDMmqp1VgduxFSgxrJJ3Zg5VQxQXc7paizj/n38xaZ1nehDLCNoeB/iQYjcQnnJM
 Ezc=
X-IronPort-AV: E=Sophos;i="5.77,421,1596470400"; 
   d="scan'208";a="151009469"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2020 07:03:23 +0800
IronPort-SDR: 3APL6fViULSanT+i0v3Rut7YPiYtegQey1eZk+6s1QWx5R5XtoLune1SAC0y7Z3ycj8Wun5wYG
 TRlK1cKnEn96FZ0uUZPx9LOf/799EaJvPFH996LedFMq+laSCuTRYzWMZr7HbXzTRApg+O/qzW
 c5dUc4K4NATBnAFcQVohzQiVZCxb9SpDRwjCPj3R63iD4tPEsZlu9ofWFuayGoQl11Me3XBSSW
 ZlcsMr6XmiKfvhWiiydjGRloMpqfqzcrf1DQC86G6M1fKFHAeMuYxl14l60+dNSv0HCq176Dif
 0FmHrlp6WgBDivquOFeFy7yu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 15:49:42 -0700
IronPort-SDR: w0qKrqk4Ps76VXo2fhQqnJ3FzMjkvDA5n76UhstySma3ZkkQkkND11NhJZJe1RlXHu/OQkarV/
 5eJJS29Zjj//2bfffUYVZXW2/yuSD0isOWFHbB8RAWw1+v7/ODIlLVksfre4BHHKG/C4su00sv
 EAC/XmNixR8peOtynxZ0tW4ZofnRxUZ5ok6zjykyuVEQPSkyAFY4IZSWqNz+XVT+JZAK6I8bpi
 YWP1fNPizwdXJD1KYcY1PiwAqN04YYwkFs6RUTz+WYH+vwTMz3OLF7cwaI9wldwepnoJKem0cx
 6Ho=
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
Subject: [PATCH v2 1/6] RISC-V: Move __start_kernel to .head.text
Date:   Mon, 26 Oct 2020 16:02:49 -0700
Message-Id: <20201026230254.911912-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026230254.911912-1-atish.patra@wdc.com>
References: <20201026230254.911912-1-atish.patra@wdc.com>
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

