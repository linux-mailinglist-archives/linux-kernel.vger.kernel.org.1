Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C8E2D8202
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406895AbgLKWZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406878AbgLKWZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:25:37 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8777C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 14:24:56 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t3so8083813pgi.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 14:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaHpOzVSojvNq1kaEb21BgS4v/5tZv/oDYr1cb6/VYk=;
        b=PhAxpjO7rK1sY5ytSqCdYeLOL3eWACAxxVNb1nqAgNJoJxcYWb7WuVVsYdnlHmrkpf
         NBgTpZUOi+Oii/3ttxBXHCXSrXCah0oi8h6GoJzkLd83rIi+KOgFdivgXx/Xvv0MSF2I
         A75z9xmBm8BrTDDeAl0U3fz0T9WKaY2gI4M6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaHpOzVSojvNq1kaEb21BgS4v/5tZv/oDYr1cb6/VYk=;
        b=Zq/R65JHNa/zYVVozGAs5t0WGbUIqBlVfTMOs7V01OaD40gsEndaQ+7fyJ5jOaW0Lb
         RlfInZMluWeggjwXldCw9lFchDMvtm8WBKG8BjcZHQ9pgNFgdgyIBOH4Ui+vtV+7D80R
         rjEVKrRlotD0Keoc9aZ17FWd4IyQUbXcHdMfcXmuoXPWBUhL5spB453ELlLP4aL8bbaT
         Cd5cDZzVD5Uw5tUhbqWA3nU9nJPoihFzsFhMC4Oq0ArhtS+r0hgcSQ/LO8XiIIBzdScM
         I9DhQM/TfSs5yH6/h1ZpwLYRjDZeo0xU9Yjs4jhdyRIRBAQjdxleQmNdP9TeYv7Vl3nj
         6ayA==
X-Gm-Message-State: AOAM530qR2V9rtK5DcRv40H59iCu9mxya9Ypots74oja2Tx8CpO/c+1O
        hPHmyZK7jNfe4pLs3DYWsOk8yg==
X-Google-Smtp-Source: ABdhPJzaxyslnWOzuXRc4oTI5Ifx2lqquL+FqgB54QdHqRj5jfeI8LVI2K2roZLWzVWTOWpRtMjq2w==
X-Received: by 2002:a63:f201:: with SMTP id v1mr14034360pgh.267.1607725496533;
        Fri, 11 Dec 2020 14:24:56 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id w70sm11669969pfd.65.2020.12.11.14.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 14:24:55 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     hdegoede@redhat.com, linux-input@vger.kernel.org,
        kai.heng.feng@canonical.com, robh+dt@kernel.org,
        swboyd@chromium.org, andrea@borgia.bo.it,
        Douglas Anderson <dianders@chromium.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Jiri Kosina <jikos@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Pavel Balan <admin@kryma.net>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/4] HID: i2c-hid: Reorganize to allow supporting goodix,gt7375p
Date:   Fri, 11 Dec 2020 14:24:44 -0800
Message-Id: <20201211222448.2115188-1-dianders@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
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
 drivers/hid/i2c-hid/i2c-hid-acpi.c            | 159 +++++++++++
 drivers/hid/i2c-hid/i2c-hid-core.c            | 252 +++---------------
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c       | 116 ++++++++
 drivers/hid/i2c-hid/i2c-hid-of.c              | 143 ++++++++++
 drivers/hid/i2c-hid/i2c-hid.h                 |  22 ++
 include/linux/platform_data/i2c-hid.h         |  41 ---
 11 files changed, 594 insertions(+), 262 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of-goodix.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of.c
 delete mode 100644 include/linux/platform_data/i2c-hid.h

-- 
2.29.2.576.ga3fc446d84-goog

