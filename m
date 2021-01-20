Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F512FC9AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbhATD5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:57:51 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:52413 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730883AbhATDyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 22:54:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UMIdG1w_1611114800;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UMIdG1w_1611114800)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jan 2021 11:53:20 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v2] x86/sgx: Fix free_cnt counting logic in epc section
Date:   Wed, 20 Jan 2021 11:53:20 +0800
Message-Id: <20210120035320.19709-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase `section->free_cnt` in sgx_sanitize_section() is more
reasonable, which is called in ksgxd kernel thread, instead of
assigning it to epc section pages number at initialization.
Although this is unlikely to fail, these pages cannot be
allocated after initialization, and which need to be reset
by ksgxd.

At the same time, taking section->lock could be moved inside
the !ret flow so that EREMOVE is done without holding the lock.
it's theoretically possible that ksgxd hasn't finished
sanitizing the EPC when userspace starts creating enclaves.

Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c519fc5f6948..34a72a147983 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -41,16 +41,18 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
 		if (kthread_should_stop())
 			return;
 
-		/* needed for access to ->page_list: */
-		spin_lock(&section->lock);
-
 		page = list_first_entry(&section->init_laundry_list,
 					struct sgx_epc_page, list);
 
 		ret = __eremove(sgx_get_epc_virt_addr(page));
-		if (!ret)
+
+		/* needed for access to ->page_list: */
+		spin_lock(&section->lock);
+
+		if (!ret) {
 			list_move(&page->list, &section->page_list);
-		else
+			section->free_cnt += 1;
+		} else
 			list_move_tail(&page->list, &dirty);
 
 		spin_unlock(&section->lock);
@@ -646,7 +648,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		list_add_tail(&section->pages[i].list, &section->init_laundry_list);
 	}
 
-	section->free_cnt = nr_pages;
 	return true;
 }
 
-- 
2.19.1.3.ge56e4f7

