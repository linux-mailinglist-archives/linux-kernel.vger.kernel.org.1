Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731C31EC334
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 21:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgFBTwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 15:52:43 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728272AbgFBTu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:50:56 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:50:50 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 466A740BED;
        Tue,  2 Jun 2020 12:50:51 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 06/32] objtool: mcount: Remove unused fname parameter
Date:   Tue, 2 Jun 2020 12:49:59 -0700
Message-ID: <0199781e29bb53e8bebaee243df02bfdae617f71.1591125127.git.mhelsley@vmware.com>
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

The name of the object file being processed is unused in
the wrapper's leaf functions so we no longer need to pass
it as a parameter.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c |  4 ++--
 tools/objtool/recordmcount.h | 19 ++++++++-----------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index f585bf7f45f5..9941683b3f60 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -586,7 +586,7 @@ static int do_file(char const *const fname)
 			reltype = R_MIPS_32;
 			is_fake_mcount32 = MIPS32_is_fake_mcount;
 		}
-		if (do32(ehdr, fname, reltype) < 0)
+		if (do32(ehdr, reltype) < 0)
 			goto out;
 		break;
 	case ELFCLASS64: {
@@ -607,7 +607,7 @@ static int do_file(char const *const fname)
 			Elf64_r_info = MIPS64_r_info;
 			is_fake_mcount64 = MIPS64_is_fake_mcount;
 		}
-		if (do64(ghdr, fname, reltype) < 0)
+		if (do64(ghdr, reltype) < 0)
 			goto out;
 		break;
 	}
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 3c4807dca3d0..3250a461895d 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -466,8 +466,7 @@ static int find_secsym_ndx(unsigned const txtndx,
 /* Evade ISO C restriction: no declaration after statement in has_rel_mcount. */
 static char const * __has_rel_mcount(GElf_Shdr const *const relhdr, /* reltype */
 				     Elf_Shdr const *const shdr0,
-				     char const *const shstrtab,
-				     char const *const fname)
+				     char const *const shstrtab)
 {
 	/* .sh_info depends on .sh_type == SHT_REL[,A] */
 	Elf_Shdr const *const txthdr = &shdr0[relhdr->sh_info];
@@ -481,25 +480,23 @@ static char const * __has_rel_mcount(GElf_Shdr const *const relhdr, /* reltype *
 
 static char const *has_rel_mcount(GElf_Shdr const *const relhdr,
 				  Elf_Shdr const *const shdr0,
-				  char const *const shstrtab,
-				  char const *const fname)
+				  char const *const shstrtab)
 {
 	if (relhdr->sh_type != SHT_REL && relhdr->sh_type != SHT_RELA)
 		return NULL;
-	return __has_rel_mcount(relhdr, shdr0, shstrtab, fname);
+	return __has_rel_mcount(relhdr, shdr0, shstrtab);
 }
 
 
 static unsigned tot_relsize(Elf_Shdr const *const shdr0,
-			    const char *const shstrtab,
-			    const char *const fname)
+			    const char *const shstrtab)
 {
 	struct section *sec;
 	unsigned totrelsz = 0;
 	char const *txtname;
 
 	list_for_each_entry(sec, &lf->sections, list) {
-		txtname = has_rel_mcount(&sec->sh, shdr0, shstrtab, fname);
+		txtname = has_rel_mcount(&sec->sh, shdr0, shstrtab);
 		if (txtname && is_mcounted_section_name(txtname))
 			totrelsz += sec->sh.sh_size;
 	}
@@ -508,7 +505,7 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 
 
 /* Overall supervision for Elf32 ET_REL file. */
-static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
+static int do_func(Elf_Ehdr *const ehdr,
 		   unsigned const reltype)
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
@@ -538,7 +535,7 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
 
-	totrelsz = tot_relsize(shdr0, shstrtab, fname);
+	totrelsz = tot_relsize(shdr0, shstrtab);
 	if (totrelsz == 0)
 		return 0;
 	mrel0 = umalloc(totrelsz);
@@ -559,7 +556,7 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 
 		relhdr = &sec->sh;
 		txtname = has_rel_mcount(relhdr, shdr0,
-			shstrtab, fname);
+			shstrtab);
 		if (txtname && is_mcounted_section_name(txtname)) {
 			unsigned int recsym;
 			uint_t recval = 0;
-- 
2.20.1

