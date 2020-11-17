Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADCF2B724D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgKQXYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgKQXYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:24:00 -0500
Received: from mail-oi1-x264.google.com (mail-oi1-x264.google.com [IPv6:2607:f8b0:4864:20::264])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD5C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:24:00 -0800 (PST)
Received: by mail-oi1-x264.google.com with SMTP id d9so126657oib.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kITuww2ahLZuCCtkTmU/9GdLFPSTFU/rSOFcgScUBfQ=;
        b=TLib962kYixicJAUBcsWgjFAiBifR0oK8/cAaeYh1AVvrP1M6GUdt3tIZhwKVBKEy2
         xzHhic3CheYDPqgZRb6vAdaUdHbmM9F8uFVxZ8YerrdBdxTnjj8CTwp/kN9loTXKcsQX
         15xXB9UJEbVA6dBqAoIqJl++1J0tFG4kJHY74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kITuww2ahLZuCCtkTmU/9GdLFPSTFU/rSOFcgScUBfQ=;
        b=WMFPqocyRvs7KaRPUwtG6IbVMjJO2I4lWrCTZLlUfnKPQbVZjmtBXMeZHkDLlSrE2e
         914Oa//YMk6MbBcaGej83zdGJSda5yzGCznD+LHwEO3ZVmWHu7Vr9FFJVW+5Ru4MPX9P
         sadIp5LOVLe2/NvidsZi6fAUcl5k0Z4sV6ZvOwfbYRm0BzIYqIZ9tpPFiasMjQxTeeFE
         KPKYN2DRPqr0uomG4WBLB1GI6LqI8290WhcgCrb/un/n6tSAZmLJEyxh0gKBVbGM8/gQ
         VvSGuWGC6d/0gaEizdiNDQaLq2rq7hb7KRMG74/3TyVVcfeAPST9QhAIupUbnva6sWbe
         gAKQ==
X-Gm-Message-State: AOAM532zsI0o5izicKjNwEfMhMy6kZdr4oqJMkWgzUMHcsFLYzUnqWA/
        nINuc0JHKIMEkPGXaK+266xWmG2HBP8j6bcSWPQO5YFbABhU
X-Google-Smtp-Source: ABdhPJzB6kGeORAt/M/DsZeAHnrvNWhEgJ7eXpg0Ou4B1mlgoqRUWgPyy9toPLA9lIGDVhRcLIOkPXgEPiXT
X-Received: by 2002:aca:a951:: with SMTP id s78mr1057274oie.114.1605655439555;
        Tue, 17 Nov 2020 15:23:59 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id q22sm5867076otg.13.2020.11.17.15.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:23:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v7 00/13] Add Broadcom VK driver
Date:   Tue, 17 Nov 2020 15:23:07 -0800
Message-Id: <20201117232320.4958-1-scott.branden@broadcom.com>
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
 drivers/misc/bcm-vk/Kconfig      |   15 +
 drivers/misc/bcm-vk/Makefile     |   12 +
 drivers/misc/bcm-vk/bcm_vk.h     |  513 ++++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 1651 ++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c | 1350 ++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  163 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c  |  275 +++++
 drivers/misc/bcm-vk/bcm_vk_sg.h  |   61 ++
 drivers/misc/bcm-vk/bcm_vk_tty.c |  333 ++++++
 include/uapi/linux/misc/bcm_vk.h |   84 ++
 13 files changed, 4466 insertions(+)
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

