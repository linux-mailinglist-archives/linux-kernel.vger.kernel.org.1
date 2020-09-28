Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EFA27B06E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgI1PBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1PBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:01:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C900AC061755;
        Mon, 28 Sep 2020 08:01:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so1719053wrs.5;
        Mon, 28 Sep 2020 08:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4rmvqeCqQcnLgyoa1rABwXSUxqPaFqVmfgnmQ3TuWY=;
        b=qSckvyirQ2xX0mglQCf2Nr57ahSvex8M8o9kQQ2yGXRWMizSts1cGS/X67+qu6ucxN
         X9moYc8VRt5BOxWUjfaOiK/U99qPmNBKoQRP9M1egmvXHb9JLgOeOehYQ4lWureNKJtP
         Xa3HgkVGOCzYODE/AC9SZmQp/Qf0BqlDAHOz2AzYcD8NDBOHGpg9KPYGQaeBuRDJ6Vt/
         I/0/nE0PmvKlvKkzR0/kxdqd5681IPCy71BWlMFypCffR+9Unhqw1CLSghxm6Mm1xpvG
         YrbPSjyj4//vG7QdbwDaIF6lvQURw1kyxTL+GlgUhBMIyasN+Y0S1/0+cTIzdLmhL+hV
         OUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4rmvqeCqQcnLgyoa1rABwXSUxqPaFqVmfgnmQ3TuWY=;
        b=DWI+zDjkkrSBBMWlyjpQTbr02q+Ik4MLnZpMpGxSw8J8ZmDcnTVH2wHB3CxgezcD3X
         UMSFfHXvYWXVOSnQzh37YeaSxDSPI3QoZDEyOQuL3AuH0h9WNYwqTKUjzGon3jt057iT
         fj2wzyuuiBhyRXGlqgvbgmDJDNfjTl+wy7XY3mykN1ZmNmV2NEazxBwb2rHVkte609Gg
         GnsevXhkVHL1iOklpXkMBoipC+tCZpE5EKmmoTc3J30EZdgbyIXlku4vuEdQDFEsBHWS
         rtePX8RWegDcxbQqK4m4IXE95kQ1y8rtEzu1auxIwmcFC1U3YQ7KijFAmQYIvfsxpYtb
         laIA==
X-Gm-Message-State: AOAM533UubfMg5n1wVSd3hJ+HmZ88H8w4UUyD0ibU92+Jabu8UK6QM6K
        CIHvx2dzhvTuMDarUvix5veC7bbDXLttQQ==
X-Google-Smtp-Source: ABdhPJxciGliXAToxp0AvwXzcJsjOMAZpov9CrokXaGDMDZKITJAjWkOz1bRtTNklcHD2ZdPz8oRvw==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr2329228wrf.77.1601305263323;
        Mon, 28 Sep 2020 08:01:03 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id z127sm1598763wmc.2.2020.09.28.08.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 08:01:02 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: h6: add eMMC voltage property for Beelink GS1
Date:   Mon, 28 Sep 2020 17:00:37 +0200
Message-Id: <20200928150038.97413-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VQMMC supply is connected to BLDO2 which provides 1.8V.

Let's reflect this in the device-tree.

Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink GS1 board")
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 049c21718846..3f20d2c9bbbb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -145,6 +145,7 @@ &mmc2 {
 	vqmmc-supply = <&reg_bldo2>;
 	non-removable;
 	cap-mmc-hw-reset;
+	mmc-hs200-1_8v;
 	bus-width = <8>;
 	status = "okay";
 };
-- 
2.25.1

