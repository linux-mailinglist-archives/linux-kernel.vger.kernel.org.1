Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E66D2DFB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgLULdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgLULc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:32:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45834C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:32:07 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id f14so6004012pju.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgo3Lo9LR4Nt1JTVxEGVpWDTr/u2CPjz3RciH2/SsG4=;
        b=FI4Z0OxksN6IRRN7E7ploqLyzeKx4iHvVBFF9XQemAsL47rt5VVEnx5RwKvaRWuFaV
         Hn9EaiJF87TtRVybZDfSowVLxHrATUHW6JO3p+waQ33tGTIcykrs97b/+Q8YiXgg6O60
         qOGGCQAxHmAqZrfCjpDsRW20kjRPzcjGlnOHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgo3Lo9LR4Nt1JTVxEGVpWDTr/u2CPjz3RciH2/SsG4=;
        b=ACM6zvvtGFylsxUQCNkWtVK+hZ3w7Ppsby9TOjy+eGY1ioDQPvp8+4t++CQmTJIxTH
         oawts35E8X3ApaCaSXOFEUSgzxEYpjVn5ihh5M2FaDQwxHzY0OrHAor3U9YwRw8yfK59
         AVoveZrHs8ihvNmy1j85eXgh1SBIWowzBEB7kvSobKMkToSbCZxyq8oRBNIQZmv7fLGO
         C4+0suX1HY129rdZ3/RogkZ725nQ/qvx55tBmsisqg5AOND4C8x9ytDnEtZxPubK3xUz
         lXYOOaKD70YaxW/O3bxFWNgsh7cFLZHCTT0cSv+8WOqWZvfeu6ZobX0DqPqxxoz4q6GQ
         BJtA==
X-Gm-Message-State: AOAM530iBw49txcRlldLfpR1auHpC9/6Y4UKnxxe2HYRkmOKwrzSQfcu
        sMKlOqgGLQjeG+Y1txuz+/fjvQ==
X-Google-Smtp-Source: ABdhPJwqFMrw2sN6X3RVNW98QM78SNW+ledAakloh3sJ/Z7ZARTvzBTWEZLlp/mcF+neXuLexqOOiw==
X-Received: by 2002:a17:902:b688:b029:dc:240a:2bd7 with SMTP id c8-20020a170902b688b02900dc240a2bd7mr15839253pls.50.1608550326665;
        Mon, 21 Dec 2020 03:32:06 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:b9d4:ed90:a69c:2530])
        by smtp.gmail.com with ESMTPSA id 197sm16714859pgd.69.2020.12.21.03.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 03:32:06 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 0/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
Date:   Mon, 21 Dec 2020 17:01:45 +0530
Message-Id: <20201221113151.94515-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the initial series to support Engicam i.Core MX8M Mini SOM
and it's associated carrier board dts(i) support.

i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.

i.Core MX8M Mini needs to mount on top of Engicam baseboards for
creating complete platform boards.

Possible baseboards are,
- EDIMM2.2
- C.TOUCH 2.0

Any inputs?
Jagan.

Jagan Teki (6):
  arm64: defconfig: Enable REGULATOR_PF8X00
  dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini SoM
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
  dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit

 .../devicetree/bindings/arm/fsl.yaml          |   3 +
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx8mm-engicam-common.dtsi  |  82 +++++++
 .../dts/freescale/imx8mm-engicam-ctouch2.dtsi |   7 +
 .../freescale/imx8mm-engicam-edimm2.2.dtsi    |   7 +
 .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  |  21 ++
 .../freescale/imx8mm-icore-mx8mm-edimm2.2.dts |  21 ++
 .../dts/freescale/imx8mm-icore-mx8mm.dtsi     | 232 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 9 files changed, 376 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi

-- 
2.25.1

