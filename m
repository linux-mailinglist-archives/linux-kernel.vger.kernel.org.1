Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13522F24B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405055AbhALAZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:10 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38128 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404195AbhAKXqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610408785; x=1641944785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tvZB29ktPRPxUbu7K7bplYyQtg0XnG4cGna9D/+Lark=;
  b=n8YSS5L4+eH8alE3YlJbXZHHr+n+5fUlsrlOZO6gBDs0ReAWpwPeXdjf
   sjYAYNe0cLzJenaXrOCBkpsEmO1PgtkSQYyaLAysr6StDgAbtgffu3ONb
   inJo0ZuFRdAuaM/WCkNDtiYwekTZ+S8J0EsrEr3SrU/S8Zk3AvjTUqpmY
   3xp53wKluz+zFexJVf0oeci2LXHbC8C649Cs0SdqWEbPksHv+pOiNnABO
   QBbonEYi1/H4/g/cSlKBQ2SZhZy3HOH/xF9q/cr7xpkarE9Jk+UcXOLig
   ed5Df/SikJPsXN7qWbK0ft3Uu+DPiYSAngTDgNNG279NstHnFB3DMW9rZ
   A==;
IronPort-SDR: H4C70pO/MhtBLrqTuPro3JIiGohP755jApeVaeXbUx3pAnT0DPADY3U+UpSh3TFwjG7nDoWQT2
 H5pXxalskVyBskIroM2U7SPEz7OROas9lPNMU4lVfK35kvTPMtCijp6+HhlV0JbDCnG2dNOPJo
 iXxxuP0IufZgk/uLm35wxkrI6qPLglOnWaRYUKJ8amvJCM1xRs0akDkZdkCHug09wWxs5aWm5Y
 nXzbjKWvip8ck6KctfZZDtOLRz+uoOLC2igbeP8IOQcFsZMFIwsUmIcRl9x8sZ366QNb92zbhy
 /H0=
X-IronPort-AV: E=Sophos;i="5.79,339,1602518400"; 
   d="scan'208";a="157190568"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 07:45:19 +0800
IronPort-SDR: Jp42Rrun7hoDnfgaKI8QUfaF4RhkqdDOFH1s5vC1gbz1YG9+50nVGbBoOci3n50BcioYCNPrfq
 k0K8kjL+vHYImEjsmnqyiHg0O17Bd44ymmIVQATHRbQsGUbJhl3Ogk0930JHea7opJrJx9n/0B
 O6s58l2GhtStay9LYCJ4dsxuGlWYh/rgjrUXkeNI4Keo+vt8QOppo0/xnt7gYTRGKuVBeTA4EB
 fa8gAmWIG/OKF0llAr6qZ8ZJkYA8hmzfSer9/pcegb4Ub5XcFA/8QFRSKPuOSnEe254/bLgXpN
 RquS1yGBcQ6s40MbvGB0SCjt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:28:13 -0800
IronPort-SDR: EQInO/9vri52nvmIWcEUHszD8BfL0SIUPoaYPJJMgKnCYS7YpuPA11r9okTng8jkPiD9/T4zoN
 nDK7ZZbZ+o35kmz5ht5VhN9IuKBxz8SQYNrHp620y6/g3erpMgJ0nxtzqxrRLqYuYqHeZePpMl
 0hjx8o4X9fXPR+AVpGucJCVncJeZDkbIRMH9B1+RFfcqurTCgEGYu3XXbfd5nhr4UF38mV2XPn
 bhX4YrOVKcarwsjP0C0bc6+moIW0MGVkGh0hxtrXMHFBa8vkaPDF3Qj5zKFdiNbT636BzWI/8U
 2hc=
WDCIronportException: Internal
Received: from usa002483.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.194])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 15:45:19 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 0/4] Assorted fixes for RV32
Date:   Mon, 11 Jan 2021 15:45:00 -0800
Message-Id: <20210111234504.3782179-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes various issues observed in latest kernel on RV32.
The first two patches fixes an resource tree introduced in 5.11-rc1
while the last two fixes the case where 2GB physical memory is used
on RV32.

There are may be better way to fix the issue pointed out in PATCH 3
as it seems a generic kernel issue where kernel pointers can not use
last 4k of addressable memory. I am open to other better alternate
suggestions.

Changes from v1->v2:
1. Added Reviewed/Tested by tags.
2. Replaced PHYS_ADDR_MAX with explicit __pa(~(ulong)0).

Atish Patra (4):
RISC-V: Do not allocate memblock while iterating reserved memblocks
RISC-V: Set current memblock limit
RISC-V: Fix L1_CACHE_BYTES for RV32
RISC-V: Fix maximum allowed phsyical memory for RV32

arch/riscv/Kconfig             |  6 ++++--
arch/riscv/include/asm/cache.h |  4 ++++
arch/riscv/kernel/setup.c      | 24 +++++++++++++-----------
arch/riscv/mm/init.c           | 16 ++++++++++++++--
4 files changed, 35 insertions(+), 15 deletions(-)

--
2.25.1

