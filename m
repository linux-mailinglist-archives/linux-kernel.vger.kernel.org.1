Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0027C1AC04A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 13:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506734AbgDPLxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 07:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506709AbgDPLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BF5C03C1A7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vZGTNFI1qsH9Qyn4to0UBz3pVYWZFo5oK0ajBpNGby8=; b=SYcO6hCRpN60137RNzIYZzd3Yz
        LwVh5/8GwrvIg4W/IqkKSgoVLtaflgHzXpGKAUbT9181HRKiB3zzgipEgn/giThD/GhLpv00DLcaU
        FGlHzZtDwcxqeshgNZRPGsOdIqJX7kOjG9QGP/HUr2uGwTeh34ehj+QDYm9i7dRlsZvZAngqTi2It
        QTso4j430t3jGQdcZNdhrS8qdWHrRzUNo2vxRU5LR8V1Drj9Gn5jJUXE6klpl0y8MbXBT+nLU79cc
        ospaVwMGpm8pwv8lyO2bt8bBZK1sxKt0io7ixkshbHbwvx6hp1EIYPujG09YR31pMPnWbnlnbwdDD
        MOrypUbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34F-0004sH-Ql; Thu, 16 Apr 2020 11:52:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63BDB30786C;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 48E682B0DE4CC; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115119.167588731@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 11/17] objtool: Optimize !vmlinux.o again
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing kbuild tests to see if the objtool changes affected those I
found that there was a measurable regression:

          pre		  post

  real    1m13.594        1m16.488s
  user    34m58.246s      35m23.947s
  sys     4m0.393s        4m27.312s

Perf showed that for small files the increased hash-table sizes were a
measurable difference. Since we already have -l "vmlinux" to
distinguish between the modes, make it also use a smaller portion of
the hash-tables.

This flips it into a small win:

  real    1m14.143s
  user    34m49.292s
  sys     3m44.746s

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c     |   62 +++++++++++++++++++++++++++++++++---------------
 tools/objtool/elf.h     |   13 ++++++----
 tools/objtool/orc_gen.c |    3 --
 3 files changed, 52 insertions(+), 26 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -27,6 +27,22 @@ static inline u32 str_hash(const char *s
 	return jhash(str, strlen(str), 0);
 }
 
