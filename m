Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4C2FE357
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbhAUHCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:02:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbhAUG7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:59:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19262239E7;
        Thu, 21 Jan 2021 06:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212230;
        bh=+H2zPsLci1bezk2S3JmavBPHLPQUue/AmNZ7OZAGcJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s94hz0ctLE03TEDMS4oSergz79QSBeWnA4adayWZ1ry5Zi4nB34tD77GvSoJlG7mK
         1742CZG9vko3YaJ58A+er4JWgNoclTtCe7ZjNTsv99JExVltr2QYh/g1RO5mgG73pJ
         pIIzvXTvxVgvG+3yg1kzw9YllolB8A+PU1jg2306qQwK8clx/yXv19uGo5U2j0Ww2F
         lq6fLVOCFICR9TUBigGUX+3LCH3wkbXx8IU37TmVpOtSLToUD2GmtLML92TgsDAJTw
         RcGWIFgm6ZU1kANh8WZI+TIFvyEvtArD/5RDPjy0tEkgZP2KSC8AAloL+EKJxQOlUu
         707IKeZpqK9hA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 16/29] csky: Add faulthandler_disabled() check
Date:   Thu, 21 Jan 2021 14:53:36 +0800
Message-Id: <20210121065349.3188251-16-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Similar to other architectures:
In addition to in_atomic, we also need pagefault_disabled() to
check.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index cecca6729b04..9533bd8d9a6a 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -143,12 +143,11 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		return;
 	}
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
 	 */
-	if (in_atomic() || !mm)
+	if (unlikely(faulthandler_disabled() || !mm))
 		goto bad_area_nosemaphore;
 
 	if (user_mode(regs))
@@ -157,6 +156,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	if (is_write(regs))
 		flags |= FAULT_FLAG_WRITE;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
-- 
2.17.1

