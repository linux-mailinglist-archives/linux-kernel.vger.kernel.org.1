Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B908C1B3EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgDVKcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 06:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbgDVKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:32:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71A7C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:32:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h2so1706219wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNc4we7ESJBS0HuNbhflGP7Zf4Z9nmjjGCh1DH2rdq4=;
        b=dUouRE0SOcGAsrk1VtKYHClkJ6iKHArdDMWWgQByxLq8/UgJN3/74xwmAa+PPp/h1K
         dDjn8lN5/zQrsZSHbUoVx9SAQ/Zg4Ym873ZWn+Xdob6XeEWl1/7Mak8IPfiA50eOUQCf
         fXeLJeMHutX6eIdDWeARKVWfq3LOK2xtJN4olLubWb7FGsYxz3BVlfyzYJdM4zVbEZ4E
         TSP/aSp4X6pMSkwhoSR2M5SSn1xWqKhXoSlWO41RpO7tA7QKlsalmRVkdpWAlMUHXkj6
         cPSPNIIhcz0KIhpZaKxHRqzH0SvyTDn4YvusuiqyMzuub5cYeJu1VmJIq+MPhLx5rhwB
         tOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lNc4we7ESJBS0HuNbhflGP7Zf4Z9nmjjGCh1DH2rdq4=;
        b=a3wE+y9YBucUKa37EsFxIs3+bcFMB2MXBIuT2uBRW2iYmn0HZ5rjCl3Y14iuzDeCTe
         wcAX44un4D1S8S7lFXQvRg+uqdLi+26P4c+MVGkZM2zki2ezLq1eu4GOJwTey9Xe+W4r
         xs/sVKKywsVTkCK60Rcu/I+A3JXpS288XByYkv9doN1wszg7a06yebP6iaQD8iCYD9hK
         6UFrvYMmQh7SaWcR3ykdgljds5eH6wjBANctR2s2Snqj+LH5/jPH55ig3vcCGGz4aOiv
         fXgSI5DfcU5Lu1CBW/7BMDP1eDtQA2CEBdJOJ61tU/VYqJUSaXfsKkcBrK4XMo9N/1lN
         LTgA==
X-Gm-Message-State: AGi0PubUyg1hHa/wTRM+ZmE2WxWuuJmD4jvHS53A0vh+Gvcd/gXm1y7r
        wCRnMXd5xVUB6n2lxTYAzU8yTnsO
X-Google-Smtp-Source: APiQypLGHJtudSOWeWVg0GgdHoVq9ESiVrgJ5vVvqIDjCppR1LhZxC73OryVAgYZDbYLMOcTG2DVLQ==
X-Received: by 2002:a1c:ba09:: with SMTP id k9mr9607860wmf.176.1587551543071;
        Wed, 22 Apr 2020 03:32:23 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s12sm6891603wmc.7.2020.04.22.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:32:22 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/3] objtool: Constify 'struct elf *' parameters
Date:   Wed, 22 Apr 2020 12:32:03 +0200
Message-Id: <20200422103205.61900-2-mingo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422103205.61900-1-mingo@kernel.org>
References: <20200422103205.61900-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to parallelize certain parts of objtool, map out which uses
of various data structures are read-only vs. read-write.

As a first step constify 'struct elf' pointer passing, most of the secondary
uses of it in find_symbol_*() methods are read-only.

Also, while at it, better group the 'struct elf' handling methods in elf.h.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/elf.c | 10 +++++-----
 tools/objtool/elf.h | 20 ++++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f26bb3e8db7b..fab5534c3365 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -127,7 +127,7 @@ static int symbol_by_offset(const void *key, const struct rb_node *node)
 	return 0;
 }
 
-struct section *find_section_by_name(struct elf *elf, const char *name)
+struct section *find_section_by_name(const struct elf *elf, const char *name)
 {
 	struct section *sec;
 
@@ -217,7 +217,7 @@ struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 	return NULL;
 }
 
-struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
+struct symbol *find_symbol_by_name(const struct elf *elf, const char *name)
 {
 	struct symbol *sym;
 
@@ -228,7 +228,7 @@ struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
 	return NULL;
 }
 
-struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
+struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len)
 {
 	struct rela *rela, *r = NULL;
@@ -257,7 +257,7 @@ struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
 	return NULL;
 }
 
-struct rela *find_rela_by_dest(struct elf *elf, struct section *sec, unsigned long offset)
+struct rela *find_rela_by_dest(const struct elf *elf, struct section *sec, unsigned long offset)
 {
 	return find_rela_by_dest_range(elf, sec, offset, 1);
 }
@@ -769,7 +769,7 @@ int elf_rebuild_rela_section(struct section *sec)
 	return 0;
 }
 
-int elf_write(struct elf *elf)
+int elf_write(const struct elf *elf)
 {
 	struct section *sec;
 	Elf_Scn *s;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 2811d04346c9..a55bcde9f1b1 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -114,22 +114,22 @@ static inline u32 rela_hash(struct rela *rela)
 }
 
 struct elf *elf_read(const char *name, int flags);
-struct section *find_section_by_name(struct elf *elf, const char *name);
+struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
+struct section *elf_create_rela_section(struct elf *elf, struct section *base);
+void elf_add_rela(struct elf *elf, struct rela *rela);
+int elf_write(const struct elf *elf);
+void elf_close(struct elf *elf);
+
+struct section *find_section_by_name(const struct elf *elf, const char *name);
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
-struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
+struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
-struct rela *find_rela_by_dest(struct elf *elf, struct section *sec, unsigned long offset);
-struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
+struct rela *find_rela_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
+struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
-struct section *elf_create_section(struct elf *elf, const char *name, size_t
-				   entsize, int nr);
-struct section *elf_create_rela_section(struct elf *elf, struct section *base);
 int elf_rebuild_rela_section(struct section *sec);
-int elf_write(struct elf *elf);
-void elf_close(struct elf *elf);
-void elf_add_rela(struct elf *elf, struct rela *rela);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
-- 
2.20.1

