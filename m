Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0112F819B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbhAORHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbhAORHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:07:45 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB00C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:07:05 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n10so6364753pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4adxDxz9HqPVfz8Lxcu2pNJI7Jq0oZpTHx7mnjR2y24=;
        b=YCH08rkeWH6gnupZGfqnqtlqNK8NtZ4N2VJ+p6e1T7504rPR0S8s4XMQyv2JBs9gNx
         l0z3kSEOAdz0i0yTOdmUvDqUdDeQJYnXvS1iacXSAMPwt8oP5P+3r3VjL2ccNkJv8bES
         aE7/gZjQSscc9ii428ukfMJc5r3g5uukRk/x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4adxDxz9HqPVfz8Lxcu2pNJI7Jq0oZpTHx7mnjR2y24=;
        b=A/9XisLjqQZHbwNVUeLofSu+M6ofIsuN2yhcfD+V/sgi/SwjR/UUAJhScCG+ViK4nB
         PLOQzNQweLqrOGQSueLkoDBSR88hTnAqrVddbi/3upLKEeinWzkbrLFACqIpOlXBkx9o
         7aHZ1YQUAJYIWoHf7GpitAE/sFn5x4D5lcTLVSRtH6LW9KMrJfDjy5Y40pKCoGo9luIz
         WnQcyrDz23wgoJ1xocHlrMgWFdf76Jt9Jee5uYxZrZwsy08RYCnLMJhvitbcq8qfyW9i
         hmMmAThjDCuHGFc4in08qRJG8Y78lOQFwFi4o7rSxoDul2yBulZu1RxlS76BBzfH829R
         24bQ==
X-Gm-Message-State: AOAM532FQQ6iKLVBHNH4yA4gmtd4NLWqiEtPlTBg9uRxwFJWLmZc+gbf
        871UZJeet4TbuJzqNQQzjRDa3v6D66BvJTxf
X-Google-Smtp-Source: ABdhPJyT3TOdHA/cqUx5fzvZGFP+CY2+Tnv5+/Uc8wxERO63aZNGWJLIlojFxJfV931cpmRjzX4I4A==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr13505698pgg.196.1610730424928;
        Fri, 15 Jan 2021 09:07:04 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id t23sm8813329pfc.0.2021.01.15.09.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:07:04 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     swboyd@chromium.org, linux-input@vger.kernel.org,
        hdegoede@redhat.com, andrea@borgia.bo.it,
        kai.heng.feng@canonical.com, robh+dt@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Coiby Xu <coiby.xu@gmail.com>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Jiri Kosina <jikos@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/4] HID: i2c-hid: Reorganize to allow supporting goodix,gt7375p
Date:   Fri, 15 Jan 2021 09:06:36 -0800
Message-Id: <20210115170641.903392-1-dianders@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The goal of this series is to support the Goodix GT7375P touchscreen.
This touchscreen is special because it has power sequencing
requirements that necessitate driving a reset GPIO.

To do this, we totally rejigger the way i2c-hid is organized so that
it's easier to jam the Goodix support in there.

This series was:
- Tested on a device that uses normal i2c-hid.
- Tested on a device that has a Goodix i2c-hid device.
- Tested on an ACPI device, but an earlier version of the series.

I believe the plan is for Benjamin to land the whole series.  Will
said this about the arm64 defconfig change (and provided his Ack):
> ...there are a few things I really care about
> in defconfig (e.g. things like page size!), generally speaking we don't
> need to Ack everything that changes in there.
>
> That said, might be worth checking whether arm-soc have any defconfig
> changes queued in -next so you don't end up with conflicts.

Changes in v9:
- 120 ms delay => 180 ms delay
- Local variable in ACPI code "ihid_of" => "ihid_acpi".
- Squash Benjamin's change for ACPI power on.

Changes in v8:
- Mark suspend/resume as static as per patches robot.

Changes in v7:
- Rebase atop commit afdd34c5fa40 ("HID: i2c-hid: show the error ...")

Changes in v6:
- ACPI probe function should have been "static"
- Don't export suspend/resume, just export dev_pm_ops from core.
- Fixed crash in ACPI module (missing init of "client")
- No need for regulator include in the core.
- Removed i2c_device_id table from ACPI module.
- Suspend/resume are no longer exported from the core.

Changes in v5:
- Add shutdown_tail op and use it in ACPI.
- Added mention of i2c-hid in the yaml itself as per Rob.
- Adjusted subject as per Rob.
- i2chid_subclass_data => i2chid_ops.
- power_up_device => power_up (same with power_down).
- subclass => ops.

Changes in v4:
- ("arm64: defconfig: Update config names for i2c-hid rejigger") new for v4.
- Fully rejigger so ACPI and OF are full subclasses.
- Totally redid based on the new subclass system.

Changes in v3:
- Fixed compatible in example.
- Removed Benjamin as a maintainer.
- Rework to use subclassing.
- Updated description.

Changes in v2:
- ("dt-bindings: HID: i2c-hid: Introduce bindings for the Goodix GT7375P") new in v2.
- Get timings based on the compatible string.
- Use a separate compatible string for this new touchscreen.

Douglas Anderson (4):
  HID: i2c-hid: Reorganize so ACPI and OF are separate modules
  arm64: defconfig: Update config names for i2c-hid rejigger
  dt-bindings: input: HID: i2c-hid: Introduce bindings for the Goodix
    GT7375P
  HID: i2c-hid: Introduce goodix-i2c-hid using i2c-hid core

 .../bindings/input/goodix,gt7375p.yaml        |  65 +++++
 arch/arm64/configs/defconfig                  |   3 +-
 drivers/hid/Makefile                          |   2 +-
 drivers/hid/i2c-hid/Kconfig                   |  47 +++-
 drivers/hid/i2c-hid/Makefile                  |   6 +-
 drivers/hid/i2c-hid/i2c-hid-acpi.c            | 143 ++++++++++
 drivers/hid/i2c-hid/i2c-hid-core.c            | 252 +++---------------
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c       | 116 ++++++++
 drivers/hid/i2c-hid/i2c-hid-of.c              | 143 ++++++++++
 drivers/hid/i2c-hid/i2c-hid.h                 |  22 ++
 include/linux/platform_data/i2c-hid.h         |  41 ---
 11 files changed, 578 insertions(+), 262 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of-goodix.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of.c
 delete mode 100644 include/linux/platform_data/i2c-hid.h

-- 
2.30.0.284.gd98b1dd5eaa7-goog

