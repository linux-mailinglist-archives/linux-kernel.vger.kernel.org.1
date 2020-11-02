Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA2E2A2A00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgKBLyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgKBLyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B5DC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:11 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so14272114wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvvRxWQAtjE/Lvm2jzqSBRL+Vs2GYrDtKRh/rhufcx8=;
        b=DGMAQjj8IfzDIDL0k2VusbyLVPl4R20xaoXFOAXmlROMdf3oI9Iar1woAgOF7ERuy3
         qbWx/bvCmUQhQrvny+y7eNcSXDCwA4cAE6Gv6FdFubannt2/fU+rEMjPbv28NVXnERzd
         h3WVkMbi1Utaw5Ia58yAtyKu8zZXJ77YPTieeE6IcstrR+q1zZQBnCg9r57A1vca1atL
         FQD+cGVf7pl70A+qVxgPoX/eoHupMyL3lUxw74DdqR1zZzwsaHxqyyDmYtgEVAW2QZsu
         aK1csFj9xVKKhlXxJ21U4zWK3d3V54JJjgIqdVOxdV2CbKBN1sDbYR2bJ2cg6VcBTvnD
         ehcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvvRxWQAtjE/Lvm2jzqSBRL+Vs2GYrDtKRh/rhufcx8=;
        b=IXsLWEDYQGDKlua/k77owTu0bjhLPFU3Ea6efzWnsijnS0mwr+i9V+aaJX04hz0zv2
         pOqV+i7S8M6TuDJk55YwpgeUzgo2BpuaDqyJ0BTpUif6+of5DQOH40A03CXybZ9VOl7f
         ysl9d5czOtf8YJGsV9d7om1N8Zw8GaLt+RwbiNVxF23z95mj1Fa9Z2/MMb9I7oxP5d92
         c7H20B2G4yFO6tTdZzunHEiHRsEYNqri7pmh+xd7RkVaA0vp/nTwlZquopzY822+6oNX
         xyqd1AsPDoJIDx7U2L+Myp1mJkUILUghJYi44VwP2G5XZ2uvseP6e/TbE9WHuIm3KghL
         FECA==
X-Gm-Message-State: AOAM531H9A8ckxJ2vJ5sxHCq34shtsczq+zFCBjwPCT31GNZ+vqkOeMm
        7VitQe/Ayy9YtMSSAOQRWvbiBAXtygZ63w==
X-Google-Smtp-Source: ABdhPJzdkop5cMVMemGa+FnIO9qze/1lzfd0+SXT1wDfLM/lNVr2028maNgE6VMXOOXqpesJB3R//g==
X-Received: by 2002:adf:82cc:: with SMTP id 70mr6972116wrc.238.1604318050053;
        Mon, 02 Nov 2020 03:54:10 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/23] Rid W=1 warnings in MTD
Date:   Mon,  2 Nov 2020 11:53:43 +0000
Message-Id: <20201102115406.1074327-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (23):
  mtd: mtdpart: Fix misdocumented function parameter 'mtd'
  mtd: devices: phram: File headers are not good candidates for
    kernel-doc
  mtd: nand: onenand: onenand_base: Fix expected kernel-doc formatting
  mtd: devices: docg3: Fix kernel-doc 'bad line' and 'excessive doc'
    issues
  mtd: mtdcore: Fix misspelled function parameter 'section'
  mtd: nand: onenand: onenand_bbt: Fix expected kernel-doc formatting
  mtd: spi-nor: controllers: hisi-sfc: Demote non-conformant kernel-doc
  mtd: ubi: build: Document 'ubi_num' in struct mtd_dev_param
  mtd: nand: spi: toshiba: Demote non-conformant kernel-doc header
  mtd: ubi: kapi: Correct documentation for 'ubi_leb_read_sg's 'sgl'
    parameter
  mtd: ubi: eba: Fix a couple of misdocumentation issues
  mtd: ubi: wl: Fix a couple of kernel-doc issues
  mtd: nand: raw: brcmnand: brcmnand: Demote non-conformant kernel-doc
    headers
  mtd: ubi: gluebi: Fix misnamed function parameter documentation
  mtd: nand: raw: diskonchip: Marking unused variables as
    __always_unused
  mtd: nand: raw: cafe_nand: Remove superfluous param doc and add
    another
  mtd: nand: raw: s3c2410: Add documentation for 2 missing struct
    members
  mtd: nand: raw: omap_elm: Finish half populated function header,
    demote empty ones
  mtd: nand: raw: omap2: Fix a bunch of kernel-doc misdemeanours
  mtd: nand: raw: sunxi_nand: Document 'sunxi_nfc's 'caps' member
  mtd: nand: raw: arasan-nand-controller: Document 'anfc_op's 'buf'
    member
  mtd: nand: onenand: onenand_base: Fix some kernel-doc misdemeanours
  mtd: devices: powernv_flash: Add function names to headers and fix
    'dev'

 drivers/mtd/devices/docg3.c                   |   5 +-
 drivers/mtd/devices/phram.c                   |   2 +-
 drivers/mtd/devices/powernv_flash.c           |   6 +-
 drivers/mtd/mtdcore.c                         |   2 +-
 drivers/mtd/mtdpart.c                         |   2 +-
 drivers/mtd/nand/onenand/onenand_base.c       | 444 +++++++++---------
 drivers/mtd/nand/onenand/onenand_bbt.c        |  32 +-
 drivers/mtd/nand/raw/arasan-nand-controller.c |   1 +
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      |   6 +-
 drivers/mtd/nand/raw/cafe_nand.c              |   2 +-
 drivers/mtd/nand/raw/diskonchip.c             |   4 +-
 drivers/mtd/nand/raw/omap2.c                  |  18 +-
 drivers/mtd/nand/raw/omap_elm.c               |   7 +-
 drivers/mtd/nand/raw/s3c2410.c                |   4 +-
 drivers/mtd/nand/raw/sunxi_nand.c             |   1 +
 drivers/mtd/nand/spi/toshiba.c                |   2 +-
 drivers/mtd/spi-nor/controllers/hisi-sfc.c    |   2 +-
 drivers/mtd/ubi/build.c                       |   1 +
 drivers/mtd/ubi/eba.c                         |   3 +-
 drivers/mtd/ubi/gluebi.c                      |   2 +-
 drivers/mtd/ubi/kapi.c                        |   2 +-
 drivers/mtd/ubi/wl.c                          |   3 +-
 22 files changed, 279 insertions(+), 272 deletions(-)

-- 
2.25.1

