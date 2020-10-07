Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF8928575C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgJGDvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:51:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:11774 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgJGDvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:51:07 -0400
IronPort-SDR: sKiShkzW6O+Jk63OXOnW396K7N+GEkcRo4hggebY35UM6Nywvcs45bpj2DbkrjRKv0p57wNios
 9+4xWvnvMxfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="152575797"
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="152575797"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 20:51:07 -0700
IronPort-SDR: wIFl3pE5EnAmfSGqGYM/3x6lioo0E8UGeARQYaSWmMIsMDuOx5XQDAgzNqBDvtbWMOQQE7Xyfn
 /KfWJcqV/uag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="297442070"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2020 20:51:06 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id A71D2580782;
        Tue,  6 Oct 2020 20:51:06 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        dvhart@infradead.org, andy@infradead.org, gayatri.kammela@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/4] pmc_core: Add RocketLake and other changes
Date:   Tue,  6 Oct 2020 20:51:04 -0700
Message-Id: <20201007035108.31078-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RocketLake platform support and other driver maintainance.

Gayatri Kammela (4):
  platform/x86: intel_pmc_core: Clean up: Remove the duplicate comments
    and reorganize
  platform/x86: intel_pmc_core: Add Intel RocketLake (RKL) support
  platform/x86: intel_pmc_core: fix: Replace dev_dbg macro with
    dev_info()
  MAINTAINERS: Update maintainers for pmc_core driver

 MAINTAINERS                           |  4 +--
 drivers/platform/x86/intel_pmc_core.c | 39 ++++++++++++++++-----------
 2 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.20.1

