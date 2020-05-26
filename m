Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6171A4ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 21:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgDJTla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 15:41:30 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36243 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726715AbgDJTl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:41:27 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:39:10 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 118DC40BC0;
        Fri, 10 Apr 2020 12:39:15 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 31/36] objtool: mcount: Pre-allocate new ELF sections
Date:   Fri, 10 Apr 2020 12:35:54 -0700
Message-ID: <d1f8a580ee30d85ace0ac2dcb1938302aaf91c3c.1586468801.git.mhelsley@vmware.com>
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

Rather than allocating the ELF sections after collecting the
mcount locations and building the relocation entries, create
the empty sections beforehand. This has the benefit of
removing the memcpy() and just using the resulting buffers
directly.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 122 +++++++++++++++--------------------
 1 file changed, 52 insertions(+), 70 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index b4d3c55f2c9c..cee5bc91d666 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -17,7 +17,6 @@
  * This conversion to macros was done by:
  * Copyright 2010 Steven Rostedt <srostedt@redhat.com>, Red Hat Inc.
  */
-#undef append_func
 #undef sift_rel_mcount
 #undef do_func
 #undef Elf_Shdr
@@ -31,7 +30,6 @@
 #undef _size
 
 #ifdef RECORD_MCOUNT_64
-# define append_func		append64
 # define sift_rel_mcount	sift64_rel_mcount
 # define do_func		do64
 # define Elf_Rel		Elf64_Rel
@@ -43,7 +41,6 @@
 # define _w			w8
 # define _size			8
 #else
-# define append_func		append32
 # define sift_rel_mcount	sift32_rel_mcount
 # define do_func		do32
 # define Elf_Rel		Elf32_Rel
@@ -62,60 +59,6 @@ static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
 }
 static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
 
