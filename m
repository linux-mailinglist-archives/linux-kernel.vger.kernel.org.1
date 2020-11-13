Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8853E2B2578
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgKMU1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:27:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:13742 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgKMU04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:56 -0500
IronPort-SDR: sDis2yQ7BfVTfchd60UJUXoqI0hYq0XMtIops3wQu7IR/gWZp5yD0e68HUKFi6GQtjRPzINIIz
 5pejLxsojNNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="232145823"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="232145823"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:26:54 -0800
IronPort-SDR: PwGPkE4CWgjf/mw2PfFOu+jtCzgDAjKQ8RVEreTUy/5RSENrh2eYtPvV3FM35PK6P/BNlguQK2
 LOV/Rw/9nn2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="367050275"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2020 12:26:54 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 2/8] platform/chrome: cros_ec_typec: Correct the Thunderbolt rounded/non-rounded cable support
Date:   Fri, 13 Nov 2020 12:24:57 -0800
Message-Id: <20201113202503.6559-3-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thunderbolt rounded/non-rounded cable support is two bits value. Correcting
it as per the Thunderbolt 3 cable discover mode VDO changes done in the
Thunderbolt 3 alternate mode header.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
--
Changes in v2:
- Removed the fixes tag as there is no functional implication.
--
---
 drivers/platform/chrome/cros_ec_typec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 31be31161350..8111ed1fc574 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -438,8 +438,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
 		data.cable_mode |= TBT_CABLE_LINK_TRAINING;
 
-	if (pd_ctrl->cable_gen)
-		data.cable_mode |= TBT_CABLE_ROUNDED;
+	data.cable_mode |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
 
 	/* Enter Mode VDO */
 	data.enter_vdo = TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
-- 
2.17.1

