Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B91ED171
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 15:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFCNvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 09:51:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:33487 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgFCNvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:51:40 -0400
IronPort-SDR: DsN0y61Xs6ZH4srtPzbK4n/gjheE0Ois0c8Y25do0ilmfccxcUSSBp9K4WzRxaQlgfp1SF/0bf
 LqMV9B10mM/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 06:51:39 -0700
IronPort-SDR: catGTPvQvQK+7mQSyl66XozjADBtn4hRlUTcrYgCvxFUFmManVSiAbf9+u2MvVXhHuig3+r5Sn
 lIIA0JZnKQag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="269082010"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 06:51:38 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1] firmware: stratix10-rsu: fix warnings
Date:   Wed,  3 Jun 2020 09:06:52 -0500
Message-Id: <1591193212-15082-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Patch fixes sparse warnings: using plain integer as NULL pointer. Replaces
equal to with logical not operator.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/firmware/stratix10-rsu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index 4379475..469b8f7 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -290,7 +290,7 @@ static ssize_t reboot_image_store(struct device *dev,
 	unsigned long address;
 	int ret;
 
-	if (priv == 0)
+	if (!priv)
 		return -ENODEV;
 
 	ret = kstrtoul(buf, 0, &address);
@@ -315,7 +315,7 @@ static ssize_t notify_store(struct device *dev,
 	unsigned long status;
 	int ret;
 
-	if (priv == 0)
+	if (!priv)
 		return -ENODEV;
 
 	ret = kstrtoul(buf, 0, &status);
-- 
2.7.4

