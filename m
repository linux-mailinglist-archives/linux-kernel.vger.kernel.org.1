Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A695268152
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgIMVGV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:06:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28959 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726070AbgIMVFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:05:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-rFevDjpFP3yg-mEIYQIY7w-1; Sun, 13 Sep 2020 17:05:17 -0400
X-MC-Unique: rFevDjpFP3yg-mEIYQIY7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1A3D1005E62;
        Sun, 13 Sep 2020 21:05:14 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E72310021AA;
        Sun, 13 Sep 2020 21:05:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 24/26] perf tools: Add buildid-list --store option
Date:   Sun, 13 Sep 2020 23:03:11 +0200
Message-Id: <20200913210313.1985612-25-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-1-jolsa@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding buildid-list --store option to populate
.debug data with build id files.

  $ rm -rf ~/.debug/

  $ perf buildid-list
  1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
  d278249792061c6b74d1693ca59513be1def13f2 /usr/lib64/libc-2.31.so

  $ perf buildid-list --store

  $ find ~/.debug/
  .../.debug/
  .../.debug/usr
  .../.debug/usr/lib64
  .../.debug/usr/lib64/ld-2.31.so
  .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b
  .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b/elf
  .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b/debug
  .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b/probes
  .../.debug/usr/lib64/libc-2.31.so
  .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2
  .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2/elf
  .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2/debug
  .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2/probes
  .../.debug/.build-id
  .../.debug/.build-id/18
  .../.debug/.build-id/18/05c738c8f3ec0f47b7ea09080c28f34d18a82b
  .../.debug/.build-id/d2
  .../.debug/.build-id/d2/78249792061c6b74d1693ca59513be1def13f2

It's possible to query debuginfod daemon for binaries by defining
DEBUGINFOD_URLS variable with server URL, like:

  $ DEBUGINFOD_URLS=http://192.168.122.174:8002 perf buildid-list --store
  OK   439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 .../.debug/.build-id/43/9fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/elf
  FAIL 23b87f5b0560481043257e82be670bc97786a171 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/net/ipv4/netfilter/ip_tables.ko.xz
  FAIL d2b3be372bcdd4ebc15e479d2ff803657de0fd1e /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/drivers/block/virtio_blk.ko.xz
  FAIL 1466a71bcd0ff5c975ee79b72752137c0143d225 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/fs/xfs/xfs.ko.xz
  OK   ad60d10b38c93bd8738d5aa594e240f01bb328cd /usr/lib/systemd/systemd
  OK   589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
  OK   3b9b2ef537520303411ad5038b596d5d18e7c2b8 /usr/lib64/libpcre2-8.so.0.10.0

Increasing debug level in util/probe-event.c to get rid
of the sdt probes messages on single verbose level (-v).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../perf/Documentation/perf-buildid-list.txt  |  12 ++
 tools/perf/builtin-buildid-list.c             | 169 +++++++++++++++++-
 tools/perf/util/probe-event.c                 |   6 +-
 3 files changed, 181 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-buildid-list.txt b/tools/perf/Documentation/perf-buildid-list.txt
index 25c52efcc7f0..9bb8948e2e75 100644
--- a/tools/perf/Documentation/perf-buildid-list.txt
+++ b/tools/perf/Documentation/perf-buildid-list.txt
@@ -33,6 +33,18 @@ OPTIONS
 -k::
 --kernel::
 	Show running kernel build id.
+
+--store::
+	Store DSOs into .debug cache.
+
+	The option goes through all build ids and try to locate related binary,
+	if found, it's stored in the build id database (~/.debug).
+
+	It's possible to query debuginfod daemon for binaries by defining
+	DEBUGINFOD_URLS variable with server URL, like:
+
+	  $ DEBUGINFOD_URLS=http://192.168.122.174:8002 perf buildid-list --store
+
 -v::
 --verbose::
 	Be more verbose.
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index adcc64478ec1..af326e7b5c44 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -17,8 +17,15 @@
 #include "util/session.h"
 #include "util/symbol.h"
 #include "util/data.h"
+#include "util/namespaces.h"
 #include <errno.h>
 #include <linux/err.h>
+#include <linux/zalloc.h>
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+#include <elfutils/debuginfod.h>
+#endif
+#include <unistd.h>
+#include <sys/stat.h>
 
 static int sysfs__fprintf_build_id(FILE *fp)
 {
@@ -49,7 +56,155 @@ static bool dso__skip_buildid(struct dso *dso, int with_hits)
 	return with_hits && !dso->hit;
 }
 
