Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1842C5FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 06:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgK0Fsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgK0Fsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:48:50 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F336221D93;
        Fri, 27 Nov 2020 05:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606456130;
        bh=jJfCMpAWjKfNJxwhpKBSwa2Eq3kgIxujrcsLjosChnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Urz6qzn3klefK/ls/u3u3D5wNrIDyEZARnR50pa92wmkzRW+C6GrwsKJDhuAtC0uY
         hU5NivYZgvmJxoX4J24TvxqiXOR24iuMacDwzfcQK0O+117GFv0XyoHlOPHy91+tq1
         jdVP/ztV0M3RDoZQoSwVQDTvB/cTxQbMsUS/X9Xc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/2] perf-probe: Fix to die_entrypc() returns error correctly
Date:   Fri, 27 Nov 2020 14:48:46 +0900
Message-Id: <160645612634.2824037.5284932731175079426.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126172849.GE53384@kernel.org>
References: <20201126172849.GE53384@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix die_entrypc() to return error correctly if the DIE has no
DW_AT_ranges attribute. Since dwarf_ranges() will treat the case
as an empty ranges and return 0, we have to check it by ourselves.

Fixes: 91e2f539eeda ("perf probe: Fix to show function entry line as probe-able")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index aa898014ad12..03c1a39c312a 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -373,6 +373,7 @@ bool die_is_func_def(Dwarf_Die *dw_die)
 int die_entrypc(Dwarf_Die *dw_die, Dwarf_Addr *addr)
 {
 	Dwarf_Addr base, end;
+	Dwarf_Attribute attr;
 
 	if (!addr)
 		return -EINVAL;
@@ -380,6 +381,13 @@ int die_entrypc(Dwarf_Die *dw_die, Dwarf_Addr *addr)
 	if (dwarf_entrypc(dw_die, addr) == 0)
 		return 0;
 
+	/*
+	 *  Since the dwarf_ranges() will return 0 if there is no
+	 * DW_AT_ranges attribute, we should check it first.
+	 */
+	if (!dwarf_attr(dw_die, DW_AT_ranges, &attr))
+		return -ENOENT;
+
 	return dwarf_ranges(dw_die, 0, &base, addr, &end) < 0 ? -ENOENT : 0;
 }
 

