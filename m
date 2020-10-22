Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A243D29616D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901111AbgJVPIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508330AbgJVPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:08:22 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58485C0613CE;
        Thu, 22 Oct 2020 08:08:22 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w17so2020867ilg.8;
        Thu, 22 Oct 2020 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1P/P7OYVc1vkdk4dgqEcyL97NN75T6pSH0KYhZ5mPA=;
        b=u0AOheS1+aug9A376TkAUPh8wozMhpzzXIy9MDjCC3DuZKkDHCryJwp9tb8XcxBalu
         9acGBPtU+eGF6iGFsGbiEkmxJupE6nwxoqBXw2bKrL6r2JxXc844QNyCt6JoSxXb8ZVm
         Wq6RdC/WspdxLGbEpbD+uwHKqF4W8T2+O2ytQ7KoJtb02sxvrPPtlab8aOrsT4Ae+PE+
         gweNvsrT9VXzz1PziokMyTUTJajc7dKDy3yjxCiJf8JP2nceKdceZ7ZG0BJp9tpT2JhJ
         Mj7GvBALpWJtyNreSfISqUKPtLXeBH8tUbNiUuOxJfopNVLeti97XMqHFDRQu1hHiV6Y
         Q9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1P/P7OYVc1vkdk4dgqEcyL97NN75T6pSH0KYhZ5mPA=;
        b=pZPmnnQpX8nJOO9TbYrURaqOkFk2t/uz7MfhALdtXSERcSxMiHWaw/diakF4plnBH0
         74xlgwrOgtjxlfa/wqK8VVZ6SLYVNVLoQVWwsqymfCj7OdULb9k6H2dJ/JREqME5iCfk
         OjjWlo0DAj4o4FFeUN0Lv/0CF7Npy9SNyru5fos80uB1ESwrhCbtgdHcwk3wbB8eEexe
         TNsvrl6u2TRDKx0X0GV9Mu+FVJbSusP0MVjf9rWR7P3XGSqHDg8ep2kZgXCZEAdmI0UH
         P9Mr4pUONUH5w56dyifu0UjlV+Ea+/N+kIh3Cz0/bmwnYKPQ2w6MgjvPUQH0zEDNiVcX
         N3UQ==
X-Gm-Message-State: AOAM533247NwPpR/MyOovCblMf8QEfxDkXZfcJ7k49GR1OUrD9Wm9/R6
        ecqxxe1glftSNuQH75oQxlI=
X-Google-Smtp-Source: ABdhPJyMpvVa/Siz4TorxHsCKTJAh/W4kPFXgCmb+oBBJQmcSGJ3mjL99tNcnjetJx17+gg6WfYBXA==
X-Received: by 2002:a92:98c5:: with SMTP id a66mr2304853ill.50.1603379301453;
        Thu, 22 Oct 2020 08:08:21 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id y6sm1233816ilj.59.2020.10.22.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 08:08:20 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, l.stach@pengutronix.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add i.MX8MN power domain and fix USB
Date:   Thu, 22 Oct 2020 10:08:03 -0500
Message-Id: <20201022150808.763082-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OTG on the Nano does not work unless the USB was started in 
the bootloader, because was lacking the power-domain control. 

This series is based on patches from [1] and an additional, pending 
patch [2] which removed a USB node which does not exist according to
documentation for the SoC.

[1] - https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=357903
[2] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201008183300.726756-1-aford173@gmail.com/

Adam Ford (4):
  dt-bindings: add defines for i.MX8MN power domains
  soc: imx: gpcv2: add support for i.MX8MN power domains
  arm64: dts: imx8mn: add GPC node and power domains
  arm64: dts: imx8mn: Add power-domain reference in USB controller

 .../bindings/power/fsl,imx-gpcv2.yaml         |   1 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  50 ++++++++
 drivers/soc/imx/gpcv2.c                       | 117 ++++++++++++++++++
 include/dt-bindings/power/imx8mn-power.h      |  15 +++
 4 files changed, 183 insertions(+)
 create mode 100644 include/dt-bindings/power/imx8mn-power.h

-- 
2.25.1

