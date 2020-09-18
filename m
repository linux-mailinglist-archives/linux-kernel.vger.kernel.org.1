Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A4026F795
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIRIBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIRIBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:01:35 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D372100A;
        Fri, 18 Sep 2020 08:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600416095;
        bh=wcXEqefbWl+ElaYYetd1g5zIjxCBnRNwbjRpvB/Dg60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=somj8kd5ro1JdBxJ0QN1BgrtQcHUdbQKMfLmQnV4X09TaSFFt9XZnpwquHOjKzHam
         4TDuZ303vlI7QurkX6cOrZhRDiJ+S19KsVgUT5kM8iDd4pFj2XKtTvLucPxb3kweB2
         ntMOPV3v33QVm0wu5E0r+0PUrseeOO4Xsz4p1ac8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     "Frank Ch . Eigler" <fche@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf probe: Fix to adjust symbol address with correct reloc_sym address
Date:   Fri, 18 Sep 2020 17:01:30 +0900
Message-Id: <160041609047.912668.14314639291419159274.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160041608027.912668.13169810485938551658.stgit@devnote2>
References: <160041608027.912668.13169810485938551658.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf probe uses ref_reloc_sym to adjust symbol offset address
from debuginfo address or ref_reloc_sym based address, but
that is misused the reloc_sym->addr and reloc_sym->unrelocated_addr.
If map is not relocated (map->reloc == 0), we can use reloc_sym->addr
as unrelocated address instead of reloc_sym->unrelocated_addr.

This usually may not happen. If we have a non-stripped elf
binary, we will use it for map and debuginfo, if not, we use only
kallsyms without debuginfo. Thus, the map is always relocated (elf
and dwarf binary) or not relocated (kallsyms).

However, if we will allow the combination of debuginfo and kallsyms
based map (like using debuginfod), we have to check the map->reloc
and choose the collect address of reloc_sym.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 99d36ac77c08..17831f186ab5 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -129,9 +129,10 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 	struct map *map;
 
 	/* ref_reloc_sym is just a label. Need a special fix*/
-	reloc_sym = kernel_get_ref_reloc_sym(NULL);
+	reloc_sym = kernel_get_ref_reloc_sym(&map);
 	if (reloc_sym && strcmp(name, reloc_sym->name) == 0)
-		*addr = (reloc) ? reloc_sym->addr : reloc_sym->unrelocated_addr;
+		*addr = (!map->reloc || reloc) ? reloc_sym->addr :
+			reloc_sym->unrelocated_addr;
 	else {
 		sym = machine__find_kernel_symbol_by_name(host_machine, name, &map);
 		if (!sym)
@@ -795,7 +796,8 @@ post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
 			free(tevs[i].point.symbol);
 		tevs[i].point.symbol = tmp;
 		tevs[i].point.offset = tevs[i].point.address -
-				       reloc_sym->unrelocated_addr;
+			(map->reloc ? reloc_sym->unrelocated_addr :
+				      reloc_sym->addr);
 	}
 	return skipped;
 }

