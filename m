Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F390127F75A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgJAB2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgJAB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:28:38 -0400
Received: from mail-ua1-x962.google.com (mail-ua1-x962.google.com [IPv6:2607:f8b0:4864:20::962])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:28:38 -0700 (PDT)
Received: by mail-ua1-x962.google.com with SMTP id z1so1003875uaa.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XrMWBdIIXtq6OAFmqihkomRdN9WgxwGFWIxYG4MNOMA=;
        b=MlZ7BjtEd7IfVlXRUHlfv7YG3ulNRrzI7e8WL0Rizn4WHMD+fmgi3egWEoePAGd4Kp
         MXajIPLthTLUq16BSCPmE3RSNWMsfNaVJMAKooHS045zXFJOm9EoBraqnEkMO4FhSteV
         iVb7L51hO9LyWAVjsukcRW9MiAD/JXwnmfawU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XrMWBdIIXtq6OAFmqihkomRdN9WgxwGFWIxYG4MNOMA=;
        b=ioPvd7PYTkJ6v2gLhbRHyHvpAm1DeQ2GF47NhSmcXJyy19wZ/CqSGQKhmiJpItoYXF
         0Slp9c7EiJS71RSJcb9Wb7+qbjdgDwVSSJPJZbSyuEAOgNJ1J6gCHwNNB6QKinN8DLwx
         kMvrRQ3kiNm9rKftoOQrdqRO/Z0HNDCr3r0dECa+p1+eKLYQ6klpGQ3WYHlu6meErijQ
         /rB9Sii9W4tNE6spHu8WrI9RbINtuDGHDhmuEBtesL6XwjDG/9rY//uY/Ada3BgXwGV4
         53PqSTz+Ljeo7UYpZywdgmp3QhIKHb6pcZOQbNx0BLlqsvR13/SoEtr6QgdRILlp22H9
         s6DA==
X-Gm-Message-State: AOAM532Zm8QZOWfFRydT0l2WZxKm937CyB4EPsnrgMhH4QNlxxQ360f+
        FEfIXGdz3WrjO02uC2gO4Nht0YYvO0DQwCcEjw5PK4LeeJkf
X-Google-Smtp-Source: ABdhPJx/Uy9npsmI9XZ4ssLckG8LZ2sv58VsC0iLEUxj1K2ala7L1xaLh22oFbcQyClLn5pZ7HGrbwNRdIyk
X-Received: by 2002:ab0:4425:: with SMTP id m34mr3394096uam.19.1601515717109;
        Wed, 30 Sep 2020 18:28:37 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id r25sm520472vkq.14.2020.09.30.18.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:28:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v5 00/15] Add Broadcom VK driver
Date:   Wed, 30 Sep 2020 18:27:55 -0700
Message-Id: <20201001012810.4172-1-scott.branden@broadcom.com>
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

Scott Branden (15):
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
  misc: bcm-vk: add sysfs interface
  misc: bcm-vk: add mmap function for exposing BAR2
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
  misc: bcm-vk: add ttyVK support

 MAINTAINERS                        |    7 +
 drivers/misc/Kconfig               |    1 +
 drivers/misc/Makefile              |    1 +
 drivers/misc/bcm-vk/Kconfig        |   29 +
 drivers/misc/bcm-vk/Makefile       |   13 +
 drivers/misc/bcm-vk/README         |   99 ++
 drivers/misc/bcm-vk/bcm_vk.h       |  510 +++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c   | 1634 ++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c   | 1363 +++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h   |  169 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c    |  275 +++++
 drivers/misc/bcm-vk/bcm_vk_sg.h    |   61 ++
 drivers/misc/bcm-vk/bcm_vk_sysfs.c | 1411 ++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_tty.c   |  333 ++++++
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

