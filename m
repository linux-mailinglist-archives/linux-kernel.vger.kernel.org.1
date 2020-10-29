Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCAF29E7E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgJ2Jza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:55:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:30816 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgJ2JzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:55:25 -0400
IronPort-SDR: ne3wz/pK1Rxh1AJ2S8CFWeVkOIXX/ARz3BayEEIBKnFneMaNqu6+H9aAHrUWCxInUdVPSYl9Vo
 zZdNmvfSDq2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="165821758"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="165821758"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 02:55:25 -0700
IronPort-SDR: Q+Pio9uByfj+iBhdCLq9bw2TgVj7/1aCdpKtn8td/LVCWx6Guvl3yLt99biztWdHj5dHUAAZk4
 kLNzhRvswmvw==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="536607372"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 02:55:23 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/3] mei: bus: deinitialize callback functions on init failure
Date:   Thu, 29 Oct 2020 11:54:44 +0200
Message-Id: <20201029095444.957924-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201029095444.957924-1-tomas.winkler@intel.com>
References: <20201029095444.957924-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

If the initialization procedure for receive or receive callback
registration on the client bus has failed the caller can't re-run it.
Deinitilize the callback pointers and cancel the work
to allow the caller to retry.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 1a54bf3ed0c3..76aa0e93748a 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -370,8 +370,11 @@ int mei_cldev_register_rx_cb(struct mei_cl_device *cldev, mei_cldev_cb_t rx_cb)
 	else
 		ret = -ENODEV;
 	mutex_unlock(&bus->device_lock);
-	if (ret && ret != -EBUSY)
+	if (ret && ret != -EBUSY) {
+		cancel_work_sync(&cldev->rx_work);
+		cldev->rx_cb = NULL;
 		return ret;
+	}
 
 	return 0;
 }
@@ -405,8 +408,11 @@ int mei_cldev_register_notif_cb(struct mei_cl_device *cldev,
 	mutex_lock(&bus->device_lock);
 	ret = mei_cl_notify_request(cldev->cl, NULL, 1);
 	mutex_unlock(&bus->device_lock);
-	if (ret)
+	if (ret) {
+		cancel_work_sync(&cldev->notif_work);
+		cldev->notif_cb = NULL;
 		return ret;
+	}
 
 	return 0;
 }
-- 
2.25.4

