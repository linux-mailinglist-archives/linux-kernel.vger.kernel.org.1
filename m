Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B566247ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 08:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHRG5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 02:57:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:12594 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgHRG5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:57:49 -0400
IronPort-SDR: Jl183Dwhe3hr6M3TOsz/EDKFd/lvMOPJLzxxHBf1uQjdYzViwl02ZSkbyEzEE1zXNrnCLvdoO3
 Cy+TQP7IDuLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="134374120"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="134374120"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:57:48 -0700
IronPort-SDR: MiFHRhmrpZSXrvaLxwc6oomeeseihVY+7xo/oR8ia5mw0HF3k4H+sWYaNmQdNWhE4PfGdFZ62z
 XtnC0ntwuocQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="370807249"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2020 23:57:45 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     andriy.shevchenko@intel.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 5/9] extcon: extcon-ptn5150: Switch to GENMASK() for port attachment macro
Date:   Tue, 18 Aug 2020 14:57:23 +0800
Message-Id: <20200818065727.50520-6-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Switch to GENMASK() macro for the port attachment.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 50fff148b772..31b7cbf1551d 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -38,9 +38,7 @@ enum ptn5150_reg {
 #define PTN5150_REG_DEVICE_ID_VERSION		GENMASK(7, 3)
 #define PTN5150_REG_DEVICE_ID_VENDOR		GENMASK(2, 0)
 
-#define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
-#define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
-	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
+#define PTN5150_REG_CC_PORT_ATTACHMENT		GENMASK(4, 2)
 
 #define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
 
@@ -108,9 +106,8 @@ static void ptn5150_irq_work(struct work_struct *work)
 			unsigned int port_status;
 			unsigned int vbus;
 
-			port_status = ((reg_data &
-					PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
-					PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
+			port_status = FIELD_GET(PTN5150_REG_CC_PORT_ATTACHMENT,
+						reg_data);
 
 			switch (port_status) {
 			case PTN5150_DFP_ATTACHED:
-- 
2.11.0

