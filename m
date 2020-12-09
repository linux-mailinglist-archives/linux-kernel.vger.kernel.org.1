Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA38D2D399A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 05:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgLIEZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 23:25:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:46202 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgLIEZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 23:25:56 -0500
IronPort-SDR: hIRMB28bGSF/40ceza1UZNQ8r/P1MnLpyf6TYdblIZkqJuMxbW6JJ5zV9lEgo7glXycAwJSb3/
 UAbOVCfFl2Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="258725300"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="258725300"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 20:25:15 -0800
IronPort-SDR: yIG/H2Ov61hebtY62L0PKVYih8ymVYJnO8k4m58Ou5011xwutPTNEdPa0lc6Su5MOzxyjbJ5xV
 CpWrwVg7BsSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="376205731"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.15])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2020 20:25:15 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v4 0/1] Thunderbolt3/USB4 cable rounded and active cable plug link training support
Date:   Tue,  8 Dec 2020 20:24:07 -0800
Message-Id: <20201209042408.23079-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the support for Thunderbolt3/USB4 rounded and
non-rounded frequencies cables and fixes the active cable plug link
training support

Changes in v4:
- Removed patches 1/4, 2/4 and 4/4 as the implementation of tbt_mode_vdo
  from Enter_USB message is not needed.
- With that there are no changes in active cable plug link training 
  support.
- Previous version can be found here: 
  https://www.spinics.net/lists/linux-usb/msg204914.html
* Patch 1: "usb: typec: intel_pmc_mux: Configure cable generation value
  for USB4"
  - Removed usage of tbt_mode_vdo since data rates should always be rounded
    in the case of USB4.
  - Updated commit message to reflect the change.

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


Utkarsh Patel (1):
  usb: typec: intel_pmc_mux: Configure cable generation value for USB4

 drivers/usb/typec/mux/intel_pmc_mux.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.17.1

