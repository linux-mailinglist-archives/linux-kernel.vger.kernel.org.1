Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA92AC9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgKJAi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:38:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:25963 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730923AbgKJAiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:38:54 -0500
IronPort-SDR: hNmH3qcIE0Cs0r6l9Chf9wTntTd/vllA30bS1DEYhKg6nLoIhKcsMyOslp26T84ECRQDS2/at4
 EqUav3YvCAhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167308586"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="167308586"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 16:38:53 -0800
IronPort-SDR: sbf93IN/N67SJ0uH032Yevp3hC3tEfY97Y8p8c4ajFhKIS5ahJc0evkzjFm5qcW0Vq+1YGZOJL
 q/5ah14Sz2Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="354312360"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2020 16:38:52 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 5/8] usb: typec: Use Thunderbolt 3 cable discover mode VDO in Enter_USB message
Date:   Mon,  9 Nov 2020 16:37:13 -0800
Message-Id: <20201110003716.5164-6-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB4 also uses same cable properties as Thunderbolt 3 so use Thunderbolt 3
cable discover mode VDO to fill details such as active cable plug link
training and cable rounded support.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
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

