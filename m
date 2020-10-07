Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA428575E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgJGDvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:51:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:16759 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbgJGDvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:51:08 -0400
IronPort-SDR: hLDdevcupMGy/C/0O8Qj0bDegLJje1+4joFL2IGNZCGCWzQhtbk1gf+3c2FMArBLFsYl/cjsoU
 Iz0vXhukutkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="144198376"
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="144198376"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 20:51:07 -0700
IronPort-SDR: l2uAfcutjDDbGY28m4TqpCMlfmGozbKXviKZaz5HJoKZA0zDbINbQlkdvuwztDc677Wd7BsDea
 AmKHTH0ijbUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="354717408"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 06 Oct 2020 20:51:07 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id E9C7358087A;
        Tue,  6 Oct 2020 20:51:06 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        dvhart@infradead.org, andy@infradead.org, gayatri.kammela@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 4/4] MAINTAINERS: Update maintainers for pmc_core driver
Date:   Tue,  6 Oct 2020 20:51:08 -0700
Message-Id: <20201007035108.31078-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007035108.31078-1-david.e.box@linux.intel.com>
References: <20201007035108.31078-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Update MAINTAINERS file for pmc_core driver to reflect the current
maintainers.

Cc: Vishwanath Somayaji <vishwanath.somayaji@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: David E. Box <david.e.box@linux.intel.com>
Acked-by: David E. Box <david.e.box@linux.intel.com>
Acked-by: Vishwanath Somayaji <vishwanath.somayaji@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33b27e62ce19..cd9fcea0d507 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8925,8 +8925,8 @@ F:	arch/x86/include/asm/intel_punit_ipc.h
 F:	drivers/platform/x86/intel_punit_ipc.c
 
 INTEL PMC CORE DRIVER
-M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
-M:	Vishwanath Somayaji <vishwanath.somayaji@intel.com>
+M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
+M:	David E Box <david.e.box@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel_pmc_core*
-- 
2.20.1

