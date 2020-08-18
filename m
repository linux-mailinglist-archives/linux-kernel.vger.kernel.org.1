Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D175A2486E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHROO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgHROMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:12:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE99FC061349
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bWebdPWO2kZ+aSt51nW30p9g5yFg2ky94+FiGxSEiuw=; b=E9RFOP86wmNYHMSSfzrtshpypS
        5wSP8cdgnppfFdSFwJNvoW0x152LJNhdRnUTJeCCEOpdm5+OSE9xVhzDrRt4Sl6vn1dR+9Bk3bRaR
        1vHXXVQ5k9vAA1OjreWQN00RL1RbDyeee7z+dz/FiLfeLsbV7G2eQE04/kXosxARw+yOHNmTCTHGI
        F5dt9wuA4R7QRmbdMYyDtnyeWLGrXW6NzTTBXu+Tr5ntK5y3X+o7HzojqBaE00nb7y+bOHblOGPnM
        lab1ZLOqrCysxPZIz4DcGf/jEkXk/iiB1WMxurGj8xx0kG3L6uQnOC5eg0rn86atPt3itGKRN41oN
        Ps1GXBFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82LK-0006VD-Kz; Tue, 18 Aug 2020 14:12:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF2B6307976;
        Tue, 18 Aug 2020 16:12:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D5E7123D42C0E; Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Message-ID: <20200818135805.101186767@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 15:57:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v7 14/18] static_call: Handle tail-calls
References: <20200818135735.948368560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC can turn our static_call(name)(args...) into a tail call, in which
case we get a JMP.d32 into the trampoline (which then does a further
tail-call).

Teach objtool to recognise and mark these in .static_call_sites and
adjust the code patching to deal with this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/static_call.c           |   21 ++++++++++++++++++---
 include/linux/static_call.h             |    4 ++--
 include/linux/static_call_types.h       |    7 +++++++
 kernel/static_call.c                    |   21 +++++++++++++--------
 tools/include/linux/static_call_types.h |    7 +++++++
 tools/objtool/check.c                   |   18 +++++++++++++-----
 6 files changed, 60 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -41,15 +41,30 @@ static void __static_call_transform(void
 	text_poke_bp(insn, code, size, NULL);
 }
 
-void arch_static_call_transform(void *site, void *tramp, void *func)
+static inline enum insn_type __sc_insn(bool null, bool tail)
+{
+	/*
+	 * Encode the following table without branches:
+	 *
+	 *	tail	null	insn
+	 *	-----+-------+------
+	 *	  0  |   0   |  CALL
+	 *	  0  |   1   |  NOP
+	 *	  1  |   0   |  JMP
+	 *	  1  |   1   |  RET
+	 */
+	return 2*tail + null;
+}
+
+void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
 	mutex_lock(&text_mutex);
 
 	if (tramp)
-		__static_call_transform(tramp, func ? JMP : RET, func);
+		__static_call_transform(tramp, __sc_insn(!func, true), func);
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
-		__static_call_transform(site, func ? CALL : NOP, func);
+		__static_call_transform(site, __sc_insn(!func, tail), func);
 
 	mutex_unlock(&text_mutex);
 }
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -103,7 +103,7 @@
 /*
  * Either @site or @tramp can be NULL.
  */
-extern void arch_static_call_transform(void *site, void *tramp, void *func);
+extern void arch_static_call_transform(void *site, void *tramp, void *func, bool tail);
 
 #define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
 
