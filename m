Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE727BF95
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgI2IdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgI2IdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:33:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B66C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:33:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t7so2268388pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dx44QJ0d0wpQDOLwOMTCd/a0pDc1XmM5I6tzJeT/8Ss=;
        b=LFncIg1k+T888IG6v8CeyKfSQF1KZzlWrmWlY/2XEdAIFbt5J2p8Bp9Jz3YKyPY68Q
         xbx2FCdOAAouJ+L2wFWHmCY0GCLKn1owfuNwlW56gRp+NpPREQKILelE0p/UeQVMZSlq
         LgPC6PgKfJ1yU3bpNKfEhtePxtl1DLU+kjiow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dx44QJ0d0wpQDOLwOMTCd/a0pDc1XmM5I6tzJeT/8Ss=;
        b=rsg4Clt0dwbi2mX2Q+XS9acjFY1ZELHBGkNBH1c42Wa6482w0aAuvPMsUO/Akkfaux
         +cHhzcwYoMonxuK6GRxUV6P2nUdrVEUmvsIpqfrSEwd57flErEGih6iQQ024sATupZo3
         MtUStOeD1rgi1TnFfPgj0F5ZeB9kWrdxyN6LQN758X2Zao5wu9m558TYi9TIJREedNHs
         gTbVmRcUSHu8tySTueEO3hMPB3ye3JWiLNjvblW8kAtER9eXEMekCb3mOBCmrl36x96n
         cCEyv44LLlEzPtgnGYSuhq90eVyx1kN3JFr/IiPpJZFZql3tZobrLwZ7pubyD1zzKtNH
         U07Q==
X-Gm-Message-State: AOAM5327tEVlmmtr3/IyIgVU7Tohmu3Si7zrhWJxrE9jwRRtYgQYUtAk
        xeUxSijJDY3P6UhgwS++X5je7Q==
X-Google-Smtp-Source: ABdhPJwfN1BQWnR0DbmK3K6Z9wqqEWdFqxfQQxAnapawWIvh0kz+rFW1pdDfsXKkbD7FZb1+cN8/dw==
X-Received: by 2002:a17:90a:e609:: with SMTP id j9mr2727199pjy.129.1601368386111;
        Tue, 29 Sep 2020 01:33:06 -0700 (PDT)
Received: from ub-XPS-13-9350.pdxnet.pdxeng.ch ([2405:201:c809:c7d5:b511:310d:8495:d767])
        by smtp.gmail.com with ESMTPSA id 36sm3961241pgl.72.2020.09.29.01.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 01:33:05 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 6/7] arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
Date:   Tue, 29 Sep 2020 14:02:16 +0530
Message-Id: <20200929083217.25406-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929083217.25406-1-jagan@amarulasolutions.com>
References: <20200929083217.25406-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose
carrier board with capacitive touch interface.

Genaral features:
- TFT 10.1" industrial, 1280x800 LVDS display
- Ethernet 10/100
- Wifi/BT
- USB Type A/OTG
- Audio Out
- CAN
- LVDS panel connector

SOM's like PX30.Core needs to mount on top of this Carrier board
for creating complete PX30.Core C.TOUCH 2.0 board.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes for v4:
- none
Changes for v3:
- add Amarula Solutions copyright
Changes for v2:
- none

 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
new file mode 100644
index 000000000000..58425b1e559f
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+#include "px30-engicam-common.dtsi"
-- 
2.25.1

