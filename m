Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6E2B2D71
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgKNNwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 08:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKNNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 08:52:21 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4EBC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:52:19 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id j19so2362702pgg.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XwyLNKLBDuYh+S1CXSzktBr8nFzPgTD1/kheOU6L4+U=;
        b=HaIUiw2QOb9sBu43gc9htmVnhXqSKwFXI8hZNLBdm7Bv+ggoF2BEKIcxPwyLm1kb+B
         iD96/IbPqCdhaYGCCd1lIliHlez52aO4YmPcyPYCNUfZJW+Q08/pZki0ueQEiS4fURow
         Ju4vwM2FJ1I1gMhDUso2UXcaKQX/vBNCEveCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XwyLNKLBDuYh+S1CXSzktBr8nFzPgTD1/kheOU6L4+U=;
        b=VOCor5q0y7uYVC4iflbHKZK6C7rYTjJaMjziH1YOl8u6kv8fQfW7EyitsGgxXLvBl1
         5RtVOO50fSDc2NmYiKEWUMiolL3lq5zcyAdhNQ4FwU3gIY4uilf/7d/4xdbOKDCn2ZyO
         uk2+FH3pKcsUCU4orDUkFaDMfNmRpzCCDFssJQ+SVab0eljh3txUWGAoj4/j0EVmIFEB
         ewMNQRDMJpMXtUh5RGmqtE/7JSI9YCikd/Aqep41kDDkREJ4OZFuj9jv+vBXAm3XEPnr
         GaiwxMC+gTS/rOeZzI1ri6rUQLWAqQ7ORO0ywFxyW6kTmoeATjogFR75OOYhz+E3ToKr
         Rc5Q==
X-Gm-Message-State: AOAM531ytiEtN3Da2tw8NkZAK126sEvJ1xzREtnBQzJhTrza3ITHho0i
        UzL5URuQKoESWvyVA+VHVTi6hA==
X-Google-Smtp-Source: ABdhPJw9EP67HuQ6JJdBN1Tbf3rKgx5WifKbz5KPceLjr+2b0yeL8JDoiHWpaTxbjAl985Lh55XdpA==
X-Received: by 2002:a63:e04:: with SMTP id d4mr6043809pgl.101.1605361939416;
        Sat, 14 Nov 2020 05:52:19 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id r205sm13008023pfr.25.2020.11.14.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 05:52:18 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/6] ARM: mstar: Basic MPLL support
Date:   Sat, 14 Nov 2020 22:50:38 +0900
Message-Id: <20201114135044.724385-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the MPLL block that is present in
MStar/SigmaStar ARMv7 SoCs.

This block is intended to be set and forgotten about before
Linux is running so all it actually does it read the registers
and calculate what the output frequencies should be.

We only care about this block because there are upstream dividers,
gates, muxes etc that need something between the input crystal
and themselves to calculate their own rates.

I think this needs to be applied after the GPIO series[0] that
is currently inflight.

0 - https://lore.kernel.org/linux-gpio/20201109121731.1537580-1-daniel@0x0f.com/

Daniel Palmer (6):
  dt-bindings: clk: mstar msc313 mpll binding header
  dt-bindings: clk: mstar msc313 mpll binding description
  clk: mstar: MStar/SigmaStar MPLL driver
  ARM: mstar: Select MSTAR_MSC313_MPLL
  ARM: mstar: Add the external clocks to the base dsti
  ARM: mstar: Add mpll to base dtsi

 .../bindings/clock/mstar,msc313-mpll.yaml     |  58 ++++++
 MAINTAINERS                                   |   3 +
 arch/arm/boot/dts/mstar-v7.dtsi               |  27 +++
 arch/arm/mach-mstar/Kconfig                   |   1 +
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/mstar/Kconfig                     |   5 +
 drivers/clk/mstar/Makefile                    |   6 +
 drivers/clk/mstar/clk-msc313-mpll.c           | 177 ++++++++++++++++++
 include/dt-bindings/clock/mstar-msc313-mpll.h |  19 ++
 10 files changed, 298 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
 create mode 100644 drivers/clk/mstar/Kconfig
 create mode 100644 drivers/clk/mstar/Makefile
 create mode 100644 drivers/clk/mstar/clk-msc313-mpll.c
 create mode 100644 include/dt-bindings/clock/mstar-msc313-mpll.h

-- 
2.29.2

