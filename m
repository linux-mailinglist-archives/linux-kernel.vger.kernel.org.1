Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546622EEBFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 04:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbhAHDmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 22:42:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:47617 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbhAHDmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 22:42:18 -0500
IronPort-SDR: 3e7xUh+hmmpzmmzNebRbx4lFweDcuBwrS2bCjcJJGqGrlDfm/2aTWQwN0dNZ/CZhAqIx3/TQcD
 ZwVK1qe59qqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="156718750"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="156718750"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 19:41:37 -0800
IronPort-SDR: 3Ps9BcQoldNuUzkLTt/ZDENe5nblFF2iLHxdw9VV0drtLwUtEKx4y+6Cw/0Y+5D0/VnWCsoJHO
 X+bk1teW0ZYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="463270096"
Received: from unknown (HELO coxu-arch-shz.sh.intel.com) ([10.239.160.33])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jan 2021 19:41:35 -0800
From:   Colin Xu <colin.xu@intel.com>
To:     virtualization@lists.linux-foundation.org
Cc:     kraxel@redhat.com, mst@redhat.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, colin.xu@intel.com
Subject: [PATCH] virtio_input: Prevent EV_MSC/MSC_TIMESTAMP loop storm for MT.
Date:   Fri,  8 Jan 2021 11:41:30 +0800
Message-Id: <20210108034130.499055-1-colin.xu@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 'commit 29cc309d8bf1 ("HID: hid-multitouch: forward MSC_TIMESTAMP")',
EV_MSC/MSC_TIMESTAMP is added to each before EV_SYN event. EV_MSC is
configured as INPUT_PASS_TO_ALL.
In case of a touch device which report MSC_TIMESTAMP:
  BE pass EV_MSC/MSC_TIMESTAMP to FE on receiving event from evdev.
  FE pass EV_MSC/MSC_TIMESTAMP back to BE.
  BE writes EV_MSC/MSC_TIMESTAMP to evdev due to INPUT_PASS_TO_ALL.
  BE receives extra EV_MSC/MSC_TIMESTAMP and pass to FE.
>>> Each new frame becomes larger and larger.

Disable EV_MSC/MSC_TIMESTAMP forwarding for MT.

Signed-off-by: Colin Xu <colin.xu@intel.com>
---
 drivers/virtio/virtio_input.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index f1f6208edcf5..244965c20d9b 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -64,6 +64,21 @@ static int virtinput_send_status(struct virtio_input *vi,
 	unsigned long flags;
 	int rc;
 
+	/*
+	 * Since 29cc309d8bf1 (HID: hid-multitouch: forward MSC_TIMESTAMP),
+	 * EV_MSC/MSC_TIMESTAMP is added to each before EV_SYN event.
+	 * EV_MSC is configured as INPUT_PASS_TO_ALL.
+	 * In case of touch device:
+	 *   BE pass EV_MSC/MSC_TIMESTAMP to FE on receiving event from evdev.
+	 *   FE pass EV_MSC/MSC_TIMESTAMP back to BE.
+	 *   BE writes EV_MSC/MSC_TIMESTAMP to evdev due to INPUT_PASS_TO_ALL.
+	 *   BE receives extra EV_MSC/MSC_TIMESTAMP and pass to FE.
+	 *   >>> Each new frame becomes larger and larger.
+	 * Disable EV_MSC/MSC_TIMESTAMP forwarding for MT.
+	 */
+	if (vi->idev->mt && type == EV_MSC && code == MSC_TIMESTAMP)
+		return 0;
+
 	stsbuf = kzalloc(sizeof(*stsbuf), GFP_ATOMIC);
 	if (!stsbuf)
 		return -ENOMEM;
-- 
2.30.0

