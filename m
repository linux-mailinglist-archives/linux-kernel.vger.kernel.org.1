Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167752AC34A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgKISKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbgKISKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:10:43 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0121AC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:10:43 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z24so7835351pgk.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVV3bJrXqfPx1wuLLV5iO8azqLq6P7y4LmMXw4UFISs=;
        b=Ui0O9rgEpFyxIpNNlCYSJCGsoUsI+pPLUja/sxGhKQEqseTd6rblDvzCRXSNGRHvoM
         Llw8AzfcobtWB/yAKgQpsoiqI2ce39PM6XBB3x2YXahmfcbP5uEh1u/MtVnKT8XBewED
         ja35W6nqwJ3qxDGnLoXtEi1YIlmJgg67nmsDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVV3bJrXqfPx1wuLLV5iO8azqLq6P7y4LmMXw4UFISs=;
        b=WTMtboWOmlTDdePFBnR1Q6b7hiUsc6zoWA114GzXLOT/EmhDlksTcU8My8BLA6Ynml
         1HI8vMupxXDGFE/YCYlPxfMoVo734AnO74QmWFy4YR3H2BlJ94Qqaz6KBhsSU8rM8NfG
         E1AbZH9w+kRiiQk7CRkEOkxqmo37WLaX1jAEbZYzAo5q9KEBZOQgja34088D7aOT/2D5
         77S6DETVBPOiMwBvFBS5NW20ss/UVGVOQkRfuC9UrZn4c/FUkQlXoHzms+U/EzeFwNGl
         6YCpwdcdHy1RZ6OeOvaX90Wo8aO+5e0tDq79as85qViJ47KgWgosZb6V7T1rb2i1E2h+
         XWIA==
X-Gm-Message-State: AOAM532xul5ppdArqrlPq7c+GCk/+gY5h1JAELLZaAbyGne3LWJD8kjd
        kHVQ6xHGgm1gFnG9r0+NOX5yXw==
X-Google-Smtp-Source: ABdhPJxcjQpkYc9csJLgDY1Zwj5sp09LlNtW+CmwPUj2525XmHLuzGlrpSKGale1f1VpUP+uZCtPhw==
X-Received: by 2002:a17:90a:6283:: with SMTP id d3mr422262pjj.96.1604945442506;
        Mon, 09 Nov 2020 10:10:42 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7a4:c0f0:b8ab:4687:594d])
        by smtp.gmail.com with ESMTPSA id 136sm12027685pfa.132.2020.11.09.10.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:10:41 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 0/9] arm64: dts: rockchip: Engicam PX30.Core changes
Date:   Mon,  9 Nov 2020 23:40:08 +0530
Message-Id: <20201109181017.206834-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series support Engicam PX30.Core SOM changes along with C.TOUCH
Open Frame 10.1" board.

All respetive LCD panels are in Mainline already.

thanks,
Jagan.

Jagan Teki (7):
  arm64: dts: rockchip: px30-enagicam: Enable USB Host, OTG
  arm64: dts: rockchip: px30-engicam-edimm2.2: Enable LVDS panel
  dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0 10.1" OF
  arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0 10.1" OF
  arm64: defconfig: Enable ROCKCHIP_LVDS
  arm64: defconfig: Enable PHY_ROCKCHIP_INNO_DSIDPHY
  arm64: defconfig: Enable USB_SERIAL_CP210X

Suniel Mahesh (2):
  arm64: dts: rockchip: px30-engicam: Add WiFi support
  arm64: dts: rockchip: px30-engicam: Add BT support

 .../devicetree/bindings/arm/rockchip.yaml     |  6 ++
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/px30-engicam-common.dtsi     | 85 +++++++++++++++++++
 .../dts/rockchip/px30-engicam-ctouch2.dtsi    | 22 +++++
 .../dts/rockchip/px30-engicam-edimm2.2.dtsi   | 59 +++++++++++++
 .../px30-engicam-px30-core-ctouch2-of10.dts   | 77 +++++++++++++++++
 .../px30-engicam-px30-core-edimm2.2.dts       | 22 +++++
 .../dts/rockchip/px30-engicam-px30-core.dtsi  |  5 ++
 arch/arm64/configs/defconfig                  |  3 +
 9 files changed, 280 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-px30-core-ctouch2-of10.dts

-- 
2.25.1

