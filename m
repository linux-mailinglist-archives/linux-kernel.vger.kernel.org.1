Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60F02B7ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKRN6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKRN6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:58:32 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38B3C0613D4;
        Wed, 18 Nov 2020 05:58:31 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q3so2059859edr.12;
        Wed, 18 Nov 2020 05:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O15+S8qQJDT/sctgXYGA2Ljv6MPm4itzezho9fQXrTw=;
        b=E0TgA8FvVhJVuL4QjwryYioG5ukaTZDNGKeVPP3cxNuekjQQhONNdSjVEESHmJaMnN
         FVEhigRNXoJlEDXlkZED6SOZu4whMRqRW0kN12qqnG1hTjYB/YXvJ8tOQmaj2tzD8/Xe
         tG5CucGg2BBmGqVIvY214dt5Dpd2RySOukfaAinlUD1qgjnqLqLVxwjIkzqzIca33e77
         qVhzBxHLQ0J0l8xc1UU1XZe7zySDlJF3C7lK/QV6Qo7WqkHrBoWN/qNKiQltWAV5nLN6
         TlIbrXowVBZwxjV5kuY8jvvFRVYK65IvSQSa3WziRuUpuKBdLZKH1G6Yfe4d83n4VDq4
         MF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O15+S8qQJDT/sctgXYGA2Ljv6MPm4itzezho9fQXrTw=;
        b=a4YPT+xcZ/iMJR49uIv1FdaHQaiwnO7AGXoWagAKxNlcy4o13jtsQy8RQr0iq4W2mz
         3x4xHpDN3CoENpeBFUv53r/Va/I1bRtJyVDqUAzQLb8ZWVCxp6h7HFovvw8B9Y7nGPmP
         zi6sjilz5YT4XEX+DGTGl2jYZZ1bnuAlQ2qaHTe0rGPgixPAwauco3jlIsQXpaogRmBt
         glxaoS7us6wfM/Css70tgAZ+PFH2XISyXNDhMDrCQ9Autd15cIsq+C9hisB/83TFu4UQ
         QDt6R/xVeh5dwwWKdyIqqEijwIkbhZnL/TuXgGJSyb6VE8uSuFhnVSSiIPk8x6rjxtzQ
         ZbyA==
X-Gm-Message-State: AOAM532MEPRHjqLOUOvL9g0Pr01CDwTRx83yn9oHv17I0zv6dn20QMh6
        99q1r/LzJEHvKlnjuZoW97M=
X-Google-Smtp-Source: ABdhPJyEp8bQ0cA1TBErbYejuIdVGGdRiXYdRohu8yPSprOL85WW3/XUARu8cgP0kyWc2Poc9qXFYA==
X-Received: by 2002:aa7:d703:: with SMTP id t3mr25109179edq.375.1605707910648;
        Wed, 18 Nov 2020 05:58:30 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cx6sm13721384edb.61.2020.11.18.05.58.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 05:58:30 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] Enable rk3066a HDMI sound
Date:   Wed, 18 Nov 2020 14:58:15 +0100
Message-Id: <20201118135822.9582-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First fix some legacy things in clk-rk3188.c that was never updated,
because probably nobody used rk3066a I2S before in the mainline kernel.
Update the rk3066a HDMI documents with a #sound-dai-cells property.
Include the code for sound in the HDMI driver.
Add a simple-sound-card compatible node to rk3066a.dtsi,
because I2S0 and HDMI TX are connected internally.
And as last enable rk3066a HDMI sound in the rk3066a-mk808.dts file.

Changed v5:
  removed unused variable
  fill frame structure

Johan Jonker (6):
  clk: rockchip: add CLK_SET_RATE_PARENT to sclk for rk3066a i2s and
    uart clocks
  clk: rockchip: fix i2s gate bits on rk3066 and rk3188
  dt-bindings: display: add #sound-dai-cells property to rockchip rk3066
    hdmi
  ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node
  ARM: dts: rockchip: add hdmi-sound node to rk3066a.dtsi
  ARM: dts: rockchip: enable hdmi_sound and i2s0 for rk3066a-mk808

Zheng Yang (1):
  drm: rockchip: add sound support to rk3066 hdmi driver

 .../display/rockchip/rockchip,rk3066-hdmi.yaml     |   4 +
 arch/arm/boot/dts/rk3066a-mk808.dts                |   8 +
 arch/arm/boot/dts/rk3066a.dtsi                     |  17 ++
 drivers/clk/rockchip/clk-rk3188.c                  |  35 +--
 drivers/gpu/drm/rockchip/Kconfig                   |   2 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             | 275 ++++++++++++++++++++-
 6 files changed, 323 insertions(+), 18 deletions(-)

--
2.11.0

