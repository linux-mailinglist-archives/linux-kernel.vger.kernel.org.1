Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4400F2C8EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgK3UVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:21:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:21510 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbgK3UVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:30 -0500
IronPort-SDR: g2lwROFg8ZV4UiMw8NEk7u2/H0ZOc7LgjxUp/70GR3368v+0ivFfRdeuoMJEKlfaWeO2dmlo+4
 PpmxmdnLChKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151959423"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151959423"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:32 -0800
IronPort-SDR: 5o4lydnJqwavSd2qtQwDGQD73q7to4tg2XW2BXICmXuXiuJuA6gGgPXRHfQgbT1qJaybpYLnwg
 xBwyhCp8hLdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793771"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 12:20:31 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "David Binderman" <dcb314@hotmail.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 06/17] selftests/resctrl: Check for resctrl mount point only if resctrl FS is supported
Date:   Mon, 30 Nov 2020 20:19:59 +0000
Message-Id: <20201130202010.178373-7-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_resctrlfs_support() does the following
1. Checks if the platform supports resctrl file system or not by looking
   for resctrl in /proc/filesystems
2. Calls opendir() on default resctrl file system path
   (i.e. /sys/fs/resctrl)
3. Checks if resctrl file system is mounted or not by looking at
   /proc/mounts

Steps 2 and 3 will fail if the platform does not support resctrl file
system. So, there is no need to check for them if step 1 fails.

Fix this by returning immediately if the platform does not support
resctrl file system.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 2c574d143ff0..c676557b376d 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -579,6 +579,9 @@ bool check_resctrlfs_support(void)
 	printf("%sok kernel supports resctrl filesystem\n", ret ? "" : "not ");
 	tests_run++;
 
+	if (!ret)
+		return ret;
+
 	dp = opendir(RESCTRL_PATH);
 	printf("%sok resctrl mountpoint \"%s\" exists\n",
 	       dp ? "" : "not ", RESCTRL_PATH);
-- 
2.29.2

