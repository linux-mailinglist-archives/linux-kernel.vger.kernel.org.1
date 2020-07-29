Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8F23270E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 23:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgG2Vnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 17:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Vnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:43:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB3CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:43:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so12582416pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=COgsXBvpKNh9mAx6VgjdbMllWMfe0jQ2ahs0hJfad7s=;
        b=K/eMS4RAhEI6jr8M3Owvp3gcL+1+KtVZJg/mVkfGiTPm/j4JAe8GKN6/jSl6elka4p
         smOIUK6I4D27Oo/N3NtA9pl/Ukbl3+zuS+0pyh/nvnPxpY1qpjdFc4AJ3vSkyOVjOpiM
         105HVUywuqDLpyiu94850/9iBhRrZUxbZORKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=COgsXBvpKNh9mAx6VgjdbMllWMfe0jQ2ahs0hJfad7s=;
        b=P9aCODRAYM6Lb9uNuTYgyAPss1LCs+0E2FnKS/Qoiy8RdykgFO2uI1+0hPb/hFHc5e
         JOHy0G666+cn9RA9H6YiEUSY22HEjrB4BhuOhRSYB5V7MSvyx/mBcZtcU4IygirzIx4S
         jl2Eh9qkIW8xi6D/Tbq0yrHuikvunppje+5gfjdTnDbvplee5K2rNv8W+0j17SzxDM/f
         PIU/Cn97LPk25KLkV5pqk1QqtXlsvNUdFSJJo+XvistK8gm8T2xQA66vNp+VAhYbE8Ed
         eoyB6ezrY59LcPIRCXjh/w71bQ9JDY0pZZ7jogmkmQ7VBKQWN58y44uRRyC6gVZPMElg
         2eyg==
X-Gm-Message-State: AOAM530Pyp1QDNifmaLo3BeYZcI1FRZVIZkB41Q3aWjGV6m4WG/2H20H
        DKQQh0PtFppEhBFKJrpD0tX8Ww==
X-Google-Smtp-Source: ABdhPJzqpcVzVfQW+lfLCaNyN7vLRcgY5yaRId21wZwUbQHL+rn2LPDNkEwdwKvzLai81yf+lpDh9Q==
X-Received: by 2002:a17:90a:14a5:: with SMTP id k34mr12059805pja.37.1596059011254;
        Wed, 29 Jul 2020 14:43:31 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b82sm3547527pfb.215.2020.07.29.14.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 14:43:30 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 0/3] Add Broadcom VK driver
Date:   Wed, 29 Jul 2020 14:43:18 -0700
Message-Id: <20200729214321.11148-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series drops previous patches in [1]
that were incorporated by Kees Cook into patch series
"Introduce partial kernel_read_file() support" [2].

Remaining patches are contained in this series to add Broadcom VK driver.
(which depends on request_firmware_into_buf API addition in
other patch series [2] being applied first).

[1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
[2] https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/

Scott Branden (3):
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom VK driver
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver

 MAINTAINERS                      |    7 +
 drivers/misc/Kconfig             |    1 +
 drivers/misc/Makefile            |    1 +
 drivers/misc/bcm-vk/Kconfig      |   29 +
 drivers/misc/bcm-vk/Makefile     |   11 +
 drivers/misc/bcm-vk/bcm_vk.h     |  424 +++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 1369 +++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c | 1507 ++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  211 +++++
 drivers/misc/bcm-vk/bcm_vk_sg.c  |  275 ++++++
 drivers/misc/bcm-vk/bcm_vk_sg.h  |   61 ++
 drivers/misc/bcm-vk/bcm_vk_tty.c |  365 ++++++++
 include/uapi/linux/misc/bcm_vk.h |   99 ++
 13 files changed, 4360 insertions(+)
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