+static inline int elf_hash_bits(void)
+{
+	return vmlinux ? ELF_HASH_BITS : 16;
+}
+
+#define elf_hash_add(hashtable, node, key) \
+	hlist_add_head(node, &hashtable[hash_min(key, elf_hash_bits())])
+
+static void elf_hash_init(struct hlist_head *table)
+{
+	__hash_init(table, 1U << elf_hash_bits());
+}
+
+#define elf_hash_for_each_possible(name, obj, member, key)			\
+	hlist_for_each_entry(obj, &name[hash_min(key, elf_hash_bits())], member)
+
 static void rb_add(struct rb_root *tree, struct rb_node *node,
 		   int (*cmp)(struct rb_node *, const struct rb_node *))
 {
@@ -115,7 +131,7 @@ struct section *find_section_by_name(str
 {
 	struct section *sec;
 
-	hash_for_each_possible(elf->section_name_hash, sec, name_hash, str_hash(name))
+	elf_hash_for_each_possible(elf->section_name_hash, sec, name_hash, str_hash(name))
 		if (!strcmp(sec->name, name))
 			return sec;
 
@@ -127,7 +143,7 @@ static struct section *find_section_by_i
 {
 	struct section *sec;
 
-	hash_for_each_possible(elf->section_hash, sec, hash, idx)
+	elf_hash_for_each_possible(elf->section_hash, sec, hash, idx)
 		if (sec->idx == idx)
 			return sec;
 
@@ -138,7 +154,7 @@ static struct symbol *find_symbol_by_ind
 {
 	struct symbol *sym;
 
-	hash_for_each_possible(elf->symbol_hash, sym, hash, idx)
+	elf_hash_for_each_possible(elf->symbol_hash, sym, hash, idx)
 		if (sym->idx == idx)
 			return sym;
 
@@ -205,7 +221,7 @@ struct symbol *find_symbol_by_name(struc
 {
 	struct symbol *sym;
 
-	hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
+	elf_hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
 		if (!strcmp(sym->name, name))
 			return sym;
 
@@ -224,7 +240,7 @@ struct rela *find_rela_by_dest_range(str
 	sec = sec->rela;
 
 	for_offset_range(o, offset, offset + len) {
-		hash_for_each_possible(elf->rela_hash, rela, hash,
+		elf_hash_for_each_possible(elf->rela_hash, rela, hash,
 				       sec_offset_hash(sec, o)) {
 			if (rela->sec != sec)
 				continue;
@@ -309,8 +325,8 @@ static int read_sections(struct elf *elf
 		sec->len = sec->sh.sh_size;
 
 		list_add_tail(&sec->list, &elf->sections);
-		hash_add(elf->section_hash, &sec->hash, sec->idx);
-		hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
+		elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 	}
 
 	if (stats)
@@ -394,8 +410,8 @@ static int read_symbols(struct elf *elf)
 		else
 			entry = &sym->sec->symbol_list;
 		list_add(&sym->list, entry);
-		hash_add(elf->symbol_hash, &sym->hash, sym->idx);
-		hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
+		elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
+		elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
 	}
 
 	if (stats)
@@ -456,6 +472,14 @@ static int read_symbols(struct elf *elf)
 	return -1;
 }
 
+void elf_add_rela(struct elf *elf, struct rela *rela)
+{
+	struct section *sec = rela->sec;
+
+	list_add_tail(&rela->list, &sec->rela_list);
+	elf_hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+}
+
 static int read_relas(struct elf *elf)
 {
 	struct section *sec;
@@ -503,8 +527,7 @@ static int read_relas(struct elf *elf)
 				return -1;
 			}
 
-			list_add_tail(&rela->list, &sec->rela_list);
-			hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+			elf_add_rela(elf, rela);
 			nr_rela++;
 		}
 		max_rela = max(max_rela, nr_rela);
@@ -531,15 +554,16 @@ struct elf *elf_read(const char *name, i
 		perror("malloc");
 		return NULL;
 	}
-	memset(elf, 0, sizeof(*elf));
+	memset(elf, 0, offsetof(struct elf, sections));
 
-	hash_init(elf->symbol_hash);
-	hash_init(elf->symbol_name_hash);
-	hash_init(elf->section_hash);
-	hash_init(elf->section_name_hash);
-	hash_init(elf->rela_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
+	elf_hash_init(elf->symbol_hash);
+	elf_hash_init(elf->symbol_name_hash);
+	elf_hash_init(elf->section_hash);
+	elf_hash_init(elf->section_name_hash);
+	elf_hash_init(elf->rela_hash);
+
 	elf->fd = open(name, flags);
 	if (elf->fd == -1) {
 		fprintf(stderr, "objtool: Can't open '%s': %s\n",
@@ -676,8 +700,8 @@ struct section *elf_create_section(struc
 	shstrtab->changed = true;
 
 	list_add_tail(&sec->list, &elf->sections);
-	hash_add(elf->section_hash, &sec->hash, sec->idx);
-	hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
+	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 
 	return sec;
 }
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -70,17 +70,19 @@ struct rela {
 	bool jump_table_start;
 };
 
+#define ELF_HASH_BITS	20
+
 struct elf {
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	int fd;
 	char *name;
 	struct list_head sections;
-	DECLARE_HASHTABLE(symbol_hash, 20);
-	DECLARE_HASHTABLE(symbol_name_hash, 20);
-	DECLARE_HASHTABLE(section_hash, 16);
-	DECLARE_HASHTABLE(section_name_hash, 16);
-	DECLARE_HASHTABLE(rela_hash, 20);
+	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(symbol_name_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(section_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(section_name_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(rela_hash, ELF_HASH_BITS);
 };
 
 #define OFFSET_STRIDE_BITS	4
@@ -127,6 +129,7 @@ struct section *elf_create_rela_section(
 int elf_rebuild_rela_section(struct section *sec);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
+void elf_add_rela(struct elf *elf, struct rela *rela);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -111,8 +111,7 @@ static int create_orc_entry(struct elf *
 	rela->offset = idx * sizeof(int);
 	rela->sec = ip_relasec;
 
-	list_add_tail(&rela->list, &ip_relasec->rela_list);
-	hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+	elf_add_rela(elf, rela);
 
 	return 0;
 }


