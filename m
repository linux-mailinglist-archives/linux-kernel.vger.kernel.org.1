Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B095B2EB78B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAFBSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbhAFBSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:18:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E007230F9;
        Wed,  6 Jan 2021 01:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609895872;
        bh=GMkUWi1HSMx6tCW3EpjcA1+Pgb7uUPIJLE5afoazVfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6NMudKKD76xBb8X/tG4J62mW7lW6/cnBXETpELbjaddU2tbIooynS/8EhUVUognJ
         ETTH7J1c8lmqUJqnPOiFbFzcls7G4axaDBMCjOxFNr1HX03Qn4sy+XFExMWnxCEGdp
         veRcTc8vDr+sXuqZxo2eU/nVABRVzMINnycM94xAEkV+hK65sf/bN730Hpt7SjH1xo
         uH3IIHTyawZ2W64PVsSNbTY95DqYYVIS0UmR1NZrwIoCrACxslxDK3ZUkg/qtR59fF
         NQ26zJHgwEiffejk48QZVC5q49fYze+Txg+OhDUersc5yPtgkcckTc+L4Lz8irZ6sQ
         Ch5ggT7TMu7LA==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ming.lei@redhat.com, axboe@kernel.dk, kernel-team@fb.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH mm,percpu_ref,rcu 4/6] mm: Make mem_obj_dump() vmalloc() dumps include start and length
Date:   Tue,  5 Jan 2021 17:17:48 -0800
Message-Id: <20210106011750.13709-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106011603.GA13180@paulmck-ThinkPad-P72>
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the starting address and number of pages to the vmalloc()
information dumped by way of vmalloc_dump_obj().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/vmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c274ea4..e3229ff 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3456,7 +3456,8 @@ bool vmalloc_dump_obj(void *object)
 	vm = find_vm_area(objp);
 	if (!vm)
 		return false;
-	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
+	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
+		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
 	return true;
 }
 
-- 
2.9.5

