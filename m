Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939412AE602
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbgKKBsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbgKKBsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:48:00 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F439C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:48:00 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e21so337862pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4fd3/0dSgTj2lugodXzs5/n1QFxRdS/bwvccHsHQoc=;
        b=nPE/AdD6ajgJFs/N7AzAkgYmtKO/jsdhXq+aBSQWNVJmQjZyRX92FO88ftRroK87jX
         5Jvm8gnR2dOEpqQJKwsLYMkctjhbCPltjCCSV1zI5Zf2X4m64aDm1ZUANKF+0TYoaBww
         fQraSzelm7y6vLyAnKbIVSx39IeyVExPCkx4wpfsYIqbeOS+QXaJKP1cA7OtrAeUEvz9
         QKBOet/+5g8Qy8/5UJCwOj6QTxpHDHMAJPt1LN8s2R1zqcjIiho6n7BfSqDoEZXvKzuy
         QKoxeNvupXnbxDxYYW/5M3Kb8/PBQCVh64Z/6IouXtq2V1eSvinX+1LyXFV0T8RFqpeN
         Tytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4fd3/0dSgTj2lugodXzs5/n1QFxRdS/bwvccHsHQoc=;
        b=KKagI7TfXkpWwZ0QgYlX+85YnFe/mC3gwJu42DuVwqSztt0HV4F9So964ohQN3np9g
         EfEJ3YIjyIJmTwdEg/teFOMTQJXyzIIS1MZ51mgPh67B27zOezJ7d0OQPa5QjsGAsGNv
         fjev+IGUJiVz13202apIUyWdVIVGnxVolFaxM890AbS6t1jKD7uIiZgv9jkkVGxREoqM
         M6OB4kcpifhABgi6JI2wKSjYiaOTw3M/tQDJQt9NoAXea8AENKkWjJpnxEahYEg6d9PO
         j8p2HbVgxRW/ZGrd/92f1Upvr5Kdzh7ZsXAeD19ljyjwr+/9ZQAgp6Q1/SfkeedZU7m5
         RMkw==
X-Gm-Message-State: AOAM532i4zyCeqn9NF3XIZbp1/mOilM+jv+mqRPUuZgcHpwrOH0mh/yp
        HV8fNL0LJa0kFoJ1Cl0mxv8=
X-Google-Smtp-Source: ABdhPJya8KqKuFlvVUGAEwIVGIIkQbMQ59JIIeT3iDixXmxmhjRPBGndp3pcXSb4EGkEPk6rVvRiIA==
X-Received: by 2002:a17:90b:180a:: with SMTP id lw10mr1247573pjb.106.1605059280006;
        Tue, 10 Nov 2020 17:48:00 -0800 (PST)
Received: from an990131127 (114-137-93-71.emome-ip.hinet.net. [114.137.93.71])
        by smtp.gmail.com with ESMTPSA id v3sm365858pfn.215.2020.11.10.17.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:47:59 -0800 (PST)
From:   Shuhao Mai <shuhao.mai.1990@gmail.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuhao Mai <shuhao.mai.1990@gmail.com>
Subject: [PATCH] mtd: spi-nor: winbond: Add support for w25q512jv
Date:   Wed, 11 Nov 2020 09:45:58 +0800
Message-Id: <20201111014556.6579-1-shuhao.mai.1990@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for w25q512jv. This is of the same series chip with
w25q256jv, which is already supported, but with size doubled and
different JEDEC ID.

Signed-off-by: Shuhao Mai <shuhao.mai.1990@gmail.com>
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index e5dfa786f190..beaa6389e2dc 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -97,6 +97,8 @@ static const struct flash_info winbond_parts[] = {
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
 			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
+	{ "w25q512jv", INFO(0xef4020, 0, 64 * 1024, 1024,
+			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
 };
 
 /**
-- 
2.20.1

