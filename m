Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2174126691E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 21:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgIKTqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 15:46:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:13920 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgIKTqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 15:46:16 -0400
IronPort-SDR: wqSBIarHw/RonIYW1IVO9IkpwtIDX+DoFvI6ZEbs3+JJPdRE+rsB9rWqGywaKUTgfSMmkVV3TB
 d13bZURJAFTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="156291247"
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="156291247"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 12:46:15 -0700
IronPort-SDR: iCANa8t5yJTApkC2iVzIOWXeKzQHIaU3Qvs3D4ap5Dg51J7W2oPKv9Nq5OO5yyj8DTtsNuTAlS
 BD789xj1r2sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="286987449"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2020 12:46:15 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id EDCBB580039;
        Fri, 11 Sep 2020 12:46:14 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org,
        alexander.h.duyck@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/3] intel_pmt: Add Alder Lake and OOB-MSM support
Date:   Fri, 11 Sep 2020 12:45:46 -0700
Message-Id: <20200911194549.12780-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Intel Platform Monitoring Technology (PMT) PCI ids for Alder Lake and
the Out Of Band Management Services Module used by Sapphire Rapdis and
other platforms.

This patchset applies on top of the patchset linked below which was
accepted and awaiting merge in mfd next.

Link: https://lore.kernel.org/lkml/20200819180255.11770-1-david.e.box@linux.intel.com/

Alexander Duyck (1):
  platform/x86: Intel PMT Crashlog capability driver

David E. Box (2):
  mfd: intel_pmt: Add OOBMSM device ID
  mfd: intel_pmt: Add Alder Lake (ADL) support

 .../ABI/testing/sysfs-class-pmt_crashlog      |  66 ++
 drivers/mfd/intel_pmt.c                       |   6 +
 drivers/platform/x86/Kconfig                  |  10 +
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/intel_pmt_crashlog.c     | 588 ++++++++++++++++++
 5 files changed, 671 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_crashlog
 create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c

-- 
2.20.1

