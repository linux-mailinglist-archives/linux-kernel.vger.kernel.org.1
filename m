Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61E0258BD9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 11:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgIAJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 05:38:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:45308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgIAJil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:38:41 -0400
IronPort-SDR: xtup/mpiL7KePkrtOE6lhiOvbjh/is2AhHiyrRJAZdu8w1PmD/Ts1+49W3GY/qkTtCQRRyWpoU
 yKPcMELZxMoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175181499"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="175181499"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 02:38:41 -0700
IronPort-SDR: QO4LjgCxpBMU6dEhYmPbcaVNCQv3ctQfb672mvAvuSL/zH90g/R87nT56DlQODwVCDSewvA80A
 d3LuNli2T7BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="502181181"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2020 02:38:39 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/6] perf tools: Handle read errors from ctl_fd
Date:   Tue,  1 Sep 2020 12:37:54 +0300
Message-Id: <20200901093758.32293-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901093758.32293-1-adrian.hunter@intel.com>
References: <20200901093758.32293-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle read errors from ctl_fd such as EINTR, EAGAIN and EWOULDBLOCK.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evlist.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 62e3f87547ce..47d1045a19af 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1802,6 +1802,7 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 	char c;
 	size_t bytes_read = 0;
 
+	*cmd = EVLIST_CTL_CMD_UNSUPPORTED;
 	memset(cmd_data, 0, data_size);
 	data_size--;
 
@@ -1813,17 +1814,22 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 			cmd_data[bytes_read++] = c;
 			if (bytes_read == data_size)
 				break;
-		} else {
-			if (err == -1)
+			continue;
+		} else if (err == -1) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EAGAIN || errno == EWOULDBLOCK)
+				err = 0;
+			else
 				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd.fd);
-			break;
 		}
+		break;
 	} while (1);
 
 	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
 		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
 
-	if (err > 0) {
+	if (bytes_read > 0) {
 		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
 			     (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
 			*cmd = EVLIST_CTL_CMD_ENABLE;
@@ -1833,7 +1839,7 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 		}
 	}
 
-	return err;
+	return bytes_read ? (int)bytes_read : err;
 }
 
 static int evlist__ctlfd_ack(struct evlist *evlist)
-- 
2.17.1

