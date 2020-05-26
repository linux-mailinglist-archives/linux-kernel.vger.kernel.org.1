Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BEC1A4A92
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 21:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgDJThD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 15:37:03 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:17475 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbgDJThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:37:02 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:36:57 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 36CAB40BBE;
        Fri, 10 Apr 2020 12:37:01 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 09/36] objtool: recordmcount: Search for __mcount_loc before walking the sections
Date:   Fri, 10 Apr 2020 12:35:32 -0700
Message-ID: <88f2bfd4259b2e951cb9a6a96d2534df2a9be9fa.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

recordmcount iterates over the sections in the order they're
listed in the ELF file and checks whether the section name
indicates it's of interest. Objtool's elf code works differently
 -- it scans the elf file and builds up data structures
representing the headers, sections, etc. and then supplies
functions to search these structures. Both walk the elf file
in order, however objtool uses more memory to enable faster
searches it needs for other tools such as the reliable backtrace
support offered by the ORC unwinder.

Rather than walk the section table a second time in the recordmcount
code, we use objtool's elf code to search for the section
recordmcount is interested in. This also simplifies flow and means
we can easily check for already-processed object files before we
do any of the more complex things recordmcount does.

This also allows us to remove the already_has_rel_mcount string
pointer trick.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c |  4 ----
 tools/objtool/recordmcount.h | 17 +++--------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 69da5339575f..46a275a393a8 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -208,8 +208,6 @@ static void *mmap_file(char const *fname)
 	} else
 		mmap_failed = 0;
 out:
-	elf_close(lf);
-	lf = NULL;
 	fd_map = -1;
 
 	file_end = file_map + sb.st_size;
@@ -424,8 +422,6 @@ static int is_mcounted_section_name(char const *const txtname)
 		strcmp(".cpuidle.text", txtname) == 0;
 }
 
-static char const *already_has_rel_mcount = "success"; /* our work here is done! */
-
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 74eab03e31d4..1a848b8104c8 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -473,11 +473,6 @@ static char const * __has_rel_mcount(Elf_Shdr const *const relhdr, /* reltype */
 	Elf_Shdr const *const txthdr = &shdr0[w(relhdr->sh_info)];
 	char const *const txtname = &shstrtab[w(txthdr->sh_name)];
 
-	if (strcmp("__mcount_loc", txtname) == 0) {
-		fprintf(stderr, "warning: __mcount_loc already exists: %s\n",
-			fname);
-		return already_has_rel_mcount;
-	}
 	if (w(txthdr->sh_type) != SHT_PROGBITS ||
 	    !(_w(txthdr->sh_flags) & SHF_EXECINSTR))
 		return NULL;
@@ -506,10 +501,6 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 
 	for (; nhdr; --nhdr, ++shdrp) {
 		txtname = has_rel_mcount(shdrp, shdr0, shstrtab, fname);
-		if (txtname == already_has_rel_mcount) {
-			totrelsz = 0;
-			break;
-		}
 		if (txtname && is_mcounted_section_name(txtname))
 			totrelsz += _w(shdrp->sh_size);
 	}
@@ -545,6 +536,9 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 
 	int result = 0;
 
+	if (find_section_by_name(lf, "__mcount_loc") != NULL)
+		return 0;
+
 	totrelsz = tot_relsize(shdr0, nhdr, shstrtab, fname);
 	if (totrelsz == 0)
 		return 0;
@@ -564,11 +558,6 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
 		char const *const txtname = has_rel_mcount(relhdr, shdr0,
 			shstrtab, fname);
-		if (txtname == already_has_rel_mcount) {
-			result = 0;
-			file_updated = 0;
-			goto out; /* Nothing to be done; don't append! */
-		}
 		if (txtname && is_mcounted_section_name(txtname)) {
 			unsigned int recsym;
 			uint_t recval = 0;
-- 
2.20.1

