Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4D72AC9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgKJAjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:39:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:25963 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731115AbgKJAi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:38:59 -0500
IronPort-SDR: yK5iQr4Kw7DEnmET5ukiH0HgIYPEQegBgk5CrLuTuxftEkcyafwrKqW2dIXw2qQ6ByI/zmLCQv
 0hiVUy/S+myg==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167308616"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="167308616"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 16:38:55 -0800
IronPort-SDR: Fll814JwIQALSl+wpFokCLz5V0TOSBTozvUSSixxMgTKVHOtrRXJQdWC92ycZ0X2RnKysrwKD+
 xtrXMCuDPDBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="354312366"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2020 16:38:54 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 6/8] platform/chrome: cros_ec_typec: Use Thunderbolt 3 cable discover mode VDO in USB4 mode
Date:   Mon,  9 Nov 2020 16:37:14 -0800
Message-Id: <20201110003716.5164-7-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure Thunderbolt3/USB4 cable generation value by filing Thunderbolt 3
cable discover mode VDO to support rounded and non-rounded Thunderbolt3/
USB4 cables.
While we are here use Thunderbolt 3 cable discover mode VDO to fill active
cable plug link training value.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 8111ed1fc574..b7416e82c3b3 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
 	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
 		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
 
-	data.active_link_training = !!(pd_ctrl->control_flags &
-				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
+	/*
+	 * This driver does not have access to the identity information or
+	 * capabilities of the cable, so we don't know is it a real USB4 or
+	 * TBT3 cable. Therefore pretending that it's always TBT3 cable by
+	 * filling the TBT3 Cable VDO.
+	 */
+	data.tbt_cable_vdo = TBT_MODE;
+
+	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
+		data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
+
+	data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
 
 	port->state.alt = NULL;
 	port->state.data = &data;
-- 
2.17.1

