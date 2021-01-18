Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D162FA54B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406094AbhARPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406041AbhARPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:53:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12821C061574;
        Mon, 18 Jan 2021 07:53:01 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so22020758ejc.1;
        Mon, 18 Jan 2021 07:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kpb7JcnZpNDj5y9zvo53/o01BgnayqHJFM7Z2whUwSY=;
        b=ho3KVEAACbgNJgVVB0IakErAZc0DXTvi79Cxq2MPxl8e0A0VkVPQJPDxNYVOTbl/1e
         +gqbzCh0oFFxGp/ImKv69R+L74HvLkzx5mHurEf4W/JshBdcyJZ2vIsLYVyXwyA2vPoX
         Bra3qOtsJEwLpy7j+1ccVwElfYB362xbhINdCJ2wb/A9HB21MLOH70rOWwq4cTVVECaK
         fjkAGe3Rw4mWcavDcArReCA8agJ7pvy62MAkE8yjxlfsoY1anSw32Beq5bqpGVpGQYVT
         puJfp6UG2JyctATvP8y7ij1InfqMUWbFws84BDWYJ3wxAm9JM7sed6KB0rpexXe53zFi
         qmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kpb7JcnZpNDj5y9zvo53/o01BgnayqHJFM7Z2whUwSY=;
        b=KrCTw9TsODImWN3VyuujCv/2faSmSqT8oDPYWc0YM1YbQgeWJXJMBlZe+y+tr5hkKg
         jbXPztF8S8DFl3Tcj1ol6Oly7OpZ8fektFGc61d0Vkpn5dO2vGSLSfdQG21txR8ymEld
         PXaAX8I+WjUA5xt5tn6DMxuX67XzdEuh0z7QIYDU7ifhF9E5JJ/LIbtduOOneMDg/fF0
         ReFEAASFotRQB4cbbe4ATvjTXsG6jhfxeE13Ap9kKbA0XKGxMlO2qT1bIJ4kex6JUa1R
         qh9ktxKA/fh2maJ8BeKkvaFj9c2GzOUt5lm460kV11njBraw2gCv49y03/iPyAT9f+XS
         UhJQ==
X-Gm-Message-State: AOAM53297z2sEkkfMON4q2Hx6OM3eHw32LTvQEm1czOLvd+vo1Vr+7YT
        EvcvguB0kuO+rKKK5o7Mybxdcpwj2ik=
X-Google-Smtp-Source: ABdhPJwG5lsKwya6yX/0XdsfQ+c8vOnv1SnLgugw8ymqhik/gq9wQJUTuib7KzpGEkYuGoWxU47ykA==
X-Received: by 2002:a17:906:4003:: with SMTP id v3mr252682ejj.82.1610985179834;
        Mon, 18 Jan 2021 07:52:59 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f13sm9561694ejf.42.2021.01.18.07.52.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:52:57 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: rockchip: assign a fixed index to mmc devices on rk3368 boards
Date:   Mon, 18 Jan 2021 16:52:42 +0100
Message-Id: <20210118155242.7172-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210118155242.7172-1-jbx6244@gmail.com>
References: <20210118155242.7172-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently introduced async probe on mmc devices can shuffle block IDs.
Pin them to fixed values to ease booting in environments where UUIDs are
not practical. Use newly introduced aliases for mmcblk devices from [1].
The sort order is based on reg address.

[1] https://patchwork.kernel.org/patch/11747669/

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index cd8274a35..b00ed0e74 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -25,6 +25,9 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		mmc0 = &sdmmc;
+		mmc1 = &sdio0;
+		mmc2 = &emmc;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.11.0

