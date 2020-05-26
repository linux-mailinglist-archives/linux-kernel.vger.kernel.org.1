Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC11ADCFA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 14:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgDQMKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 08:10:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2351 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727831AbgDQMKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:10:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B89DD7271A07F10F0C2;
        Fri, 17 Apr 2020 20:10:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 20:10:36 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <atish.patra@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/3] riscv: sbi: Correct sbi_shutdown() and sbi_clear_ipi() export
Date:   Fri, 17 Apr 2020 20:12:20 +0800
Message-ID: <20200417121222.156422-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect EXPORT_SYMBOL().

Fixes: efca13989250 ("RISC-V: Introduce a new config for SBI v0.1")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/kernel/sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 7c24da59bccf..62b10a16c8d7 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -102,7 +102,7 @@ void sbi_shutdown(void)
 {
 	sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
 }
-EXPORT_SYMBOL(sbi_set_timer);
+EXPORT_SYMBOL(sbi_shutdown);
 
 /**
  * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
@@ -113,7 +113,7 @@ void sbi_clear_ipi(void)
 {
 	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
 }
-EXPORT_SYMBOL(sbi_shutdown);
+EXPORT_SYMBOL(sbi_clear_ipi);
 
 /**
  * sbi_set_timer_v01() - Program the timer for next timer event.
-- 
2.20.1

