Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6902C8D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbgK3SnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgK3SnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:43:04 -0500
Received: from mail-ot1-x364.google.com (mail-ot1-x364.google.com [IPv6:2607:f8b0:4864:20::364])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E47C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:42:23 -0800 (PST)
Received: by mail-ot1-x364.google.com with SMTP id h19so12351154otr.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e9eQlY82KL0yKDJVMFW8y+YLSKwzABIVbbo4HIFaL/c=;
        b=CqXuyyzYsDMqk4dQM9ckn+GyNOoelzNTKBhWivnVD3zoeNs79dKjBuaeQ72u9MAoRZ
         ZsDQeRE3CLZ73Whe8x4nQtCtq+/+y8a8qvUlv53gTXN/lJE65xK2+zG4AS2Yka+K+dzW
         UI7kTXpqkjXWFVze2TPtcADHNSbfpmdLccnsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e9eQlY82KL0yKDJVMFW8y+YLSKwzABIVbbo4HIFaL/c=;
        b=Ihgq2mj352vbEBY3/bp3EmDzBryqsyh9zYFeJESvNWpw6zjiznIul9wcJhffZC8qPv
         pPO/nJM4geQwx3nBbJtN04O4wOlsIQ4gcRz7TZKBYnNZTYdLl7TIdtnkzmzOZtDWxagI
         KN7HFU2ejBsEm6LffB+LHpLtOBNHcf99Itwj3nbBDLEkVnl5w+igvwllEvxF9v8wXDQk
         k0iSp+2WgaZu0RQVgrBI/17jVX0tmzR7BNqSAt+7AvSoiqOMYaYwP3V0cpdK0DrakAtd
         EMZzU/rm0jV5QbpsIFCJzt6TJLGx0AB4rGHKKB0MicMbOnoXiVIb0B97EDi2tdJY0akx
         3/uQ==
X-Gm-Message-State: AOAM531jZrnMY0WLE5fqj+rX/bzAsvPwpMfy6U6RUiDZ9XRoHK56z9im
        V9/mdCvrtHF2MpnT81AR/hf4iNaVbZUhLbLlzrnLO1Mzu7tv
X-Google-Smtp-Source: ABdhPJxeRG40CbMCDBExQfL5te/WzkW54Gpcgqo6/YPv9133uoUYuygtY8sbqgzaIHYuUxvwHvVS3XdLm9Ay
X-Received: by 2002:a05:6830:1d8f:: with SMTP id y15mr18582685oti.332.1606761743152;
        Mon, 30 Nov 2020 10:42:23 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id z21sm1909069ooe.19.2020.11.30.10.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:42:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v8 00/13] Add Broadcom VK driver
Date:   Mon, 30 Nov 2020 10:41:47 -0800
Message-Id: <20201130184200.5095-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series drops previous patches in [1]
that were incorporated by Kees Cook into patch series
"Introduce partial kernel_read_file() support" [2].

Remaining patches are contained in this series to add Broadcom VK driver.
(which depends on request_firmware_into_buf API addition which has
now been accepted into the upstream kernel as of v5.10-rc1).

[1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
[2] https://lore.kernel.org/lkml/20201002173828.2099543-1-keescook@chromium.org/

Changes from v7:
 - add more information in Kconfig help description
Changes from v6:
 - drop QSTATS patch as it needs to be reviewed if trace_printk makes sense
 - add wdog and IPC interface alerts
 - add boundary check to msgq and peerlog
 - clear additional registers on reset
Changes from v5:
 - dropped sysfs patch from series for now as rework to use hwmon
 - tty patch still at end of series to drop if another solution available
 - updated cover letter commit to point to Kees' latest patch submission in [2]
 - specified --base with Kees' patches applied (kernel branches don't have these yet)
 - removed trivial comment
 - moved location of const to before the struct in two declarations
 - changed dev_info to dev_warn and only print when irq don't match expected
 - changed dev_info to dev_dbg when printing debug QSTATS
 - removed unnecessary %p print
Changes from v4:
 - fixed memory leak in probe function on failure
 - changed -1 to -EBUSY in bcm_vk_tty return code
 - move bcm_vk_tty patch to end of patch series so it
   can be dropped from current patch series if needed
   and rearchitected if needed.
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

Scott Branden (13):
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom VK driver
  misc: bcm-vk: add autoload support
  misc: bcm-vk: add misc device to Broadcom VK driver
  misc: bcm-vk: add triggers when host panic or reboots to notify card
  misc: bcm-vk: add open/release
  misc: bcm-vk: add ioctl load_image
  misc: bcm-vk: add get_card_info, peerlog_info, and proc_mon_info
  misc: bcm-vk: add VK messaging support
  misc: bcm-vk: reset_pid support
  misc: bcm-vk: add mmap function for exposing BAR2
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
  misc: bcm-vk: add ttyVK support

 MAINTAINERS                      |    7 +
 drivers/misc/Kconfig             |    1 +
 drivers/misc/Makefile            |    1 +
 drivers/misc/bcm-vk/Kconfig      |   17 +
 drivers/misc/bcm-vk/Makefile     |   12 +
 drivers/misc/bcm-vk/bcm_vk.h     |  513 ++++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 1651 ++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c | 1350 ++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  163 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c  |  275 +++++
 drivers/misc/bcm-vk/bcm_vk_sg.h  |   61 ++
 drivers/misc/bcm-vk/bcm_vk_tty.c |  333 ++++++
 include/uapi/linux/misc/bcm_vk.h |   84 ++
 13 files changed, 4468 insertions(+)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

