Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90E32A7396
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgKEAFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:05:02 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35631 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387859AbgKEAFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604534700; x=1636070700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BXRrXHASEZw+q5AEH6JXn4IG5K15cGG21TkLjxF25TY=;
  b=aZLysDbiSdJcXQrwfuD6CakSIJrPWD0uQIReUIEImwIWkQ31SoXA9+jy
   jZ5XLwLJq6ZVoW4ua9tbQtX0T/5IvQ32w1qjVZGK/Hxw2w+GHS9aWj526
   glL2FM1V4GreZapSxGmU2tVQACAB65NHiDbLlJJjISzANoW1mxK++Bj0/
   Fhi/ZcW2qqxsRn0np/E0l9qxWM+GaYdsFA1nCQVME0GCfnXBWV4Seq/NJ
   3Wixpk6Mb1mFSimy4O6D+nVDXy5OCd8nvjKX522gebB72rIme6CZXBTHZ
   NdbOdMdSUJtofTectM3yRVU7Fp8C75fHOkFgQyhDlzixdzB05A3rC1Z0f
   Q==;
IronPort-SDR: p/DYTusq7biufAJ3S4PS6VG1un0QNdrtxzoJVABjCuAbTtG0KRZMC184sUI07Y+kNsLNLa5n0F
 8TU8Hw5ZBfzhrVf9FkfCuUZ7KqMdJYdUZJvo2OYO3m1NbGN7hbeRU33LiUYCBSRFE7oNizTUT3
 s5+787grU0D9Dbq8S4DkmBWmd28/xXy3Y2g0GpbWUGRqoXaau60iRjtDFv40h5lP6/GzZ/Yyl5
 Pz5dhw2BAn7PqPOOM5o8gQBK6V+yyxpf/qPx/xc5TCRAXYyjGi5bvklE9kaqCdMiLcgu53GaQU
 vUY=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; 
   d="scan'208";a="151945111"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 08:05:00 +0800
IronPort-SDR: ZQNKPG+SDlxK8BzpQk2DPPyFpSGeeGVDhS2CyVs88mcAXxUOI6xib/GJ1ruU+yTTA097HrmSGu
 knvO8e84Sx1axZyhIoRJrexsdLrfhBCxl1b4/gP5ZBuEE8gFqOFNtJf46BXr0fBVaNUxEpXLAM
 8AjFog7rmwAWZwzfHg2tZvdmvoIAbhBlt/qMc4cYnvAPgIpnFe7FSQmXTjnq4tdBinBSJUCCwh
 1ft1V9xtKLPnSTRq/2XuzdY9rDCgqhm4OuTC1H8JxrtQKN99wxglBA8cw2V5F2dS306QzU51of
 DxUchtWiVFwvzHLNRxHHPwOw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 15:51:08 -0800
IronPort-SDR: 2kBqKLfZRTKPik4vjGm4JTPL+wbmUTlo3Ysh8bs3KaEywAiOKWO5WSUs20iEdVAavr3XgDyz7M
 RgzKRGH7w7o9kz/+ZEmiaMZkRYwaiqfhP9o9S6l5PLGIT/AEdjR2voufleZg6H8yLg79hrSgJL
 ua6Y1XLCY5npxZaZg40dYEcXfVF2h5FdrMcDRt+INNUDBX5vhKZE3NgbBwZVTr4zjUbNHRsqY1
 nkJg7g0pu94qjsEfRFL8TYqMjTZV908Y3h4FYXvySXqJWLK16yaqKt4Ei3zaWhkiP2ELoMJ2y1
 IEQ=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.117])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 16:05:00 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Jim Wilson <jimw@sifive.com>,
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
Subject: [PATCH v3 3/5] RISC-V: Align the .init.text section
Date:   Wed,  4 Nov 2020 16:04:37 -0800
Message-Id: <20201105000439.1491243-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105000439.1491243-1-atish.patra@wdc.com>
References: <20201105000439.1491243-1-atish.patra@wdc.com>
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

