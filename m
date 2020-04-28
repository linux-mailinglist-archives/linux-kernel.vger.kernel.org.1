Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ACA1BB6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 08:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD1GeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 02:34:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbgD1GeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:34:04 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BC3706C49FD3CD5A717C;
        Tue, 28 Apr 2020 14:34:02 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:33:53 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <aryabinin@virtuozzo.com>, <glider@google.com>,
        <dvyukov@google.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <nickhu@andestech.com>, <zong.li@sifive.com>,
        <kasan-dev@googlegroups.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] riscv: remove unneeded semicolon in kasan_init.c
Date:   Tue, 28 Apr 2020 14:33:19 +0800
Message-ID: <20200428063319.44539-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

arch/riscv/mm/kasan_init.c:103:2-3: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/riscv/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index ec0ca90dd900..dfe988dd0ceb 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -100,7 +100,7 @@ void __init kasan_init(void)
 			break;
 
 		populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
-	};
+	}
 
 	for (i = 0; i < PTRS_PER_PTE; i++)
 		set_pte(&kasan_early_shadow_pte[i],
-- 
2.21.1

