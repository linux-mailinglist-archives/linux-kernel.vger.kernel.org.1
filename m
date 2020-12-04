Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BA2CF4CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgLDTby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:31:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:1543 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbgLDTby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:31:54 -0500
IronPort-SDR: j9EnRfIssOpAy+tS6ouF/fipfTP+AsAqAb2o13G4FgFtUsFHLwOLP8mLsj8GgZ8O1xd7mwemfL
 DutbwDjIPRXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="191679502"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="191679502"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 11:31:12 -0800
IronPort-SDR: 5/6J6mkb/nPuJ9YZM/5796enck5FOaDgwjQuIg+8RD1jZgBez6bgQpigTOBOlApAR66BbEh13A
 jgetLFtfjLPw==
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="331314883"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.16.218])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 11:31:11 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 0/1] mfd: intel-m10-bmc: add sysfs files for mac_address
Date:   Fri,  4 Dec 2020 11:31:08 -0800
Message-Id: <20201204193109.4086-1-russell.h.weight@intel.com>
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

