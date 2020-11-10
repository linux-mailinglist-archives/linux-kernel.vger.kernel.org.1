Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826942AC9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgKJAiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:38:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:25963 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJAip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:38:45 -0500
IronPort-SDR: +8RFbWz5M5zT6QGvTAYZU5254bHlLCwvqXU25vmSnsA4PDp5mxc0TaqexNH6+PxrzF0tH02hTw
 IHof8TZcf/rA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167308557"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="167308557"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 16:38:44 -0800
IronPort-SDR: V7L5k+e9r2CLbh30vomy9O2Tgbe0B4Bho+LcG2x6nM28dNscpaCQQBT/1gaui0RxYdoW2dEFYe
 uHMJskG2l9tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="354312328"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2020 16:38:44 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 1/8] usb: typec: Correct the bit values for the Thunderbolt rounded/non-rounded cable support
Date:   Mon,  9 Nov 2020 16:37:09 -0800
Message-Id: <20201110003716.5164-2-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rounded and non-rounded Thunderbolt cables are represented by two bits as
per USB Type-C Connector specification v2.0 section F.2.6.
Corrected that in the Thunderbolt 3 cable discover mode VDO.

Fixes: ca469c292edc ("usb: typec: Add definitions for Thunderbolt 3 Alternate Mode")
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
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

