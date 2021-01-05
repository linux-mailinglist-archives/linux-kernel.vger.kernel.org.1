Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2652EB58C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbhAEW4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:56:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:6834 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbhAEW4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:56:18 -0500
IronPort-SDR: Uhl6qMooXNVsaQ4NMZDgSBUXwftrFQEBk+p7SADfGAxDddqSuBsZasnU2R1DhtxhnZVF6hP2Lp
 mT4PCXwKtSFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="241272608"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="241272608"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 14:55:36 -0800
IronPort-SDR: xF7Wws8HTipZzJSvtFk9iGW2nKaTb/L6PI40JoSCvtDHo2tiuUp0EgFEv8FAmiTXu1Bhb4d0Rt
 yDjCim89mRHA==
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="398007011"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.23.122])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 14:55:35 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 0/1] mfd: intel-m10-bmc: add sysfs files for mac_address
Date:   Tue,  5 Jan 2021 14:55:19 -0800
Message-Id: <20210105225520.14473-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two sysfs nodes to the Intel MAX10 BMC driver: mac_address
and mac_count. The mac_address provides the first of a series
of sequential MAC addresses assigned to the FPGA card. The
mac_count indicates how many MAC addresses are assigned to the
card.

Changelog v2 -> v3:
  - Updated Date and KernelVersion in ABI documentation

Changelog v1 -> v2:
  - Updated the documentation for the mac_address and mac_count
    sysfs nodes to clearify their usage.
  - Changed sysfs _show() functions to use sysfs_emit() instead
    of sprintf.

Russ Weight (1):
  mfd: intel-m10-bmc: expose mac address and count

 .../ABI/testing/sysfs-driver-intel-m10-bmc    | 21 +++++++++
 drivers/mfd/intel-m10-bmc.c                   | 43 +++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |  9 ++++
 3 files changed, 73 insertions(+)

-- 
2.25.1

