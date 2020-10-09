Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FA289A77
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391302AbgJIVNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:13:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50437 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388641AbgJIVNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602278538; x=1633814538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P6MToLoY21O2rZVwNli0IYzCJtAmEa+Tym9KCg1Gq3Q=;
  b=R/r/6C8DCPa22svE2jVgOlj+g+TbAGjO+63d5ixlJK95XIQwUCZznczU
   3rKgljAb0zJlBDfI9dnVMM5iPR+yzTJN7I4XFSDd+yizzZFuYYWZbUeLy
   LjQOrDbxgyq8u888tXRAye47oOaKTRhKJSsenVCRPQfnBWUm3Jxg4JSSv
   FCBdDzFk/yTtFZwvcx+yuR3bAoTkWMkpJYp/lznswc8+fQUPWHhTJiYff
   3JjHGKC9sUazA6cujoxJH3/p2Xj+cYvHqPs3VmH/G8DxXyLI9Zfhxh261
   Ze7n6BouqecyK87IlQZAwUVAt+aRtZkPE9Woq28Yglz+RQym0dEwZUfQT
   A==;
IronPort-SDR: GmHX556dJwDW7VosNh98DbgyWUy153trxuN/TBz5N54wQg7d/qCCVCtWfs96z9drlCSh9YKvW9
 ra0JjX6nNBKfkbqChQSGABn/s1Trl2DfCxgP548eyaOKUqur1JZPrZZDF8R/mdoY7kIm68TJ1x
 iqbXP84NM6B6+/68zhcYMaid/OyYVF6NJViK/P1A3lOcUY6X55uwPVuLXOhklunwO9PMzMQhOJ
 4gcpXDEvjsjRb2TBWpA73iksQux+PBPYeoqDCLlKlILsv81MknEXUpxkJMqYBGimR6cr1vNBfR
 Y90=
X-IronPort-AV: E=Sophos;i="5.77,356,1596470400"; 
   d="scan'208";a="252936922"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2020 05:22:18 +0800
IronPort-SDR: yuXhJvhu+A9Erbj3H6fYT/B+vmb0TxXZlpw4h1vRZU5fkSrB4RcflkMmnuBODpGlmbUgP/iFwg
 i8FStXQDq+6om0ZkMcKPG3+SUex2cu04eUiAJhTWUmYF4BW0g/YC8eH+O+gsnjSLEfpRFHDuCt
 tTlK/ifFkVbIIwQMLL5AUJ1x18MlTTYwoEZllbwekcT/768FHJTu3lR7jtFUpYZQqJgWgNtpBO
 ltBRe+nSBc4Y6VjYhxIuEQnfyR90z65LeQ8znkMsuigLRBLHnkGeOEHb3d1wiVS1m9WC2V2Nlt
 SEkx8FXTQ6rftzRExRfWsQPn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:59:40 -0700
IronPort-SDR: awzyS2FKyWwGRL2l9UN6x4T3nQsC2SFXYZlWDZBGgRgs9wdh/EUzSaXW6aAwGazTcEn3zVzUV4
 DXGWftDkcWrPmwbWdz6/9GoJEQA5JQkgjvzMAwgMGTxzrOPu0992/21TbYmVInH1zLtAQBqbFq
 Onl44KPAf9AfNWvzrtCPJ9zTPYjm1T1Y+3/ct1iaaqn0o8CJNsQHp1igR8Q2yuwsTylJaZ8ZBH
 eewJwyhKvOsLr9I4L+1dBvNSLtFb155iPBDs0Ma1h6ysErWop6/ZP3nLoLFh585JZi8Nw29CNR
 XCM=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Oct 2020 14:13:52 -0700
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
Subject: [PATCH 0/5] Improve kernel section protections
Date:   Fri,  9 Oct 2020 14:13:39 -0700
Message-Id: <20201009211344.2358688-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims at improving kernel permissions by doing following things.

1. Protect kernel sections early instead of after /init.
2. Protect .init.text & .init.data sections with appropriate permissions.
3. Move dynamic relocation section to _init.

This series is based on Guo's static object fixes[1].

[1]https://patchwork.kernel.org/project/linux-riscv/list/?series=360951

Atish Patra (5):
RISC-V: Move __start_kernel to .head.text
RISC-V: Initialize SBI early
RISC-V: Enforce protections for kernel sections early
RISC-V: Protect .init.text & .init.data
RISC-V: Move dynamic relocation section under __init

arch/riscv/include/asm/sections.h   |  2 ++
arch/riscv/include/asm/set_memory.h |  4 ++++
arch/riscv/kernel/head.S            |  1 -
arch/riscv/kernel/setup.c           | 13 +++++++++----
arch/riscv/kernel/vmlinux.lds.S     | 18 +++++++++++++-----
arch/riscv/mm/init.c                | 17 +++++++++++++++--
arch/riscv/mm/pageattr.c            |  6 ++++++
7 files changed, 49 insertions(+), 12 deletions(-)

--
2.25.1

