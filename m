Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9C304FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhA0DXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:23:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:6630 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387660AbhAZU5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:57:12 -0500
IronPort-SDR: 1EYpuUwSwRB+HSwl4SwJkObAOZJLhN4+x+sB1Eq+ZXr8U5gT67niEMsdxSvF9k95K8UJgTXhPu
 FOjLe01b/szg==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="198763496"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="198763496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 12:55:11 -0800
IronPort-SDR: ld6fRdUvmV6536VBNHEFMwm4Z1lJPqSUM9drzVI0S8nJXLgsxLNxumqrzGXa2EKW4dULy6ZYti
 eTDhvOYFEKuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="410282390"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2021 12:55:11 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 389D65807C8;
        Tue, 26 Jan 2021 12:55:11 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     mark.gross@intel.com, hdegoede@redhat.com, lee.jones@linaro.org,
        torvalds@linux-foundation.org
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: intel_pmt_crashlog: Add dependency on MFD_INTEL_PMT
Date:   Tue, 26 Jan 2021 12:55:08 -0800
Message-Id: <20210126205508.30907-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126205508.30907-1-david.e.box@linux.intel.com>
References: <20210126205508.30907-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All devices that expose Intel Platform Monitoring Technology (PMT)
crashlog are currently owned by the intel_pmt MFD driver. Therefore make
the crashlog driver depend on the MFD driver for build.

Fixes: 5ef9998c96b0 ("platform/x86: Intel PMT Crashlog capability driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 9948c5f4928d..ac4125ec0660 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1394,6 +1394,7 @@ config INTEL_PMT_TELEMETRY
 
 config INTEL_PMT_CRASHLOG
 	tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
+	depends on MFD_INTEL_PMT
 	select INTEL_PMT_CLASS
 	help
 	  The Intel Platform Monitoring Technology (PMT) crashlog driver provides
-- 
2.20.1

