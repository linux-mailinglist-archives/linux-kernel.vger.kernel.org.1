Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98882B8BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKSGeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:34:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:60908 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgKSGeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:34:01 -0500
IronPort-SDR: /L5LUNTVVq0s8aY0quwOFn8O1vueQf4Y5xmge95LLhbXOlZBmvcJROp4CmNmODmTA6TVKlpQMk
 pmduFnbbthEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159012434"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="159012434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 22:34:01 -0800
IronPort-SDR: KZzoLQoZ0h1Ju8oxEB9l/PYn1IJ6qGGP+RLqskGpx5w/5XU8jmXCgzOCd2tVEDMvCTNdSpE40Q
 GCxdHPtRSr2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="544877897"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2020 22:34:01 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbolt 3 cable discover mode VDO in USB4 mode
Date:   Wed, 18 Nov 2020 22:32:09 -0800
Message-Id: <20201119063211.2264-3-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure Thunderbolt 3 cable generation value by filling Thunderbolt 3
cable discover mode VDO to support rounded Thunderbolt 3 cables.
While we are here use Thunderbolt 3 cable discover mode VDO to fill active
cable plug link training value.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

--
Changes in v3:
- Added a check for cable's TBT support before filling TBT3 discover mode
  VDO.

Changes in v2:
- No change.
--
---
 drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 8111ed1fc574..68b17ee1d1ae 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
 	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
 		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
 
-	data.active_link_training = !!(pd_ctrl->control_flags &
-				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
+	/*
+	 * Filling TBT3 Cable VDO when TBT3 cable is being used to establish
+	 * USB4 connection.
+	 */
+	if (pd_ctrl->cable_gen) {
+		data.tbt_cable_vdo = TBT_MODE;
+
+		if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
+			data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
+
+		data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
+	}
 
 	port->state.alt = NULL;
 	port->state.data = &data;
-- 
2.17.1

