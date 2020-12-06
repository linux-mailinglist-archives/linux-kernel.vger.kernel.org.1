Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0312D0535
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 14:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgLFNes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 08:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgLFNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 08:34:47 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16089C0613D1;
        Sun,  6 Dec 2020 05:34:07 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b73so10768313edf.13;
        Sun, 06 Dec 2020 05:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ClADTS0QuKL62E36tFTJGwg2N6O3ikpA70hf73VQQnA=;
        b=CfD7avGjj9/HgOdFJm+Jgte+0mkMn+vGKFsqCQBDCZ50PATgRCsdgmcytM62CytxJC
         rvoAvmj62E3Fr8aYb3+wz3KU0pQ5tky/PGHGKhwth6triY4yAZRF9ayyBvVmA5HAp09P
         GW63o62egMZJHFzOX8EFlLGGbIj9FbCeI/fC99/r3EUs7hnZDLRqHi3fHe3NaYBUvi/L
         nq+BPdt0JUKhyhaUFbnmjY7niejby0WuKHKarxrQiTeI2BEEl1KFyw9cAXSb3CBRKOx8
         yPXMonW2DgspzsUmWeu0dsKjV4AokqjBVObeHzytEsmZF0vAqySZm5Hz0fyTciWeK2TC
         6Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ClADTS0QuKL62E36tFTJGwg2N6O3ikpA70hf73VQQnA=;
        b=RqXZY3QuyNOjXPuvA1wIu9aKc24cFMDxDJ//9byA+95/3ItplfNiE50zuyGXlHKiWQ
         dgqm2Icv1Tuzvnki5ZJlWezpY0wkmy9zewcl3kX4TvFUxUi3tIGWh86nLBVdQ4Mgmh1T
         qjpnKjkTLXEqN3DVdOIreHH1ut9cV80jn3vvfz5eAPBRIvlJGlWfunf9C1Robj2xYDO6
         uwls30zo2KKyxzDvkbNmRfYy0DEIin84kV6AZJGmY+weQlJy8lESm8aKc1fsJXAfEonv
         g1UQOHPTcQMQJUqA4mbxtyw/PX1fwoqXQGcAzrW3Orfy/qwo0U5sU2pVqCDjMbThhXjz
         kT4A==
X-Gm-Message-State: AOAM530osv64kN0GCOcDrS1XlVcLKHsHnY8Oami2omHIOTCDrwRXy9pj
        FDRRVIr4kGbSPKPY6JFmS1c=
X-Google-Smtp-Source: ABdhPJwPC3fbAsKPZT91sG3R8CMEf4NtuXxEwAQprJeqKkicBpn3851hCBqQkQzBx3hOuH58dimu0A==
X-Received: by 2002:aa7:db59:: with SMTP id n25mr14352860edt.203.1607261645894;
        Sun, 06 Dec 2020 05:34:05 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id qh23sm7770129ejb.71.2020.12.06.05.34.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 05:34:05 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] Enable rk3066a HDMI sound
Date:   Sun,  6 Dec 2020 14:33:50 +0100
Message-Id: <20201206133355.16007-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the rk3066a HDMI documents with a #sound-dai-cells property.
Include the code for sound in the HDMI driver.
Add a simple-sound-card compatible node to rk3066a.dtsi,
because I2S0 and HDMI TX are connected internally.
And as last enable rk3066a HDMI sound in the rk3066a-mk808.dts file.

make ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- -j4
cp ./arch/arm/boot/zImage ../zImage-dtb
cat ./arch/arm/boot/dts/rk3066a-mk808.dtb >> ../zImage-dtb
../tools/rkcrc -k ../zImage-dtb ../mk808.img
sudo ../tools/rkflashtool w 0x4000 0x8000 < ../mk808.img
sudo ../tools/rkflashtool b

Changed v6:
  remove patches that are applied to linux-next
  add platform_device_unregister()
  restyle

Changed v5:
  removed unused variable
  fill frame structure

Johan Jonker (4):
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
 drivers/gpu/drm/rockchip/Kconfig                   |   2 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             | 277 ++++++++++++++++++++-
 5 files changed, 307 insertions(+), 1 deletion(-)

-- 
2.11.0

