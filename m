Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C90527EA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgI3NvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3NvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:51:12 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A844DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:51:10 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so1207581qtv.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmjGHJDSLD445MzK0ZHH2zcKo0LcYsCTK8O0XEHvNPE=;
        b=hSyO/kDGmOQ7Dmh1PdLQbvlPl8ycNDTIn1QHxi3eKr0ds5wpxEMvKkn40uGFwY8neu
         UsONdpeiTq92eM4iwi38Hnk8GT5nIf969ie38Q1OV5zskMWvYsIWAx7vHrHbE5/n3Yo1
         AmSWvO9CaRxr0jfFSDMl7OZNrSzwsLmuyBIe8rkaZFsVhTutsflfL4+8+YYJZCRU+wL9
         ZIaMuD0ZzYTu/sXU62ZOUJtQ1ohKhuzbG3imcLqN8lLRuuQGiJ4HvaYgQ0Ce53+Do8JD
         JHhL00lvKeYhcAfvGoBxqVadyKZM5RSaHVgq/2+UjumxsJuhDYVfL8yA3uOHO0NdAnpC
         MTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmjGHJDSLD445MzK0ZHH2zcKo0LcYsCTK8O0XEHvNPE=;
        b=oWcSXtXmOp0vRp33FDsTDYnFWDxGU57F/HkEtdC4apjCn+1/pEYJ3662g4Vwv6/yiS
         rBpNB2DB0u0hyPXP3mBEEy0B3mAiBgRDda9ChOpAEnaaq5uAO6bKuaH77wvcks86eDXd
         ddBqRk/n32oaFpLAbbYMBRQW2G0q1YTM+6MbdVFN+kRv5US5e2HpZymTeuQxeNuBhdgp
         Jyftlarwdw2UwPQjeF3dW/icRdUoW5/d2/x4h026Ot8kGuBSsEweK8f1SAmeGf2Z/Os0
         +NuEl6HoFEXJMwncjC8Wf/9dTxJ8LejPq/GTb3fB0XKesz0emwWJRnEOC7ntIq2HlLfv
         Rnkg==
X-Gm-Message-State: AOAM530HceU5sGfyB/D2Awpm2wpGZS7OC6Iy/cFhIShMU8+reZXm045D
        Am4VGMY2KR7nuIeV7mBEP1aCww==
X-Google-Smtp-Source: ABdhPJwLN3DrwH4o0moTLli9BNmHMEo1GZaRrJjuhOeQ9R/a6auEof7aMdctsiBBjokQL9ig2vG8hA==
X-Received: by 2002:aed:2b63:: with SMTP id p90mr2284241qtd.71.1601473869706;
        Wed, 30 Sep 2020 06:51:09 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id y29sm2510008qtj.20.2020.09.30.06.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 06:51:09 -0700 (PDT)
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 0/2] Platform integrity information in sysfs (version 9)
Date:   Wed, 30 Sep 2020 10:51:01 -0300
Message-Id: <20200930135101.5424-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie adds a misc kernel module and extends the intel-spi drivers
to publish platform integrity data in the sys-fs.
Please check the comments in the following patches of this serie for further
details.

Daniel Gutson (2):
  Platform integrity information in sysfs (version 9)
  This patch exports the BIOS Write Enable (bioswe), BIOS Lock Enable
    (biosle), and the SMM BIOS Write Protect (SMM_BIOSWP) fields of the
    BIOS Control register using the platform-integrity misc kernel
    module. The idea is to keep adding more flags, not only from the BC
    but also from other registers in following versions.

 .../ABI/stable/sysfs-class-platform-integrity | 23 +++++
 MAINTAINERS                                   |  7 ++
 drivers/misc/Kconfig                          | 11 +++
 drivers/misc/Makefile                         |  1 +
 drivers/misc/platform-integrity.c             | 57 ++++++++++++
 drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
 .../mtd/spi-nor/controllers/intel-spi-pci.c   | 75 +++++++++++++++-
 .../spi-nor/controllers/intel-spi-platform.c  |  2 +-
 drivers/mtd/spi-nor/controllers/intel-spi.c   | 90 ++++++++++++++++++-
 drivers/mtd/spi-nor/controllers/intel-spi.h   |  9 +-
 include/linux/platform-integrity.h            | 19 ++++
 11 files changed, 288 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-class-platform-integrity
 create mode 100644 drivers/misc/platform-integrity.c
 create mode 100644 include/linux/platform-integrity.h

--
2.25.1
