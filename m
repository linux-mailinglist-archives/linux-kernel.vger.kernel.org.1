Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F057F26AF44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgIOVOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:14:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48202 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgIOVLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:11:03 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7BBC620A115B;
        Tue, 15 Sep 2020 14:11:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7BBC620A115B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600204262;
        bh=7xajAEpRfasIvIA9qX7Nw/+zwdXKydGaiUOrgh4P5wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=adZiRDEA3132WzypO//6vmLB/t2g1KuZTJvpfaWOrPVwCWEcJfnt+lBmOwJ76yZt6
         QQPBDIEbGprHvAVudVndd8a2sg4vp+WOSsUd0aMjTQ6a6piwJzopk/eY84aeh7uGVN
         URbEjN848tTQOUzEnZYLcJeBnt3apSqQShtozDN8=
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
Subject: [v2 2/2] mm: khugepaged: avoid overriding min_free_kbytes set by user
Date:   Tue, 15 Sep 2020 14:10:58 -0700
Message-Id: <1600204258-13683-2-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600204258-13683-1-git-send-email-vijayb@linux.microsoft.com>
References: <1600204258-13683-1-git-send-email-vijayb@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
user.  Post start-of-day THP enable or memory hotplug operations can
lose user specified min_free_kbytes, in particular when it is higher than
calculated recommended value.  Also modifying "recommended_min" variable
type to "int" from "unsigned long" to avoid undesired result noticed
during testing.  It is due to comparing "unsigned long" with "int" type.

Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: stable@vger.kernel.org
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/khugepaged.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4f7107476a6f..b4b753ba411a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2253,7 +2253,7 @@ static void set_recommended_min_free_kbytes(void)
 {
 	struct zone *zone;
 	int nr_zones = 0;
-	unsigned long recommended_min;
+	int recommended_min;
 
 	for_each_populated_zone(zone) {
 		/*
@@ -2280,12 +2280,12 @@ static void set_recommended_min_free_kbytes(void)
 
 	/* don't ever allow to reserve more than 5% of the lowmem */
 	recommended_min = min(recommended_min,
-			      (unsigned long) nr_free_buffer_pages() / 20);
+			      (int) nr_free_buffer_pages() / 20);
 	recommended_min <<= (PAGE_SHIFT-10);
 
-	if (recommended_min > min_free_kbytes) {
+	if (recommended_min > user_min_free_kbytes) {
 		if (user_min_free_kbytes >= 0)
-			pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
+			pr_info("raising min_free_kbytes from %d to %d to help transparent hugepage allocations\n",
 				min_free_kbytes, recommended_min);
 
 		min_free_kbytes = recommended_min;
-- 
2.28.0

