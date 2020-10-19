Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB041292AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgJSPmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:42:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730224AbgJSPme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:42:34 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CD300BCC271466CF4279;
        Mon, 19 Oct 2020 23:42:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 23:42:17 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <irogers@google.com>, <yao.jin@linux.intel.com>,
        <yeyunfeng@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/2] perf jevents: Tidy error handling
Date:   Mon, 19 Oct 2020 23:38:27 +0800
Message-ID: <1603121908-53543-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1603121908-53543-1-git-send-email-john.garry@huawei.com>
References: <1603121908-53543-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is much duplication in the error handling for directory traversing
for processing JSONs.

Factor out the common code to tidy a bit.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 81 ++++++++++++++-------------------
 1 file changed, 33 insertions(+), 48 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e47644cab3fa..ed2374661665 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -1100,12 +1100,13 @@ static int process_one_file(const char *fpath, const struct stat *sb,
  */
 int main(int argc, char *argv[])
 {
-	int rc, ret = 0;
+	int rc, ret = 0, empty_map = 0;
 	int maxfds;
 	char ldirname[PATH_MAX];
 	const char *arch;
 	const char *output_file;
 	const char *start_dirname;
+	char *err_string_ext = "";
 	struct stat stbuf;
 
 	prog = basename(argv[0]);
@@ -1133,7 +1134,8 @@ int main(int argc, char *argv[])
 	/* If architecture does not have any event lists, bail out */
 	if (stat(ldirname, &stbuf) < 0) {
 		pr_info("%s: Arch %s has no PMU event lists\n", prog, arch);
-		goto empty_map;
+		empty_map = 1;
+		goto err_close_eventsfp;
 	}
 
 	/* Include pmu-events.h first */
@@ -1150,75 +1152,58 @@ int main(int argc, char *argv[])
 	 */
 
 	maxfds = get_maxfds();
-	mapfile = NULL;
 	rc = nftw(ldirname, preprocess_arch_std_files, maxfds, 0);
-	if (rc && verbose) {
-		pr_info("%s: Error preprocessing arch standard files %s\n",
-			prog, ldirname);
-		goto empty_map;
-	} else if (rc < 0) {
-		/* Make build fail */
-		fclose(eventsfp);
-		free_arch_std_events();
-		return 1;
-	} else if (rc) {
-		goto empty_map;
-	}
+	if (rc)
+		goto err_processing_std_arch_event_dir;
 
 	rc = nftw(ldirname, process_one_file, maxfds, 0);
-	if (rc && verbose) {
-		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
-		goto empty_map;
-	} else if (rc < 0) {
-		/* Make build fail */
-		fclose(eventsfp);
-		free_arch_std_events();
-		ret = 1;
-		goto out_free_mapfile;
-	} else if (rc) {
-		goto empty_map;
-	}
+	if (rc)
+		goto err_processing_dir;
 
 	sprintf(ldirname, "%s/test", start_dirname);
 
 	rc = nftw(ldirname, process_one_file, maxfds, 0);
-	if (rc && verbose) {
-		pr_info("%s: Error walking file tree %s rc=%d for test\n",
-			prog, ldirname, rc);
-		goto empty_map;
-	} else if (rc < 0) {
-		/* Make build fail */
-		free_arch_std_events();
-		ret = 1;
-		goto out_free_mapfile;
-	} else if (rc) {
-		goto empty_map;
-	}
+	if (rc)
+		goto err_processing_dir;
 
 	if (close_table)
 		print_events_table_suffix(eventsfp);
 
 	if (!mapfile) {
 		pr_info("%s: No CPU->JSON mapping?\n", prog);
-		goto empty_map;
+		empty_map = 1;
+		goto err_close_eventsfp;
 	}
 
-	if (process_mapfile(eventsfp, mapfile)) {
+	rc = process_mapfile(eventsfp, mapfile);
+	fclose(eventsfp);
+	if (rc) {
 		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
 		/* Make build fail */
-		fclose(eventsfp);
-		free_arch_std_events();
 		ret = 1;
+		goto err_out;
 	}
 
+	free_arch_std_events();
+	free(mapfile);
+	return 0;
 
-	goto out_free_mapfile;
-
-empty_map:
+err_processing_std_arch_event_dir:
+	err_string_ext = " for std arch event";
+err_processing_dir:
+	if (verbose || rc > 0) {
+		pr_info("%s: Error walking file tree %s%s\n", prog, ldirname,
+			err_string_ext);
+		empty_map = 1;
+	} else {
+		ret = 1;
+	}
+err_close_eventsfp:
 	fclose(eventsfp);
-	create_empty_mapping(output_file);
+	if (empty_map)
+		create_empty_mapping(output_file);
+err_out:
 	free_arch_std_events();
-out_free_mapfile:
 	free(mapfile);
 	return ret;
 }
-- 
2.26.2

