Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25FB1E565F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 07:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgE1FTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 01:19:31 -0400
Received: from foss.arm.com ([217.140.110.172]:47192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgE1FTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 01:19:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66D0C30E;
        Wed, 27 May 2020 22:19:30 -0700 (PDT)
Received: from nicgas01-03-arm-vm.shanghai.arm.com (nicgas01-03-arm-vm.shanghai.arm.com [10.169.138.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 104E03F52E;
        Wed, 27 May 2020 22:19:27 -0700 (PDT)
From:   Nick Gasson <nick.gasson@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Cc:     Nick Gasson <nick.gasson@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf jit: Fix inaccurate DWARF line table
Date:   Thu, 28 May 2020 13:19:16 +0800
Message-Id: <20200528051916.6722-1-nick.gasson@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an issue where addresses in the DWARF line table are offset by
-0x40 (GEN_ELF_TEXT_OFFSET). This can be seen with `objdump -S` on the
ELF files after perf inject.

Signed-off-by: Nick Gasson <nick.gasson@arm.com>
---
 tools/perf/util/genelf_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
index 30e9f618f6cd..dd40683bd4c0 100644
--- a/tools/perf/util/genelf_debug.c
+++ b/tools/perf/util/genelf_debug.c
@@ -342,7 +342,7 @@ static void emit_lineno_info(struct buffer_ext *be,
 	 */
 
 	/* start state of the state machine we take care of */
-	unsigned long last_vma = code_addr;
+	unsigned long last_vma = 0;
 	char const  *cur_filename = NULL;
 	unsigned long cur_file_idx = 0;
 	int last_line = 1;
@@ -473,7 +473,7 @@ jit_process_debug_info(uint64_t code_addr,
 		ent = debug_entry_next(ent);
 	}
 	add_compilation_unit(di, buffer_ext_size(dl));
-	add_debug_line(dl, debug, nr_debug_entries, 0);
+	add_debug_line(dl, debug, nr_debug_entries, GEN_ELF_TEXT_OFFSET);
 	add_debug_abbrev(da);
 	if (0) buffer_ext_dump(da, "abbrev");
 
-- 
2.26.2

