Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB2B291345
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 18:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438569AbgJQQu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438056AbgJQQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 12:50:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1AC061755;
        Sat, 17 Oct 2020 09:50:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qp15so7930298ejb.3;
        Sat, 17 Oct 2020 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iTzuemyXkpM0NB6MrjzDP3iYy24eeV3XKFWaqiWlow=;
        b=QE5LRD33T+2CIsxl9EkU3t1lujWDwZZv7osP9Gdqh1NX8CXp9EUAduBeMAmVmVLdr3
         nd8WAGZ2Vpk8sZl6vg6Y/+rhnSF847IHQXKnhheaYBxLNZzPCNNS5rgMYvLq5548Io0p
         a1zHQXC31xHKUYsxqwDSbnCNwNUB4TEAxl1SWsQ0N4bdyoOUYf47tenvgvBVL6MtEOku
         4ovfZFUEnXNpPO6HtZQWipgr4bpRY2lhW0MEPQRm6HRkdp8jmlE2HyOyrLhwd+XXONQO
         /8FBgx3W67phcYgiBYX5JuXXzGN5xLQRmgyBKFdMseZZR7vcdY6yUElBcI370pQ1ltwr
         43UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iTzuemyXkpM0NB6MrjzDP3iYy24eeV3XKFWaqiWlow=;
        b=ZVNUswnOdOh6IADwq23rZ0y7OT9hbof2ZADMgOSNNZ2m4ybqMKd0XDCCge0yReD3wW
         iftOJ0Y7iXpOYLrzdLijSRg3wd0pchQSURO8qZLR0um4uNXBh8RyxTH6fd5QCfXRLoby
         lZRGm1zY/I6Nwfo5JMC0tdXBLEu3rR6zdFdCNIk1G1KLyC1PNv8Re6I4yKd9vI9fcVD6
         yg2ikqlTZDRhZSaX7qNYALgOB3flbsKWpkeWTkndzqAP5ZumPC/WxX8QZKfXusiSq2Tk
         vT94X5n3UbmDpASf7BwTl8a7mCb6yIEr3Nu5oLDk3jhZSHk5Gvj2bN/kOHrjDlJaWvnl
         NdSw==
X-Gm-Message-State: AOAM5336I2TJ+7aQ5SmsYG1ejwWJmS1q14h4C2Jt1oU9peUjqqd/hV8B
        4kbzIJJgocleqsKJHVQSE/wHib8wI98=
X-Google-Smtp-Source: ABdhPJzRN7jCxQ1xZCtG4Yni0wG9n8K3flau2+JNrDleOFDJoV0BfSh1iwwxRuOjUNQ3DRPkWHIbog==
X-Received: by 2002:a17:906:d978:: with SMTP id rp24mr9868225ejb.0.1602953421751;
        Sat, 17 Oct 2020 09:50:21 -0700 (PDT)
Received: from localhost.localdomain (p4fd5d4ba.dip0.t-ipconnect.de. [79.213.212.186])
        by smtp.googlemail.com with ESMTPSA id v14sm5533074ejh.6.2020.10.17.09.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 09:50:21 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-usb@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, hminas@synopsys.com, axboe@kernel.dk,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] usb: dwc2: Avoid leaving the error_debugfs label unused
Date:   Sat, 17 Oct 2020 18:50:12 +0200
Message-Id: <20201017165012.546729-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error_debugfs label is only used when either
CONFIG_USB_DWC2_PERIPHERAL or CONFIG_USB_DWC2_DUAL_ROLE is enabled. Add
the same #if to the error_debugfs label itself as the code which uses
this label already has.

This avoids the following compiler warning:
  warning: label ‘error_debugfs’ defined but not used [-Wunused-label]

Fixes: e1c08cf23172ed ("usb: dwc2: Add missing cleanups when usb_add_gadget_udc() fails")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/usb/dwc2/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index e2820676beb1..5f18acac7406 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -608,10 +608,13 @@ static int dwc2_driver_probe(struct platform_device *dev)
 #endif /* CONFIG_USB_DWC2_PERIPHERAL || CONFIG_USB_DWC2_DUAL_ROLE */
 	return 0;
 
+#if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
+	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
 error_debugfs:
 	dwc2_debugfs_exit(hsotg);
 	if (hsotg->hcd_enabled)
 		dwc2_hcd_remove(hsotg);
+#endif
 error_drd:
 	dwc2_drd_exit(hsotg);
 
-- 
2.28.0

