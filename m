Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DC826D087
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIQBWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:22:12 -0400
Received: from linux.microsoft.com ([13.77.154.182]:32846 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIQBVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:21:54 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id E5AE02010AE6;
        Wed, 16 Sep 2020 18:21:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5AE02010AE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600305713;
        bh=nv6FZPTzLlrfKJYlmRC7YqZySDk8iJTmDpEu0XOLTlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/jWPoUSVrHFsbHVwZLwhNusodUwenbNs96V6oLPTDL7F45o7h8uBT6WPVhKyXIg5
         OGjPN7WK+k2EcJxGubb8M10tdMfa96RUweVyV53MjR694mH/z6KGalbdIh890ha/+J
         kbreXTpV/qMityRD7SPqKZpRlud6MZj+BYNnZXMk=
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Allen Pais <apais@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [v3 2/2] mm: khugepaged: avoid overriding min_free_kbytes set by user
Date:   Wed, 16 Sep 2020 18:21:49 -0700
Message-Id: <1600305709-2319-3-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600305709-2319-1-git-send-email-vijayb@linux.microsoft.com>
References: <1600305709-2319-1-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
user.  Post start-of-day THP enable or memory hotplug operations can
lose user specified min_free_kbytes, in particular when it is higher than
calculated recommended value.  user_min_free_kbytes initialized to 0
to avoid undesired result when comparing with  "unsigned long" type.

Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: stable@vger.kernel.org
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/khugepaged.c | 3 ++-
 mm/page_alloc.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4f7107476a6f..3c1147816d12 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2283,7 +2283,8 @@ static void set_recommended_min_free_kbytes(void)
 			      (unsigned long) nr_free_buffer_pages() / 20);
 	recommended_min <<= (PAGE_SHIFT-10);
 
-	if (recommended_min > min_free_kbytes) {
+	if (recommended_min > min_free_kbytes ||
+		recommended_min > user_min_free_kbytes) {
 		if (user_min_free_kbytes >= 0)
 			pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
 				min_free_kbytes, recommended_min);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..7b81fb139034 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -315,7 +315,7 @@ compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS] = {
 };
 
 int min_free_kbytes = 1024;
-int user_min_free_kbytes = -1;
+int user_min_free_kbytes = 0;
 #ifdef CONFIG_DISCONTIGMEM
 /*
  * DiscontigMem defines memory ranges as separate pg_data_t even if the ranges
-- 
2.28.0

