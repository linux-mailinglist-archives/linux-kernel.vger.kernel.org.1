Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931B82AC9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgKJAjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:39:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:25974 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731130AbgKJAjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:39:11 -0500
IronPort-SDR: T2HXha+OnmeyGqV0UsAyU5NBsNogDJB7yIjYUBWSwMgellrWVKvmHewCPhzCqZyg0hl8uD4Fm1
 Z7pVObWGgX1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167308689"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="167308689"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 16:38:58 -0800
IronPort-SDR: I8VpbswOaV7EmvvtK8g+7qrYToR7tuShwspPwrXpQWuCI2QE1D/JwSOM9n1je1OqVVHYWzAvBH
 KkbDoJ9atiVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="354312394"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2020 16:38:58 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 8/8] usb: typec: Remove active_link_training variable from Enter_USB message
Date:   Mon,  9 Nov 2020 16:37:16 -0800
Message-Id: <20201110003716.5164-9-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thunderbolt 3 cable discover mode VDO support has been added as part of
Enter_USB message to fill details of active cable plug link training.
Hence, removing unused variable active_link_training from Enter_USB
message data structure.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
 include/linux/usb/typec.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index d91e09d9d91c..4a9608a15ac1 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -76,16 +76,10 @@ enum typec_orientation {
  * struct enter_usb_data - Enter_USB Message details
  * @eudo: Enter_USB Data Object
  * @tbt_cable_vdo: TBT3 Cable Discover Mode Response
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