-/* Append the new  __mcount_loc and its relocations. */
-static int append_func(uint_t const *const mloc0,
-			uint_t const *const mlocp,
-			Elf_Rel const *const mrel0,
-			Elf_Rel const *const mrelp,
-			unsigned int const loc_size,
-			unsigned int const rel_entsize,
-			unsigned int const symsec_sh_link)
-{
-	/* Begin constructing output file */
-	struct section *sec;
-	char const *mc_name = (sizeof(Elf_Rela) == rel_entsize)
-		? ".rela__mcount_loc"
-		:  ".rel__mcount_loc";
-	unsigned const old_shnum = lf->ehdr.e_shnum;
-
-	/* add section: __mcount_loc */
-	sec = elf_create_section(lf, mc_name + (sizeof(Elf_Rela) == rel_entsize) + strlen(".rel"), loc_size, mlocp - mloc0);
-	if (!sec)
-		return -1;
-
-	// created sec->sh.sh_size = (void *)mlocp - (void *)mloc0;
-	sec->sh.sh_link = 0;/* TODO objtool uses this? */
-	sec->sh.sh_info = 0;/* TODO objtool uses this? */
-	sec->sh.sh_addralign = loc_size;
-	// created sec->sh.sh_entsize = _size;
-
-	// assert sec->data->d_size == (void *)mlocp - (void *)mloc0
-	memcpy(sec->data->d_buf, mloc0, sec->data->d_size);
-	/* HACK link in Pre-assembled buffer ?
-	sec->data->d_buf = mloc0;
-	sec->data->d_size = sec->sh.sh_size;*/
-
-	/* add section .rel[a]__mcount_loc */
-	sec = elf_create_section(lf, mc_name, rel_entsize, mrelp - mrel0);
-	if (!sec)
-		return -1;
-	sec->sh.sh_type = (sizeof(Elf_Rela) == rel_entsize)
-				? SHT_RELA
-				: SHT_REL;
-	sec->sh.sh_flags = 0;
-	sec->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
-	sec->sh.sh_info = old_shnum;
-	sec->sh.sh_addralign = loc_size;
-
-	// assert sec->data->d_size == (void *)mrelp - (void *)mrel0
-	memcpy(sec->data->d_buf, mrel0, sec->data->d_size);
-	/* HACK link in Pre-assembled buffer ?
-	sec->data->d_buf = mrel0;
-	sec->data->d_size = sec->sh.sh_size;*/
-
-	return elf_write(lf);
-}
-
 /*
  * Look at the relocations in order to find the calls to mcount.
  * Accumulate the section offsets that are found, and their relocation info,
@@ -172,11 +115,13 @@ static int do_func(unsigned const reltype)
 	uint_t *      mlocp;
 
 	unsigned int rel_entsize = 0;
-	unsigned symsec_sh_link = 0;
 
-	struct section *sec;
+	struct section *sec, *mlocs, *mrels;
+	unsigned int const old_shnum = lf->ehdr.e_shnum;
 
-	int result = 0;
+	int result = -1;
+	char const *mc_name;
+	bool is_rela;
 
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
@@ -184,6 +129,7 @@ static int do_func(unsigned const reltype)
 	totrelsz = tot_relsize(&rel_entsize);
 	if (totrelsz == 0)
 		return 0;
+
 	mrel0 = malloc(totrelsz);
 	mrelp = mrel0;
 	if (!mrel0)
@@ -197,6 +143,32 @@ static int do_func(unsigned const reltype)
 		return -1;
 	}
 
+	is_rela = (sizeof(Elf_Rela) == rel_entsize);
+	mc_name = is_rela
+			? ".rela__mcount_loc"
+			:  ".rel__mcount_loc";
+
+	/* add section: __mcount_loc */
+	mlocs = elf_create_section(lf, mc_name + (is_rela ? 1 : 0) + strlen(".rel"), _size, 0);
+	if (!mlocs)
+		goto out;
+
+	mlocs->sh.sh_link = 0;
+	mlocs->sh.sh_info = 0;
+	mlocs->sh.sh_addralign = _size;
+
+	/* add section .rel[a]__mcount_loc */
+	mrels = elf_create_section(lf, mc_name, rel_entsize, 0);
+	if (!mrels)
+		goto out;
+	mrels->sh.sh_type = is_rela
+				? SHT_RELA
+				: SHT_REL;
+	mrels->sh.sh_flags = 0;
+	mrels->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
+	mrels->sh.sh_info = old_shnum;
+	mrels->sh.sh_addralign = _size;
+
 	list_for_each_entry(sec, &lf->sections, list) {
 		char const *txtname;
 
@@ -205,10 +177,8 @@ static int do_func(unsigned const reltype)
 			unsigned long recval = 0;
 			unsigned int recsym;
 
-			symsec_sh_link = sec->sh.sh_link;
-			result = find_section_sym_index(sec->sh.sh_info,
-						txtname, &recval, &recsym);
-			if (result)
+			if (find_section_sym_index(sec->sh.sh_info,
+						txtname, &recval, &recsym))
 				goto out;
 
 			mlocp = sift_rel_mcount(mlocp,
@@ -219,15 +189,27 @@ static int do_func(unsigned const reltype)
 			 * This section is ignored by ftrace, but still
 			 * has mcount calls. Convert them to nops now.
 			 */
-			if (nop_mcount(sec, txtname) < 0) {
-				result = -1;
+			if (nop_mcount(sec, txtname) < 0)
 				goto out;
-			}
 		}
 	}
-	if (!result && mloc0 != mlocp)
-		result = append_func(mloc0, mlocp, mrel0, mrelp,
-				     _size, rel_entsize, symsec_sh_link);
+
+	if (mloc0 != mlocp) {
+		/* Update the section sizes */
+		mlocs->sh.sh_size = (void *)mlocp - (void *)mloc0;
+		mlocs->len = mlocs->sh.sh_size;
+		mlocs->data->d_size = mlocs->len;
+		mlocs->data->d_buf = mloc0;
+
+		mrels->sh.sh_size = (void *)mrelp - (void *)mrel0;
+		mrels->len = mrels->sh.sh_size;
+		mrels->data->d_size = mrels->len;
+		mrels->data->d_buf = mrel0;
+
+		/* overwrite the ELF file */
+		result = elf_write(lf);
+	} else
+		result = 0;
 out:
 	free(mrel0);
 	free(mloc0);
-- 
2.20.1

