Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4218A26CCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgIPUuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgIPQ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:56:00 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F01224D3;
        Wed, 16 Sep 2020 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600274696;
        bh=8tdwj3aFqDfhW0jHoTtJmNGhQP2dJm5epE5yr5XkVn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+idCUK3PRYFPDUaKRgvPavOPLfWuPV6eVSfZpdwOX++4OG7p7IPFx/anCpTqyCsT
         8Y+BFoqa4Fv4FB2zwtoKO8r5w7eKUuKd0ENVzeX87qa9zi3bmMIjMjAle9eNYYGIDy
         t6u8hKw0M5xKji4HVeTRxYp0YU/DQfML6GFxjuuQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     "Frank Ch . Eigler" <fche@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf probe: Fall back to debuginfod query if debuginfo and source not found
Date:   Thu, 17 Sep 2020 01:44:52 +0900
Message-Id: <160027469272.803747.13799945548211140499.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160027467316.803747.10741549521899847231.stgit@devnote2>
References: <160027467316.803747.10741549521899847231.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the perf-probe heavily depends on the debuginfo, debuginfod
gives us many benefits on the perf probe command on remote machine.
Especially, this will be helpful for the embedded devices which will
not have enough storage, or boot with a cross-build kernel whose
source code is in the host machine.
This will work as similar to the commit c7a14fdcb3fa ("perf build-ids:
Fall back to debuginfod query if debuginfo not found")

Tested with:

  (host) $ cd PATH/TO/KBUILD/DIR/
  (host) $ debuginfod -F .
  ...

  (remote) # perf probe -L vfs_read
  Failed to find the path for the kernel: No such file or directory
    Error: Failed to show lines.

  (remote) # export DEBUGINFOD_URLS="http://$HOST_IP:8002/"
  (remote) # perf probe -L vfs_read
  <vfs_read@...>
        0  ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
           {
        2         ssize_t ret;

                  if (!(file->f_mode & FMODE_READ))
                          return -EBADF;
        6         if (!(file->f_mode & FMODE_CAN_READ))
                          return -EINVAL;
        8         if (unlikely(!access_ok(buf, count)))
                          return -EFAULT;

       11         ret = rw_verify_area(READ, file, pos, count);
       12         if (ret)
                          return ret;
                  if (count > MAX_RW_COUNT)
  ...

  (remote) # perf probe -a "vfs_read count"
  Added new event:
    probe:vfs_read       (on vfs_read with count)

  (remote) # perf probe -l
    probe:vfs_read       (on vfs_read@ksrc/linux/fs/read_write.c with count)


Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c  |   52 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/probe-finder.c |   56 ++++++++++++++++++++++++++++++++++++----
 tools/perf/util/probe-finder.h |    7 ++++-
 3 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 17831f186ab5..26733c8070a7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -43,6 +43,10 @@
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+#include <elfutils/debuginfod.h>
+#endif
+
 #define PERFPROBE_GROUP "probe"
 
 bool probe_event_dry_run;	/* Dry run flag */
@@ -338,6 +342,8 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 
 	map = machine__kernel_map(host_machine);
 	dso = map->dso;
+	if (!dso->has_build_id)
+		dso__read_running_kernel_build_id(dso, host_machine);
 
 	vmlinux_name = symbol_conf.vmlinux_name;
 	dso->load_errno = 0;
@@ -453,6 +459,43 @@ static int get_alternative_line_range(struct debuginfo *dinfo,
 	return ret;
 }
 
+static struct debuginfo *open_from_debuginfod(struct dso *dso, struct nsinfo *nsi,
+					      bool silent)
+{
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+	debuginfod_client * c = debuginfod_begin();
+	char sbuild_id[SBUILD_ID_SIZE + 1];
+	struct debuginfo *ret = NULL;
+	struct nscookie nsc;
+	char *path;
+	int fd;
+
+	if (!c)
+		return NULL;
+
+	build_id__sprintf(dso->build_id, BUILD_ID_SIZE, sbuild_id);
+	fd = debuginfod_find_debuginfo(c, (const unsigned char *)sbuild_id,
+					0, &path);
+	if (fd >= 0)
+		close(fd);
+	debuginfod_end(c);
+	if (fd < 0) {
+		if (!silent)
+			pr_debug("Failed to find debuginfo in debuginfod.\n");
+		return NULL;
+	}
+	if (!silent)
+		pr_debug("Load debuginfo from debuginfod (%s)\n", path);
+
+	nsinfo__mountns_enter(nsi, &nsc);
+	ret = debuginfo__new((const char *)path);
+	nsinfo__mountns_exit(&nsc);
+	return ret;
+#else
+	return NULL;
+#endif
+}
+
 /* Open new debuginfo of given module */
 static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 					bool silent)
@@ -472,6 +515,10 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 					strcpy(reason, "(unknown)");
 			} else
 				dso__strerror_load(dso, reason, STRERR_BUFSIZE);
