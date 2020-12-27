Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D23E2E309C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 10:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgL0Jbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 04:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgL0Jbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 04:31:49 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282C6C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 01:31:09 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ce23so10702839ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 01:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zpxAV7QKLbXe8V1eaquEFrptlAyHVmid9k6lfAj1Lco=;
        b=FRcKc+fniwCHp2PLp2EqeQJIBxItDCJy86ZNowOkB8c70EMBnPs/NbQMkv2W+vHbyZ
         qJq+qihnEXzmrzy50FJgIBkHFy9xqpkBJ8pzzCp46h6GndnWy+kgZ4TklWqF9VwgseY0
         eCFMl/wIa91eRw6+6Ewf6k25iq1wFEm/nfclKPGihT1ztO7IpIJGMr66rLkKLQqcI49V
         QBxA3qMOu1VpcUMABZrIlFPdiy+drDg29pvAy4KEINc8W2geA3yABop+bjChpmx3QWQ+
         dyR8tmVM/YItveE4Zgho/vdeiIokHfsfl/TFpN5Q2S6p1Lh9RY9YLyImlqjKzS/SDKfv
         d8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=zpxAV7QKLbXe8V1eaquEFrptlAyHVmid9k6lfAj1Lco=;
        b=VZmAWGhAU93SKEUNRhtj9IJj78U8BjT/+Cv3Ck7jS/UPfUa8fuHIDqqAgzh51t3H/l
         hKPEDVGWmVRj0F7G/JbGkmjD3wcSDQ97jgFyLpspYWAC+eAIRN4xthjrniFhct+Ay28d
         fFSkRiBIqNjcaSjPNTK5ocJ/5HOGqS/LHOFIxlhMegkKfAytng4ueyMEwjmHLt+be02G
         1cEuBcTB8J3sxn3d84wwUIj59kw2HXqNzZmsooHJ9WY+nKI9IdwVRvbP9UyhJsMAUAcg
         SOcUssTIDMG6FBTiMV8XExRghGOLgXy1daBNzSGko08arh6c0bI4lLqov/2TDEThtLe0
         PYIw==
X-Gm-Message-State: AOAM533RzCjuL3Fms2CMnJgcY7PxJoqvJemBe0zeY68vU4RkAPNFCI+e
        TsfgeBGuE82ywbSt8Pb2sV06S+MZD5Y=
X-Google-Smtp-Source: ABdhPJzjZ7k2307Swpn2xwg+LOpmv7Z1l2EDohQ7KDcfWHACRLx0JPPj3dsYffpOu8LCclqx/9Odjw==
X-Received: by 2002:a17:906:1488:: with SMTP id x8mr26494320ejc.124.1609061467615;
        Sun, 27 Dec 2020 01:31:07 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id j25sm10048835ejx.125.2020.12.27.01.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 01:31:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 27 Dec 2020 10:31:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool fix
Message-ID: <20201227093105.GA1806713@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2020-12-27

   # HEAD: 44f6a7c0755d8dd453c70557e11687bb080a6f21 objtool: Fix seg fault with Clang non-section symbols

Fix a segfault that occurs when built with Clang.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (1):
      objtool: Fix seg fault with Clang non-section symbols


 tools/objtool/check.c   | 11 +++++++++--
 tools/objtool/elf.c     | 26 ++++++++++++++++++++++++++
 tools/objtool/elf.h     |  2 ++
 tools/objtool/orc_gen.c | 29 +++++------------------------
 4 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6ab44543c92..5f8d3eed78a1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -467,13 +467,20 @@ static int create_static_call_sections(struct objtool_file *file)
 
 		/* populate reloc for 'addr' */
 		reloc = malloc(sizeof(*reloc));
+
 		if (!reloc) {
 			perror("malloc");
 			return -1;
 		}
 		memset(reloc, 0, sizeof(*reloc));
-		reloc->sym = insn->sec->sym;
-		reloc->addend = insn->offset;
+
+		insn_to_reloc_sym_addend(insn->sec, insn->offset, reloc);
+		if (!reloc->sym) {
+			WARN_FUNC("static call tramp: missing containing symbol",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
 		reloc->type = R_X86_64_PC32;
 		reloc->offset = idx * sizeof(struct static_call_site);
 		reloc->sec = reloc_sec;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e1d7460574b..be89c741ba9a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -262,6 +262,32 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 	return find_reloc_by_dest_range(elf, sec, offset, 1);
 }
 
+void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
+			      struct reloc *reloc)
+{
+	if (sec->sym) {
+		reloc->sym = sec->sym;
+		reloc->addend = offset;
+		return;
+	}
+
+	/*
+	 * The Clang assembler strips section symbols, so we have to reference
+	 * the function symbol instead:
+	 */
+	reloc->sym = find_symbol_containing(sec, offset);
+	if (!reloc->sym) {
+		/*
+		 * Hack alert.  This happens when we need to reference the NOP
+		 * pad insn immediately after the function.
+		 */
+		reloc->sym = find_symbol_containing(sec, offset - 1);
+	}
+
+	if (reloc->sym)
+		reloc->addend = offset - reloc->sym->offset;
+}
+
 static int read_sections(struct elf *elf)
 {
 	Elf_Scn *s = NULL;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 807f8c670097..e6890cc70a25 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -140,6 +140,8 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
+void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
+			      struct reloc *reloc);
 int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
 
 #define for_each_sec(file, sec)						\
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 235663b96adc..9ce68b385a1b 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -105,30 +105,11 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	}
 	memset(reloc, 0, sizeof(*reloc));
 
-	if (insn_sec->sym) {
-		reloc->sym = insn_sec->sym;
-		reloc->addend = insn_off;
-	} else {
-		/*
-		 * The Clang assembler doesn't produce section symbols, so we
-		 * have to reference the function symbol instead:
-		 */
-		reloc->sym = find_symbol_containing(insn_sec, insn_off);
-		if (!reloc->sym) {
-			/*
-			 * Hack alert.  This happens when we need to reference
-			 * the NOP pad insn immediately after the function.
-			 */
-			reloc->sym = find_symbol_containing(insn_sec,
-							   insn_off - 1);
-		}
-		if (!reloc->sym) {
-			WARN("missing symbol for insn at offset 0x%lx\n",
-			     insn_off);
-			return -1;
-		}
-
-		reloc->addend = insn_off - reloc->sym->offset;
+	insn_to_reloc_sym_addend(insn_sec, insn_off, reloc);
+	if (!reloc->sym) {
+		WARN("missing symbol for insn at offset 0x%lx",
+		     insn_off);
+		return -1;
 	}
 
 	reloc->type = R_X86_64_PC32;
