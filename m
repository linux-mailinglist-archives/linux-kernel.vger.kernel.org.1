Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57761B456F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 14:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDVMwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 08:52:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:14544 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgDVMwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:52:07 -0400
IronPort-SDR: aAMmmskMx3Iaki/APs4BIit1MsiwF063mNSF6EqQZfOX44dEAUwVbM4kgc7k3YmYCW9MObNtIC
 D67Q1L8vHpcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 05:52:06 -0700
IronPort-SDR: 7amkLPUudwiUzh/H41MnGZ0jaz06OMzOmPN9cE6CAyqNE6X+iGOlLmcndV5SrvD92OEs+YaNO3
 /K8uEKKwcx9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="244505747"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 22 Apr 2020 05:52:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 78B6058F; Wed, 22 Apr 2020 15:52:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 1/7] drm: shmobile: Reduce include dependencies
Date:   Wed, 22 Apr 2020 15:51:55 +0300
Message-Id: <20200422125201.37618-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file doesn't need anything provided by <linux/kernel.h>.
All it needs are some types, which are provided by <drm/drm_mode.h>.

Drop unneeded <linux/kernel.h> completely.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v4: new patch (reviewed by driver maintainer)
 include/linux/platform_data/shmob_drm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/platform_data/shmob_drm.h b/include/linux/platform_data/shmob_drm.h
index fe815d7d9f58c..d661399b217df 100644
--- a/include/linux/platform_data/shmob_drm.h
+++ b/include/linux/platform_data/shmob_drm.h
@@ -10,8 +10,6 @@
 #ifndef __SHMOB_DRM_H__
 #define __SHMOB_DRM_H__
 
-#include <linux/kernel.h>
-
 #include <drm/drm_mode.h>
 
 enum shmob_drm_clk_source {
-- 
2.26.1

