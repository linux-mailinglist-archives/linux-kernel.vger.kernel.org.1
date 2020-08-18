Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8035924847E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgHRMKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 08:10:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:58731 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgHRMKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:10:07 -0400
IronPort-SDR: yXSoLmJDW/y7pDlJuMd3DeecgGvtfiVBXFbq9YVXuH4PXnTS0shOC456pO24arMflciTj2EnuR
 a6ZQjK1ihMKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200377"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200377"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:10:07 -0700
IronPort-SDR: Njiq7GMnBLPqEhbcHfL3QIC/M0pxNriDc+y2ciisbfs4X6mDkAjrvqOzTBKVqvLDW2dhk/5LXL
 AwupFcFwDOBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326712983"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:10:05 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 05/13] mei: bump hbm version to 2.2
Date:   Tue, 18 Aug 2020 14:51:39 +0300
Message-Id: <20200818115147.2567012-6-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200818115147.2567012-1-tomas.winkler@intel.com>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Bump HBM version to 2.2 to indicate vtag support.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index c3c628132b50..8bac86c4d86b 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -25,7 +25,7 @@
 /*
  * MEI Version
  */
-#define HBM_MINOR_VERSION                   1
+#define HBM_MINOR_VERSION                   2
 #define HBM_MAJOR_VERSION                   2
 
 /*
-- 
2.25.4

