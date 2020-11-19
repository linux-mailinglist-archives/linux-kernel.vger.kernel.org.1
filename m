Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969F82B8BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgKSGd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:33:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:60908 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgKSGd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:33:57 -0500
IronPort-SDR: DrZzt4gosLdmdren37IkzcUsMkiKlWL3WWyjcjmPRrKqSJWNjID39/fa8VBbEIiIpox6sUnYzA
 OK9mJnxLaO+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159012423"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="159012423"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 22:33:56 -0800
IronPort-SDR: wbDiW33NWiofA9oWiYwfz//xWCHSPo1NwOsIHCn68QA2oiaP6xlrFu1rqcwCFyY4N+LqxJ5t6+
 9kBzxJjMZRLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="544877871"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2020 22:33:56 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 0/4] Thunderbolt3/USB4 cable rounded and active cable plug link training support
Date:   Wed, 18 Nov 2020 22:32:07 -0800
Message-Id: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the support for Thunderbolt3/USB4 rounded and
non-rounded frequencies cables and fixes the active cable plug link
training support.

Changes in v3:
- First four patches of this series have been queued by Greg to usb-testing
  branch. https://www.spinics.net/lists/linux-usb/msg204880.html
- Changed commit message and description in header file in patch 1/4.
- Added a check for Cable's TBT support in patch 2/4
- Moved TBT_CABLE_ROUNDED_SUPPORT assignment to same line in patch 3/4.
- Rebased and added Reviewed-by tag in patch 4/4.

Changes in v2:
- Removed the fixes tag as there is no functional implication from patches
  1/8, 2/8 and 4/8.

Utkarsh Patel (4):
  usb: typec: Use Thunderbolt 3 cable discover mode VDO in Enter_USB
    message
  platform/chrome: cros_ec_typec: Use Thunderbolt 3 cable discover mode
    VDO in USB4 mode
  usb: typec: intel_pmc_mux: Configure active cable properties for USB4
  usb: typec: Remove active_link_training variable from Enter_USB
    message

 drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
 drivers/usb/typec/mux/intel_pmc_mux.c   | 17 ++++++++++++++---
 include/linux/usb/typec.h               | 11 +++++------
 3 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.17.1

