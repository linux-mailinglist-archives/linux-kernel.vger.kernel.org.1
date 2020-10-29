Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CBA29E7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgJ2Jz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:55:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:30816 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgJ2JzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:55:24 -0400
IronPort-SDR: 4JaDkanXFJM1tOOSSzVhp/B3hXm9WqFt5EgylwpUAKRD4L1QoJ7bLT4WNQ72F7ZQOP71Gn0snS
 HxNAtcxAX+AA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="165821752"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="165821752"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 02:55:23 -0700
IronPort-SDR: HqLVDk1UkwL/Gzlj1IRKrBBc/v8WJMpLJyI7peMzastnSbOCJzjbDGx0F5vi1g2N3buspwmMTT
 kvQSAI+ozSfg==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="536607352"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 02:55:21 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/3] mei: bus: do not start a read for disconnected clients
Date:   Thu, 29 Oct 2020 11:54:43 +0200
Message-Id: <20201029095444.957924-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201029095444.957924-1-tomas.winkler@intel.com>
References: <20201029095444.957924-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Avoid queuing reads and registering rx callbacks in
case the client is not connected, to prevent null
dereferencing and memory leaks.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 9cdaa7f3af23..1a54bf3ed0c3 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -276,7 +276,8 @@ static void mei_cl_bus_rx_work(struct work_struct *work)
 		cldev->rx_cb(cldev);
 
 	mutex_lock(&bus->device_lock);
-	mei_cl_read_start(cldev->cl, mei_cl_mtu(cldev->cl), NULL);
+	if (mei_cl_is_connected(cldev->cl))
+		mei_cl_read_start(cldev->cl, mei_cl_mtu(cldev->cl), NULL);
 	mutex_unlock(&bus->device_lock);
 }
 
@@ -364,7 +365,10 @@ int mei_cldev_register_rx_cb(struct mei_cl_device *cldev, mei_cldev_cb_t rx_cb)
 	INIT_WORK(&cldev->rx_work, mei_cl_bus_rx_work);
 
 	mutex_lock(&bus->device_lock);
-	ret = mei_cl_read_start(cldev->cl, mei_cl_mtu(cldev->cl), NULL);
+	if (mei_cl_is_connected(cldev->cl))
+		ret = mei_cl_read_start(cldev->cl, mei_cl_mtu(cldev->cl), NULL);
+	else
+		ret = -ENODEV;
 	mutex_unlock(&bus->device_lock);
 	if (ret && ret != -EBUSY)
 		return ret;
-- 
2.25.4

