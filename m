Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858A12A2A1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgKBLzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgKBLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:24 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE992C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:23 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id x7so14269029wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgCfvBJWtLw81z7RjPwr6bormd4FsaQ3wcZ4l8FFWRs=;
        b=moD0ijFtxs3YDF9szj7mvVpXUGbBcJvo25U/w2SGBdKEu2CJe2/R9I45WDZ0zBMghV
         33Ou3U3Z8oI1pYoV1NDil2EEJmk2Jk26h50Eo1qoCzP5PKJ05JjvVMb8Hg2emu5oXtdO
         G/G5/2QBDvcV+xwQHea1IkLwNPNqIpDoKKtCJZjyk+mYoSrpc43UQ53YC9Mfb/ICtOEH
         1KKjRHcQwq3w9Rud0CHnJYkCGpLRFKJe3xaOCRePtSzfvCimRfWnJ3r9d6/PGbghlgae
         SXipOAv3fpd6hLpmhNQhXlntG8L3Ky/YcpO7LvVTqTa91x+Pd4Hbd477hn6dmOeA5sMh
         mvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgCfvBJWtLw81z7RjPwr6bormd4FsaQ3wcZ4l8FFWRs=;
        b=Z/Rif2KyioBAotOW6mchYIW/jHTnQPRUl07hOpeVbBeUGitMOdz8sb2wb3mcSg7MKF
         elAQts0zQafvNp7NOpGKXu8swHJDmAjbxlrT4YnYot/VdGqrR+oKCBg6yfXy076/1UVn
         aiDrJtRj8AEf1NEb05TZ88dVYufA7oCrkHikz4LN/VkraEkIQa7akiKDpBOBY92RfwZ0
         ixJVv5Ke5yhsiFT1w/OMU/SKvcxBf7XRamVJv0qYd3uP2G8Ie4yyHBF9Iwu8a0836n+d
         XEZxoSq/FM0CRFIxak9pZWwNpMb5vrlbgzSMsWxCU6BFiR/PyZRbOyOCYvS7n+p6MwPT
         6PSQ==
X-Gm-Message-State: AOAM533NKiJMnsCvOLWLsP+tYmDJ87Hk2IjJz2DAbcJRH+a04rDV8jFg
        qNMwuAciOvmtzvNpBboV1JXjig==
X-Google-Smtp-Source: ABdhPJy4Qc6S807GOZhDFOw1vxX6caxNriQqJXpn9auBPJu7Ej+kcF0sDBj8+ECN81+2ejh4BB/VTA==
X-Received: by 2002:adf:804b:: with SMTP id 69mr19675757wrk.274.1604318062508;
        Mon, 02 Nov 2020 03:54:22 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-mtd@lists.infradead.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 07/23] mtd: spi-nor: controllers: hisi-sfc: Demote non-conformant kernel-doc
Date:   Mon,  2 Nov 2020 11:53:50 +0000
Message-Id: <20201102115406.1074327-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/spi-nor/controllers/hisi-sfc.c:328: warning: Function parameter or member 'np' not described in 'hisi_spi_nor_register'
 drivers/mtd/spi-nor/controllers/hisi-sfc.c:328: warning: Function parameter or member 'host' not described in 'hisi_spi_nor_register'

Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/spi-nor/controllers/hisi-sfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/hisi-sfc.c b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
index 95c502173cbda..7c26f8f565cba 100644
--- a/drivers/mtd/spi-nor/controllers/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
@@ -320,7 +320,7 @@ static const struct spi_nor_controller_ops hisi_controller_ops = {
 	.write = hisi_spi_nor_write,
 };
 
-/**
+/*
  * Get spi flash device information and register it as a mtd device.
  */
 static int hisi_spi_nor_register(struct device_node *np,
-- 
2.25.1

