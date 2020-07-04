Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9A02144C8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGDKZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGDKZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4FAC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so23796997wmm.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bDNf3J71u1aUfcnNyg8gyy9KZOUzjLKhZpSmplNUzVU=;
        b=n7SAyMDoC8z9XGY9pGLfmg7j7xlUarueDRBmVPXx5wlzTW+NHKqXBu2H/pL+fr9uxB
         3bchYayv83a1Be2PrwfgB1qtqk1SvDPy5asdP3CDEVyPFFKDWEcAk9uQz1NVU2zEIHXW
         0o985UdlcDRlVZU7oON3XZpQMvJbk4S7h5C3cb1CQVhDvDyBxH19Qkvzt3079Gt/3q/2
         i+jhxpJjTPtex472NFmZIGlnoFj2ZX27DF/ea4TnLT1UA8xyW57TiO1CklA1tE33dTVI
         iEdEQFVgKkRVyAiOyd1I44rEsdBRPEBB4ApHVIZwc1V7uRlkUA00x7krm7zU4B/D2LvQ
         vZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bDNf3J71u1aUfcnNyg8gyy9KZOUzjLKhZpSmplNUzVU=;
        b=MFaVwqi90K8ycpCQk8J9qqhRxzg1eBtSf1f8Z64U1JQBnY7KtJiqtYAN4OhEEarX0k
         RRyIDHTARkN9FQA3bUMHUOZ7/fxkzCUyfsCD862WmFRljy8wPg5mG+5z43MXOOCP/HDL
         6uR2P4fCEzMSvew+zFxCFmcYLzESXfmoP80+XhV32pdFO6Q/RdOo2czbE0ugCk6Ibu0F
         pYndPa9Go9edBHGc83RdMyhSXl75B5TN6sKD269lVXmhKJe0jbhmRGXt0fzOCFOSKvMe
         7C9c2qmGzFag5m3KCoBFVyOsD1rbMIKfiajt2ZKemGszSqwU8RTFaNZiAYDdPqGXbs9z
         CQ4A==
X-Gm-Message-State: AOAM530tPT/4wjobtXiTaAe4KQf/WbQEpHO1yYa2p8EBAcowe8IzLQ9L
        wAvFDyWkifJIFHBFJGpjzoR3fLEa01U=
X-Google-Smtp-Source: ABdhPJyzdD6tO+bRBuPcM+rAdj+oVuvZ4Y1HfXEtSxZXy/ZXO3TR+iENAw9yF6eoD42kE3wPnpRemg==
X-Received: by 2002:a1c:6006:: with SMTP id u6mr39776781wmb.111.1593858342397;
        Sat, 04 Jul 2020 03:25:42 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:41 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 00/14] Add regulator devfreq support to Panfrost
Date:   Sat,  4 Jul 2020 12:25:21 +0200
Message-Id: <20200704102535.189647-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This serie cleans and adds regulator support to Panfrost devfreq.
This is mostly based on comment for the freshly introduced lima
devfreq.

We need to add regulator support because on Allwinner the GPU OPP
table defines both frequencies and voltages.

First patches [01-07] should not change the actual behavior
and introduce a proper panfrost_devfreq struct.

Regards,
Clément

Clément Péron (14):
  drm/panfrost: avoid static declaration
  drm/panfrost: clean headers in devfreq
  drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
  drm/panfrost: introduce panfrost_devfreq struct
  drm/panfrost: use spinlock instead of atomic
  drm/panfrost: properly handle error in probe
  drm/panfrost: rename error labels in device_init
  drm/panfrost: move devfreq_init()/fini() in device
  drm/panfrost: dynamically alloc regulators
  drm/panfrost: add regulators to devfreq
  arm64: defconfig: Enable devfreq cooling device
  arm64: dts: allwinner: h6: Add cooling map for GPU
  [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
  [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 102 +++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 165 ++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h   |  30 +++-
 drivers/gpu/drm/panfrost/panfrost_device.c    |  61 ++++---
 drivers/gpu/drm/panfrost/panfrost_device.h    |  14 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  15 +-
 drivers/gpu/drm/panfrost/panfrost_job.c       |  10 +-
 9 files changed, 290 insertions(+), 109 deletions(-)

-- 
2.25.1