-static int perf_session__list_build_ids(bool force, bool with_hits)
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+static int get_executable(const char *sbuild_id, char **path)
+{
+	debuginfod_client *c;
+	int fd;
+
+	c = debuginfod_begin();
+	if (c == NULL)
+		return -1;
+
+	pr_debug("trying debuginfod for executable <%s> ... ", sbuild_id);
+
+	fd = debuginfod_find_executable(c, (const unsigned char *) sbuild_id,
+					0, path);
+	if (fd >= 0)
+		close(fd); /* retaining reference by realname */
+
+	debuginfod_end(c);
+	pr_debug("%s%s\n", *path ? "OK " : "FAILED", *path ? *path : "");
+	return *path ? 0 : -1;
+}
+#else
+static int get_executable(const char *sbuild_id __maybe_unused,
+			  char **path __maybe_unused)
+{
+	return -1;
+}
+#endif
+
+struct dso_store_data {
+	bool with_hits;
+};
+
+static int dso__store(struct dso *dso, struct machine *machine __maybe_unused, void *priv)
+{
+	struct dso_store_data *data = priv;
+	char sbuild_id[SBUILD_ID_SIZE];
+	u8 bid[BUILD_ID_SIZE];
+	char *path = NULL;
+	bool is_kallsyms;
+	int err = -1;
+
+	if (!dso->has_build_id ||
+	    !build_id__is_defined(dso->build_id))
+		return 0;
+
+	if (data->with_hits && !dso->hit)
+		return 0;
+
+	/*
+	 * The storing process is:
+	 *   - get build id of the dso
+	 *   - check if it matches provided build id from mmap3 event
+	 *   - if not, try debuginfod to download the binary
+	 *   - store binary to build id database
+	 */
+	is_kallsyms = !strcmp(machine->mmap_name, dso->short_name);
+	build_id__sprintf(dso->build_id, sizeof(dso->build_id), sbuild_id);
+
+	if (is_kallsyms) {
+		/*
+		 * Find out if we are on the same kernel as perf.data
+		 * and keel kallsyms in that case.
+		 */
+		path = strdup(dso->long_name);
+		if (!path)
+			goto out_err;
+
+		err = sysfs__read_build_id("/sys/kernel/notes", &bid, sizeof(bid));
+		if (err < 0)
+			goto out_err;
+	} else {
+		struct stat st;
+
+		/*
+		 * Does the file exists in the first place, if it does,
+		 * resolve path and read the build id.
+		 */
+		if (stat(dso->long_name, &st)) {
+			zfree(&path);
+			goto try_download;
+		}
+
+		path = nsinfo__realpath(dso->long_name, dso->nsinfo);
+		if (!path)
+			goto out_err;
+
+		err = filename__read_build_id(path, &bid, sizeof(bid));
+		if (err != sizeof(bid))
+			goto out_err;
+	}
+
+	/*
+	 * If we match then we want in mmap3 event,
+	 * is what we got in the binary, so we're happy.
+	 */
+	if (memcmp(&bid, dso->build_id, BUILD_ID_SIZE)) {
+		char sbid[SBUILD_ID_SIZE];
+
+		build_id__sprintf(bid, sizeof(bid), sbid);
+		pr_debug("mmap build id <%s> does not match for %s <%s>\n",
+			 sbuild_id, path, sbid);
+		zfree(&path);
+	}
+
+try_download:
+	/*
+	 * We did not match build id or did not find the
+	 * binary - try debuginfod as last resort.
+	 */
+	if (!path) {
+		char *tmp = NULL;
+
+		/*
+		 * The debuginfo retrieval is handled within
+		 * build_id_cache__add function.
+		 */
+		if (get_executable(sbuild_id, &tmp)) {
+			err = -1;
+			goto out_err;
+		}
+
+		path = tmp;
+
+		/*
+		 * The kernel dso is now elf binary, so disable is_kallsyms
+		 * so build_id_cache__add can prepare proper file names.
+		 */
+		is_kallsyms = false;
+	}
+
+	pr_debug("linking %s %s <%s>\n", dso->short_name, path, sbuild_id);
+
+	err = build_id_cache__add(sbuild_id, path, path,
+				  dso->nsinfo, is_kallsyms, false);
+out_err:
+	free(path);
+	fprintf(stderr, "%s %s %s\n", err ? "FAIL" : "OK  ", sbuild_id, dso->long_name);
+	return 0;
+}
+
+static int perf_session__store(struct perf_session *session, bool with_hits)
+{
+	struct dso_store_data data = { .with_hits = with_hits, };
+
+	return __perf_session__cache_build_ids(session, dso__store, &data);
+}
+
+static int perf_session__list_build_ids(bool force, bool with_hits, bool store)
 {
 	struct perf_session *session;
 	struct perf_data data = {
@@ -94,7 +249,13 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 	if (with_hits || perf_data__is_pipe(&data))
 		perf_session__process_events(session);
 
-	perf_session__fprintf_dsos_buildid(session, stdout, dso__skip_buildid, with_hits);
+	if (store) {
+		perf_session__store(session, with_hits);
+	} else {
+		perf_session__fprintf_dsos_buildid(session, stdout, dso__skip_buildid,
+						   with_hits);
+	}
+
 	perf_session__delete(session);
 out:
 	return 0;
@@ -105,11 +266,13 @@ int cmd_buildid_list(int argc, const char **argv)
 	bool show_kernel = false;
 	bool with_hits = false;
 	bool force = false;
+	bool store = false;
 	const struct option options[] = {
 	OPT_BOOLEAN('H', "with-hits", &with_hits, "Show only DSOs with hits"),
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
 	OPT_BOOLEAN('k', "kernel", &show_kernel, "Show current kernel build id"),
+	OPT_BOOLEAN(0, "store", &store, "Store build id dsos in .debug cache"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_END()
 	};
@@ -124,5 +287,5 @@ int cmd_buildid_list(int argc, const char **argv)
 	if (show_kernel)
 		return !(sysfs__fprintf_build_id(stdout) > 0);
 
-	return perf_session__list_build_ids(force, with_hits);
+	return perf_session__list_build_ids(force, with_hits, store);
 }
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 99d36ac77c08..a7d7ebffd005 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1555,9 +1555,9 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 		return -EINVAL;
 	}
 
-	pr_debug("symbol:%s file:%s line:%d offset:%lu return:%d lazy:%s\n",
-		 pp->function, pp->file, pp->line, pp->offset, pp->retprobe,
-		 pp->lazy_line);
+	pr_debug2("symbol:%s file:%s line:%d offset:%lu return:%d lazy:%s\n",
+		  pp->function, pp->file, pp->line, pp->offset, pp->retprobe,
+		  pp->lazy_line);
 	return 0;
 }
 
-- 
2.26.2