@@ -206,7 +206,7 @@ void __static_call_update(struct static_
 {
 	cpus_read_lock();
 	WRITE_ONCE(key->func, func);
-	arch_static_call_transform(NULL, tramp, func);
+	arch_static_call_transform(NULL, tramp, func, false);
 	cpus_read_unlock();
 }
 
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -17,6 +17,13 @@
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
 /*
+ * Flags in the low bits of static_call_site::key.
+ */
+#define STATIC_CALL_SITE_TAIL 1UL	/* tail call */
+#define STATIC_CALL_SITE_INIT 2UL	/* init section */
+#define STATIC_CALL_SITE_FLAGS 3UL
+
+/*
  * The static call site table needs to be created by external tooling (objtool
  * or a compiler plugin).
  */
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -15,8 +15,6 @@ extern struct static_call_site __start_s
 
 static bool static_call_initialized;
 
-#define STATIC_CALL_INIT 1UL
-
 /* mutex to protect key modules/sites */
 static DEFINE_MUTEX(static_call_mutex);
 
@@ -39,18 +37,23 @@ static inline void *static_call_addr(str
 static inline struct static_call_key *static_call_key(const struct static_call_site *site)
 {
 	return (struct static_call_key *)
-		(((long)site->key + (long)&site->key) & ~STATIC_CALL_INIT);
+		(((long)site->key + (long)&site->key) & ~STATIC_CALL_SITE_FLAGS);
 }
 
 /* These assume the key is word-aligned. */
 static inline bool static_call_is_init(struct static_call_site *site)
 {
-	return ((long)site->key + (long)&site->key) & STATIC_CALL_INIT;
+	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_INIT;
+}
+
+static inline bool static_call_is_tail(struct static_call_site *site)
+{
+	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_TAIL;
 }
 
 static inline void static_call_set_init(struct static_call_site *site)
 {
-	site->key = ((long)static_call_key(site) | STATIC_CALL_INIT) -
+	site->key = ((long)static_call_key(site) | STATIC_CALL_SITE_INIT) -
 		    (long)&site->key;
 }
 
@@ -104,7 +107,7 @@ void __static_call_update(struct static_
 
 	key->func = func;
 
-	arch_static_call_transform(NULL, tramp, func);
+	arch_static_call_transform(NULL, tramp, func, false);
 
 	/*
 	 * If uninitialized, we'll not update the callsites, but they still
@@ -154,7 +157,8 @@ void __static_call_update(struct static_
 				continue;
 			}
 
-			arch_static_call_transform(site_addr, NULL, func);
+			arch_static_call_transform(site_addr, NULL, func,
+				static_call_is_tail(site));
 		}
 	}
 
@@ -198,7 +202,8 @@ static int __static_call_init(struct mod
 			key->mods = site_mod;
 		}
 
-		arch_static_call_transform(site_addr, NULL, key->func);
+		arch_static_call_transform(site_addr, NULL, key->func,
+				static_call_is_tail(site));
 	}
 
 	return 0;
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -17,6 +17,13 @@
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
 /*
+ * Flags in the low bits of static_call_site::key.
+ */
+#define STATIC_CALL_SITE_TAIL 1UL	/* tail call */
+#define STATIC_CALL_SITE_INIT 2UL	/* init section */
+#define STATIC_CALL_SITE_FLAGS 3UL
+
+/*
  * The static call site table needs to be created by external tooling (objtool
  * or a compiler plugin).
  */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -511,7 +511,7 @@ static int create_static_call_sections(s
 		}
 		memset(reloc, 0, sizeof(*reloc));
 		reloc->sym = key_sym;
-		reloc->addend = 0;
+		reloc->addend = is_sibling_call(insn) ? STATIC_CALL_SITE_TAIL : 0;
 		reloc->type = R_X86_64_PC32;
 		reloc->offset = idx * sizeof(struct static_call_site) + 4;
 		reloc->sec = reloc_sec;
@@ -720,6 +720,10 @@ static int add_jump_destinations(struct
 		} else {
 			/* external sibling call */
 			insn->call_dest = reloc->sym;
+			if (insn->call_dest->static_call_tramp) {
+				list_add_tail(&insn->static_call_node,
+					      &file->static_call_list);
+			}
 			continue;
 		}
 
@@ -771,6 +775,10 @@ static int add_jump_destinations(struct
 
 				/* internal sibling call */
 				insn->call_dest = insn->jump_dest->func;
+				if (insn->call_dest->static_call_tramp) {
+					list_add_tail(&insn->static_call_node,
+						      &file->static_call_list);
+				}
 			}
 		}
 	}
@@ -1639,6 +1647,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_static_call_tramps(file);
+	if (ret)
+		return ret;
+
 	ret = add_jump_destinations(file);
 	if (ret)
 		return ret;
@@ -1671,10 +1683,6 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = read_static_call_tramps(file);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 


