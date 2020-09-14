Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14625268319
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 05:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgIND2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 23:28:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:27438 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgIND2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:28:30 -0400
IronPort-SDR: BtEvS2HBjhGWgcJfsJUzn9KH/to7bA6CZRAg8RTYCDnIKRX4wtjGLqErMYGIjEBH5oZsBOLG4b
 8boExQQ8xFsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="243850851"
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; 
   d="scan'208";a="243850851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 20:28:29 -0700
IronPort-SDR: ht3z4prTyg6/AD7ktePHWbFV4fbVpogys0DPQki0eUnfpIYfPGCHfOEO7p5jPKTdc6/AVITSQn
 d2/tjp3DRjUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; 
   d="scan'208";a="306018259"
Received: from ubuntu1604.sh.intel.com ([10.67.114.235])
  by orsmga006.jf.intel.com with ESMTP; 13 Sep 2020 20:28:28 -0700
From:   Lang Dai <lang.dai@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     yuan1.wang@intel.com, Lang Dai <lang.dai@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] uio: free uio id after uio file node is freed
Date:   Mon, 14 Sep 2020 11:26:41 +0800
Message-Id: <1600054002-17722-1-git-send-email-lang.dai@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uio_register_device() do two things.
1) get an uio id from a global pool, e.g. the id is <A>
2) create file nodes like /sys/class/uio/uio<A>

uio_unregister_device() do two things.
1) free the uio id <A> and return it to the global pool
2) free the file node /sys/class/uio/uio<A>

There is a situation is that one worker is calling uio_unregister_device(),
and another worker is calling uio_register_device().
If the two workers are X and Y, they go as below sequence,
1) X free the uio id <AAA>
2) Y get an uio id <AAA>
3) Y create file node /sys/class/uio/uio<AAA>
4) X free the file note /sys/class/uio/uio<AAA>
Then it will failed at the 3rd step and cause the phenomenon we saw as it
is creating a duplicated file node.

Failure reports as follows:
sysfs: cannot create duplicate filename '/class/uio/uio10'
Call Trace:
   sysfs_do_create_link_sd.isra.2+0x9e/0xb0
   sysfs_create_link+0x25/0x40
   device_add+0x2c4/0x640
   __uio_register_device+0x1c5/0x576 [uio]
   adf_uio_init_bundle_dev+0x231/0x280 [intel_qat]
   adf_uio_register+0x1c0/0x340 [intel_qat]
   adf_dev_start+0x202/0x370 [intel_qat]
   adf_dev_start_async+0x40/0xa0 [intel_qat]
   process_one_work+0x14d/0x410
   worker_thread+0x4b/0x460
   kthread+0x105/0x140
 ? process_one_work+0x410/0x410
 ? kthread_bind+0x40/0x40
 ret_from_fork+0x1f/0x40
 Code: 85 c0 48 89 c3 74 12 b9 00 10 00 00 48 89 c2 31 f6 4c 89 ef
 e8 ec c4 ff ff 4c 89 e2 48 89 de 48 c7 c7 e8 b4 ee b4 e8 6a d4 d7
 ff <0f> 0b 48 89 df e8 20 fa f3 ff 5b 41 5c 41 5d 5d c3 66 0f 1f 84
---[ end trace a7531c1ed5269e84 ]---
 c6xxvf b002:00:00.0: Failed to register UIO devices
 c6xxvf b002:00:00.0: Failed to register UIO devices

Signed-off-by: Lang Dai <lang.dai@intel.com>

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 73efb80..6dca744 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -1048,8 +1048,6 @@ void uio_unregister_device(struct uio_info *info)
 
 	idev = info->uio_dev;
 
-	uio_free_minor(idev);
-
 	mutex_lock(&idev->info_lock);
 	uio_dev_del_attributes(idev);
 
@@ -1064,6 +1062,8 @@ void uio_unregister_device(struct uio_info *info)
 
 	device_unregister(&idev->dev);
 
+	uio_free_minor(idev);
+
 	return;
 }
 EXPORT_SYMBOL_GPL(uio_unregister_device);
-- 
2.7.4

