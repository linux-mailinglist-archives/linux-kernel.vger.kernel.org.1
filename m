Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750D22B2566
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKMU1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:27:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:13742 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgKMU06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:58 -0500
IronPort-SDR: IAv27fhk5PN0ERH4Js1n5ZlmoaewuJF6OFKO6EMieO/9IyZD66C+Pc8ScjKF+pTD7ui6kALKU2
 Vxonlahskl0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="232145825"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="232145825"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:26:54 -0800
IronPort-SDR: 0uYqFerfBpohQ/FhcKesQtVO6X7QMnFZJ1OuCAGQbOvS46kQscQke8uA8UNN8hIAOcTZUmalHS
 4YwulySiLKNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="367050281"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2020 12:26:54 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 4/8] usb: typec: Remove one bit support for the Thunderbolt rounded/non-rounded cable
Date:   Fri, 13 Nov 2020 12:24:59 -0800
Message-Id: <20201113202503.6559-5-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two bits support for the Thunderbolt rounded/non-rounded cable has been
added to the header file.
Hence, removing unused TBT_CABLE_ROUNDED definition from the header file.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

--
changes in v2:
- Removed the fixes tag as there is no functional implication.
--
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

