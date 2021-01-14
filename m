Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9712F68BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbhANSCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbhANSCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:02:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD6BF23A34;
        Thu, 14 Jan 2021 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610647265;
        bh=le/X67LqDQyYNfmvnh3xPk1qP9pMyMRhNXSbQy6H+SM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pWzH1j8Vdej/zy9+re0IxtOLZ1Npy8Kaf+fx/fK0SsPPlM+NzZBl+g9RnCPNS1n3s
         CxWm8Qg75WMAtEulY47zE2T3jvidDyc03HYzFttAsAVhg5rWSyJjWCqMeANJdMwZQQ
         sVjZzsBBnieVyMenHT/j4I5+Pw6Zan2KSffZiCkpksNqyeU5PnApJgFHaNMVeaMgCW
         heOkRBlQMIbYBNG62v+XLydCFfGUuZmAJSZLxzGcIhKF6kUqCN5jyE9n65JLK2Wv1D
         wrRGEZtjuOc2jyX6r6ThbnZhFPlFJ6rsclSUjF0z9hyEzpMPmVk/C082wEsQhmUyV5
         plWaxStDUW91A==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: [RFC PATCH 8/8] mm: Mark 'info' field of 'struct vm_fault' as 'const'
Date:   Thu, 14 Jan 2021 17:59:34 +0000
Message-Id: <20210114175934.13070-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114175934.13070-1-will@kernel.org>
References: <20210114175934.13070-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field is only ever read after being initialised, so mark it 'const'
before somebody tries to modify it again.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c24dd17b32c5..b45a8e075f7f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -521,7 +521,7 @@ struct vm_fault_info {
 };
 
 struct vm_fault {
-	struct vm_fault_info info;
+	const struct vm_fault_info info;
 	unsigned int flags;		/* FAULT_FLAG_xxx flags
 					 * XXX: should be in vm_fault_info */
 	pmd_t *pmd;			/* Pointer to pmd entry matching
-- 
2.30.0.284.gd98b1dd5eaa7-goog

