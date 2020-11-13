Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671402B256B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgKMU04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:26:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:13739 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgKMU0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:55 -0500
IronPort-SDR: beNN5KLIZ+rF+5qsHe/5dB0LXYLz1qPyi45eX9Pfs463ie3VW//ZHJeHg+Vr871n5NaAT9PT7S
 omVs/S9a9ygA==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="232145822"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="232145822"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:26:54 -0800
IronPort-SDR: dCEbx2WZURtavMopFhFjC+0yVd/sYXqSCUHHc7Mge6UGphduyRyYRhmOotSvWxV7gKHmkikTIf
 V/Q6gZtUB1FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="367050271"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2020 12:26:54 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 1/8] usb: typec: Correct the bit values for the Thunderbolt rounded/non-rounded cable support
Date:   Fri, 13 Nov 2020 12:24:56 -0800
Message-Id: <20201113202503.6559-2-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rounded and non-rounded Thunderbolt cables are represented by two bits as
per USB Type-C Connector specification v2.0 section F.2.6.
Corrected that in the Thunderbolt 3 cable discover mode VDO.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

--
Changes in v2:
- Removed the fixes tag as there is no functional implication.
--
---
 include/linux/usb/typec_tbt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
index 47c2d501ddce..aad648d14bb3 100644
--- a/include/linux/usb/typec_tbt.h
+++ b/include/linux/usb/typec_tbt.h
@@ -40,11 +40,16 @@ struct typec_thunderbolt_data {
 #define   TBT_CABLE_USB3_PASSIVE	2
 #define   TBT_CABLE_10_AND_20GBPS	3
 #define TBT_CABLE_ROUNDED		BIT(19)
+#define TBT_CABLE_ROUNDED_SUPPORT(_vdo_) \
+					(((_vdo_) & GENMASK(20, 19)) >> 19)
+#define   TBT_GEN3_NON_ROUNDED                 0
+#define   TBT_GEN3_GEN4_ROUNDED_NON_ROUNDED    1
 #define TBT_CABLE_OPTICAL		BIT(21)
 #define TBT_CABLE_RETIMER		BIT(22)
 #define TBT_CABLE_LINK_TRAINING		BIT(23)
 
 #define TBT_SET_CABLE_SPEED(_s_)	(((_s_) & GENMASK(2, 0)) << 16)
+#define TBT_SET_CABLE_ROUNDED(_g_)	(((_g_) & GENMASK(1, 0)) << 19)
 
 /* TBT3 Device Enter Mode VDO bits */
 #define TBT_ENTER_MODE_CABLE_SPEED(s)	TBT_SET_CABLE_SPEED(s)
-- 
2.17.1

