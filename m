Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739FC27A738
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI1GGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgI1GGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:06:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FA1C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 23:06:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q123so3171068pfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 23:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHJjusODSL5KLL1weep7z/YaDVJ91HtbgB4OW9jv2/8=;
        b=mybmCirxvUPgvcZsFPVfJz+tQvfkoNdnBxQ5MPul8JfkV1UE4PLmHWTXBppoYyCyv/
         nP4x2flAM9/D33leQdjy9lT8hwBJEnfuyh6yaTPYANO1T7imIgKSKVl0saQet3/TcJiF
         e2nJotE7q8UgFbCpBB6iDcnYB97xj0c/hniZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHJjusODSL5KLL1weep7z/YaDVJ91HtbgB4OW9jv2/8=;
        b=gSGJzapOFJ8L4t5h2c6CtPtLNe/jfpcP+VTKTdgA+6+5Z/RBmOXBQv0t5hQIwIx1AV
         0eFfpxMV37p3ujwrX0JmRStsQdOJZ8Z8Tx+0ykmh+6C0G1i1Pzr622QnOeY8oGVtGVGf
         8WiMEg5YoR4LY/pqxdYxlYS1gEO8xHGTqPMo5pHnInIJCPG0WmajFvvAZZ65L3Xn/jti
         KWuFLFS61e5ijA/4tFPDiYR46OAQqjf42kq7Vg+Y5DtnNd2XRwOhLjzKK/eZK0o9zR2n
         nJij48ka4tS1RDh9s0b0btT1N0escD8I7igQExn5gixOArTZCx9EGfUGNyjTfcpIYUMS
         y0IA==
X-Gm-Message-State: AOAM530ztC57omhsXtFPb+WgVEVWh1Ffz7lIJBmQkVxgW44aViquCyr9
        FiS2R3grno4bo/wx9T9oVRiVFQ==
X-Google-Smtp-Source: ABdhPJys0fcAQCikN4bA7YkLZiDDMVxPgjOg08J6Xzpi8IGQ3V0rpHGTaHALqVKPRNBBeyN7puEbnQ==
X-Received: by 2002:a63:524a:: with SMTP id s10mr75810pgl.40.1601273196923;
        Sun, 27 Sep 2020 23:06:36 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id ml20sm5754895pjb.20.2020.09.27.23.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 23:06:36 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Xingyu Wu <wuxy@bitland.corp-partner.google.com>,
        ST Lin <stlin2@winbond.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4] mtd: spi-nor: winbond: Add support for w25q64jwm
Date:   Mon, 28 Sep 2020 14:06:31 +0800
Message-Id: <20200928060631.2090541-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support Winbond w25q{64,128,256}jwm which are identical to existing
w25q32jwm except for their sizes.

This was tested with w25q64jwm, basic erase/write/readback and
lock/unlock both lower/upper blocks were okay.

Signed-off-by: ikjn@chromium.org <ikjn@chromium.org>
Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
Signed-off-by: ST Lin <stlin2@winbond.com>
Tested-by: Nicolas Boichat <drinkcat@chromium.org>

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

Changes in v4:
- drops package type code from name

Changes in v3:
- fix commit message formats

Changes in v2:
- remove duplicated flash ID (w25q32jwm)

 drivers/mtd/spi-nor/winbond.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 6dcde15fb1aa..e5dfa786f190 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -63,6 +63,15 @@ static const struct flash_info winbond_parts[] = {
 	{ "w25q32jwm", INFO(0xef8016, 0, 64 * 1024,  64,
 			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q64jwm", INFO(0xef8017, 0, 64 * 1024, 128,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q128jwm", INFO(0xef8018, 0, 64 * 1024, 256,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q256jwm", INFO(0xef8019, 0, 64 * 1024, 512,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
 	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128,
 			 SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-- 
2.28.0.681.g6f77f65b4e-goog

