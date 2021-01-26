Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F3F304FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhA0DVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:21:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:22403 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732138AbhAZU5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:57:00 -0500
IronPort-SDR: EXCIfKYWc7SHDoBrYAPOeqXZHTHsRHNpem80Gop2kxodePOjWqvfK7idC3glqI1jJX1vMdM0pl
 gFq6s8ofLIwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="241500151"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="241500151"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 12:55:10 -0800
IronPort-SDR: sKEk9XZ9yGG7sQiEwrN0nAXAf/bO7EQ3NfIU3eVoQdjlJ/ye0W+ocQ77Ht97K4yYPYuR6XJB/G
 UyjnbzZSTf8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="472877740"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2021 12:55:09 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id B58C65807C8;
        Tue, 26 Jan 2021 12:55:09 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     mark.gross@intel.com, hdegoede@redhat.com, lee.jones@linaro.org,
        torvalds@linux-foundation.org
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: intel_pmt_telemetry: Add dependency on MFD_INTEL_PMT
Date:   Tue, 26 Jan 2021 12:55:07 -0800
Message-Id: <20210126205508.30907-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126205508.30907-1-david.e.box@linux.intel.com>
References: <20210126205508.30907-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All devices that expose Intel Platform Monitoring Technology (PMT)
telemetry are currently owned by the intel_pmt MFD driver. Therefore make
the telemetry driver depend on the MFD driver for build.

Fixes: 68fe8e6e2c4b ("platform/x86: Intel PMT Telemetry capability driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index af75c3342c06..9948c5f4928d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1382,6 +1382,7 @@ config INTEL_PMT_CLASS
 
 config INTEL_PMT_TELEMETRY
 	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
+	depends on MFD_INTEL_PMT
 	select INTEL_PMT_CLASS
 	help
 	  The Intel Platform Monitory Technology (PMT) Telemetry driver provides
-- 
2.20.1

