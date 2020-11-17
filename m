Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695262B6F16
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgKQTpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgKQTpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:45:17 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E8C0613CF;
        Tue, 17 Nov 2020 11:45:17 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id v22so23736330edt.9;
        Tue, 17 Nov 2020 11:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7FuTWq4BSG35jYcVC2y/aAokRjHupx3BOtYk6g9sB7k=;
        b=bEGG7+pWjohHYGCns+rU7864961TKkiTrUm42uvT6LxfEO1YbnvJekuitA/BWkBKCo
         qsN7cTlm7OY2hRiTAQmLfnUp5/8RZkKp3Z1cgY6qHSkU2RUHKqAoAI1oAj92qbp+41pe
         b6MjEliAQcKXdDVxBibvY1dzSUPVoAUuBdgwaCY1IAT2zds2yNeNwWnKqoWmVMTxDpmU
         Akl7TpvzvH5UZnc2SzUfp1e4+K8aIFpDLyllv88lW4vf7WvlidV+fOa2lO/WErCtz9Eb
         wrQ/xv8kRnYDHyi6GvBxmPENKiQuoaJ2MA8DAOb2WxOwi6mr7o/5gY81Y8VYrIQ0wr9s
         1piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7FuTWq4BSG35jYcVC2y/aAokRjHupx3BOtYk6g9sB7k=;
        b=JAp6rLSDz8xSSKqpNf0dKOYpmnfXdCd6f/RMZzBqBkNcVA/xrJP86Ea2TD46X7YJKl
         RFKRxO0bu4o9XOunvrSyZZDiNfS7f7jGcWWl6GbrpaIGWMz+GLksPhOnYyx+P0ZfwuRd
         JIZm5PFFxXglEYxYIQnu3IRH4j1SKim4+hmzHNJqSptYRvhooY7z9RG1c2T+BJ/f6tdE
         qydrTeqmgPNwqgH0/R1YGCXzoOtqwN5w21ecwiY5RZ5v3t08LemA/UUuguE8Y/QDqXBq
         /6jKJbg4J1N9u5ghFNYyoiyYyfUaSlwVgyB8aCfBcVFNwIu7otzJPZ7ebzuYYAX/BR2a
         04IA==
X-Gm-Message-State: AOAM533W0Q0l/jdZDLvWWgLZItY3fGngUjbE7fDBqotSExvZNOKvqAiN
        8ReXT93OYkqdnBWGnpbyznfqUawlL14Big==
X-Google-Smtp-Source: ABdhPJwioSe6dJaxInh8X3IisG9hWd9obKO0KYfxQKA8qdRvbEI9nQjadusnXlOz4yN8QPtxAn5+Fg==
X-Received: by 2002:aa7:df82:: with SMTP id b2mr21560851edy.251.1605642316279;
        Tue, 17 Nov 2020 11:45:16 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w2sm727972ejc.109.2020.11.17.11.45.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 11:45:15 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] Enable rk3066a HDMI sound
Date:   Tue, 17 Nov 2020 20:45:00 +0100
Message-Id: <20201117194507.14843-1-jbx6244@gmail.com>
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
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             | 272 ++++++++++++++++++++-
 6 files changed, 320 insertions(+), 18 deletions(-)

--
2.11.0

