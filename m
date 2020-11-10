Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20982AC9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgKJAis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:38:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:25963 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbgKJAiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:38:46 -0500
IronPort-SDR: aOBQkAW7iTy9oJ5Jhs1URI2lkmfRKJyCGAl03NASg88WHg/KRWhLi7fICAeCbiSszHo4kRNlil
 U0FjPbITjv2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167308560"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="167308560"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 16:38:46 -0800
IronPort-SDR: qYE5tI5DSRYrRZocpoW+TfVXos6L0C7s3Y9Rh1exCBm+0CRMV53vzEx+nw1c6srS7EeY1VomgP
 HlHzb0dzB3wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="354312331"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2020 16:38:46 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 2/8] platform/chrome: cros_ec_typec: Correct the Thunderbolt rounded/non-rounded cable support
Date:   Mon,  9 Nov 2020 16:37:10 -0800
Message-Id: <20201110003716.5164-3-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thunderbolt rounded/non-rounded cable support is two bits value. Correcting
it as per the Thunderbolt 3 cable discover mode VDO changes done in the
Thunderbolt 3 alternate mode header.

Fixes: 5b30bd35aab4 ("platform/chrome: cros_ec_typec: Add TBT compat support")
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
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

