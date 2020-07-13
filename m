Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0821CC6D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 02:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgGMAZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 20:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgGMAZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 20:25:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BEBC061794;
        Sun, 12 Jul 2020 17:25:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id r22so10674432qke.13;
        Sun, 12 Jul 2020 17:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MNQQ+hyQNqz/JuGSalQ8ldWzSx4fTga3Roz/EAlmuLc=;
        b=aLRApDcz2S4eAcRZu0S4mUjBqA7Pxccts1w4+QmFqlzD5M4yra7I48rG7WkCN/QBtP
         BNI1mmCBRuQq2S0YdjvnQVX7v2Lz2aJSDccpq+YO5nrL3EmWhas1FcREdqvCR7FkUIJ1
         pA3qCmSobQvmyNt6HzxR2DrIpkYtL7gxDwKctxFCdB4uoapQzEJekNrbiWElpCCTFDBv
         SBS76YFxbPOdB35SAiny4jeuozqgUtdaCuJSPx8qkyJLEp1eqV0HKRG8e6m0PRKae+gd
         YbKc9OmcaQWIEFLJ9LD8YQb1abEhOjYQ7TkI0/T7Ydw5SKk8iTeZSx7J/DFPNYQw/2Us
         CecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MNQQ+hyQNqz/JuGSalQ8ldWzSx4fTga3Roz/EAlmuLc=;
        b=CX1v67wgOb9Gr42ysdIEHyRnaV05Pa1kDb2k/5uyybEXOyZVLi9Wi2qayM5+VG8r5o
         Ue/ZDwpWdb68I1VmS9iJtlqEr+f/RWfPZ8zFs9AdmGA1s7ZAC/wT6v+VzVO/HP8pyso5
         F/z+FtjX1uMn69NLH8QXyfWV8623vjxTH7UgKZrW9xcVQJP8CbOBbonHKGiS79/tuc6b
         Hl6JeF/w9tRbC9OdOH8mUVSzK3U6thJXq1trprU3fL6Eac3LmwYvdl65jVyP8fH5PgnZ
         +/o/cyvvE8mETb73tjFsqQjrJHumHr1tcSkO+/knM5jHlYmXPBtWVhuW0g90FsEKRAuO
         vnvA==
X-Gm-Message-State: AOAM532viKc7/0K+Lg/a7bQo8Oaw7RUsQUb4C4tn/BV7vXzsSLRBPUS6
        0pxsIbRLRnANeVnVeyqYJZU=
X-Google-Smtp-Source: ABdhPJygFZaTQ/4r8Q45IxyGdkrJNhgiE8e+dUZVrGs+qeDGkHO7T5mG5bd5rWtJbTVtpBYMM3hhFQ==
X-Received: by 2002:a37:6488:: with SMTP id y130mr76336140qkb.194.1594599916663;
        Sun, 12 Jul 2020 17:25:16 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id u5sm17044309qke.32.2020.07.12.17.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 17:25:16 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 0/5] imx6qp QuadPlus: support improved enet clocking
Date:   Sun, 12 Jul 2020 20:25:07 -0400
Message-Id: <20200713002512.28742-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the imx6qp QuadPlus, the h/w designers have improved enet clocking.

This patchset extends the clock tree to reflect the situation on QuadPlus.

This allows board designers to choose the enet clocking method by making
simple clocktree changes in the devicetree.

Default setting: external routing of enet_ref from pad to pad.

Example, change the default to enet_ref @ 125MHz clock routed internally:

&fec {
	assigned-clocks = <&clks IMX6QDL_CLK_ENET_PTP>,
			  <&clks IMX6QDL_CLK_ENET_REF>;
	assigned-clock-parents = <&clks IMX6QDL_CLK_ENET_REF>;
	assigned-clock-rates = <0>, <125000000>;
};

To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org

Sven Van Asbroeck (5):
  ARM: mach-imx6q: do not select enet PTP clock source on QuadPlus
  clk: imx: add simple regmap-backed clock mux
  dt-bindings: imx6qdl-clock: add QuadPlus enet clocks
  clk: imx6q: support improved enet clocking on QuadPlus
  ARM: dts: imx6qp: support improved enet clocking on QuadPlus

 .../bindings/clock/imx6q-clock.yaml           |   2 +
 arch/arm/boot/dts/imx6qp.dtsi                 |   3 +
 arch/arm/mach-imx/mach-imx6q.c                |   4 +
 drivers/clk/imx/Makefile                      |   1 +
 drivers/clk/imx/clk-imx6q.c                   |  46 ++++++++
 drivers/clk/imx/clk-mux-regmap.c              | 110 ++++++++++++++++++
 drivers/clk/imx/clk.h                         |   7 ++
 include/dt-bindings/clock/imx6qdl-clock.h     |   5 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h   |   1 +
 9 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-mux-regmap.c

-- 
2.17.1

