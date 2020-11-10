Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B622AC9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgKJAiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:38:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:25963 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbgKJAiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:38:50 -0500
IronPort-SDR: P9S2hNSbYAiPSWqlTelFyfX/Gdls3BgUiGjC2WdExxO2Bmp23KqCzm18isuZGhXJJVuSp2BL87
 TzIXmw3ENwxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167308568"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="167308568"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 16:38:50 -0800
IronPort-SDR: O/Ttf5HRpmiY+MgxDf0+6LWfFh3Mr15pHDoxn6Xrm1BS2c566MK1aeLZbjbMkdGSArQ4oQAII5
 b6qsKRACVf6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="354312348"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2020 16:38:50 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 4/8] usb: typec: Remove one bit support for the Thunderbolt rounded/non-rounded cable
Date:   Mon,  9 Nov 2020 16:37:12 -0800
Message-Id: <20201110003716.5164-5-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two bits support for the Thunderbolt rounded/non-rounded cable has been
added to the header file.
Hence, removing unused TBT_CABLE_ROUNDED definition from the header file.

Fixes: ca469c292edc ("usb: typec: Add definitions for Thunderbolt 3 Alternate Mode")
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
 include/linux/usb/typec_tbt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
index aad648d14bb3..63dd44b72e0c 100644
--- a/include/linux/usb/typec_tbt.h
+++ b/include/linux/usb/typec_tbt.h
@@ -39,7 +39,6 @@ struct typec_thunderbolt_data {
 #define   TBT_CABLE_USB3_GEN1		1
 #define   TBT_CABLE_USB3_PASSIVE	2
 #define   TBT_CABLE_10_AND_20GBPS	3
-#define TBT_CABLE_ROUNDED		BIT(19)
 #define TBT_CABLE_ROUNDED_SUPPORT(_vdo_) \
 					(((_vdo_) & GENMASK(20, 19)) >> 19)
 #define   TBT_GEN3_NON_ROUNDED                 0
-- 
2.17.1

