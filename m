Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C02F66FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbhANRJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhANRJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:09:13 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677FAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:33 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jx16so9229975ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZBe6+BA7tdZGkyochkRBwv5ISoXDHJ6XemChWzr63Y=;
        b=Jj1zFKh+4yTO85hcuIosWpVFXEmtoROxkTyphLYun1n6kaN2CkjGvNXCzmX2RkB94R
         7Ig1DvDG9LOcg3SAoQc54oKSPYIEu0KBULIzDuphh/xMVBOs1iuP5Qz0uSEgBvXmnyRY
         M2veC8ZLnFTu2y76KmwZcBSMF57rT1UDyGUUvDukIrhlg5z6R1E893Y1oc96j8AMl/an
         0Z/JLuj3dE9Q7yWmBbA86o/tL/QWWnlcvt+uEde02GoHM21b1CVR5XVT3/pLKL+Z0vVm
         oLZkiYY3qZf2iJKN9i02mkb6NZWTeZC+aus7p7kBdGXT/V0FQJPaE6Wi96KZUGEku0Oa
         zx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZBe6+BA7tdZGkyochkRBwv5ISoXDHJ6XemChWzr63Y=;
        b=ttVZ22k32COgIM4eFAndpoMruhWg6REh8gR8N6G05ehy7geB3vjSecfaJ5WYfI2Hj6
         n91EpHpPzQrFAuyRKw9P/yxl1c8WBoTeie5pXwg7vt3YWevuOoVmUrInpwGFymZp6dz5
         +ID4kt0o7IY+u4tdXherwNROBOEEFZXJ7pR//SED2sAax6i+g8LwXD8drNR2ub0VvM0a
         qQmLk5PBfNlP1Sn7e7869HBLZNFmsix1JI7H3wzbcQn7QS1M8an9jyxz3yE0uqgzQoLR
         aXyQxzGTs5LvdDRfRFzDUBkujDkQXvUTNpgM1X+Yj5FVuW7V4qa9iWkwjFqpO7Pp8MoW
         2A+A==
X-Gm-Message-State: AOAM5310P/SiwWA15Aahg9O/Oc9QbMuqoTABsSb9a99ZbphFm4dofX/2
        RgujfaBXTMaHheVJA70tQlmN7jKCwKX3rg==
X-Google-Smtp-Source: ABdhPJwxukBQL4HcZQR29MAZHscDUpiFLJVX3dztYzf7R0Zq6fBT6sdF4hQbpBfGR6KCtKMILT6Q3Q==
X-Received: by 2002:a17:906:7090:: with SMTP id b16mr6106096ejk.76.1610644111903;
        Thu, 14 Jan 2021 09:08:31 -0800 (PST)
Received: from yoga-910.localhost (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id be6sm2397644edb.29.2021.01.14.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:08:31 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/5] bus: fsl-mc: add userspace support
Date:   Thu, 14 Jan 2021 19:07:47 +0200
Message-Id: <20210114170752.2927915-1-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

This patch set adds userspace support in the fsl-mc bus along with a
rescan attribute to the root DPRC container. An earlier discussion on
this functionality can be found at the link below. I didn't continue
with the versioning scheme since quite some time has passed since the
last discussion.
https://lkml.org/lkml/2018/11/20/1162

The FSL_MC_SEND_MC_COMMAND ioctl acts as a direct passthrough to the
Management Complex (or MC) by passing fixed-length command/response
pairs. Keeping in mind that the MC manages DPAA2 hardware resources and
provides and object-based abstraction for sofware drivers, the proposed
ioctl interface enables userspace tools to do the following: 
 - Get layout information about the available resources abstracted and
   exported by the Management Complex firmware. This is especially
   useful to generate a complete description of the current hardware
   resource partitioning.
 - Manage DPAA2 objects lifecycle (create, destroy) and establish
   connection between different components as needed.

The ioctl interface is intended for dynamic usecases where DPAA2 objects
need to be created on demand or destroyed so that the underlying
hardware resources can be further repurposed. In static usecases,
depending on the requirements, a firmware configuration file can be used
to describe the needed DPAA2 objects, their attributes or any link
between them.

Each command received through the ioctl interface is first checked
against a list of accepted MC commands. Also, commands which would alter
the hardware resource management require CAP_NET_ADMIN.  The command is
also check so that it does not contain garbage beyond the maximum size
expected for that command id.

Ioana Ciornei (5):
  bus: fsl-mc: move fsl_mc_command struct in a uapi header
  bus: fsl-mc: export mc_cmd_hdr_read_cmdid() to the fsl-mc bus
  bus: fsl-mc: add fsl-mc userspace support
  bus: fsl-mc: add bus rescan attribute
  bus: fsl-mc: add autorescan sysfs

 Documentation/ABI/stable/sysfs-bus-fsl-mc     |  19 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   2 +
 drivers/bus/fsl-mc/Kconfig                    |   7 +
 drivers/bus/fsl-mc/Makefile                   |   3 +
 drivers/bus/fsl-mc/dprc-driver.c              |  33 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c               |  96 +++
 drivers/bus/fsl-mc/fsl-mc-private.h           |  49 ++
 drivers/bus/fsl-mc/fsl-mc-uapi.c              | 547 ++++++++++++++++++
 drivers/bus/fsl-mc/mc-sys.c                   |   2 +-
 include/linux/fsl/mc.h                        |   8 +-
 include/uapi/linux/fsl_mc.h                   |  34 ++
 12 files changed, 789 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-uapi.c
 create mode 100644 include/uapi/linux/fsl_mc.h

-- 
2.29.2

