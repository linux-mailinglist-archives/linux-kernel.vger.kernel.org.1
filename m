Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400DF1E5A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 10:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgE1IBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 04:01:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:28956 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgE1IBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:01:53 -0400
IronPort-SDR: 4luX1zpe8mNI6oCj0sn5tt+W7o1HuoAvVeuJvUbo+gyEOmwiyBgJbVaV5Q3zn0E9v/JJW2WE+s
 9WsZ1qrzLmMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 01:01:52 -0700
IronPort-SDR: AFvuVv3zwYqJuYuY7mkIY5CkfI7UnA5E3+cKFiujY8+1Wr8dhThkE0wrlItRD1KAO5lelM65s8
 7kzGlrztdRQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="256996039"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga008.fm.intel.com with ESMTP; 28 May 2020 01:01:29 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 03/15] kprobes: Add symbols for kprobe insn pages
Date:   Thu, 28 May 2020 11:00:58 +0300
Message-Id: <20200528080058.20230-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527174345.GB706478@hirez.programming.kicks-ass.net>
References: <20200527174345.GB706478@hirez.programming.kicks-ass.net>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbols are needed for tools to describe instruction addresses. Pages
allocated for kprobe's purposes need symbols to be created for them.
Add such symbols to be visible via /proc/kallsyms.

Note: kprobe insn pages are not used if ftrace is configured. To see the
effect of this patch, the kernel must be configured with:

	# CONFIG_FUNCTION_TRACER is not set
	CONFIG_KPROBES=y

and for optimised kprobes:

	CONFIG_OPTPROBES=y

Example on x86:

	# perf probe __schedule
	Added new event:
	  probe:__schedule     (on __schedule)
	# cat /proc/kallsyms | grep '\[__builtin__kprobes\]'
	ffffffffc00d4000 t kprobe_insn_page     [__builtin__kprobes]
	ffffffffc00d6000 t kprobe_optinsn_page  [__builtin__kprobes]

Note: This patch adds "__builtin__kprobes" as a module name in
/proc/kallsyms for symbols for pages allocated for kprobes' purposes, even
though "__builtin__kprobes" is not a module.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V8:

	Move kprobe_cache_get_kallsym() under __ARCH_WANT_KPROBES_INSN_SLOT


 include/linux/kprobes.h | 15 ++++++++++++++
 kernel/kallsyms.c       | 37 +++++++++++++++++++++++++++++----
 kernel/kprobes.c        | 45 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 04bdaf01112c..39878bc9bcb0 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -242,6 +242,7 @@ struct kprobe_insn_cache {
 	struct mutex mutex;
 	void *(*alloc)(void);	/* allocate insn page */
 	void (*free)(void *);	/* free insn page */
+	const char *sym;	/* symbol for insn pages */
 	struct list_head pages; /* list of kprobe_insn_page */
 	size_t insn_size;	/* size of instruction slot */
 	int nr_garbage;
@@ -272,6 +273,10 @@ static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
 {									\
 	return __is_insn_slot_addr(&kprobe_##__name##_slots, addr);	\
 }
+#define KPROBE_INSN_PAGE_SYM		"kprobe_insn_page"
+#define KPROBE_OPTINSN_PAGE_SYM		"kprobe_optinsn_page"
+int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
+			     unsigned long *value, char *type, char *sym);
 #else /* __ARCH_WANT_KPROBES_INSN_SLOT */
 #define DEFINE_INSN_CACHE_OPS(__name)					\
 static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
@@ -373,6 +378,11 @@ void dump_kprobe(struct kprobe *kp);
 void *alloc_insn_page(void);
 void free_insn_page(void *page);
 
+int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+		       char *sym);
+
+int arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
+			    char *type, char *sym);
 #else /* !CONFIG_KPROBES: */
 
 static inline int kprobes_built_in(void)
@@ -435,6 +445,11 @@ static inline bool within_kprobe_blacklist(unsigned long addr)
 {
 	return true;
 }
