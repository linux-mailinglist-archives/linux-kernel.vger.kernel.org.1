Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54827BF87
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgI2Icl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgI2Ick (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:32:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8954AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:32:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so3242127pgo.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXrfz0lgdtXjn1yWAWiw2AoB3KPUQJy22o0sHXCM7rE=;
        b=X+eOV2VtnvWodXlCp4alhgLMkPYiUsUzvIZMjV0MyTI1pAEzaqFuZR8uIUrpVmB2ji
         XIU5Wwga0kxfLS7RsvbjoV8r7gXpuH6IMllYG95RNYOyFCtM2rmecZQVJRY/pnRK4LUI
         sGqQ6mhSDSQVZiKNaHCcPmlUoFeL5C/2Dc0Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXrfz0lgdtXjn1yWAWiw2AoB3KPUQJy22o0sHXCM7rE=;
        b=uJdAIz5mekL+XcfWkqz4EyJi1jsEBljINj+0/KQKbhkSi1buD3dmfkca1Ue6ocEPp1
         d7u40QkKAnGKMXpxF2T+kUyy+/4BATRfbzbNmjmxPYtnMUDiIRkdN0ufRIAM6QW1z7cC
         F/Vnai9ccYpCDtNU4eQcX3HLJWHfgZl8vrF+AAJ+wmbBYX1L1Ct0HqWRfrEvUrbf1Jxk
         JGsozZ0dF5tSRtaCqtGjx8UtHTOAdZ2FT9ludRn5ysNA4K1GBPx7AmPDSsaRwwyUeOjt
         VtN9mUzj6NUBM2Hi5610J4n7OzEShSKacoSN1lQ8VaPP210MV/83P6L8EAtDDny4/UQR
         kbag==
X-Gm-Message-State: AOAM533pUErrldX40Vhzmhi+3kKLSUbgFuKn3e9AD5UPQKPUscCCD2bq
        2J/fvqzhqyeIOUqT30wQ8IfNqA==
X-Google-Smtp-Source: ABdhPJxS9qQ/WSI+qFu8XiAYmDf0txJeY0HYFYXYaxcTfKtN443h0IRWD7p/p/ALZTycg0vcibK8Lw==
X-Received: by 2002:a05:6a00:844:b029:13f:dd99:d1a4 with SMTP id q4-20020a056a000844b029013fdd99d1a4mr3202215pfk.31.1601368358748;
        Tue, 29 Sep 2020 01:32:38 -0700 (PDT)
Received: from ub-XPS-13-9350.pdxnet.pdxeng.ch ([2405:201:c809:c7d5:b511:310d:8495:d767])
        by smtp.gmail.com with ESMTPSA id 36sm3961241pgl.72.2020.09.29.01.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 01:32:38 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 0/7] arm64: dts: rockchip: Add Engicam PX30.Core
Date:   Tue, 29 Sep 2020 14:02:10 +0530
Message-Id: <20200929083217.25406-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

PX30.Core needs to mount on top of Engicam baseboards for creating
complete platform boards.

Possible baseboards are,
- EDIMM2.2 Starter Kit
- C.TOUCH 2.0 Carrier Board

Changes for v4:
- collect Rob A-b
Changes for v3:
- resolved Johan comments about sorting node properties
- add copyright to Amarula Solutions
- update px30 dtsi author
Changes for v2:
- include C.TOUCH 2.0 carrier board
- skip 10" OF LCD as it requires separate dts with panel support.

Note: These baseboards can be used for i.MX8 SOM's as well. So having
baseboard on respective SoC seems to be easy rather than making it
common across all.

Any inputs?
Jagan.

Jagan Teki (6):
  dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
  arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
  arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
  dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
  arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
  arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0

Michael Trimarchi (1):
  arm64: dts: rockchip: Add Engicam PX30.Core SOM

 .../devicetree/bindings/arm/rockchip.yaml     |  12 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/px30-engicam-common.dtsi     |  39 +++
 .../dts/rockchip/px30-engicam-ctouch2.dtsi    |   8 +
 .../dts/rockchip/px30-engicam-edimm2.2.dtsi   |   7 +
 .../dts/rockchip/px30-px30-core-ctouch2.dts   |  22 ++
 .../dts/rockchip/px30-px30-core-edimm2.2.dts  |  21 ++
 .../boot/dts/rockchip/px30-px30-core.dtsi     | 232 ++++++++++++++++++
 8 files changed, 343 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi

-- 
2.25.1

