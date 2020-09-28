Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5054227ABB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgI1KVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:21:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:22496 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgI1KVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:21:38 -0400
IronPort-SDR: mEb6xMHiTdlQDExpKlPS3ceolmM7r/s5hJ7RMWQOTp/v8FA1vXYVrO/O5+SRQ70bOOZQEIo//i
 +5MGwvFac3lQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="159351029"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="159351029"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 03:21:38 -0700
IronPort-SDR: 6Gu2ZVPTI0r/8o7SDpYDBe9cF637XDsOJQaAS/U6JcMswPij9ndIyeE4MGGxLmsveVoNWpcsrt
 lhNqNvQsp4Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="456769086"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga004.jf.intel.com with ESMTP; 28 Sep 2020 03:21:34 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        alexey.budankov@linux.intel.com, ak@linux.intel.com,
        acme@kernel.org, mingo@redhat.com,
        alexander.antonov@linux.intel.com, kyle.meyer@hpe.com, rja@hpe.com
Subject: [PATCH] perf/x86/intel/uncore: Fix for iio mapping on Skylake Server
Date:   Mon, 28 Sep 2020 13:21:33 +0300
Message-Id: <20200928102133.61041-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Introduced early attributes /sys/devices/uncore_iio_<pmu_idx>/die* are
initialized by skx_iio_set_mapping(), however, for example, for multiple
segment platforms skx_iio_get_topology() returns -EPERM before a list of
attributes in skx_iio_mapping_group will have been initialized.
As a result the list is being NULL. Thus the warning
"sysfs: (bin_)attrs not set by subsystem for group: uncore_iio_*/" appears
and uncore_iio pmus are not available in sysfs. Clear IIO attr_update
to properly handle the cases when topology information cannot be
retrieved.

Fixes: bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to IIO PMON mapping")
Reported-by: Kyle Meyer <kyle.meyer@hpe.com>
Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Alexei Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 62e88ad919ff..ccfa1d6b6aa0 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3749,7 +3749,9 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 
 	ret = skx_iio_get_topology(type);
 	if (ret)
-		return ret;
+		goto clear_attr_update;
+
+	ret = -ENOMEM;
 
 	/* One more for NULL. */
 	attrs = kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_KERNEL);
@@ -3781,8 +3783,9 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 	kfree(eas);
 	kfree(attrs);
 	kfree(type->topology);
+clear_attr_update:
 	type->attr_update = NULL;
-	return -ENOMEM;
+	return ret;
 }
 
 static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)

base-commit: a1b8638ba1320e6684aa98233c15255eb803fac7
-- 
2.19.1

