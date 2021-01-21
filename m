Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3832FE380
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbhAUHKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbhAUHAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:00:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87C48239D3;
        Thu, 21 Jan 2021 06:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212239;
        bh=n/d4qzyKEBSN6wEYviPTAANOgNC5x/Ni05YWDF3mv7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U23fQpQnrVKh2CQwhM4RooWyadDSWljBAd10FqWNrDFruQBgyJcsW9IjAeLHPKpmy
         z16xWjUSG5G/MIs7wCqZkYSWanbCwX6hT0lR+nOR5cMxOHZGmo1TGfQTaN8Zhoov47
         J266N1xeuL0VGeUFSQsI/LG5S7/2fC0V2B/t77+7RAPnyloepFi8/lYfpLaleozDMu
         UKsTq/wzWn0vNGWi2dK6kcvngFbbQ7jGC+7Wu3S495m4Bxpu8bkz+qRDy32ts4ouIc
         VZPckTkamO/FvYCh4jfTUybM0Zchfpvv7Rgbe4buqFOdntXK7ksHDJpeOoGghINzF+
         hDerCdMwSuB0Q==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 19/29] csky: mm: abort uaccess retries upon fatal signal
Date:   Thu, 21 Jan 2021 14:53:39 +0800
Message-Id: <20210121065349.3188251-19-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Pick up the patch from the 'Link' made by Mark Rutland. Keep the
same with x86, arm, arm64, arc, sh, power.

Link: https://lore.kernel.org/linux-arm-kernel/1499782763-31418-1-git-send-email-mark.rutland@arm.com/
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/csky/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index c7b67976bac4..1482de56f4f7 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -279,8 +279,11 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * signal first. We do not need to release the mmap_lock because it
 	 * would already be released in __lock_page_or_retry in mm/filemap.c.
 	 */
-	if (fault_signal_pending(fault, regs))
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			no_context(regs, addr);
 		return;
+	}
 
 	if (unlikely((fault & VM_FAULT_RETRY) && (flags & FAULT_FLAG_ALLOW_RETRY))) {
 		flags |= FAULT_FLAG_TRIED;
-- 
2.17.1

