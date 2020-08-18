Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66429247ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 08:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHRG6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 02:58:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:50597 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgHRG57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:57:59 -0400
IronPort-SDR: 96euouaBm3Cg0CKjKMN12PT8Il6KkKXM8zPrtj+c6DZyHl0/VeZBNpSjmWsTg0gEKOK7/2VPNC
 XF6RpugF9f0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154111276"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="154111276"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:57:58 -0700
IronPort-SDR: D0VT8o+sVu2DR8zV0Y1kvKjxmtI22otR11ZZN41SK1CfCiK5c3xxE85YUKiV8sjMo5RcoZgjb2
 szQftCSxGnrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="310342560"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2020 23:57:56 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     andriy.shevchenko@intel.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 8/9] extcon: extcon-ptn5150: Add USB analog audio accessory support
Date:   Tue, 18 Aug 2020 14:57:26 +0800
Message-Id: <20200818065727.50520-9-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add USB analog audio accessory attached and detection support.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index b985a5e5c9bc..140994ac43ed 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -34,6 +34,7 @@ enum ptn5150_reg {
 #define PTN5150_DFP_ATTACHED			0x1
 #define PTN5150_UFP_ATTACHED			0x2
 #define PTN5150_DEBUG_ATTACHED			0x3
+#define PTN5150_AUDIO_ATTACHED			0x4
 
 /* Define PTN5150 MASK/SHIFT constant */
 #define PTN5150_REG_DEVICE_ID_VERSION		GENMASK(7, 3)
@@ -63,6 +64,7 @@ static const unsigned int ptn5150_extcon_cable[] = {
 	EXTCON_USB,
 	EXTCON_USB_HOST,
 	EXTCON_JIG,
+	EXTCON_JACK_HEADPHONE,
 	EXTCON_NONE,
 };
 
@@ -89,6 +91,7 @@ static void ptn5150_irq_work(struct work_struct *work)
 	union extcon_property_value flipped;
 	bool host_vbus = false;
 	bool debug = false;
+	bool audio = false;
 	bool host = false;
 	bool dev = false;
 
@@ -158,6 +161,9 @@ static void ptn5150_irq_work(struct work_struct *work)
 			case PTN5150_DEBUG_ATTACHED:
 				debug = true;
 				break;
+			case PTN5150_AUDIO_ATTACHED:
+				audio = true;
+				break;
 			default:
 				dev_err(info->dev,
 					"Unknown Port status : %x\n",
@@ -189,6 +195,7 @@ static void ptn5150_irq_work(struct work_struct *work)
 			    EXTCON_PROP_USB_VBUS, vbus_detected);
 	extcon_set_state_sync(info->edev, EXTCON_USB_HOST, host);
 	extcon_set_state_sync(info->edev, EXTCON_JIG, debug);
+	extcon_set_state_sync(info->edev, EXTCON_JACK_HEADPHONE, audio);
 	extcon_set_state_sync(info->edev, EXTCON_USB, dev);
 
 	mutex_unlock(&info->mutex);
-- 
2.11.0

