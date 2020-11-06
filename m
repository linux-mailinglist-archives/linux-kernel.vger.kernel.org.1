Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6C02A8D7F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgKFDaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:30:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7151 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFDaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:30:52 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CS5WL2l2Qz15Q31;
        Fri,  6 Nov 2020 11:30:38 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 11:30:34 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <osandov@fb.com>, <rppt@kernel.org>,
        <lijiang@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <hewenliang4@huawei.com>, <hushiyuan@huawei.com>
Subject: [PATCH] x86/kexec: Initialize the value of ident mapping offset
Date:   Thu, 5 Nov 2020 22:30:05 -0500
Message-ID: <20201106033005.2354-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hewenliang <hewenliang4@huawei.com>

It is necessary to initialize the value of ident mapping offset.
This can not only avoid using dirty data, but also improve the
code readability when we using the variable of offset.

Signed-off-by: hewenliang <hewenliang4@huawei.com>
---
 arch/x86/kernel/machine_kexec_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a29a44a98e5b..101cbce893e4 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -196,6 +196,7 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 		.alloc_pgt_page	= alloc_pgt_page,
 		.context	= image,
 		.page_flag	= __PAGE_KERNEL_LARGE_EXEC,
+		.offset		= 0,
 		.kernpg_flag	= _KERNPG_TABLE_NOENC,
 	};
 	unsigned long mstart, mend;
-- 
2.19.1

