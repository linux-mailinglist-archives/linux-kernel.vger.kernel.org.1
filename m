Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F102FF609
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbhAUHu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:50:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbhAUG6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:58:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE73E2396D;
        Thu, 21 Jan 2021 06:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212228;
        bh=YHbzxdhpG02t8cJd6mky5l0pwml7Rhb1efMcLMa9ZyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgM20hSFY4iNBf7iiMo9nGiigCLZU8NdvnPkgsmx8lKTcI0mwVIQ5dCXTBFwlqxoI
         xNN8lYs04nmIiUwYfUVUttpTFgjdvJXHw9anygN3tzo/dstrZrPFNYdR6FivE3FdcM
         N+ofd3H7sdEgPlF8+8JhjOAMkhcXyKUewoEXNUFkzYfMQcxWnbpTDgh2hDHkWzC0Oz
         Jan1/Kgtk3snmNK+ff0mvwquCTe64YA412yweaIWLX2waok/DpRmxbHkz0S8OT3BEl
         ZZ32mFEHK9XnYe+1mYcEjoNwbUj3hUn3ULTHBdAeEc9MH2HTx0M95d8Oop8FmRGYtN
         aZWz3oxyzq4jg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 15/29] csky: Fixup update_mmu_cache called with user io mapping
Date:   Thu, 21 Jan 2021 14:53:35 +0800
Message-Id: <20210121065349.3188251-15-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The function update_mmu_cache could be called by user-io mapping.
There is no space of struct page in mem_map for the pte. Just
ignore the user-io mmaping in update_mmu_cache.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/abiv2/cacheflush.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
index 790f1ebfba44..39c51399dd81 100644
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@ -12,6 +12,9 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	unsigned long addr;
 	struct page *page;
 
+	if (!pfn_valid(pte_pfn(*pte)))
+		return;
+
 	page = pfn_to_page(pte_pfn(*pte));
 	if (page == ZERO_PAGE(0))
 		return;
-- 
2.17.1

