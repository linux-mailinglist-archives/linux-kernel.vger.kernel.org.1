Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6892A2AFC91
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgKLBj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgKLAll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:41:41 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95428C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:41:39 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r10so2651326pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Utwe4xR8J8QGLdCImujYGLQlNTOgzBqC1iHA5Eyo1w4=;
        b=R2s1M0pmReZg68qwieY3zSp8emiSgL1YMPaMVa32i0hE9tK60LpmUBVrpNiinG6vQJ
         i07E5AMD14YR0zSnIE9S1JJyVleGMI+Zcjm77YA/Ddmh6xWeMK+51bUDesZWNZ9XKRY1
         YGLn+bz3iMLkZu6zhEs8FfLq3CY4Ml06aoXVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Utwe4xR8J8QGLdCImujYGLQlNTOgzBqC1iHA5Eyo1w4=;
        b=LE6rwLZoBgmKIGFnJ4wn3SoXO1JUUh/CAGlb/fwZSmpCmBUQJyLB6pZfVwkkb2JJCM
         YOlhIxBu1GjHUHe9qBY2EELvRW5rYDGKpamPc/uC/uPqJmhPeMIkVx6hz6lEguWRlkzs
         xVKCzjqpiqnXkjNAo371P316199l2azNp0TzLfk6B6iSjE0PHwdh2K6OodXDxOiAHreT
         fFe6ITIcb3obGSbp52BjkMlav69gau/Oz8Tqhs3eYT4pMNV3hmkscxm+eM88v2eQavl3
         P3YJFkXM6001pOy9TXcPQrPzZ6ps7RjLW/S6/RsoS8DR/6XfavVFyuBahnCJfd7qi3FC
         ha2Q==
X-Gm-Message-State: AOAM532/6rnQqoW7oyNFlZp74GoK/qmW1AwNRo4DVmfqKvz1x93LVtrb
        pSuTNh2pXbIUVL44tsOM4UMgfA==
X-Google-Smtp-Source: ABdhPJyVp3nagtjEa+HXLXT+UNnpG/bMPWN3BscAh7XrhLgMKsFjUAPbrXErc++yKAhQWjX5SqM88A==
X-Received: by 2002:a17:90a:df15:: with SMTP id gp21mr6542210pjb.37.1605141698821;
        Wed, 11 Nov 2020 16:41:38 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id t26sm4265522pfl.72.2020.11.11.16.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 16:41:38 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     andrea@borgia.bo.it, robh+dt@kernel.org,
        kai.heng.feng@canonical.com, swboyd@chromium.org,
        linux-input@vger.kernel.org, hdegoede@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Kosina <jikos@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>, Pavel Balan <admin@kryma.net>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] HID: i2c-hid: Reorganize to allow supporting goodix,gt7375p
Date:   Wed, 11 Nov 2020 16:41:26 -0800
Message-Id: <20201112004130.17290-1-dianders@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
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
 drivers/hid/i2c-hid/i2c-hid-core.c            | 254 +++---------------
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c       | 116 ++++++++
 drivers/hid/i2c-hid/i2c-hid-of.c              | 143 ++++++++++
 drivers/hid/i2c-hid/i2c-hid.h                 |  22 ++
 include/linux/platform_data/i2c-hid.h         |  41 ---
 11 files changed, 596 insertions(+), 262 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of-goodix.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of.c
 delete mode 100644 include/linux/platform_data/i2c-hid.h

-- 
2.29.2.222.g5d2a92d10f8-goog

