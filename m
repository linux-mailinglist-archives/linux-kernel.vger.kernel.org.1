Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2A2A2A10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgKBLyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgKBLyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:43 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58322C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:43 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 205so1467017wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRzuWaCfIw4UTs2aF+5rmwioSm/r/nvXMg3tmaX+2L0=;
        b=JS+KwdswLAieYiaVeglSx5ggqAhqLpcikTROj7r7BZ55giY22O3qr5VILyrUR4yONv
         UAruY8PiBxCqihxjeC67TcC7ye9Au72twge4l2BcSioJyYz1PMNuh41qs3FzprrNPvbI
         FHLyC0K835GWyx+1GV9YalD1Bd8Sce/mRu8mP2CPSUSmo/6F9XuEYdh73H5Jqw8pojNJ
         aTD22WfqdQq2A8BhX0GeNNwaNjMv6U1rPQJzCmNu81+Vr1fqwcquHFk+NKPDlYt3/K5e
         adHhhB2e2J+MIVdkHOdnx1VyZWF99+Kqaep73B7geFO2cQgTGZCefO10Quqw/jDYQM5X
         s0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRzuWaCfIw4UTs2aF+5rmwioSm/r/nvXMg3tmaX+2L0=;
        b=axFEhNQUeFgIePp9o3kMVwWXi1v1PaBzLmW0EPg0WIpKdGhShIXSItC4cFUUc5TxQX
         DrFHbjFafT0bpeyggfcK3TX6imw1cT+O1Hw8rupa3X17Pcd7XHxsKFhE9CZ0poQkWBU6
         eOSrkBu0ozBC0Oe1exoOCZhN6eGry7bNjR9bUQ/NflXn4dw/+BBJCykSKsTBQ+FoGSvK
         0b1wwVHRnsDYFI7i707ZpMAnT4KMISHVINGzfoObNXVvtZfoofWzI9yIersvgty5x7H6
         DY1kk2JyzkO89Gr7Mjob26dTosBSQ88sVIsoNiQTPMne1LY/SXyPrUWWVvY6D93zgsk5
         ykNA==
X-Gm-Message-State: AOAM531W5eM3QHjUYCvSLPsuiJyWKhzcyrOnxzyGcxoSt73L//rf5j0c
        27sbOSURLXbR4B989j5foeYEsg==
X-Google-Smtp-Source: ABdhPJwqyLdi+hvK8ABATLFZsgWDxfRSJ/d6F8En9RgoXNzWtzAm3miqfTQw75V5SnGsKn+a3h1n3A==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr10168153wmi.136.1604318082123;
        Mon, 02 Nov 2020 03:54:42 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Cyril Bur <cyril.bur@au1.ibm.com>,
        linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 23/23] mtd: devices: powernv_flash: Add function names to headers and fix 'dev'
Date:   Mon,  2 Nov 2020 11:54:06 +0000
Message-Id: <20201102115406.1074327-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/devices/powernv_flash.c:129: warning: Cannot understand  * @mtd: the device
 drivers/mtd/devices/powernv_flash.c:145: warning: Cannot understand  * @mtd: the device
 drivers/mtd/devices/powernv_flash.c:161: warning: Cannot understand  * @mtd: the device
 drivers/mtd/devices/powernv_flash.c:184: warning: Function parameter or member 'dev' not described in 'powernv_flash_set_driver_info'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Cyril Bur <cyril.bur@au1.ibm.com>
Cc: linux-mtd@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/powernv_flash.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 0b757d9ba2f6b..32cb0e649096f 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -126,6 +126,8 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 }
 
 /**
+ * powernv_flash_read
+ *
  * @mtd: the device
  * @from: the offset to read from
  * @len: the number of bytes to read
@@ -142,6 +144,7 @@ static int powernv_flash_read(struct mtd_info *mtd, loff_t from, size_t len,
 }
 
 /**
+ * powernv_flash_write
  * @mtd: the device
  * @to: the offset to write to
  * @len: the number of bytes to write
@@ -158,6 +161,7 @@ static int powernv_flash_write(struct mtd_info *mtd, loff_t to, size_t len,
 }
 
 /**
+ * powernv_flash_erase
  * @mtd: the device
  * @erase: the erase info
  * Returns 0 if erase successful or -ERRNO if an error occurred
@@ -176,7 +180,7 @@ static int powernv_flash_erase(struct mtd_info *mtd, struct erase_info *erase)
 
 /**
  * powernv_flash_set_driver_info - Fill the mtd_info structure and docg3
- * structure @pdev: The platform device
+ * @dev: The device structure
  * @mtd: The structure to fill
  */
 static int powernv_flash_set_driver_info(struct device *dev,
-- 
2.25.1

