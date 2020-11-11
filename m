Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CAE2AE85E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgKKFsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:48:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:10322 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKKFsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:48:21 -0500
IronPort-SDR: 0Q4kqZS5CejBjWxnXlcBjJGfuVQ/sHwqYD8r+8Gur44PfVXiqGUIGGiP96gYOVfi9mVxBS30ia
 cROM+MB8Eb+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="157878642"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="157878642"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:48:18 -0800
IronPort-SDR: WYNzA27gZPv6wwbg7/TmB4OGBuaHUE33HXyvhRsDUZF6NyfNrUG7ydyd/ETie3vk/Hrn1K59nO
 401vsZUTTOgw==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="541641535"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:48:15 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     "Neftin, Sasha" <sasha.neftin@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/4][RFC] Disable e1000e power management if hardware error is detected
Date:   Wed, 11 Nov 2020 13:50:35 +0800
Message-Id: <cover.1605073208.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trial patchset that aims to cope with an intermittently
triggered hardware error during system resume.

On some platforms the NIC's hardware error was detected during
resume from S3, causing the NIC to not fully initialize
and remain in unstable state afterwards. As a consequence
the system fails to suspend due to incorrect NIC status.

In theory if the NIC could not be initialized after resumed,
it should not do system/runtime suspend/resume afterwards.
There are two proposals to deal with this situation:

Either:
1. Each time before the NIC going to suspend, check the status
   of NIC by querying corresponding registers, bypass the suspend
   callback on this NIC if it's unstable.

Or:
2. During NIC resume, if the hardware error was detected, removes
   the NIC from power management list entirely.

Proposal 2 was chosen in this patch set because:
1. Proposal 1 requires that the driver queries the status
   of the NIC in e1000e driver. However there seems to be
   no specific registers for the e1000e to query the result
   of NIC initialization.
2. Proposal 1 just bypass the suspend process but the power management
   framework is still aware of this NIC, which might bring potential issue
   in race condition.
3. Approach 2 is a clean solution and it is platform independent
   that, not only e1000e, but also other drivers could leverage
   this generic mechanism in the future.

Comments appreciated.

Chen Yu (4):
  e1000e: save the return value of e1000e_reset()
  PM: sleep: export device_pm_remove() for driver use
  e1000e: Introduce workqueue to disable the power management
  e1000e: Disable the power management if hardware error detected during
    resume

 drivers/base/power/main.c                  |  1 +
 drivers/base/power/power.h                 |  8 -------
 drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 27 ++++++++++++++++++----
 include/linux/pm.h                         | 12 ++++++++++
 5 files changed, 37 insertions(+), 12 deletions(-)

-- 
2.17.1

