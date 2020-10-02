Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FD6281D98
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJBVX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBVX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:23:58 -0400
Received: from mail-ua1-x961.google.com (mail-ua1-x961.google.com [IPv6:2607:f8b0:4864:20::961])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8314FC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:23:58 -0700 (PDT)
Received: by mail-ua1-x961.google.com with SMTP id z19so763136uap.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mCn2TEy6yaHr+0J6CyzwYwExaAaXeUXiViBtCfsv5VY=;
        b=cMWMIVtnJTdgC9R1B3oDGvdT5YGmncElo2qqmeOwMABxiShH3d9TlOCFPgPp1EhXnX
         gT0JFPhI0my3eHfzAdDaLSxXXHoDghROwNvYUVkhJPHxp/bIcZW6+c23KTEejcVUrz6T
         hFSDb7PJGAk4CRK0LIftWpw8C5ohPa11ozAU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mCn2TEy6yaHr+0J6CyzwYwExaAaXeUXiViBtCfsv5VY=;
        b=FWtp6F6sZ6lckriD0i4q0XjfEEZ16lFngv2ZkcBlnfORxAMHfgsXSTbqb4EziDv/sz
         +gCxoVeTElKpbr0y+p9K6BWEnJokBxvnRj6bz2DqlrkdJmM1L1429/AVVeZVgFQiFWdZ
         6m0B0c7IJCiltM0n+zhbpxMWEAGIq2OCATf+UHihtcrZrLMfSh4hzYvsp0QaJ5Br3TJ9
         Km6L8o2GfR0VcXcNFbsR+7OhyQ7nTeXgMLs9QikT3hUM2Kzxtmqt++19HWPYK9IZhJD6
         fr2euQsO58jVzGE0tq8FcTpjqK2kj3mtr7hj7rzHNW7VWssHjQ/vvs5hvNKEBJ2PK58Z
         ZC4g==
X-Gm-Message-State: AOAM533XiUIQmAB1QtWxAiqimTZ88GnY+JDlIdCjZ4T/GL1l04moIX6P
        WcZgomtRFMFZ8Z2xEZmLUKcekfJeqmJKEhrZ/oXOSdL1O5tx
X-Google-Smtp-Source: ABdhPJyHP+hlV3CRdXlmtyJANEN5aNZLz0GTjM9ENgA68aqw6WaMgsRWKX9uLp7uoIsRoyUm8r9uxZhdrkCH
X-Received: by 2002:ab0:73da:: with SMTP id m26mr2455935uaq.136.1601673837610;
        Fri, 02 Oct 2020 14:23:57 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id x2sm327292vsn.4.2020.10.02.14.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 14:23:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v6 00/14] *Add Broadcom VK driver
Date:   Fri,  2 Oct 2020 14:23:13 -0700
Message-Id: <20201002212327.18393-1-scott.branden@broadcom.com>
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
[2] https://lore.kernel.org/lkml/20201002173828.2099543-1-keescook@chromium.org/

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

Scott Branden (14):
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
  misc: bcm-vk: add BCM_VK_QSTATS
  misc: bcm-vk: add mmap function for exposing BAR2
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
  misc: bcm-vk: add ttyVK support

 MAINTAINERS                      |    7 +
 drivers/misc/Kconfig             |    1 +
 drivers/misc/Makefile            |    1 +
 drivers/misc/bcm-vk/Kconfig      |   29 +
 drivers/misc/bcm-vk/Makefile     |   12 +
 drivers/misc/bcm-vk/bcm_vk.h     |  507 ++++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 1629 ++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c | 1363 +++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  169 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.c  |  275 +++++
 drivers/misc/bcm-vk/bcm_vk_sg.h  |   61 ++
 drivers/misc/bcm-vk/bcm_vk_tty.c |  333 ++++++
 include/uapi/linux/misc/bcm_vk.h |   84 ++
 13 files changed, 4471 insertions(+)
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


base-commit: ea39bd280a47b40ed7e756a2f7d669f4a0a0811f
-- 
2.17.1

