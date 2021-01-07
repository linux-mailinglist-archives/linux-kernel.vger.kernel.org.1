Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5732EC927
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbhAGDfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:35:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbhAGDfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609990416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pZqGGGdUIYcv87Ot+psilLDqvmj8DgXQf5XxNgXhBWU=;
        b=Q3KlpRXS8uonxcXRpyFEJp/ZopUlT7HmQpIGJZhsdwMhMsRSinIbWBiDVYdFOrTPseJkLH
        XIf+GXpSKQSNLnGmWgzxJtfWmVvQsGB9Xl6BN8+asyKCcRXoAeKHRBrbliLX6NHJI9+M7I
        EXhQSTv6m8l4qNrSJsxJIJftpi/EqLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-eHp9FK90N6e2gpouyO6SvQ-1; Wed, 06 Jan 2021 22:33:34 -0500
X-MC-Unique: eHp9FK90N6e2gpouyO6SvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE24D801817;
        Thu,  7 Jan 2021 03:33:32 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C05962691;
        Thu,  7 Jan 2021 03:33:32 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] objtool: Don't add empty symbols to the rbtree
Date:   Wed,  6 Jan 2021 21:33:20 -0600
Message-Id: <9638ee49574226218d978ce7e26f7a107021f509.1609990368.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with the Clang assembler shows the following warning:

  arch/x86/kernel/ftrace_64.o: warning: objtool: missing symbol for insn at offset 0x16

The Clang assembler strips section symbols.  That ends up giving
objtool's find_func_containing() much more test coverage than normal.
Turns out, find_func_containing() doesn't work so well for overlapping
symbols:

     2: 000000000000000e     0 NOTYPE  LOCAL  DEFAULT    2 fgraph_trace
     3: 000000000000000f     0 NOTYPE  LOCAL  DEFAULT    2 trace
     4: 0000000000000000   165 FUNC    GLOBAL DEFAULT    2 __fentry__
     5: 000000000000000e     0 NOTYPE  GLOBAL DEFAULT    2 ftrace_stub

The zero-length NOTYPE symbols are inside __fentry__(), confusing the
rbtree search for any __fentry__() offset coming after a NOTYPE.

Try to avoid this problem by not adding zero-length symbols to the
rbtree.  They're rare and aren't needed in the rbtree anyway.

One caveat, this actually might not end up being the right fix.
Non-empty overlapping symbols, if they exist, could have the same
problem.  But that would need bigger changes, let's see if we can get
away with the easy fix for now.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index be89c741ba9a..ccee8fc331f0 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -448,6 +448,13 @@ static int read_symbols(struct elf *elf)
 		list_add(&sym->list, entry);
 		elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
 		elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
+
+		/*
+		 * Don't store empty STT_NOTYPE symbols in the rbtree.  They
+		 * can exist within a real function, confusing the sorting.
+		 */
+		if (!sym->len)
+			rb_erase(&sym->node, &sym->sec->symbol_tree);
 	}
 
 	if (stats)
-- 
2.29.2

