Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8C12854BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgJFWrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:47:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:56741 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgJFWrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:47:17 -0400
IronPort-SDR: nbTHD4Gbca35bk0eNsJAje1Hft6lcWp1zlJiJMZroNrORtPj7fyCgp3MtJk8sj8ZDC8JNgkqCM
 hI4W4IiMpQZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="162114470"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="162114470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 15:47:17 -0700
IronPort-SDR: nlvM41EbBvxPpf4wxQloshof0OPhPRpv71KCiyrmeiN5E7+BeH80hYznFSw0mubqeaSzhPHwdr
 f4wFD8MBwVnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="518529574"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2020 15:47:17 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 0AC22580569;
        Tue,  6 Oct 2020 15:47:17 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org, gayatri.kammela@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Tiger Lake PMC core driver fixes
Date:   Tue,  6 Oct 2020 15:46:59 -0700
Message-Id: <20201006224702.12697-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds several critical fixes for intel_pmc_core driver.

Patch 1: Uses descriptive register names for the TigerLake low power
	 mode registers. Not critical, but was requested in review of
	 Patch 2.

Patch 2: Fixes the register mapping to the correct IPs in the power
	 gating status register for TigerLake.

Patch 3: Fixes the slps0 residency multiplier to use the correct, platform
	 specific values.

David E. Box (1):
  platform/x86: pmc_core: Use descriptive names for LPM registers

Gayatri Kammela (2):
  platform/x86: intel_pmc_core: Fix TigerLake power gating status map
  platform/x86: intel_pmc_core: Fix the slp_s0 counter displayed value

 drivers/platform/x86/intel_pmc_core.c | 82 ++++++++++++++-------------
 drivers/platform/x86/intel_pmc_core.h |  5 +-
 2 files changed, 47 insertions(+), 40 deletions(-)

-- 
2.20.1

