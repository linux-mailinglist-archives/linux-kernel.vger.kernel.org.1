Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DEA1CB089
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgEHNcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 09:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728780AbgEHNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:32:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80374C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ms4cIcg8hCLTUr0z0CcPk4qX/5M5Ay/W6c6+fEky25w=; b=Ej3sZFukGv0/8tFpavM0rLEk5k
        RgOeWFk68LmxF8PuysCeqQ5CpyVHrlPzdUtkTnZMkVbQxROZJ9XshpxYdMGJ1Mk50dFZ1OJ4Bob29
        MegmW+u8zW4BX8Fz4AJsRfQr6gIFSEpBx67/Dr5ttc/BR0Sf46M8ULU9b5U0vu9eznxN12I/0Cc/r
        bET/OX5yUB2RmluEcmpiaPZLxsWOXMsbT1yIsihIZdrYJ9oI1JlPr23DoOq1EWpS1KBGUQLXfMfpw
        L//lY0dYJjwe06deKVdnAEQKWouc9zdZop9X47iqQv17GORUCs3rxUv8BydRLm5qrB1P0Wunza64N
        TCh2gBEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX36d-0004UI-Ei; Fri, 08 May 2020 13:31:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6B3F307A7F;
        Fri,  8 May 2020 15:31:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAF242B94B350; Fri,  8 May 2020 15:31:56 +0200 (CEST)
Date:   Fri, 8 May 2020 15:31:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 16/18] static_call: Allow early init
Message-ID: <20200508133156.GC3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.706674211@infradead.org>
 <20200506211547.2vnuhkfzhgbi27dm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506211547.2vnuhkfzhgbi27dm@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 04:15:47PM -0500, Josh Poimboeuf wrote:

> This doesn't work when the key is defined in a module.  In
> __static_call_update(), first.site_mod->mod is NULL, but
> static_call_key_sites() points to the module's call sites.
> 
> This seems to fix it (sorry, also has the 'next' -> 'mods' rename).
> The actual fix is in static_call_key_sites() and static_call_key_mods().
> 

