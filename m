Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E61A4AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgDJTia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 15:38:30 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:28711 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgDJTi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:38:29 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:38:24 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 3CCBFB2C9B;
        Fri, 10 Apr 2020 15:38:24 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 23/36] objtool: mcount: Move nop_mcount()
Date:   Fri, 10 Apr 2020 12:35:46 -0700
Message-ID: <db184a4dfe250c943f44313dc99ffb249f5aa9e7.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nop_mcount() function overwrites mcount calls that should be
ignored with no-ops. This operation varies by architecture and
wordsize so we retain the function pointers used to implement
the fundamental operation while nop_mcount() itself is responsible
for walking the relocations, determining if they should be turned
into no-ops, then calling the arch-specific code. Since none of
these use the recordmcount ELF wrappers anymore we can move it out
of the wrapper.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 47 +++++++++++++++++++++++++++++++++
 tools/objtool/recordmcount.h | 50 ------------------------------------
 2 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 65b7a34f2619..99938d5a5bb1 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -398,6 +398,53 @@ static int find_section_sym_index(unsigned const txtndx,
 	return missing_sym;
 }
 
+/*
+ * Read the relocation table again, but this time its called on sections
+ * that are not going to be traced. The mcount calls here will be converted
+ * into nops.
+ */
+static int nop_mcount(struct section * const rels,
+		      const char *const txtname)
+{
+	struct rela *rela;
+	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
+	unsigned mcountsym = 0;
+	int once = 0;
+
+	list_for_each_entry(rela, &rels->rela_list, list) {
+		int ret = -1;
+
+		if (!mcountsym)
+			mcountsym = get_mcountsym(rela);
+
+		if (mcountsym == GELF_R_INFO(rela->sym->idx, rela->type) && !is_fake_mcount(rela)) {
+			if (make_nop) {
+				ret = make_nop(txts, rela->offset);
+				if (ret < 0)
+					return -1;
+			}
+			if (warn_on_notrace_sect && !once) {
+				printf("Section %s has mcount callers being ignored\n",
+				       txtname);
+				once = 1;
+				/* just warn? */
+				if (!make_nop)
+					return 0;
+			}
+		}
+
+		/*
+		 * If we successfully removed the mcount, mark the relocation
+		 * as a nop (don't do anything with it).
+		 */
+		if (!ret) {
+			rela->type = rel_type_nop;
+			rels->changed = true;
+		}
+	}
+	return 0;
+}
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 4971258a2ab7..4bbdb6c107b8 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -20,7 +20,6 @@
 #undef append_func
 #undef mcount_adjust
 #undef sift_rel_mcount
-#undef nop_mcount
 #undef has_rel_mcount
 #undef tot_relsize
 #undef do_func
@@ -37,7 +36,6 @@
 #ifdef RECORD_MCOUNT_64
 # define append_func		append64
 # define sift_rel_mcount	sift64_rel_mcount
-# define nop_mcount		nop_mcount_64
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
 # define do_func		do64
@@ -53,7 +51,6 @@
 #else
 # define append_func		append32
 # define sift_rel_mcount	sift32_rel_mcount
-# define nop_mcount		nop_mcount_32
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
 # define do_func		do32
@@ -171,53 +168,6 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 	return mlocp;
 }
 
-/*
- * Read the relocation table again, but this time its called on sections
- * that are not going to be traced. The mcount calls here will be converted
- * into nops.
- */
-static int nop_mcount(struct section * const rels,
-		      const char *const txtname)
-{
-	struct rela *rela;
-	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
-	unsigned mcountsym = 0;
-	int once = 0;
-
-	list_for_each_entry(rela, &rels->rela_list, list) {
-		int ret = -1;
-
-		if (!mcountsym)
-			mcountsym = get_mcountsym(rela);
-
-		if (mcountsym == GELF_R_INFO(rela->sym->idx, rela->type) && !is_fake_mcount(rela)) {
-			if (make_nop) {
-				ret = make_nop(txts, rela->offset);
-				if (ret < 0)
-					return -1;
-			}
-			if (warn_on_notrace_sect && !once) {
-				printf("Section %s has mcount callers being ignored\n",
-				       txtname);
-				once = 1;
-				/* just warn? */
-				if (!make_nop)
-					return 0;
-			}
-		}
-
-		/*
-		 * If we successfully removed the mcount, mark the relocation
-		 * as a nop (don't do anything with it).
-		 */
-		if (!ret) {
-			rela->type = rel_type_nop;
-			rels->changed = true;
-		}
-	}
-	return 0;
-}
-
 static char const *has_rel_mcount(const struct section * const rels)
 {
 	const struct section *txts;
-- 
2.20.1

