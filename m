Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1C2AE869
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgKKFto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:49:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:60892 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKKFtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:49:43 -0500
IronPort-SDR: wxDOy10vg5XKZsj3fvB0KHbfJEhF5S3PKzIL3AYbUwEO9636maCJ4eG2z9bFtzPywiv4XTLgpK
 4eMcX5NVAb0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="169314878"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="169314878"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:49:42 -0800
IronPort-SDR: EFXgvL/vAHXVTKliiw1HruU9JpJ8S27UtCWTJV+oO6JxtDhNUxMZD+lgUSNc3L01R8rUrqUtvT
 dyKj0eSi6S+A==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="308336506"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:49:39 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     "Neftin, Sasha" <sasha.neftin@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 4/4][RFC] e1000e: Disable the power management if hardware error detected during resume
Date:   Wed, 11 Nov 2020 13:52:07 +0800
Message-Id: <7eb46aa2f49f6c7a2ff0d6cc65ad4195781ae960.1605073208.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1605073208.git.yu.c.chen@intel.com>
References: <cover.1605073208.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the hardware error is detected during resume, the NIC might
be in a unstable status and blocks the subsequent suspend afterwards.
A broken device is not expected to impact the system wide suspend, and
this patch disable the power management support of this NIC. So that
the borken NIC will not be considered during suspend/resume, thus not
to prevent the system from suspend/resume.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205015
Reported-by: "Brandt, Todd E" <todd.e.brandt@intel.com>
Reported-by: Len Brown <len.brown@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 45e0b1901440..08bc544e879a 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6959,7 +6959,8 @@ static int __e1000_resume(struct pci_dev *pdev)
 		ew32(WUS, ~0);
 	}
 
-	e1000e_reset(adapter);
+	if (_e1000e_reset(adapter))
+		schedule_work(&adapter->pm_remove_task);
 
 	e1000_init_manageability_pt(adapter);
 
-- 
2.17.1