> @@ -118,7 +118,12 @@ static inline struct static_call_site *static_call_key_sites(struct static_call_
>  void __static_call_update(struct static_call_key *key, void *tramp, void *func)
>  {
>  	struct static_call_site *site, *stop;
> -	struct static_call_mod *site_mod, first;
> +	struct static_call_mod *site_mod;
> +	struct static_call_mod first = {
> +		.next = static_call_key_mods(key),
> +		.mod = NULL,
> +		.sites = static_call_key_sites(key),
> +	};
>  
>  	cpus_read_lock();
>  	static_call_lock();

This bit is actually broken, we need static_call_lock(), otherwise the
values just read in @first are not reliable.

New version below.

---
Subject: static_call: Allow early init
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 4 Oct 17:21:10 CEST 2019

In order to use static_call() to wire up x86_pmu, we need to
initialize earlier; copy some of the tricks from jump_label to enable
this.

Primarily we overload key->next to store a sites pointer when there
are no modules, this avoids having to use kmalloc() to initialize the
sites and allows us to run much earlier.

(arguably, this is much much earlier than needed for perf, but it
might allow other uses.)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/setup.c       |    2 +
 arch/x86/kernel/static_call.c |    8 +++++-
 include/linux/static_call.h   |   15 +++++++++--
 kernel/static_call.c          |   55 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 74 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -19,6 +19,7 @@
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
+#include <linux/static_call.h>
 
 #include <uapi/linux/mount.h>
 
@@ -848,6 +849,7 @@ void __init setup_arch(char **cmdline_p)
 	early_cpu_init();
 	arch_init_ideal_nops();
 	jump_label_init();
+	static_call_init();
 	early_ioremap_init();
 
 	setup_olpc_ofw_pgd();
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -11,7 +11,7 @@ enum insn_type {
 	RET = 3,  /* tramp / site cond-tail-call */
 };
 
-static void __static_call_transform(void *insn, enum insn_type type, void *func)
+static void __ref __static_call_transform(void *insn, enum insn_type type, void *func)
 {
 	int size = CALL_INSN_SIZE;
 	const void *code;
@@ -33,11 +33,17 @@ static void __static_call_transform(void
 		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
 		size = RET_INSN_SIZE;
 		break;
+
+	default: /* GCC is a moron -- it figures @code can be uninitialized below */
+		BUG();
 	}
 
 	if (memcmp(insn, code, size) == 0)
 		return;
 
+	if (unlikely(system_state == SYSTEM_BOOTING))
+		return text_poke_early(insn, code, size);
+
 	text_poke_bp(insn, code, size, NULL);
 }
 
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -99,6 +99,8 @@ extern void arch_static_call_transform(v
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
+extern void __init static_call_init(void);
+
 struct static_call_mod {
 	struct static_call_mod *next;
 	struct module *mod; /* for vmlinux, mod == NULL */
@@ -107,7 +109,12 @@ struct static_call_mod {
 
 struct static_call_key {
 	void *func;
-	struct static_call_mod *mods;
+	union {
+		/* bit 0: 0 = mods, 1 = sites */
+		unsigned long type;
+		struct static_call_mod *mods;
+		struct static_call_site *sites;
+	};
 };
 
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
@@ -118,7 +125,7 @@ extern int static_call_text_reserved(voi
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = _func,						\
-		.next = NULL,						\
+		.type = 1,						\
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
@@ -143,6 +150,8 @@ extern int static_call_text_reserved(voi
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+static inline void static_call_init(void) { }
+
 struct static_call_key {
 	void *func;
 };
@@ -188,6 +197,8 @@ static inline int static_call_text_reser
 
 #else /* Generic implementation */
 
+static inline void static_call_init(void) { }
+
 struct static_call_key {
 	void *func;
 };
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -94,10 +94,31 @@ static inline void static_call_sort_entr
 	     static_call_site_cmp, static_call_site_swap);
 }
 
+static inline bool static_call_key_has_mods(struct static_call_key *key)
+{
+	return !(key->type & 1);
+}
+
+static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
+{
+	if (!static_call_key_has_mods(key))
+		return NULL;
+
+	return key->mods;
+}
+
+static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
+{
+	if (static_call_key_has_mods(key))
+		return NULL
+
+	return (struct static_call_site *)(key->type & ~1);
+}
+
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
 	struct static_call_site *site, *stop;
-	struct static_call_mod *site_mod;
+	struct static_call_mod *site_mod, first;
 
 	cpus_read_lock();
 	static_call_lock();
@@ -116,13 +137,22 @@ void __static_call_update(struct static_
 	if (WARN_ON_ONCE(!static_call_initialized))
 		goto done;
 
-	for (site_mod = key->mods; site_mod; site_mod = site_mod->next) {
+	first = (struct static_call_mod){
+		.next = static_call_key_next(key),
+		.mod = NULL,
+		.sites = static_call_key_sites(key),
+	};
+
+	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
 		struct module *mod = site_mod->mod;
 
 		if (!site_mod->sites) {
 			/*
 			 * This can happen if the static call key is defined in
 			 * a module which doesn't use it.
+			 *
+			 * It also happens in the has_mods case, where the
+			 * 'first' entry has no sites associated with it.
 			 */
 			continue;
 		}
@@ -192,16 +222,35 @@ static int __static_call_init(struct mod
 		if (key != prev_key) {
 			prev_key = key;
 
+			if (!mod) {
+				key->sites = site;
+				key->type |= 1;
+				goto do_transform;
+			}
+
 			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
 			if (!site_mod)
 				return -ENOMEM;
 
+			if (!static_call_key_has_mods(key)) {
+				site_mod->mod = NULL;
+				site_mod->next = NULL;
+				site_mod->sites = static_call_key_sites(key);
+
+				key->mods = site_mod;
+
+				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+				if (!site_mod)
+					return -ENOMEM;
+			}
+
 			site_mod->mod = mod;
 			site_mod->sites = site;
 			site_mod->next = key->mods;
 			key->mods = site_mod;
 		}
 
+do_transform:
 		arch_static_call_transform(site_addr, NULL, key->func,
 				static_call_is_tail(site));
 	}
@@ -344,7 +393,7 @@ int static_call_text_reserved(void *star
 	return ret;
 }
 
-static void __init static_call_init(void)
+void __init static_call_init(void)
 {
 	int ret;
 
