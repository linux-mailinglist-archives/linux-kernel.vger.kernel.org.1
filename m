Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CDA2CF22B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgLDQrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:47:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:64250 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgLDQra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:47:30 -0500
IronPort-SDR: B7+vHnxdpIrKWKDEuRoueA5y96rOKdpIeJAFgEOBYXDESm5N3kbkwYqvEoxZygqPHDAVg+MTYa
 dOhbrh82Wa+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="153225411"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="153225411"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 08:46:50 -0800
IronPort-SDR: E5GvzQDhvQe9AAxqBU9s2ScqLbUhUG2MiV+MtMU61fpkpW41zrRBju0qeD05JYLKuHwJKj4a5z
 P5Zl6REzCjhQ==
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="551008011"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 08:46:49 -0800
Subject: [PATCH] driver core: auxiliary bus: Fix auxiliary bus shutdown null
 auxdrv ptr
From:   Dave Jiang <dave.jiang@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, david.m.ertman@intel.com,
        dan.j.williams@intel.com
Date:   Fri, 04 Dec 2020 09:46:49 -0700
Message-ID: <160710040926.1889434.8840329810698403478.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe of the auxdrv failed, the device->driver is set to NULL.
During kernel shutdown, the bus shutdown will call auxdrv->shutdown and
cause an invalid ptr dereference. Add check to make sure device->driver is
not NULL before we proceed.

Fixes: 7de3697e9cbd ("Add auxiliary bus support")
Cc: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/auxiliary.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index f303daadf843..8336535f1e11 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -92,10 +92,15 @@ static int auxiliary_bus_remove(struct device *dev)
 
 static void auxiliary_bus_shutdown(struct device *dev)
 {
-	struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
-	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
+	struct auxiliary_driver *auxdrv = NULL;
+	struct auxiliary_device *auxdev;
+
+	if (dev->driver) {
+		auxdrv = to_auxiliary_drv(dev->driver);
+		auxdev = to_auxiliary_dev(dev);
+	}
 
-	if (auxdrv->shutdown)
+	if (auxdrv && auxdrv->shutdown)
 		auxdrv->shutdown(auxdev);
 }
 


