Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07B92C8EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgK3UVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:21:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:21506 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbgK3UVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:13 -0500
IronPort-SDR: B4daLBJiklVsk1+u7cByMV6Y2lgbGMtyZniMU5RYgucLe8pzDB0rjHQgUw6KJrcShgDgJdIHv4
 XDCKKxtIolTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151959425"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151959425"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:32 -0800
IronPort-SDR: 1go8FaEdg9V8QKB4v49pxXOd68m1NIrAnoksSSRWCoSFBNVWN4mVLYVe2+iWXE4DKFRWT0+qES
 JFCy8Xhx8XlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793780"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 12:20:32 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "David Binderman" <dcb314@hotmail.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 08/17] selftests/resctrl: Ensure sibling CPU is not same as original CPU
Date:   Mon, 30 Nov 2020 20:20:01 +0000
Message-Id: <20201130202010.178373-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

The resctrl tests can accept a CPU on which the tests are run and use
default of CPU #1 if it is not provided. In the CAT test a "sibling CPU"
is determined that is from the same package where another thread will be
run.

The current algorithm with which a "sibling CPU" is determined does not
take the provided/default CPU into account and when that CPU is the
first CPU in a package then the "sibling CPU" will be selected to be the
same CPU since it starts by picking the first CPU from core_siblings_list.

Fix the "sibling CPU" selection by taking the provided/default CPU into
account and ensuring a sibling that is a different CPU is selected.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index d2cae4927b62..3f43bcf0b8d5 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -268,7 +268,7 @@ int get_core_sibling(int cpu_no)
 	while (token) {
 		sibling_cpu_no = atoi(token);
 		/* Skipping core 0 as we don't want to run test on core 0 */
-		if (sibling_cpu_no != 0)
+		if (sibling_cpu_no != 0 && sibling_cpu_no != cpu_no)
 			break;
 		token = strtok(NULL, "-,");
 	}
-- 
2.29.2

