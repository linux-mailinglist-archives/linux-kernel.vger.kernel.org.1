Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9F289A78
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391340AbgJIVNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:13:55 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50437 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbgJIVNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602278539; x=1633814539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/QbUqQmeMLjTwBzMbaBF9lCBuT7lct8fLe+m4vUDssY=;
  b=OkzHqm/LS2JO3YxRHz3VisN3DjDbFKKlS812Z581lflTozBDTphiyFGd
   p9SgWZcmmWP8E5hM1lrF3KTYCTh6Iq74kGrYhqNvazAYMMgcY7UPJ1API
   xaoEQxlt8UsssBRtUNFRgI3ZJpoMjaiQqYM9jFKqFtXTHcqSpgvVI9tk3
   2bfYGE1bdHVivfDFzmLOCRQ2AOkRuKAK9W89hat4X2UaMa8km5pmLXMf0
   q2QqvNO1kKEPw8Jx663BSC3skyzRSd+OH+hxHEiR1PW5D1s6xtSaMHPNm
   VCkWPR/DMOFr1GoGI+rd2FtuhG42DvdBVw7Q8tj8CzF5ob+dGxO6ELmsq
   Q==;
IronPort-SDR: 0RFAegzT2jT9Wc5Uhlq7VZlbcFEKCnBQyHnV404+xPZTMUcdavIZ+fxU5LLS0c8kFxuXlS+rNK
 +v6/bMD1YnEUMUpwlTjdF740FICWKxet9aq4k2WEJcgktHO5JZpMwQOeZ8qlLExlJaxAWf6gxM
 tIhqa8qorKRljw+NVFLQuUvXeysOswqYsVlH5xBFkR3ZrGmFjgKGuJ9lZPC1xR6NA8J87Ud4Uc
 RAEwOnnBvLGdvUM48LsBo6MT05iQS/yvq6X+KBtEakYEavve5lMfWV+CmrKvS6Z0HiMPiCH9ed
 JNE=
X-IronPort-AV: E=Sophos;i="5.77,356,1596470400"; 
   d="scan'208";a="252936927"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2020 05:22:19 +0800
IronPort-SDR: uR8DGVkW+QNaR6d/oTL5/vGhDAdAUHaIAGqEld/cZXIKMYaXJOUj55WSW8Iu5kY6yrc/cx+HAG
 8iCzeCrz27MRmPXhjbXPDAm6Yjfvw7wn98QBviWvSR7NpjtuEujmZlG48JMysXiWGXlqEqIyEy
 dFqxqaOFk2bdgnuWIqs4WpoeYE9Up+8FYy926zjszo/w4wnSY/B1A96c0A9Fd/2zCrJ0tnSfJ2
 kWXBaiKHoNRVSkg8sBGuxvHq8kNrbbWjf5aj3dtRl9NW6i9PF0uoHQ32rzFyGcZsOkJXVFWKIC
 sZ8yV0bC6RMUPkpMnOFZqViY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:59:41 -0700
IronPort-SDR: DpNNZ5QX9GY5e4Dv4bfNJw2Zednqrf5wkbR/vJKlJyg8CCbe3aBt1YYFjjIY93YGNCX/Bv0hD6
 OMi72XUnj78eYponFLeyS5CjqiV5CyauHbxPhIoGTODjsCGH4pu2DKx6MI6AWzyP17Q283EfiZ
 s/xPfPLrNk3M5jA5RtoLPgHW6XEOFTW774UAKVo3TBIUzQ4wbOHWeLuH0ryZ43idOgBb7cI4AF
 VBZoRioUS0iai5b8kyxfB3VVu4T8YtAeJFUAtqwAVlzkc/fl29HQl6TdpF6qqAkS717tWe5kkZ
 s4c=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Oct 2020 14:13:53 -0700
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
Subject: [PATCH 1/5] RISC-V: Move __start_kernel to .head.text
Date:   Fri,  9 Oct 2020 14:13:40 -0700
Message-Id: <20201009211344.2358688-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009211344.2358688-1-atish.patra@wdc.com>
References: <20201009211344.2358688-1-atish.patra@wdc.com>
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
index 3631147732ee..e820b0c09528 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -178,7 +178,6 @@ setup_trap_vector:
 
 END(_start)
 
-	__INIT
 ENTRY(_start_kernel)
 	/* Mask all interrupts */
 	csrw CSR_IE, zero
-- 
2.25.1

