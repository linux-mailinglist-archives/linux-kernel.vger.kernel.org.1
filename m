Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64DA26897C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgINKoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgINKnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:43:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC79C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:43:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x123so12287040pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mShHt/IoIdL3zeM5kIPVohLF6OMC2OmAiOHFn3/ncho=;
        b=TlSyaj053NENZSrfv+oka1gshBooRj3AvapgIi6QCWmTwNyeTmetK9vMsLNNR+ozXy
         RbmBxz5ox9jH88LJ3ApAYjuFI64eDX9X0KVSqUriSwv3whAWQViYjJgECAfTT5Qvd9mm
         1DEsN4dJPRGvJPUq32DgY1RL3YWVtSBZ2L2U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mShHt/IoIdL3zeM5kIPVohLF6OMC2OmAiOHFn3/ncho=;
        b=tSSGp+0IsLqOcYgrHlmBOz11HMOAdq/VboAMnMch93x+nwFDseIBQZMJ5AjrdFn20P
         TWynPdhZsl3+ibmcSqHjTe2HvZ7/7Z9Mr07VoLXACftLr/YEf63/FJ6Y4HPzc2dNekeL
         S1HtjnBWaSs+vFxORI5GwHhRnh/1DSdkLJvDnF/XWvFMQekiNmpJuGGkRDwNLj7wOs9a
         v8TQUssNmB75AnirWySAoF9r19202glXlBY+Oy86Vw1bY+krh7TcLAwyui8mmDi3cL0P
         RzQrngl34MTVPGgmn4CB3bPw6phgcycx/hROYp3Jr6ijC0UnMRE4t4+1YjPZXhcCdtZk
         EbZw==
X-Gm-Message-State: AOAM531cMHjN8R4KZlnKxzTIVWQR2nREZ5GNUBLu9BTK4r6fKnkBv7qu
        WiP+dyFNxqaDzvg+s8Ucagg5EA==
X-Google-Smtp-Source: ABdhPJwg/lYdcj3OZVybohSNYV5EFYCt8XkCIyDkfaxG2ud8Xq9uxHY7E0+aNG7IJevg90qa6w/6PA==
X-Received: by 2002:a63:5d09:: with SMTP id r9mr9667453pgb.397.1600080189654;
        Mon, 14 Sep 2020 03:43:09 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id j11sm8090881pgh.8.2020.09.14.03.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 03:43:09 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Xingyu Wu <wuxy@bitland.corp-partner.google.com>,
        ST Lin <stlin2@winbond.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] mtd: spi-nor: winbond: Add support for w25q64jwm
Date:   Mon, 14 Sep 2020 18:43:03 +0800
Message-Id: <20200914104303.830795-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support Winbond w25q{64,128,256}jwm which are identical to existing
w25q32jwm except for their sizes.

This was tested with w25q64jwm, basic erase/write/readback and
lock/unlock top and bottom blocks were okay.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
Signed-off-by: ST Lin <stlin2@winbond.com>
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
2.28.0.618.gf4bc123cb7-goog

