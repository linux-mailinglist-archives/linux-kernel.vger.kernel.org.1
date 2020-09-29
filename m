Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1044927B8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgI2AMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgI2AMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:12:32 -0400
Received: from mail-pl1-x662.google.com (mail-pl1-x662.google.com [IPv6:2607:f8b0:4864:20::662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04990C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:12:32 -0700 (PDT)
Received: by mail-pl1-x662.google.com with SMTP id j7so14946plk.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tapYhgMQJZCiMS8VGm5pB8V4XJd8y/+UH4GC9p9jPpk=;
        b=T6zYYAJu5mR3/vza/B4HZNb7Vy8lp8pDO00JHd+vjetibTi6QdEC4vveXSzdFgpovt
         zv8fsvbVuGzPnyTjBCGkbOP0v1SzCQYjD+xABGlboA6lUTQPJ2OcO8R6YGGu0hSZ8Rsi
         J4psfgH0QEcePJ8XTaBgP+SXfTZ8wrE9Uw5/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tapYhgMQJZCiMS8VGm5pB8V4XJd8y/+UH4GC9p9jPpk=;
        b=OaOnrFH+XI6nhRFN/GBaLD/AvUG51piBkt0yRL63tEp35RYVcuXTIOwEw73Cq5MGWO
         s9Yzdi+2xHG+EQm3PEdjGS7lKwzx+jNVKQP1JYw40vun1mayPmzTIo1Tx9OTN7wDLWND
         LTaWVUmks5bXCi4zBUHPuMrobjxiNb94Acp/NV0CLIepzRUBYAh5IznDMLQT0daKQIOH
         V/wabBkvnN4CZb0CoIr6iifkXYp8pDlsxuOrBHUdxTFS+ixSYbJzCX1WUJ2PhAQCsfzk
         sTtiuDT54FUhXjNzwBx4iMxJ/Xb2yukrI2DQGEZbJDKN/qtyNulyvCUG4r87QZd2VCiw
         cZBw==
X-Gm-Message-State: AOAM533OoUWJ3kDCUHuu4lDITkL3SBIidvzyxb9AH64gShrrmauFCSef
        E5m296Adfj8DpgsF2mh9kDd7stvtVpt7QMwo0g7ierDi3UFd
X-Google-Smtp-Source: ABdhPJwltDCfsS2ZcFsAzS5h1DywUsn6+NdywzMffu4oSqMdWiFWnuF2lrLQCMCUn4KmfM3YjxavXKxrzvqV
X-Received: by 2002:a17:90b:1741:: with SMTP id jf1mr1422763pjb.164.1601338351437;
        Mon, 28 Sep 2020 17:12:31 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id t1sm1047973pjr.8.2020.09.28.17.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:12:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v4 00/16] Add Broadcom VK driver
Date:   Mon, 28 Sep 2020 17:11:53 -0700
Message-Id: <20200929001209.16393-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series drops previous patches in [1]
that were incorporated by Kees Cook into patch series
"Introduce partial kernel_read_file() support" [2].

Remaining patches are contained in this series to add Broadcom VK driver.
(which depends on request_firmware_into_buf API addition in
other patch series [2] being applied first).

Please note this patch series will not compile without [2].

[1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
[2] https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/

Changes from v3:
 - split driver into more incremental commits for acceptance/review
 - lowered some dev_info to dev_dbg
 - remove ANSI stdint types and replace with linux u8, etc types
 - changed an EIO return to EPFNOSUPPORT
 - move vk_msg_cmd internal to driver to not expose to UAPI at this time
Changes from v2:
 - open code BIT macro in uapi header
 - A0/B0 boot improvements
Changes from v1:
 - declare bcm_vk_intf_ver_chk as static

Scott Branden (16):
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom VK driver
  misc: bcm-vk: add autoload support
  misc: bcm-vk: add misc device to Broadcom VK driver
  misc: bcm-vk: add triggers when host panic or reboots to notify card
  misc: bcm-vk: add ttyVK support
  misc: bcm-vk: add open/release
  misc: bcm-vk: add ioctl load_image
  misc: bcm-vk: add get_card_info, peerlog_info, and proc_mon_info
  misc: bcm-vk: add VK messaging support
  misc: bcm-vk: reset_pid support
  misc: bcm-vk: add BCM_VK_QSTATS
  misc: bcm-vk: add tty irq handler
  misc: bcm-vk: add sysfs interface
  misc: bcm-vk: add mmap function for exposing BAR2
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver

 MAINTAINERS                        |    7 +
 drivers/misc/Kconfig               |    1 +
 drivers/misc/Makefile              |    1 +
 drivers/misc/bcm-vk/Kconfig        |   29 +
 drivers/misc/bcm-vk/Makefile       |   13 +
 drivers/misc/bcm-vk/README         |   99 ++
 drivers/misc/bcm-vk/bcm_vk.h       |  510 +++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c   | 1631 ++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c   | 1363 +++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h   |  169 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c    |  275 +++++
 drivers/misc/bcm-vk/bcm_vk_sg.h    |   61 ++
 drivers/misc/bcm-vk/bcm_vk_sysfs.c | 1411 ++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_tty.c   |  336 ++++++
 include/uapi/linux/misc/bcm_vk.h   |   84 ++
 15 files changed, 5990 insertions(+)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/README
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sysfs.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

