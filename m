Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0042AA8EA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 03:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgKHCXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 21:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgKHCXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 21:23:39 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC372C0613CF;
        Sat,  7 Nov 2020 18:23:38 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id i7so3728871qti.6;
        Sat, 07 Nov 2020 18:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6rkqQI9V9lROFbHJI+B+EQmZZyK1AJ6qNQuTyiy8+Ro=;
        b=GQnXisneiPdHkYaiMmc3TvSVsZSfPyaVl5jFngbAVpaGwXA1+vI5bpmR5/wu5Youf9
         7mzqBjHvL+B+TZC31bLwRynRhLqAURLN8UZZy3S9EKgpWcVWiT2mDsaUzOGnOUpNG/rr
         tKDEL5nQpe7iychN0ocyq5JnAhbbgPZwrdqNh4Gu8oiUuLTBcgxz0CbV96Y4GbIX5XNL
         dMjDxrZ9RK1o9/2UYV8NMmSnqZmKeJMXqORgHNqD0auvYmBBw7Cy9vihmr1Ejvnac6WX
         /qkLdiyRPSGr5qpWDTBfJliqqnGlGwcdTMDjlPFnwxbkmfaKWBlfzvWUJ5PYABmjUJFj
         3PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6rkqQI9V9lROFbHJI+B+EQmZZyK1AJ6qNQuTyiy8+Ro=;
        b=sXUIWrbJVsMoIVQS318waEofXc/N6BJEDiMIWyCO8rZolccVQO9/xN6N3JQrKBje0I
         JPAW4WUvrRcCoGAjh2athnCrrQqiw35IKCeCVvewmoE4prfHL/a/G+eQd/450UGo/H1D
         kthwRimWmylgUwP5tT+ATWYOOUoidB/hmcd06cLy35XugLoFIhcj9QrWEetNbtL7z2A2
         9YrACp4+y7CxPQADwWTL9RKFAd1yE3q4BQa/tMBZ9Ot6vYnMT9vpG8gZGwFnaWoGW50/
         gd1Vm5fs6Xu9aEHqoLrOFtGIsKUBRDm5/7Z5fwz2Q2GY4ouz3W3yAVX8DnMSqiXGJCP1
         rGKA==
X-Gm-Message-State: AOAM531f4ia9Uf8hjEGuY5P07KBS0I7/12bed00Mji6Io73C1MKjc1yj
        2JbFzauZAaa7O8u6z2AUM9I=
X-Google-Smtp-Source: ABdhPJyUQT1gVbgMNtgfSnHby5r3ccDU+40KTRx6CFNr40pcnKHIfUtVm7QlNCNCU4Sx0oDsAa0zGg==
X-Received: by 2002:ac8:51d0:: with SMTP id d16mr7795879qtn.315.1604802217837;
        Sat, 07 Nov 2020 18:23:37 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id w138sm3702277qkb.130.2020.11.07.18.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 18:23:37 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] arm64: dts: imx: Fix imx8mm-kontron-n801x-s.dtb target
Date:   Sat,  7 Nov 2020 19:23:21 -0700
Message-Id: <20201108022321.2114430-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- \
INSTALL_DTBS_PATH=rootfs distclean defconfig dtbs dtbs_install
...
make[3]: *** No rule to make target
'rootfs/freescale/imx8mm-kontron-n801x-s.dts', needed by
'__dtbs_install'
...

It should be .dtb, not .dts.

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/boot/dts/freescale/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 876bf484bbe6..6f0777ee6cd6 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -32,7 +32,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
-dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dts
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb

base-commit: 39fabe22e0f8c00334882ceac1dc70ffbd7f4871
-- 
2.29.2

