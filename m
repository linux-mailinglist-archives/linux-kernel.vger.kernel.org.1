Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F8E229388
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgGVIcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 04:32:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:10111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVIcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:32:01 -0400
IronPort-SDR: pRCJEv6Xfgr7rvDkECWUlFVT10/5IUGRR3q3wPUjD/xJL8JOFfR7E9GOSl+n60eZHJR4jOeBIz
 /qzXcWdD1q2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147787991"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="147787991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:01 -0700
IronPort-SDR: oSYQKsaUJt4GbZiQzRM0DKFa35YwmLMmSTtlC/YsLi8BAjXmrUUxmFr4Ib19krD3KZHGbAjJjU
 xXg6aKlPw4jA==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303232"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:31:56 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 04/13] soundwire: intel: fix race condition on system resume
Date:   Wed, 22 Jul 2020 04:37:14 +0800
Message-Id: <20200721203723.18305-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Previous patches took care of the case where the master device is
pm_runtime 'suspended' when a system suspend occurs.

In the case where the master device was not suspended, e.g. if suspend
occurred while streaming audio, Intel validation noticed a race
condition: the pm_runtime suspend may conflict with the enumeration
started by the system resume.

This can be simply fixed by updating the status before exiting system
resume.

GitHub issue: https://github.com/thesofproject/linux/issues/1482
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 284e5c9d240a..b7d8ea6b331e 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1531,6 +1531,18 @@ static int intel_resume(struct device *dev)
 		return ret;
 	}
 
+	/*
+	 * after system resume, the pm_runtime suspend() may kick in
+	 * during the enumeration, before any children device force the
+	 * master device to remain active.  Using pm_runtime_get()
+	 * routines is not really possible, since it'd prevent the
+	 * master from suspending.
+	 * A reasonable compromise is to update the pm_runtime
+	 * counters and delay the pm_runtime suspend by several
+	 * seconds, by when all enumeration should be complete.
+	 */
+	pm_runtime_mark_last_busy(dev);
+
 	return ret;
 }
 
-- 
2.17.1

