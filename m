Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6532B7FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgKRPBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:01:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:37906 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgKRPBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:01:04 -0500
IronPort-SDR: SBemjTiVyGvF9Yl1xjgsFa95MyhvgoXPvw38JPreCgtBi1qIDSt8GzMFE/b+HAWkAM5+OBjtxq
 5qnm1LOFRNWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171224100"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171224100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:01:04 -0800
IronPort-SDR: 9KBkcqlFub0GAnpedm3ZCWLcSyFEdGqk3vFU7IBAgfWnB7Qwy5V3kjMIyBQl++YjHxy75tk9Nl
 leFMwrCC8RLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430881579"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2020 07:01:02 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH 1/3] usb: pd: DFP product types
Date:   Wed, 18 Nov 2020 18:00:57 +0300
Message-Id: <20201118150059.3419-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Power Delivery Specification R3.0 introduced separate
field for the DFP product type to the ID Header VDO.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/usb/pd_vdo.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index 68bdc4e2f5a90..704aaf826c5b4 100644
--- a/include/linux/usb/pd_vdo.h
+++ b/include/linux/usb/pd_vdo.h
@@ -103,17 +103,26 @@
  * --------------------
  * <31>     :: data capable as a USB host
  * <30>     :: data capable as a USB device
- * <29:27>  :: product type
+ * <29:27>  :: product type (UFP / Cable)
  * <26>     :: modal operation supported (1b == yes)
- * <25:16>  :: Reserved, Shall be set to zero
+ * <25:16>  :: product type (DFP)
  * <15:0>   :: USB-IF assigned VID for this cable vendor
  */
 #define IDH_PTYPE_UNDEF		0
 #define IDH_PTYPE_HUB		1
 #define IDH_PTYPE_PERIPH	2
+#define IDH_PTYPE_PSD		3
+#define IDH_PTYPE_AMA		5
+#define IDH_PTYPE_VPD		6
+
 #define IDH_PTYPE_PCABLE	3
 #define IDH_PTYPE_ACABLE	4
-#define IDH_PTYPE_AMA		5
+
+#define IDH_PTYPE_DFP_UNDEF	0
+#define IDH_PTYPE_DFP_HUB	1
+#define IDH_PTYPE_DFP_HOST	2
+#define IDH_PTYPE_DFP_PB	3
+#define IDH_PTYPE_DFP_AMC	4
 
 #define VDO_IDH(usbh, usbd, ptype, is_modal, vid)		\
 	((usbh) << 31 | (usbd) << 30 | ((ptype) & 0x7) << 27	\
@@ -122,6 +131,7 @@
 #define PD_IDH_PTYPE(vdo)	(((vdo) >> 27) & 0x7)
 #define PD_IDH_VID(vdo)		((vdo) & 0xffff)
 #define PD_IDH_MODAL_SUPP(vdo)	((vdo) & (1 << 26))
+#define PD_IDH_DFP_PTYPE(vdo)	(((vdo) >> 23) & 0x7)
 
 /*
  * Cert Stat VDO
-- 
2.29.2

