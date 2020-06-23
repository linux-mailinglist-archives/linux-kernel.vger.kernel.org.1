Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1C204573
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgFWAcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbgFWAcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:32:33 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1F92053B;
        Tue, 23 Jun 2020 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872353;
        bh=Upgc+1fy6WFH3XNcBPCvqoAbvhOSY1dzH3U/SYaFv04=;
        h=Date:From:To:Cc:Subject:From;
        b=1n1lxV3OcLThhL8WtBPjr/PToUwi5lyitl08vDuv+e1LoNi9J0195yAj5Gf5ejRYd
         NecAdT8RxzHXY+jo9uWPg1chv5+TeIWmDkHrxE0LXCmlqRfM3vDs05oq275kVf1+Hv
         QXmD9lMJ394RNnlLyk/VjqAHpAwETqlcKPGHnzj0=
Date:   Mon, 22 Jun 2020 19:38:02 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] perf cputopo: Use struct_size() helper
Message-ID: <20200623003802.GA21572@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 tools/perf/util/cputopo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 1b52402a8923..1d1b26e39f12 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -7,6 +7,7 @@
 #include <api/fs/fs.h>
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
+#include <linux/overflow.h>
 
 #include "cputopo.h"
 #include "cpumap.h"
@@ -321,7 +322,7 @@ struct numa_topology *numa_topology__new(void)
 
 	nr = (u32) node_map->nr;
 
-	tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0])*nr);
+	tp = zalloc(struct_size(tp, nodes, nr));
 	if (!tp)
 		goto out;
 
-- 
2.27.0

