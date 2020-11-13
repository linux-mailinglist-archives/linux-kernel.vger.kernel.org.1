Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCC42B2577
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKMU1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:27:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:13739 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgKMU04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:56 -0500
IronPort-SDR: ApxSU5/+tgkMG2WNKGW/1xVF6mKA2m+q7nEQSV8dP0lNOeSckXNoFjNASUYBjmGqjRDuk1Tk5Z
 xRjHm0L+ZKQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="232145826"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="232145826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:26:55 -0800
IronPort-SDR: J1v9hMYtdprMGM/vkcaJwmWy3vF8yklLS+XlBQt0wqnOSfyGk4m0k30HWC31/29LxDH1mkPYS0
 cXuLZMOzgAcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="367050284"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2020 12:26:54 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 5/8] usb: typec: Use Thunderbolt 3 cable discover mode VDO in Enter_USB message
Date:   Fri, 13 Nov 2020 12:25:00 -0800
Message-Id: <20201113202503.6559-6-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB4 also uses same cable properties as Thunderbolt 3 so use Thunderbolt 3
cable discover mode VDO to fill details such as active cable plug link
training and cable rounded support.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

--
Changes in v2:
- No change.
--
---
 include/linux/usb/typec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 6be558045942..d91e09d9d91c 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -75,6 +75,7 @@ enum typec_orientation {
 /*
  * struct enter_usb_data - Enter_USB Message details
  * @eudo: Enter_USB Data Object
+ * @tbt_cable_vdo: TBT3 Cable Discover Mode Response
  * @active_link_training: Active Cable Plug Link Training
  *
  * @active_link_training is a flag that should be set with uni-directional SBRX
@@ -83,6 +84,7 @@ enum typec_orientation {
  */
 struct enter_usb_data {
 	u32			eudo;
+	u32			tbt_cable_vdo;
 	unsigned char		active_link_training:1;
 };
 
-- 
2.17.1

