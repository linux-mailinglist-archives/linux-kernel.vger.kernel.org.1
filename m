Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEFE278D42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgIYPyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:54:14 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:42770 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgIYPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:54:13 -0400
X-Greylist: delayed 1026 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 11:54:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AIt158zG6UrFe+7u3ioemv3NfqN1fmnQVECYXJh2LR0=; b=syJkk2dnWCoUhtN8IZ6cqFKR+s
        wOUqxjL1oWSw21XLUmaVVlxsjILZHDJVNRF0Jf93ZFAZDlDyDoV7YJKh26tEN0/epPbmwfYMGeUA4
        7I/Jitsi24HpOh/cpRgOSyjHm5APTsLaSZIrVlvQnbX44/bzC/23tAJOh8jO6p8jom8c=;
Received: from pool-72-73-20-93.clppva.fios.verizon.net ([72.73.20.93] helo=derek-personal-arch.fios-router.home)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <dlesho@codeweavers.com>)
        id 1kLpmT-0007N8-Gk; Fri, 25 Sep 2020 10:37:07 -0500
From:   Derek Lesho <dlesho@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     Derek Lesho <dlesho@codeweavers.com>
Subject: [RFC] mm: Allow 64-bit mmap syscalls to access higher addresses.
Date:   Fri, 25 Sep 2020 10:37:03 -0500
Message-Id: <20200925153703.288236-1-dlesho@codeweavers.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -36.4
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  For those curious about my usecase, I'm working on running
    some windows 64-bit driver code in context of any given process. I accomplish
    this by mapping some of the fake kernel bits in the target proc [...] 
 Content analysis details:   (-36.4 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 USER_IN_WELCOMELIST    user is listed in 'welcomelist_from'
  -20 USER_IN_WHITELIST      DEPRECATED: See USER_IN_WELCOMELIST
  -20 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -0.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  4.1 AWL                    AWL: Adjusted score from AWL reputation of From: address
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For those curious about my usecase, I'm working on running some windows 64-bit driver code in context of any given process.  I accomplish this by mapping some of the fake kernel
bits in the target process, and running the code in a dedicated thread.
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 40248d84ad5f..3a6940ef6128 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2240,7 +2240,7 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
-	if (addr > TASK_SIZE - len)
+	if (addr > TASK_SIZE_MAX - len)
 		return -ENOMEM;
 	if (offset_in_page(addr))
 		return -EINVAL;
@@ -2767,7 +2767,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	unsigned long end;
 	struct vm_area_struct *vma, *prev, *last;
 
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
+	if ((offset_in_page(start)) || start > TASK_SIZE_MAX || len > TASK_SIZE_MAX-start)
 		return -EINVAL;
 
 	len = PAGE_ALIGN(len);
-- 
2.28.0

