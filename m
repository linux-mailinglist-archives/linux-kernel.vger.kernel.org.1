Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12CD1F5E70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 00:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFJWrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 18:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgFJWrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:47:08 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34A7C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:06 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id y25so3230720qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=H71MExYm/CGiyWc/B8p0G3A3RqB8QbYwFWDgAbb3BjM=;
        b=H+S9mH+IiwxAwIQTSovuAEu2EFLyte/T9t8Mco9jzx/THTvUBD5wHEtcNNustYp43W
         DSCiCYS6v4m7JHRJfIZxXH7KN7DLgQDTC7B8xDTZtkXral/lxUJISHBSRb+VwVqwXFlP
         WrAssSVfB2Vj+KnFewuA4m02kp+KuEhmWThgB5O25FmeLxTOhRmUXi343gSefNH6/VnI
         lEa9gW/ptqBD336Eh08d2R6P2UzriNj+oHjp3Jvy41xOLoTQVPr6qmarB4wrmH5C1EVw
         r3J3n8+JBAwu1TVkokVBXsfyrDnii+NpaRCsUDlj2a86BHTmfaDngC0oD/cTLxsOVo6B
         TqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=H71MExYm/CGiyWc/B8p0G3A3RqB8QbYwFWDgAbb3BjM=;
        b=JEXCZVuJ4pVdb5Toll/v0sPJ1CUyVdUO0qXdQTCxxaPxEKwlZ1mY20fnxwvzk3Yzl6
         SOiIkPXBFXo9Vz23kHwGTCYTez+7ZCdKj1jS8AUbv75QSCNP9sFi5S3JGXDcSbtEH/9R
         WqRf7/YDMp6kCJ9mQlvBMRzBYqeyaWBX6wnYnGmyk/rsIwBNo3jjfL6Mw9pBqbXwJf/c
         /ED0/UoTswUGOjnaRq7U9bKRRzJa0mcDX36SSmnQRwuCwzN3ST4uDlzz+8leT8etG/rO
         q1nCD3pqhBtAlw5v1KwY9lRIPYC6i6IqoXuJuVIUXZCVssD6MThkOuXzYh9BaOYb/VFQ
         HX/A==
X-Gm-Message-State: AOAM532FfGMl0baVYpfp8UDd1rmcrkk5wK6jMjtRk7gB48naIFaBfrJG
        pyW2Y7rtkPBhmqnI4DL/0RsVyv0SM4Nwv5BX3g==
X-Google-Smtp-Source: ABdhPJzJYz+fyBLjsOWr76YEXLuzWpBMVdATp7e+yVnxro1rX8w4AIJwNDBOxf4Vh5dVRZUj4+RQR/pgQE2zI5rFog==
X-Received: by 2002:a05:6214:10cb:: with SMTP id r11mr5342385qvs.203.1591829225669;
 Wed, 10 Jun 2020 15:47:05 -0700 (PDT)
Date:   Wed, 10 Jun 2020 22:46:49 +0000
Message-Id: <20200610224652.64336-1-luisalberto@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH] mtd: revert "spi-nor: intel: provide a range for poll_timout"
From:   Luis Alberto Herrera <luisalberto@google.com>
To:     tudor.ambarus@microchip.com
Cc:     Luis Alberto Herrera <luisalberto@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change reverts aba3a882a178: "mtd: spi-nor: intel: provide a range
for poll_timout". That change introduces a performance regression when
reading sequentially from flash. Logging calls to intel_spi_read without
this change we get:

Start MTD read
[   20.045527] intel_spi_read(from=1800000, len=400000)
[   20.045527] intel_spi_read(from=1800000, len=400000)
[  282.199274] intel_spi_read(from=1c00000, len=400000)
[  282.199274] intel_spi_read(from=1c00000, len=400000)
[  544.351528] intel_spi_read(from=2000000, len=400000)
[  544.351528] intel_spi_read(from=2000000, len=400000)
End MTD read

With this change:

Start MTD read
[   21.942922] intel_spi_read(from=1c00000, len=400000)
[   21.942922] intel_spi_read(from=1c00000, len=400000)
[   23.784058] intel_spi_read(from=2000000, len=400000)
[   23.784058] intel_spi_read(from=2000000, len=400000)
[   25.625006] intel_spi_read(from=2400000, len=400000)
[   25.625006] intel_spi_read(from=2400000, len=400000)
End MTD read

Signed-off-by: Luis Alberto Herrera <luisalberto@google.com>
---
 drivers/mtd/spi-nor/controllers/intel-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index 61d2a0ad2131..2b89361a0d3a 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -292,7 +292,7 @@ static int intel_spi_wait_hw_busy(struct intel_spi *ispi)
 	u32 val;
 
 	return readl_poll_timeout(ispi->base + HSFSTS_CTL, val,
-				  !(val & HSFSTS_CTL_SCIP), 40,
+				  !(val & HSFSTS_CTL_SCIP), 0,
 				  INTEL_SPI_TIMEOUT * 1000);
 }
 
@@ -301,7 +301,7 @@ static int intel_spi_wait_sw_busy(struct intel_spi *ispi)
 	u32 val;
 
 	return readl_poll_timeout(ispi->sregs + SSFSTS_CTL, val,
-				  !(val & SSFSTS_CTL_SCIP), 40,
+				  !(val & SSFSTS_CTL_SCIP), 0,
 				  INTEL_SPI_TIMEOUT * 1000);
 }
 
-- 
2.27.0.278.ge193c7cf3a9-goog

