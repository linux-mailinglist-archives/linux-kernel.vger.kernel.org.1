Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A25300AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbhAVSLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbhAVSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:06:49 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84ABC0613D6;
        Fri, 22 Jan 2021 10:06:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id kg20so8455530ejc.4;
        Fri, 22 Jan 2021 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wKv3VmvCnRntCHs4GsLyXTyeF0OtsFtLwN9+DR5TApY=;
        b=q/OW5+LTAhKirNLQ41QsLZvmlnxyuynyWAqLO/aXU31JMwlut9p058w9Fj6cy50CK/
         jC1bpnRARTNMUBfafadfCbh/E/N+4+pXHtQrWlohSlsMrv80yXr+MGkoGvEkttO56suc
         I2STnzbcX2mZZWMBv92/U/GGwiQz7teaCgvg5dKe6kYqhAUfhdtD/VRepeZWqAg1A8Pn
         6qUjvwrg6ikDYFfwM+MkdROd0u7uhexMLEQOoj4kEC8MUQAG517GtB/6lsDN5IpDHYV6
         2Qxe9PUe2RBUqrBQcjTBF+YMd5gY3ZlqlLvzAmDcbzDtnsHQAkHIpKyU3FjUAQf5RK/t
         qsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wKv3VmvCnRntCHs4GsLyXTyeF0OtsFtLwN9+DR5TApY=;
        b=HAnSPEJx49c58CN8DRDC5ZnuxU+SJMVBwuiksyp37BAJWYuQa13tfVuAcio6GuISq+
         kWkO9eTx9kcy641N0Yj5B5JYjWt3jpofy2ioAlWFWSSIGCqtdtK/IJtwUd6FEHz8oNRV
         P4L+r3g0+fV0bwx15fvpQ6u+h+hHH3NyaZS+tnBXeyaP/xMcKwlzD5NTGPaG+NhM8Yva
         7LPnqaL6NgQDzAT8k0VrlO5qg0YWIieS5Yqp6f+7Xikz1Unyqn6i+Eq2h+FG81821hnz
         oRHopwvFOnwYO8FxTKDEZY5qkU0+do5syTDM5tuvPWby0HifPOoTkZpEcmvi0sawuviR
         4TvA==
X-Gm-Message-State: AOAM531nd/bd20ErwWKHvgKudXrvd2IOmGmXC4PijUsnRhrUBzGA1RlB
        drRlkmGK/6RmYFqaOXk5oYs=
X-Google-Smtp-Source: ABdhPJxxvW7RLs53Cx3f5saY+QeYl9nXt+zXf5wqPCizp1q/YFEfCG8tUtf3y8zlCu3XY+IFW5lsoQ==
X-Received: by 2002:a17:907:3e04:: with SMTP id hp4mr3966801ejc.188.1611338767623;
        Fri, 22 Jan 2021 10:06:07 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w6sm4885858ejj.116.2021.01.22.10.06.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:06:07 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add device_type property to rk3399 pcie node
Date:   Fri, 22 Jan 2021 19:05:59 +0100
Message-Id: <20210122180559.18171-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:
/arch/arm64/boot/dts/rockchip/rk3399-rock960.dt.yaml:
pcie@f8000000: 'device_type' is a required property

Fix this by adding a device_type property to the rk3399 pcie node.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
schemas/pci/pci-bus.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 28459d194..6c571fee8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -252,6 +252,7 @@
 				<0 0 0 2 &pcie0_intc 1>,
 				<0 0 0 3 &pcie0_intc 2>,
 				<0 0 0 4 &pcie0_intc 3>;
+		device_type = "pci";
 		linux,pci-domain = <0>;
 		max-link-speed = <1>;
 		msi-map = <0x0 &its 0x0 0x1000>;
-- 
2.11.0

