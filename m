Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629D42B44A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgKPNXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgKPNXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:23:19 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65897C0613CF;
        Mon, 16 Nov 2020 05:23:19 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id m16so3811167edr.3;
        Mon, 16 Nov 2020 05:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G0T5yMoydp6E6nfIQvkyLdPxpOSjZqvp9iT1QJ5MAdI=;
        b=sm5O5h5tKDovkV/5mskWrX+P9iq6xa4y3wieGVnqK77Mw/fmWo0dC9ciHHIx8qsSXB
         HXfYvmPSoFDCvRQB+wcrLdEEAZq0w1lbRBih+gJNLA9P0OX2YsFpgDPJeZSOssDeOGhs
         0FqdFmYjkR5/7RmML/007eeScOLD+JFMo3YVtMxvsN/2vz/JBHFJyUIVn38Ry++PM3kU
         F61o+7TeywzZ2XpdDvvTx/Zq83YuxSRMO7MVp3AS9dCyCLz2z4IbPtySnj862smoN8nD
         3V+MkDg3TOoSFAWIFfZGITGF8sKdDb/LNObh+CvB41oDXgBjTucJvEovRyS/I9dD7j6x
         t/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G0T5yMoydp6E6nfIQvkyLdPxpOSjZqvp9iT1QJ5MAdI=;
        b=TlagNoAXtFKmwbJ2JqRyfF3zCSJRrMwfodHquUUq8b/zK1cNgEL+Lk5YNpjLrIBUfp
         1W1dzc0z/odx3qanBlXFl7iBN5NJp2LdYMAVGV9yPzHPSbdqaY84NATynAhJopSUKFHM
         7zb1fgL87BU0M0yfwaGzSKW7ukV/sCVY1uNyVJrk4HmhdMVpKXhD3qIVZCofm7qpnclV
         XRkYOZ2YPwGJOwz5Qe2LjN6RSq+4Ufv9FF+6nqk6Eod52fwlUN7TQnAzSN45HuUiu8eM
         biN640a+5U9iJIzHmZ0bGHXHpXwGms8oTNsw06GjzsUlb++lQKK14DZQwTD2wbeP9JLt
         s2Cg==
X-Gm-Message-State: AOAM531d6KbIbZXeH660liKIZxCuwIGhRPb7sQ87eOYSVmj+eul84vMS
        BkdmNX7+IDXD7xWmkcdMoTk=
X-Google-Smtp-Source: ABdhPJxKH+eJazMgAP6plRVNSIXMKel5IbKw8Yiu7z8hTL10hQo3Efm98BHivxowuJn4oaVgwGHvTg==
X-Received: by 2002:a50:ab15:: with SMTP id s21mr15519457edc.88.1605532998207;
        Mon, 16 Nov 2020 05:23:18 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id oh19sm10550650ejb.49.2020.11.16.05.23.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 05:23:17 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rename sdhci nodename to mmc in rk3399.dtsi
Date:   Mon, 16 Nov 2020 14:23:11 +0100
Message-Id: <20201116132311.8318-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

/arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml:
sdhci@fe330000: $nodename:0: 'sdhci@fe330000'
does not match '^mmc(@.*)?$'

Fix it by renaming sdhci to mmc.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/
mmc/arasan,sdhci.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 32e867179..6cba2c77e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -328,7 +328,7 @@
 		status = "disabled";
 	};
 
-	sdhci: sdhci@fe330000 {
+	sdhci: mmc@fe330000 {
 		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
 		reg = <0x0 0xfe330000 0x0 0x10000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.11.0

