Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A872FA547
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbhARPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406027AbhARPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:53:38 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89357C061573;
        Mon, 18 Jan 2021 07:52:57 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id g3so4957018ejb.6;
        Mon, 18 Jan 2021 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1X+r3rIHhYyL6aQz5bVp1gC9k/hbSfHY26WTukrVjhI=;
        b=AoOuDk/mePLd9aT+57VoNa2cx6wInQE6sPmyZWxAx3/YABARdyO8R1uMuv5dkVo6Y+
         AYNWfgC3W76LoMtCbG6LWoWX9pUXYvZ8Zl5wiXpJWnMua+VFbbiKKCEsDr8aD6wYoNHw
         NBLiMRCh01XbA/qFE9AtMz0FgURlVrNjg8cfkfRZYRPGBuVmBx1ZZ1er7Wa6Ox+4arux
         jDlAg0g7SDyt1D6raDXA3+bKwbDVSfdGhpI+NoYzQ4MI5CN+d9kuJVRxX+CNhn9pokig
         /hNaRX10ZAoKsuM6sZfaWExtISTPkS2cczFeLJxXsqsZOB9X+sPura6wWwfkZ4A7mP9H
         /CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1X+r3rIHhYyL6aQz5bVp1gC9k/hbSfHY26WTukrVjhI=;
        b=B0Y+DcVPLqMLIW/5QDmJIu01idxcq9/ZdIbqmhXVqftlvwv74wzyMsS28rxA/cnHXS
         O6D1Qpi8S8hwxgB+uqrql4NIyZU6jNxSTIwenZTqgYV8Ayvi2Ml+DSus0aHRUg041Qf5
         8Q4HNApguDfmuybNSbWsjvGesey4jd9nG32ECGXCY7wr/e8jtadNXqjHsbaQShoWNSBz
         AwHSqoCDFemZ1lBR8LMCYCUqAdNqgHDHOuLdcUmNK++MKmtLM+E0LkY7MMFhjyFajWaJ
         Jk3LItjrOCpTlCPIwo+FaHvnU4e4G6pkXlMcUL/WICw0xKKPFdlAbffcVkPTKKAxoHiA
         dw3g==
X-Gm-Message-State: AOAM531wGfi7OEUYdt8SPbt7uBY1orMWEstJtzYCE1oQDNvD02hiO7jX
        w5uekS0ThT4gyTprp8eRqY4=
X-Google-Smtp-Source: ABdhPJwEe8+OJdHJZhzDww9IlyIFg3M01x6qLnE+hU9+1Dy3bIe7FkeQFyMzYgPif0U0xPwsHfucnQ==
X-Received: by 2002:a17:907:3e02:: with SMTP id hp2mr197147ejc.411.1610985176362;
        Mon, 18 Jan 2021 07:52:56 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f13sm9561694ejf.42.2021.01.18.07.52.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:52:54 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: rockchip: assign a fixed index to mmc devices on rk3308 boards
Date:   Mon, 18 Jan 2021 16:52:41 +0100
Message-Id: <20210118155242.7172-4-jbx6244@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index ad54acf5d..b360b059f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -24,6 +24,9 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		mmc0 = &sdmmc;
+		mmc1 = &emmc;
+		mmc2 = &sdio;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.11.0

