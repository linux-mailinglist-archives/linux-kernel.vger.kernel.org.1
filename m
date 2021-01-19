Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6E12FB014
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 06:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbhASEpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 23:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732161AbhASElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:41:10 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ADCC0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:39:26 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id f26so20789578qka.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7Zip2QrmKQ/Mplic3YGjgwGPQdefB544/adjAiin1/E=;
        b=FJM8VIvv0OUU4yIdZkGWfg8bo1z91Vm4wnb+rF+Aqdi7m++B0uERD6Ylx03QPvZUpi
         RLGNPtXoanfpidtqZpgsFnG4tDyY1VW2sTt0uibOXptbLmCJsuoYFzKC7Qj2PmDRiGU2
         gto4YFvVExedtPn86aLUavKI2J9x6LUPZioSgzAEb1L4rJiSPJNiPJm3czeTh51s9l/a
         kk45Lxxa0ZnSIEYx3bUY4BtCzLBp9m4L5r0bE2mcJxmriQOsZpDjKzbwqhg8n41R833x
         jSro0CWsMJWTkIvEG4XIEbatykdhcM53L4q6J1sYnalXE/rzb+FMO7QeZBjpVvwbySGJ
         4RGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Zip2QrmKQ/Mplic3YGjgwGPQdefB544/adjAiin1/E=;
        b=gRCi5SO+oqqvdxUciT4Uo+y66yFGQ+vg80amvObm+N0sYSMx918OjwfQ+O+db0snXC
         Mk3Jggs25iRo01eNA25mVFt1vmoTq0qYBhm0hWSnQbUOAnfhEIbDhEIzAbngs6Yw3Q8U
         OthtVx7NCsvovHoGYtbwXR4R6EquQItkbFWnRTA/ciEFOcz6YkKOvD0OcGE8+PxcigAX
         vnMgKWL/8RjarS6shAVTLT+y5TWNFWJI4OTG+svWxdSCs/iBpJATdwfPLno7vRRyKaYW
         tdYAoKFyqMWswhXkKy52yHhkKsJdD0rR4U93/P0/+x6ThNCf54qkUY/NvUrKjqJcIrnT
         z6lw==
X-Gm-Message-State: AOAM533L6/ZMHUhSDajCzNR0G6Eiu8l5nPuczahzLyNi1A2ZXdIEWFde
        w4Do8GLB0CVSUFKLoyokaDd6Og==
X-Google-Smtp-Source: ABdhPJx0jhW1FsaaMPRajeI4eKkMnvtdY6UgwPpqZSl8lUTzedh5iHTxAoJBWP1QS03gqLKsrFWgqg==
X-Received: by 2002:ae9:ef12:: with SMTP id d18mr2753571qkg.473.1611031165857;
        Mon, 18 Jan 2021 20:39:25 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z20sm11934536qkz.37.2021.01.18.20.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 20:39:25 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v5 02/14] mm/gup: check every subpage of a compound page during isolation
Date:   Mon, 18 Jan 2021 23:39:08 -0500
Message-Id: <20210119043920.155044-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119043920.155044-1-pasha.tatashin@soleen.com>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pages are isolated in check_and_migrate_movable_pages() we skip
compound number of pages at a time. However, as Jason noted, it is
not necessary correct that pages[i] corresponds to the pages that
we skipped. This is because it is possible that the addresses in
this range had split_huge_pmd()/split_huge_pud(), and these functions
do not update the compound page metadata.

The problem can be reproduced if something like this occurs:

1. User faulted huge pages.
2. split_huge_pmd() was called for some reason
3. User has unmapped some sub-pages in the range
4. User tries to longterm pin the addresses.

The resulting pages[i] might end-up having pages which are not compound
size page aligned.

Fixes: aa712399c1e8 ("mm/gup: speed up check_and_migrate_cma_pages() on huge page")

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/gup.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 24f25b1e9103..16f10d5a9eb6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1556,26 +1556,23 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 					unsigned int gup_flags)
 {
 	unsigned long i;
-	unsigned long step;
 	bool drain_allow = true;
 	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
+	struct page *prev_head, *head;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
 		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 check_again:
-	for (i = 0; i < nr_pages;) {
-
-		struct page *head = compound_head(pages[i]);
-
-		/*
-		 * gup may start from a tail page. Advance step by the left
-		 * part.
-		 */
-		step = compound_nr(head) - (pages[i] - head);
+	prev_head = NULL;
+	for (i = 0; i < nr_pages; i++) {
+		head = compound_head(pages[i]);
+		if (head == prev_head)
+			continue;
+		prev_head = head;
 		/*
 		 * If we get a page from the CMA zone, since we are going to
 		 * be pinning these entries, we might as well move them out
@@ -1599,8 +1596,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 				}
 			}
 		}
-
-		i += step;
 	}
 
 	if (!list_empty(&cma_page_list)) {
-- 
2.25.1

