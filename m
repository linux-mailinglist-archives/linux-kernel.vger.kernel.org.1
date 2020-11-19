Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1E2B8BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgKSGeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:34:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:60908 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgKSGeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:34:00 -0500
IronPort-SDR: bXDUlx1VVyyb9WgQjOcTykYrMl/ospheTLQXSTuH++0l2lzb/FFiRsybtHqQ2GFZ+sAez283Z2
 rOMcK4iddFsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159012429"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="159012429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 22:33:59 -0800
IronPort-SDR: dBw0Q2tNdWSWLpD2JbEBKmH5WP8raXhxKZrDPAocpKJ/jE8dsp9EPjQBT2gEORGZXC0YZDP7DM
 /LQw4k2S7aCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="544877885"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2020 22:33:59 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 1/4] usb: typec: Use Thunderbolt 3 cable discover mode VDO in Enter_USB message
Date:   Wed, 18 Nov 2020 22:32:08 -0800
Message-Id: <20201119063211.2264-2-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Thunderbolt 3 cable is being used to create USB4 connection, use
Thunderbolt 3 discover mode VDO to fill details such as active cable plug
link training and cable rounded support.
With USB4 cables, these VDO members need not be filled.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

--
Changes in v3:
- Changed the commit mesage to reflect why TBT3 VDO is being used.
- Added more details in the header file about the usage of TBT3 VDO.

Changes in v2:
- No change.
--
---
 include/linux/usb/typec.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 6be558045942..25731ed863fa 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -75,6 +75,10 @@ enum typec_orientation {
 /*
  * struct enter_usb_data - Enter_USB Message details
  * @eudo: Enter_USB Data Object
+ * @tbt_cable_vdo: TBT3 Cable Discover Mode Response
+ * @tbt_cable_vdo needs to be filled with details of active cable plug link
+ * training and cable rounded support when thunderbolt 3 cable is being used to
+ * create USB4 connection. Do not fill this in case of USB4 cable.
  * @active_link_training: Active Cable Plug Link Training
  *
  * @active_link_training is a flag that should be set with uni-directional SBRX
@@ -83,6 +87,7 @@ enum typec_orientation {
  */
 struct enter_usb_data {
 	u32			eudo;
+	u32			tbt_cable_vdo;
 	unsigned char		active_link_training:1;
 };
 
-- 
2.17.1

