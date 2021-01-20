Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71382FD82B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404308AbhATSUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:20:20 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:41048 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391913AbhATSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:10:01 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6F5C67DC6;
        Wed, 20 Jan 2021 09:58:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6F5C67DC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611165510;
        bh=2CtK/Zx9WL6Nfa8WJcD2mRMzahFMxZsOBaKEA0m7DaU=;
        h=From:To:Cc:Subject:Date:From;
        b=EU7PWu0kRJtWUcgQJw2WSDtCj3pkepDlkBZ1yWAZV1uUyH1HDhBMrxOND0OuVg70w
         CUueLsUAz49jUzoQMiuksxka8dSnhlj7sIUbCfo8ZxfIx2soA6OFP2psvfQAtrBNjl
         fznM7TgHNriNe0XouSu2sxoMaLUoBoBjrLueuL24=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v9 00/13] Add Broadcom VK driver
Date:   Wed, 20 Jan 2021 09:58:14 -0800
Message-Id: <20210120175827.14820-1-scott.branden@broadcom.com>
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

Changes from v8:
 - add ack's by Olof Johansson
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

