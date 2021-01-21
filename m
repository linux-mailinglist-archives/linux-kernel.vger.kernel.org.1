Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2272FE389
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbhAUHKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbhAUG7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:59:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC5E1239FF;
        Thu, 21 Jan 2021 06:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212269;
        bh=PA3iL6Vo65yS8xIO5KQrW22ZwgmgjzdJPdVkRydkCcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmOVW7lOsUudgxp6np0LNoTVBFaQpuBqyZOzQL2bJeP97EpKZs2AqLpEdBRtsn+X0
         jLJ5VqVUArc/nyE4MWn7D48dtoYY+n55Cn6xLDCfCUrrBD0LQ9cBo883d18iOTNWVY
         qpCk/3fVO1mxgxge3nv37xZuUGg/T77NCphqhrEg927IUYin2kr39SEEh5kKjhRj5F
         Lid1U8VK0x+ywbYThZivgkiOd9EvxFntPGzgpDrsH0MZ5JOxrSJiJUJlkMoJ8Qj2DY
         25sO7igy64HLAlg0+0uJf4xSbqNJ5Mk8fDRKqBz15tsSvw7UE1Q1l6Jo6dsfpKITL0
         XOLfz5xGk8ESQ==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 29/29] csky: Fixup pfn_valid error with wrong max_mapnr
Date:   Thu, 21 Jan 2021 14:53:49 +0800
Message-Id: <20210121065349.3188251-29-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The max_mapnr is the number of PFNs, not absolute PFN offset.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index 03970f4408f5..81e4e5e78f38 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -86,9 +86,9 @@ void __init mem_init(void)
 #ifdef CONFIG_HIGHMEM
 	unsigned long tmp;
 
-	set_max_mapnr(highend_pfn);
+	set_max_mapnr(highend_pfn - ARCH_PFN_OFFSET);
 #else
-	set_max_mapnr(max_low_pfn);
+	set_max_mapnr(max_low_pfn - ARCH_PFN_OFFSET);
 #endif
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
-- 
2.17.1

