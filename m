Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1491EC319
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 21:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgFBTvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 15:51:22 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728377AbgFBTvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:04 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:51:00 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6707740BF4;
        Tue,  2 Jun 2020 12:51:01 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 19/32] objtool: mcount: Move has_rel_mcount() and tot_relsize()
Date:   Tue, 2 Jun 2020 12:50:12 -0700
Message-ID: <08c542035a8ad36e56c7e791e3632e858cfd1897.1591125127.git.mhelsley@vmware.com>
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

The has_rel_mcount() and tot_relsize() helpers are no longer
dependent on the ELF wrapper so we can move them.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 25 +++++++++++++++++++++++++
 tools/objtool/recordmcount.h | 33 ---------------------------------
 2 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 88998a505859..248e49033538 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -445,6 +445,31 @@ static int nop_mcount(struct section * const rels,
 	return 0;
 }
 
+static char const *has_rel_mcount(const struct section * const rels)
+{
+	const struct section *txts;
+	if (rels->sh.sh_type != SHT_REL && rels->sh.sh_type != SHT_RELA)
+		return NULL;
+	txts = find_section_by_index(lf, rels->sh.sh_info);
+	if ((txts->sh.sh_type != SHT_PROGBITS) ||
+	    !(txts->sh.sh_flags & SHF_EXECINSTR))
+		return NULL;
+	return txts->name;
+}
+
+static unsigned tot_relsize(void)
+{
+	const struct section *sec;
+	unsigned totrelsz = 0;
+	char const *txtname;
+
+	list_for_each_entry(sec, &lf->sections, list) {
+		txtname = has_rel_mcount(sec);
+		if (txtname && is_mcounted_section_name(txtname))
+			totrelsz += sec->sh.sh_size;
+	}
+	return totrelsz;
+}
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index e033b600bd61..f8d3e81c0129 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -20,8 +20,6 @@
 #undef append_func
 #undef mcount_adjust
 #undef sift_rel_mcount
-#undef has_rel_mcount
-#undef tot_relsize
 #undef do_func
 #undef Elf_Shdr
 #undef Elf_Rel
@@ -36,8 +34,6 @@
 #ifdef RECORD_MCOUNT_64
 # define append_func		append64
 # define sift_rel_mcount	sift64_rel_mcount
-# define has_rel_mcount		has64_rel_mcount
-# define tot_relsize		tot64_relsize
 # define do_func		do64
 # define mcount_adjust		mcount_adjust_64
 # define Elf_Rel		Elf64_Rel
@@ -51,8 +47,6 @@
 #else
 # define append_func		append32
 # define sift_rel_mcount	sift32_rel_mcount
-# define has_rel_mcount		has32_rel_mcount
-# define tot_relsize		tot32_relsize
 # define do_func		do32
 # define mcount_adjust		mcount_adjust_32
 # define Elf_Rel		Elf32_Rel
@@ -168,33 +162,6 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 	return mlocp;
 }
 
-static char const *has_rel_mcount(const struct section * const rels)
-{
-	const struct section *txts;
-	if (rels->sh.sh_type != SHT_REL && rels->sh.sh_type != SHT_RELA)
-		return NULL;
-	txts = find_section_by_index(lf, rels->sh.sh_info);
-	if ((txts->sh.sh_type != SHT_PROGBITS) ||
-	    !(txts->sh.sh_flags & SHF_EXECINSTR))
-		return NULL;
-	return txts->name;
-}
-
-
-static unsigned tot_relsize(void)
-{
-	const struct section *sec;
-	unsigned totrelsz = 0;
-	char const *txtname;
-
-	list_for_each_entry(sec, &lf->sections, list) {
-		txtname = has_rel_mcount(sec);
-		if (txtname && is_mcounted_section_name(txtname))
-			totrelsz += sec->sh.sh_size;
-	}
-	return totrelsz;
-}
-
 
 /* Overall supervision for Elf32 ET_REL file. */
 static int do_func(unsigned const reltype)
-- 
2.20.1

