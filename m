Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0F20446B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 01:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgFVX1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 19:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgFVX1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:27:09 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03BC720720;
        Mon, 22 Jun 2020 23:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592868429;
        bh=VjnZP0UJkWtMoh9mmcu3OkA3Gx/ME5wU7WbuTuzTSAc=;
        h=Date:From:To:Cc:Subject:From;
        b=hgFD1DX6czqgIEETk2kVqM+1UIrM+d7Mrklck6xgMzPEBxJXgiKHMuQNMKxk1Gg9M
         vvNdhwCabDH4RWBK4ixED2gLoynkSXtVYF42Qyi8rA2sXENDPyYiyMMNtvIP9fRYVA
         T5VtVluO7ZzAcLS7jdvFIftPWWHXVaoGPZm200vU=
Date:   Mon, 22 Jun 2020 18:32:39 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] libperf: Use struct_size() helper
Message-ID: <20200622233239.GA12892@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes. Also, remove unnecessary
variable _size_.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 tools/lib/perf/threadmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index e92c368b0a6c..86d9dabd7fe5 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <asm/bug.h>
 #include <stdio.h>
+#include <linux/overflow.h>
 
 static void perf_thread_map__reset(struct perf_thread_map *map, int start, int nr)
 {
@@ -17,10 +18,9 @@ static void perf_thread_map__reset(struct perf_thread_map *map, int start, int n
 
 struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr)
 {
-	size_t size = sizeof(*map) + sizeof(map->map[0]) * nr;
 	int start = map ? map->nr : 0;
 
-	map = realloc(map, size);
+	map = realloc(map, struct_size(map, map, nr));
 	/*
 	 * We only realloc to add more items, let's reset new items.
 	 */
-- 
2.27.0

