Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36B300AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbhAVRYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbhAVRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:13:36 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B0CC061793;
        Fri, 22 Jan 2021 09:12:52 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id n6so7373197edt.10;
        Fri, 22 Jan 2021 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=roMb/tyW1M9NQnpXqSRx9W00sUX6gkBYwKxG+CPcXzI=;
        b=fLRYxC7AMQdGJXu08Ng+pctI1fQayyxI5Mz88cRgUvTT/OSddQ/AcIiNEH9kw33TK/
         +UfJwsrO5GROpkmcYFqrBFeu+8xbk9a0lE590S+wqWy0ChKCnv3u/Ewvw/IdjYmm7dpj
         9HNXAamxY3/Q3fK3qIW0wddC/Xq0omP6MDZNhkcIwWaLaSt+Pkb4s6n4YSdRW7mhfImo
         30LZS8vS+Ar59oX9n4anGZYzdDSdaQiMsN0yprVzaYQuHrGc/VEebcmVMNAhqrEtKRsi
         amjz1dgF6fo8UbyCN35YZwIq/I7w3kN5IKib6y7yJStE28dqo0OK0QwkdySp3CrhfsFn
         5EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=roMb/tyW1M9NQnpXqSRx9W00sUX6gkBYwKxG+CPcXzI=;
        b=k+tT3/L4NyLBrOrlQUikEEfGqPbGOiOQxDN05xfDZlL2YaAiqGFv+Rq9a6yGDs4Z4d
         kyDM4t5aV0lOOUqtl9PUxuPYwx3rBgSa0R+IO2Pr8cDVKWQz2M2UtsSgd4rDmvoAAGur
         /GlJATFURituWS+EZzu9/bIO+srLQpf85cNoSyhOjoyjpyOB9RrDuMZLQozg1hmhEyPI
         CNmJFf29qbv99P+CQxe/z2T6LRM49iki6jp5N3THHQ5hXevmOwjQP+ktMXri8OfLlQWA
         JWcM/B7RCVu5FFeEzXx/PdHKLenyPsWqZyjWcP99XLl+SJwvw68de/hRQ6s5E1R1sdIh
         bnMQ==
X-Gm-Message-State: AOAM533bO3p+Xj7nLdQ6AVLuSKMMZkkueh4KNXPkcbKwrTSD9zEr0gGr
        /YJr6SfYgT4PSFLsCc4lxu3g4DArE1s=
X-Google-Smtp-Source: ABdhPJwRQf20pEeRaLSU0zk5VFjq9xuFDxAISiKNGEbg4TZWmEW3jx8FO8sHyg3W/Zz7tgjMVG8XnQ==
X-Received: by 2002:aa7:d98a:: with SMTP id u10mr3972073eds.275.1611335571524;
        Fri, 22 Jan 2021 09:12:51 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t21sm5927429edv.82.2021.01.22.09.12.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 09:12:51 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix ranges property format for rk3399 pcie node
Date:   Fri, 22 Jan 2021 18:12:43 +0100
Message-Id: <20210122171243.16138-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:
/arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: pcie@f8000000:
ranges: 'oneOf' conditional failed, one must be fixed:

The pcie ranges property is an array. The dt-check expects that
each array item is wrapped with angle brackets, so fix that ranges
property format for the rk3399 pcie node.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
schemas/pci/pci-bus.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 15f8b212c..28459d194 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -259,8 +259,8 @@
 		       <&pcie_phy 2>, <&pcie_phy 3>;
 		phy-names = "pcie-phy-0", "pcie-phy-1",
 			    "pcie-phy-2", "pcie-phy-3";
-		ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000
-			  0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
+		ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
+			 <0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
 		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
 			 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>,
 			 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>,
-- 
2.11.0

