Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7366B2F6EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 00:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbhANXRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:17:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:15489 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbhANXRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:17:38 -0500
IronPort-SDR: h67Nw6/21wjIvJhV/bgNEz+ERF86wCgby/vD6RHeCdmhKVeOGgHVBY4v7Zm6Vn1Ux1ri0aceuC
 cpYosMFVZlcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="242530588"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="242530588"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 15:16:58 -0800
IronPort-SDR: kyOkYqeewQDgqxsjLKph2DMsjEBjs+g0rcSMFECJ9pKb+PGBsLR6kSv8F/aGtiVI7uDnA1TP3L
 BUixNbEfQR+Q==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="352641194"
Received: from jbae-mobl.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.60.253])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 15:16:57 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v4 0/1] mfd: intel-m10-bmc: add sysfs files for mac_address
Date:   Thu, 14 Jan 2021 15:16:47 -0800
Message-Id: <20210114231648.199685-1-russell.h.weight@intel.com>
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

Changelog v3 -> v4:
  - Changed local variables macaddr1 and macaddr2 to macaddr_low
    and macaddr_high
  - Change macros M10BMC_MACADDR1 and M10BMC_MACADDR2 to
    M10BMC_MAC_LOW and M10BMC_MAC_HIGH

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

