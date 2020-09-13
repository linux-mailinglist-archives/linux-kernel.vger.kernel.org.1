Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A3326802F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgIMQPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIMQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:15:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56837C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:15:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s14so296684pju.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxRhW0q4qHba4ZEu7vFkAhq6kKTQeSQtKSIqomEo05s=;
        b=IVb33OPbuWUMxtLqCPROtKsWJGRe3DLaIo11HwC/99jf1H4P6CQyAM/meGhHnXcO4Z
         SpsJ6luI87yqCMKxCuEbEtOrVCDFJgv4xL0JDzcSMoEp9Gupx3DTbgtiRp7aYm8hoOq+
         y7Wjz9GP3obFYwrOtjuE4204K1DEsEvY0xDw5sAWOqRSot7thugx95kRLX1oC+dHE468
         ZB9PTjkktrVq6KJrOXPjYaUQmxXeEUfbzq9ib542IP5sIT4i6TzyLuN/WLtchSUCzxPp
         U9NHBR1QpqYkqKEkGNQS0nXtpBZA+02qkyWPJrpMd4kWw8h7JkRJ+J5kSDEl334qut6x
         clfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxRhW0q4qHba4ZEu7vFkAhq6kKTQeSQtKSIqomEo05s=;
        b=CddsNJjtIWTqzsm/Vf+iYu+XiA4mT39d+py0ehlMfg21t5Sykja9n1MfOB8O8rzS9s
         6XH9pCVr1h/wWBCPl1AzIGUq5uxZTlvjS4skehMI2ISU34wEYnIrHtb0YwCrDhlmzgqv
         meFRruS6omSV1PMg/pBCAeAHbKVQgA+7P5Dg+au0uiK4ht2zCqy6yMgL/X/kERedW8nV
         nY4PrN8+ZPT6573dgIBXd+g8yhDStG8kFl0dTGOFcyu2766mwAjeSPEWSGyMUokMIWx2
         q7hznxRlT27NpGV/7F7h0OXCrvhwDzeLjYK+zB5Xhyyijnt7J7m8GCR3XQnlc4kqdXcr
         eVeQ==
X-Gm-Message-State: AOAM531k/QlSkPFBb+pXWbPOzt6qUK29q3Kc1hzwkhP5LylyAhSzMdD5
        8hgqI63AOj/AodiZ/8xRDyg=
X-Google-Smtp-Source: ABdhPJworav/VebiBiIRtBtZQXgd4+pygu0xh8WhqVaUZ1eVeTVt9Lmr6KCC5X5zwK/XXBPjIYpR1w==
X-Received: by 2002:a17:902:fe08:: with SMTP id g8mr10563529plj.122.1600013742075;
        Sun, 13 Sep 2020 09:15:42 -0700 (PDT)
Received: from Thiru.localdomain ([27.104.143.83])
        by smtp.gmail.com with ESMTPSA id c202sm7833953pfc.15.2020.09.13.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 09:15:41 -0700 (PDT)
From:   Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: [PATCH v4 0/2] Add support for micron SPI NAND MT29F2G01AAAED
Date:   Mon, 14 Sep 2020 00:15:31 +0800
Message-Id: <20200913161533.10655-1-nthirumalesha7@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for Micron SPI NAND MT29F2G01AAAED device and generalised
the structure & function names as per the review comments

v4: Split patch into two parts,
    1. Generalise the oob structure & function names as show in v3
    2. Add support for MT29F2G01AAAED device
       a. Add oob generic section check in the function micron_ooblayout_free
       b. Rename mt29f2g01aaaed_* to generic name micron_4_*

v3: As per the review comments,
     1. Renamed read_cache_variants as quadio_read_cache_variants,
write_cache_variants as x4_write_cache_variants/x1_write_cache_variants,
update_cache_variants as x4_update_cache_variants/x1_update_cache_variants,
read_cache_variants as x4_read_cache_variants
     2. Renamed micron_8_ooblayout as micron_grouped_ooblayout &
mt29f2g01aaaed_ooblayout as micron_interleaved_ooblayout
     3. Generalized page size based oob section check in
mt29f2g01aaaed_ooblayout_ecc function
      and separate case check for two bytes BBM reserved in
mt29f2g01aaaed_ooblayout_free function
     4. Removed mt29f2g01aaaed_ecc_get_status function &
MICRON_STATUS_ECC_1TO4_BITFLIPS

v2: Removed SPINAND_SELECT_TARGET as per the comments & fixed typo
errors

v1: Add support for Micron SPI Nand device MT29F2G01AAAED

Thirumalesha Narasimhappa (2):
  mtd: spinand: micron: Generalize the function and structure names
  mtd: spinand: micron: add support for MT29F2G01AAAED

 drivers/mtd/nand/spi/micron.c | 144 ++++++++++++++++++++++++----------
 1 file changed, 104 insertions(+), 40 deletions(-)

-- 
2.25.1

