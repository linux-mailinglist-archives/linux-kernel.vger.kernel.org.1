Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9242C8F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbgK3UWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:22:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:60098 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388430AbgK3UWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:22:17 -0500
IronPort-SDR: 4Duw1dXnqLUDFytpW8xv23SEfDv9mcv4MdbCZbpNaXgFu9ns6Pso5RXQA/7GrlIa00QvVxc0V/
 XRZDur+Vgeig==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140754"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:34 -0800
IronPort-SDR: 4FxaxbO4J5rQhsXK9ej2Tf5mdxnRXMqZSwCvuXJTZj+p4BHbHQklGX+Qn/G8JRSyCz+62rHcNx
 3yzuOEhPEFWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793808"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 12:20:33 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "David Binderman" <dcb314@hotmail.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 15/17] selftests/resctrl: Fix unmount resctrl FS
Date:   Mon, 30 Nov 2020 20:20:08 +0000
Message-Id: <20201130202010.178373-16-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

umount_resctrlfs() directly attempts to unmount resctrl file system without
checking if resctrl FS is already mounted or not. It returns 0 on success
and on failure it prints an error message and returns an error status.
Calling umount_resctrlfs() when resctrl FS isn't mounted will return an
error status.

There could be situations where-in the caller might not know if resctrl
FS is already mounted or not and the caller might still want to unmount
resctrl FS if it's already mounted (For example during teardown).

To support above use cases, change umount_resctrlfs() such that it now
first checks if resctrl FS is already mounted or not and unmounts resctrl
FS only if it's already mounted.

unmount resctrl FS upon exit. For example, running only mba test on a
Broadwell (BDW) machine (MBA isn't supported on BDW CPU).

This happens because validate_resctrl_feature_request() would mount resctrl
FS to check if mba is enabled on the platform or not and finds that the H/W
doesn't support mba and hence will return false to run_mba_test(). This in
turn makes the main() function return without unmounting resctrl FS.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 1 +
 tools/testing/selftests/resctrl/resctrlfs.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 63400a51cbd8..7a63d5fcf4e0 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -257,6 +257,7 @@ int main(int argc, char **argv)
 		run_cat_test(cpu_no, no_of_bits);
 
 out:
+	umount_resctrlfs();
 	printf("1..%d\n", tests_run);
 
 	return 0;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 3f43bcf0b8d5..868f6f186e98 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -90,6 +90,9 @@ int remount_resctrlfs(bool mum_resctrlfs)
 
 int umount_resctrlfs(void)
 {
+	if (find_resctrl_mount(NULL))
+		return 0;
+
 	if (umount(RESCTRL_PATH)) {
 		perror("# Unable to umount resctrl");
 
-- 
2.29.2

