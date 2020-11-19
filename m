Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE52B8BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgKSGeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:34:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:60908 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgKSGeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:34:05 -0500
IronPort-SDR: dFSqme/PRaTOgSoiDV0NghUlgCZ6ipwW/Jj6kUftPGK2iRljIIODSaF/TjYVzXamArSvI3wjXR
 bEnYPMNSL4Uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159012441"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="159012441"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 22:34:04 -0800
IronPort-SDR: 3UYDVX0MCer5gpeuzPlBIvQHTQlSAR4iYLrubaQxKGYYwV00I5UAPMYjyGJtq5vfn8V3ZQAAVq
 3yyfMOXUohqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="544877929"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2020 22:34:04 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 4/4] usb: typec: Remove active_link_training variable from Enter_USB message
Date:   Wed, 18 Nov 2020 22:32:11 -0800
Message-Id: <20201119063211.2264-5-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thunderbolt 3 cable discover mode VDO support has been added as part of
Enter_USB message to fill details of active cable plug link training.
Hence, removing unused variable active_link_training from Enter_USB
message data structure.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

--
Changes in v3:
- Rebased and Added Reviewed-by tag.

Changes in v2:
- No change.
--
---
 include/linux/usb/typec.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 25731ed863fa..d26824a30ff9 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -79,16 +79,10 @@ enum typec_orientation {
  * @tbt_cable_vdo needs to be filled with details of active cable plug link
  * training and cable rounded support when thunderbolt 3 cable is being used to
  * create USB4 connection. Do not fill this in case of USB4 cable.
- * @active_link_training: Active Cable Plug Link Training
- *
- * @active_link_training is a flag that should be set with uni-directional SBRX
- * communication, and left 0 with passive cables and with bi-directional SBRX
- * communication.
  */
 struct enter_usb_data {
 	u32			eudo;
 	u32			tbt_cable_vdo;
-	unsigned char		active_link_training:1;
 };
 
 /*
-- 
2.17.1

