Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E597B20B2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgFZNwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 09:52:36 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33093 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728938AbgFZNwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:52:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U0lTVpj_1593179550;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0lTVpj_1593179550)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Jun 2020 21:52:30 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, vbabka@suse.cz, willy@infradead.org,
        thomas_os@shipmail.org, thellstrom@vmware.com,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        aneesh.kumar@linux.ibm.com, peterx@redhat.com, walken@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [RESEND Patch v2 1/4] mm/mremap: format the check in move_normal_pmd() same as move_huge_pmd()
Date:   Fri, 26 Jun 2020 21:52:13 +0800
Message-Id: <20200626135216.24314-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, just improve the readability and prepare for
following cleanup.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 5dd572d57ca9..97bf9a2a8bd5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -200,8 +200,9 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t pmd;
 
-	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
-	    || old_end - old_addr < PMD_SIZE)
+	if ((old_addr & ~PMD_MASK) ||
+	    (new_addr & ~PMD_MASK) ||
+	    old_end - old_addr < PMD_SIZE)
 		return false;
 
 	/*
-- 
2.20.1 (Apple Git-117)

