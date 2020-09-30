Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC7627EF57
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgI3Qhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Qh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:37:26 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D76C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:37:26 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q5so2053685qkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmjGHJDSLD445MzK0ZHH2zcKo0LcYsCTK8O0XEHvNPE=;
        b=ZNPdo82N4SU780DChitWi8IdWj1uilBva+gKWUJp7WtVYMQl/FWldvXPgZc1lDDjXE
         lsdLn3sUMMsiGMWJS3vUxCpAjCzu3ee8/YHfMJYmbhpeZNkozrPGiG4tYB63ca0Knp9A
         RSXB9zkgG/YmDpqZOWkeC/rWs+YQcCoDo585Uzgk/sn5KiCmlSdEqUIxPgdau//d1UBr
         m/0T1z5K5k9T/gP/7nWZ8T++e+x0m4HmWPQYdXXWPCGglKZ4yIZjFUaqDwG7k/DqAHWl
         wfIcsRFjT9G+7oCbJmvGCJQqvvD1hd7BMQuLiLYOh0bCQztF508sWsFRF4RHjzsusA+c
         s9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmjGHJDSLD445MzK0ZHH2zcKo0LcYsCTK8O0XEHvNPE=;
        b=gJkqojiximYndHj0QhzZ5kJM7fSDIB7MFAxud/2GE3SSHakZY0j6LVobMDJLwYZ2rG
         NyiYZwNIXsnKkcBCE8/XXDuxtptM3F1J73BqYuWmkcVdw+gJj8D0r8Nc6mNU42CSHFWn
         P+yVR9dWgId9M4VOlmTRKVfDkm7kALDvnVkiggYM5s48k311kfmekmZIHP1xAlLNMQOQ
         nzpWN9s4srO8wDBGj6GwHSLbtPBldegODGINx2kVC3BrlJXojvyD3UuPJatxJLrb80fC
         QwrSgIhrZDM8lRFkAt4FLfT2eqjQsuOP4KLujWQiNGG/U8eUK6OINY/BemXz0QTqmHLe
         i+LA==
X-Gm-Message-State: AOAM533M24azEy48ysvqswZZPOjVUobYrHqEa7LpmBlpRcPrgLF4vTQ4
        uHr9R2xqbeT62zOctSKsfKgr8nWD7UzxUt6Y
X-Google-Smtp-Source: ABdhPJzoQW+QOAXSW4qUUeQ7QJhtqjRQPlaHbp/YPlLigwsavTETXvSTJGoET2Tvv7aWSe2XnvlmsQ==
X-Received: by 2002:a05:620a:40c9:: with SMTP id g9mr3424578qko.262.1601483845694;
        Wed, 30 Sep 2020 09:37:25 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id u13sm2816333qtv.57.2020.09.30.09.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 09:37:25 -0700 (PDT)
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
Date:   Wed, 30 Sep 2020 13:37:12 -0300
Message-Id: <20200930163714.12879-1-daniel.gutson@eclypsium.com>
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
