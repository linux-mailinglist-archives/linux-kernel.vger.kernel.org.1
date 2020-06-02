Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635D51EC328
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgFBTwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 15:52:12 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728374AbgFBTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:03 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:51:00 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id A143540BEE;
        Tue,  2 Jun 2020 12:51:00 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 18/32] objtool: mcount: Move nop_mcount()
Date:   Tue, 2 Jun 2020 12:50:11 -0700
Message-ID: <7109ceb239a88c2901eeb7f52c29f69cdb413cd3.1591125127.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591125127.git.mhelsley@vmware.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
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
index 89762908290e..88998a505859 100644
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
+	struct reloc *reloc;
+	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
+	unsigned mcountsym = 0;
+	int once = 0;
+
+	list_for_each_entry(reloc, &rels->reloc_list, list) {
+		int ret = -1;
+
+		if (!mcountsym)
+			mcountsym = get_mcountsym(reloc);
+
+		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
+			if (make_nop) {
+				ret = make_nop(txts, reloc->offset);
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
+			reloc->type = rel_type_nop;
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
index 6754bde0bacc..e033b600bd61 100644
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
-	struct reloc *reloc;
-	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
-	unsigned mcountsym = 0;
-	int once = 0;
-
-	list_for_each_entry(reloc, &rels->reloc_list, list) {
-		int ret = -1;
-
-		if (!mcountsym)
-			mcountsym = get_mcountsym(reloc);
-
-		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
-			if (make_nop) {
-				ret = make_nop(txts, reloc->offset);
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
-			reloc->type = rel_type_nop;
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

