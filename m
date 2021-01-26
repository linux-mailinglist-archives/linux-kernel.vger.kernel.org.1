Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20DF303CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392606AbhAZMVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404774AbhAZLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:03:12 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E4C06174A;
        Tue, 26 Jan 2021 03:02:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hs11so22372548ejc.1;
        Tue, 26 Jan 2021 03:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ExoicPWb9nj37ivHRf0sfAyfETbOTvzRxB/xRvmXmU=;
        b=gULRw+fQvf6cEe5Jiju+B7Su1M7tU8zPqZgjfo1mPadYvRypYxul3cs9pu/COoyDJT
         TRlb4Scm0NubDKK0NBbvUatnV0YGTkpjdl74Xti1i8GIbMCKw5CIlvBziTw7n3rpzL09
         pdwRh9qRCXaGe535cg5CLr3UEFRR0VJ201z1cAcaf2+DdP9NVGVHHLqzvH0vrm+Y5wry
         K5iE0r9CmUnRa59orDPb8uyQbcHydzTjhCysHH8uDPJiUaeh9IooxMCNLgSrOYEoQRei
         7lZINf5OB3Q29V5fwqh4KIcH0B1iXxoWG449ZVeBp2rs/odQyk9POcMXrhB0zXpkhF2W
         uIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ExoicPWb9nj37ivHRf0sfAyfETbOTvzRxB/xRvmXmU=;
        b=CErrLEWiBkdpVAZ/A7WU5cuGITaNwd+CsfnSHBGQzoDi7TUK1O7qagrjkz4+lUXSo0
         IfRHHt7hcnod7MvUifSrpPQdxBdsdp7QMDm/QTPqHsiTd9DO7/NwdnCZKBkFbmuLnAP8
         Q+7WhMTObMVAAnv2v2jrcgH1g78mxuWfEC4Ni3/JYvJFuRDRcssSVQp1NsomuEwWQVo9
         Kq2Ys9kvK/52KectT35P5FJa5n9svF9lyrMhlrYwTbefXHMOnF0xpmUm1gj6rwcBsPS7
         nXt1G5/X/Rb+n/mBijlWlVFn+PBGgwEDuH3m1G4/44ezLCOspYBgH5bY7gM3ZxbdYn8r
         DsHg==
X-Gm-Message-State: AOAM533FRQR47skPz7ew+apiy2v3RcqeSDRd4kGl2w+77ZTmBeZhgjOX
        fwAv4yA4j+3apOKCGxtttNs=
X-Google-Smtp-Source: ABdhPJwD9bEZYnFDqHJRo/ilNGeJy4pvg35s/7WkgPHClbyyzEy8XmUpbC8NKCoi6q6Eq7z2G7aUrw==
X-Received: by 2002:a17:907:94d4:: with SMTP id dn20mr3126122ejc.397.1611658950596;
        Tue, 26 Jan 2021 03:02:30 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a2sm9533408ejk.80.2021.01.26.03.02.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 03:02:29 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: fix pinctrl sleep nodename for rk3399.dtsi
Date:   Tue, 26 Jan 2021 12:02:21 +0100
Message-Id: <20210126110221.10815-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210126110221.10815-1-jbx6244@gmail.com>
References: <20210126110221.10815-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below aimed at powerpc generates
notifications in the Rockchip arm64 tree.

Fix pinctrl "sleep" nodename by renaming it to "suspend"
for rk3399.dtsi

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index d0602f62f..6c571fee8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2347,7 +2347,7 @@
 			};
 		};
 
-		sleep {
+		suspend {
 			ap_pwroff: ap-pwroff {
 				rockchip,pins = <1 RK_PA5 1 &pcfg_pull_none>;
 			};
-- 
2.11.0