+static inline int kprobe_get_kallsym(unsigned int symnum, unsigned long *value,
+				     char *type, char *sym)
+{
+	return -ERANGE;
+}
 #endif /* CONFIG_KPROBES */
 static inline int disable_kretprobe(struct kretprobe *rp)
 {
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 16c8c605f4b0..c6cc293c0e67 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/filter.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 #include <linux/compiler.h>
 
 /*
@@ -437,6 +438,7 @@ struct kallsym_iter {
 	loff_t pos_arch_end;
 	loff_t pos_mod_end;
 	loff_t pos_ftrace_mod_end;
+	loff_t pos_bpf_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
 	char type;
@@ -496,11 +498,33 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 
 static int get_ksymbol_bpf(struct kallsym_iter *iter)
 {
+	int ret;
+
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
-	return bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
-			       &iter->value, &iter->type,
-			       iter->name) < 0 ? 0 : 1;
+	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
+			      &iter->value, &iter->type,
+			      iter->name);
+	if (ret < 0) {
+		iter->pos_bpf_end = iter->pos;
+		return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * This uses "__builtin__kprobes" as a module name for symbols for pages
+ * allocated for kprobes' purposes, even though "__builtin__kprobes" is not a
+ * module.
+ */
+static int get_ksymbol_kprobe(struct kallsym_iter *iter)
+{
+	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
+	iter->exported = 0;
+	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
+				  &iter->value, &iter->type,
+				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
@@ -527,6 +551,7 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 		iter->pos_arch_end = 0;
 		iter->pos_mod_end = 0;
 		iter->pos_ftrace_mod_end = 0;
+		iter->pos_bpf_end = 0;
 	}
 }
 
@@ -551,7 +576,11 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 	    get_ksymbol_ftrace_mod(iter))
 		return 1;
 
-	return get_ksymbol_bpf(iter);
+	if ((!iter->pos_bpf_end || iter->pos_bpf_end > pos) &&
+	    get_ksymbol_bpf(iter))
+		return 1;
+
+	return get_ksymbol_kprobe(iter);
 }
 
 /* Returns false if pos at or past end of file. */
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c241ac00..c2a7330e406e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -118,6 +118,7 @@ struct kprobe_insn_cache kprobe_insn_slots = {
 	.mutex = __MUTEX_INITIALIZER(kprobe_insn_slots.mutex),
 	.alloc = alloc_insn_page,
 	.free = free_insn_page,
+	.sym = KPROBE_INSN_PAGE_SYM,
 	.pages = LIST_HEAD_INIT(kprobe_insn_slots.pages),
 	.insn_size = MAX_INSN_SIZE,
 	.nr_garbage = 0,
@@ -290,12 +291,34 @@ bool __is_insn_slot_addr(struct kprobe_insn_cache *c, unsigned long addr)
 	return ret;
 }
 
+int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
+			     unsigned long *value, char *type, char *sym)
+{
+	struct kprobe_insn_page *kip;
+	int ret = -ERANGE;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(kip, &c->pages, list) {
+		if ((*symnum)--)
+			continue;
+		strlcpy(sym, c->sym, KSYM_NAME_LEN);
+		*type = 't';
+		*value = (unsigned long)kip->insns;
+		ret = 0;
+		break;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 #ifdef CONFIG_OPTPROBES
 /* For optimized_kprobe buffer */
 struct kprobe_insn_cache kprobe_optinsn_slots = {
 	.mutex = __MUTEX_INITIALIZER(kprobe_optinsn_slots.mutex),
 	.alloc = alloc_insn_page,
 	.free = free_insn_page,
+	.sym = KPROBE_OPTINSN_PAGE_SYM,
 	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
 	/* .insn_size is initialized later */
 	.nr_garbage = 0,
@@ -2179,6 +2202,28 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
+int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
+				   char *type, char *sym)
+{
+	return -ERANGE;
+}
+
+int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+		       char *sym)
+{
+#ifdef __ARCH_WANT_KPROBES_INSN_SLOT
+	if (!kprobe_cache_get_kallsym(&kprobe_insn_slots, &symnum, value, type, sym))
+		return 0;
+#ifdef CONFIG_OPTPROBES
+	if (!kprobe_cache_get_kallsym(&kprobe_optinsn_slots, &symnum, value, type, sym))
+		return 0;
+#endif
+#endif
+	if (!arch_kprobe_get_kallsym(&symnum, value, type, sym))
+		return 0;
+	return -ERANGE;
+}
+
 int __init __weak arch_populate_kprobe_blacklist(void)
 {
 	return 0;
-- 
2.17.1

