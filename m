Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A332269D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 06:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgIOEzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 00:55:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37690 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgIOEzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 00:55:52 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2B7B7209F325;
        Mon, 14 Sep 2020 21:55:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B7B7209F325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600145752;
        bh=Ywtr357/PxAYIicMt86wE4sG51M8kFX9o9Bks8Pdzrs=;
        h=From:To:Cc:Subject:Date:From;
        b=VofK15xsFToJVZo5nz6jJlrpsg7b23rszIEcSeoFO2rS00tpY2GnZih5fCjD+uKMN
         tXRMyyFX39KsxqnAf4dgI5gAX6SJZZHIiZKpCeQpF2n5PT+SuOpqejkLCZDhxzdHYn
         fCd8CveMIecD9tecdRKodcjyq2d/PUCXCShEULFU=
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
Subject: [v1] mm: khugepaged: avoid overriding min_free_kbytes set by user
Date:   Mon, 14 Sep 2020 21:55:48 -0700
Message-Id: <1600145748-26518-1-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
user.  Post start-of-day THP enable or memory hotplug operations can
lose user specified min_free_kbytes, in particular when it is higher than
calculated recommended value.

Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: stable@vger.kernel.org
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

