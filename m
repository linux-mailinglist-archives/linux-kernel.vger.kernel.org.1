Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406021C54EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgEEL7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 07:59:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3805 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbgEEL7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:59:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E7844BA485B2E66112B2;
        Tue,  5 May 2020 19:59:30 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 19:59:20 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mm: remove an unnecessary goto jump
Date:   Tue, 5 May 2020 19:58:58 +0800
Message-ID: <20200505115858.1718-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "goto" doesn't reduce any code, but bother the readers.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/page_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 76965be1d40e..b1d4f4558e6b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -235,10 +235,10 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 	sis->highest_bit = page_no - 1;
 out:
 	return ret;
+
 bad_bmap:
 	pr_err("swapon: swapfile has holes\n");
-	ret = -EINVAL;
-	goto out;
+	return -EINVAL;
 }
 
 /*
-- 
2.26.0.106.g9fadedd