+			if (dso)
+				ret = open_from_debuginfod(dso, nsi, silent);
+			if (ret)
+				return ret;
 			if (!silent) {
 				if (module)
 					pr_err("Module %s is not loaded, please specify its full path name.\n", module);
@@ -959,6 +1006,7 @@ static int __show_line_range(struct line_range *lr, const char *module,
 	int ret;
 	char *tmp;
 	char sbuf[STRERR_BUFSIZE];
+	char sbuild_id[SBUILD_ID_SIZE] = "";
 
 	/* Search a line range */
 	dinfo = open_debuginfo(module, NULL, false);
@@ -971,6 +1019,8 @@ static int __show_line_range(struct line_range *lr, const char *module,
 		if (!ret)
 			ret = debuginfo__find_line_range(dinfo, lr);
 	}
+	if (dinfo->build_id)
+		build_id__sprintf(dinfo->build_id, BUILD_ID_SIZE, sbuild_id);
 	debuginfo__delete(dinfo);
 	if (ret == 0 || ret == -ENOENT) {
 		pr_warning("Specified source line is not found.\n");
@@ -982,7 +1032,7 @@ static int __show_line_range(struct line_range *lr, const char *module,
 
 	/* Convert source file path */
 	tmp = lr->path;
-	ret = get_real_path(tmp, lr->comp_dir, &lr->path);
+	ret = find_source_path(tmp, sbuild_id, lr->comp_dir, &lr->path);
 
 	/* Free old path when new path is assigned */
 	if (tmp != lr->path)
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 659024342e9a..a98590940003 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -31,6 +31,10 @@
 #include "probe-file.h"
 #include "string2.h"
 
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+#include <elfutils/debuginfod.h>
+#endif
+
 /* Kprobe tracer basic type is up to u64 */
 #define MAX_BASIC_TYPE_BITS	64
 
@@ -51,6 +55,7 @@ static const Dwfl_Callbacks offline_callbacks = {
 static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
 					 const char *path)
 {
+	GElf_Addr dummy;
 	int fd;
 
 	fd = open(path, O_RDONLY);
@@ -70,6 +75,8 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
 	if (!dbg->dbg)
 		goto error;
 
+	dwfl_module_build_id(dbg->mod, &dbg->build_id, &dummy);
+
 	dwfl_report_end(dbg->dwfl, NULL, NULL);
 
 	return 0;
@@ -942,6 +949,7 @@ static int probe_point_lazy_walker(const char *fname, int lineno,
 /* Find probe points from lazy pattern  */
 static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 {
+	char sbuild_id[SBUILD_ID_SIZE] = "";
 	int ret = 0;
 	char *fpath;
 
@@ -949,7 +957,10 @@ static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 		const char *comp_dir;
 
 		comp_dir = cu_get_comp_dir(&pf->cu_die);
-		ret = get_real_path(pf->fname, comp_dir, &fpath);
+		if (pf->dbg->build_id)
+			build_id__sprintf(pf->dbg->build_id,
+					BUILD_ID_SIZE, sbuild_id);
+		ret = find_source_path(pf->fname, sbuild_id, comp_dir, &fpath);
 		if (ret < 0) {
 			pr_warning("Failed to find source file path.\n");
 			return ret;
@@ -1448,7 +1459,7 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 				 struct probe_trace_event **tevs)
 {
 	struct trace_event_finder tf = {
-			.pf = {.pev = pev, .callback = add_probe_trace_event},
+			.pf = {.pev = pev, .dbg = dbg, .callback = add_probe_trace_event},
 			.max_tevs = probe_conf.max_probes, .mod = dbg->mod};
 	int ret, i;
 
@@ -1618,7 +1629,7 @@ int debuginfo__find_available_vars_at(struct debuginfo *dbg,
 				      struct variable_list **vls)
 {
 	struct available_var_finder af = {
-			.pf = {.pev = pev, .callback = add_available_vars},
+			.pf = {.pev = pev, .dbg = dbg, .callback = add_available_vars},
 			.mod = dbg->mod,
 			.max_vls = probe_conf.max_probes};
 	int ret;
@@ -1973,17 +1984,52 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
 	return (ret < 0) ? ret : lf.found;
 }
 
+/* debuginfod doesn't require the comp_dir but buildid is required */
+static int get_source_from_debuginfod(const char *raw_path,
+				const char *sbuild_id, char **new_path)
+{
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+	debuginfod_client * c = debuginfod_begin();
+	const char *p = raw_path;
+	int fd;
+
+	if (!c)
+		return -ENOMEM;
+
+	fd = debuginfod_find_source(c, (const unsigned char *)sbuild_id,
+				0, p, new_path);
+	pr_debug("Search %s from debuginfod -> %d\n", p, fd);
+	if (fd >= 0)
+		close(fd);
+	debuginfod_end(c);
+	if (fd < 0) {
+		pr_debug("Failed to find %s in debuginfod (%s)\n",
+			raw_path, sbuild_id);
+		return -ENOENT;
+	}
+	pr_debug("Got a source %s\n", *new_path);
+
+	return 0;
+#else
+	return -ENOTSUP;
+#endif
+}
 /*
  * Find a src file from a DWARF tag path. Prepend optional source path prefix
  * and chop off leading directories that do not exist. Result is passed back as
  * a newly allocated path on success.
  * Return 0 if file was found and readable, -errno otherwise.
  */
-int get_real_path(const char *raw_path, const char *comp_dir,
-			 char **new_path)
+int find_source_path(const char *raw_path, const char *sbuild_id,
+		const char *comp_dir, char **new_path)
 {
 	const char *prefix = symbol_conf.source_prefix;
 
+	if (sbuild_id && !prefix) {
+		if (!get_source_from_debuginfod(raw_path, sbuild_id, new_path))
+			return 0;
+	}
+
 	if (!prefix) {
 		if (raw_path[0] != '/' && comp_dir)
 			/* If not an absolute path, try to use comp_dir */
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 11be10080613..2febb5875678 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include "intlist.h"
+#include "build-id.h"
 #include "probe-event.h"
 #include <linux/ctype.h>
 
@@ -32,6 +33,7 @@ struct debuginfo {
 	Dwfl_Module	*mod;
 	Dwfl		*dwfl;
 	Dwarf_Addr	bias;
+	const unsigned char	*build_id;
 };
 
 /* This also tries to open distro debuginfo */
@@ -59,11 +61,12 @@ int debuginfo__find_available_vars_at(struct debuginfo *dbg,
 				      struct variable_list **vls);
 
 /* Find a src file from a DWARF tag path */
-int get_real_path(const char *raw_path, const char *comp_dir,
-			 char **new_path);
+int find_source_path(const char *raw_path, const char *sbuild_id,
+		     const char *comp_dir, char **new_path);
 
 struct probe_finder {
 	struct perf_probe_event	*pev;		/* Target probe event */
+	struct debuginfo	*dbg;
 
 	/* Callback when a probe point is found */
 	int (*callback)(Dwarf_Die *sc_die, struct probe_finder *pf);

