Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90872B4418
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgKPM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:57:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:16105 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgKPM5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:57:14 -0500
IronPort-SDR: ayLfF+/Rw1IqH0DTSz3rjBUeHO8NPEHzp64vbhbvt508M141NyxkLWtw6Cd601hbV1tqkgX+/1
 /XXh/g/fFVZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="157765311"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="157765311"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:57:12 -0800
IronPort-SDR: F/jSnKN098h0snytVYx+biObxO7tmenaAWd2FcXe0Bo0+EMxLUbnaRIzY22R9eCKfb71ybYMzS
 evf97b8UNYjg==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="358454835"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:57:10 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Sean Z Huang <sean.z.huang@intel.com>
Subject: [char-misc-next 2/2] mei: bus: enable pavp device.
Date:   Mon, 16 Nov 2020 14:56:12 +0200
Message-Id: <20201116125612.1660971-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201116125612.1660971-1-tomas.winkler@intel.com>
References: <20201116125612.1660971-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable protected audio video path client on mei client
bus.

Cc: Sean Z Huang <sean.z.huang@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 6cc3145bb716..d8e760b11ae3 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -33,6 +33,9 @@ static const uuid_le mei_nfc_info_guid = MEI_UUID_NFC_INFO;
 #define MEI_UUID_HDCP UUID_LE(0xB638AB7E, 0x94E2, 0x4EA2, \
 			      0xA5, 0x52, 0xD1, 0xC5, 0x4B, 0x62, 0x7F, 0x04)
 
+#define MEI_UUID_PAVP UUID_LE(0xfbf6fcf1, 0x96cf, 0x4e2e, 0xA6, \
+			      0xa6, 0x1b, 0xab, 0x8c, 0xbe, 0x36, 0xb1)
+
 #define MEI_UUID_ANY NULL_UUID_LE
 
 /**
@@ -491,6 +494,7 @@ static struct mei_fixup {
 	MEI_FIXUP(MEI_UUID_MKHIF_FIX, mei_mkhi_fix),
 	MEI_FIXUP(MEI_UUID_HDCP, whitelist),
 	MEI_FIXUP(MEI_UUID_ANY, vt_support),
+	MEI_FIXUP(MEI_UUID_PAVP, whitelist),
 };
 
 /**
-- 
2.26.2

