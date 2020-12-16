Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE5D2DC0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgLPNMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:12:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9533 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgLPNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:12:18 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CwwVV559vzhrSW;
        Wed, 16 Dec 2020 21:10:58 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:11:27 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] kernel: cpu: mtrr: convert comma to semicolon
Date:   Wed, 16 Dec 2020 21:11:59 +0800
Message-ID: <20201216131159.14393-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 5bd011737272..9231640782fa 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -537,9 +537,9 @@ static void __init print_out_mtrr_range_state(void)
 		if (!size_base)
 			continue;
 
-		size_base = to_size_factor(size_base, &size_factor),
+		size_base = to_size_factor(size_base, &size_factor);
 		start_base = range_state[i].base_pfn << (PAGE_SHIFT - 10);
-		start_base = to_size_factor(start_base, &start_factor),
+		start_base = to_size_factor(start_base, &start_factor);
 		type = range_state[i].type;
 
 		pr_debug("reg %d, base: %ld%cB, range: %ld%cB, type %s\n",
-- 
2.22.0

