Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297A22FF83C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbhAUWzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:55:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:29380 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbhAUWzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:55:51 -0500
IronPort-SDR: 3SrkVORVsbu3QZzMIkmLymhiUgm0Sv+KgPYpTpU7cjM23ITqZSw8PoGFiS9nDJcJ6ycuipbZhI
 VldkFUak/O1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="166457789"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="166457789"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 14:55:06 -0800
IronPort-SDR: UmkvMWB+q/ykoMzCImF0cga000+BcgttVsifU76tAhX47JNi9nARa9yaGxD1WxMyFC4Cw2GqpN
 upBcMgjh+DNw==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="351627846"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.217.24])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 14:55:05 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v8 0/1] Intel MAX10 BMC Macros for Secure Update
Date:   Thu, 21 Jan 2021 14:54:26 -0800
Message-Id: <20210121225427.302467-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was previously patch 1 of 6 in the patch-series entitled
"Intel MAX10 BMC Secure Update Driver". This is the only patch in
the series that is subject to conflicts with other ongoing changes
and is separated here to simplify maintenance of the patchset.

This patch creates a number of macro definitions that are required
for the Intel MAX10 BMC Secure Update Driver.

Changelog v7 -> v8:
  - Rebased on next-20210121
  - Separated out from patchset: "Intel MAX10 BMC Secure Update Driver"
Changelog v6 -> v7:
  - No change
Changelog v5 -> v6:
  - No change
Changelog v4 -> v5:
  - Renamed USER_FLASH_COUNT to STAGING_FLASH_COUNT
Changelog v3 -> v4:
  - No change
Changelog v2 -> v3:
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
    Update driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions will be called directly.
Changelog v1 -> v2:
  - These functions and macros were previously distributed among
    the patches that needed them. They are now grouped together
    in a single patch containing changes to the Intel MAX10 BMC
    driver.
  - Added DRBL_ prefix to some definitions
  - Some address definitions were moved here from the .c files that
    use them.

Russ Weight (1):
  mfd: intel-m10-bmc: support for MAX10 BMC Secure Updates

 include/linux/mfd/intel-m10-bmc.h | 85 +++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

-- 
2.25.1

