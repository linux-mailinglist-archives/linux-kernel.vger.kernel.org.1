Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4A2B2564
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKMU0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:26:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:13739 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKMU0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:55 -0500
IronPort-SDR: LR9y4xNGYzThyjgLcHe4mILatr9UH9UvxRu9fbeOdTV5TCRxf8UVmSNWghnieTJTvZkhRFUI8y
 +1hiPbTPf7PA==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="232145821"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="232145821"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:26:54 -0800
IronPort-SDR: CqhIFSLesgsAuFyqq8Be0JaJui2gdTFsT/b+zQ7EQtpRMQhKbOHH7iq3Bg+hC2PuHSpoU+Sh4O
 hWb6u8ikTJVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="367050268"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2020 12:26:54 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 0/8] Thunderbolt3/USB4 cable rounded and active cable plug link training support
Date:   Fri, 13 Nov 2020 12:24:55 -0800
Message-Id: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the support for Thunderbolt3/USB4 rounded and
non-rounded frequencies cables and fixes the active cable plug link
training support.

Changes in v2:
- Removed the fixes tag as there is no functional implication from patches
  1/8, 2/8 and 4/8.

Utkarsh Patel (8):
  usb: typec: Correct the bit values for the Thunderbolt
    rounded/non-rounded cable support
  platform/chrome: cros_ec_typec: Correct the Thunderbolt
    rounded/non-rounded cable support
  usb: typec: intel_pmc_mux: Configure Thunderbolt cable generation bits
  usb: typec: Remove one bit support for the Thunderbolt
    rounded/non-rounded cable
  usb: typec: Use Thunderbolt 3 cable discover mode VDO in Enter_USB
    message
  platform/chrome: cros_ec_typec: Use Thunderbolt 3 cable discover mode
    VDO in USB4 mode
  usb: typec: intel_pmc_mux: Configure active cable properties for USB4
  usb: typec: Remove active_link_training variable from Enter_USB
    message

 drivers/platform/chrome/cros_ec_typec.c | 17 +++++++++++++----
 drivers/usb/typec/mux/intel_pmc_mux.c   | 21 ++++++++++++++++++---
 include/linux/usb/typec.h               |  8 ++------
 include/linux/usb/typec_tbt.h           |  6 +++++-
 4 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.17.1

