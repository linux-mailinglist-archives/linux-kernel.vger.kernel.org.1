Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4672FA566
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406133AbhARP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404903AbhARPxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:53:36 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004AC0613C1;
        Mon, 18 Jan 2021 07:52:55 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b21so9291962edy.6;
        Mon, 18 Jan 2021 07:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VhphvaoMO0MSplwXzOX+UYmDiouvxFZXbU4yg9NjsGs=;
        b=Vouj50Rd8oFIgyNCzYWsOiRU+A9x8iFQkL81ktgnKTvoP68En66kpjJvjmRDt7qi5O
         BS7mKPJqYU81oEA94M8QnH37V8lvuJqL3MdJHaGCuFR8q78g6oTgIbRpSHtFAPCgOQr1
         8UYvEn6RTPxSLaQg6z4aum7UZYSvco5dufgb3Osk/Bdr8gAbxoPVZadBJulKRFRqGYob
         0M3BKZxyyaFV8MZE9my96BuDpCLF/UHQE9nECh/bkrbwf/4OPIkNvGfvYHT3Mk++jZ0U
         MSvtbFIwSndQHAgt36qJbAZ8C9lGnJzhWudTTImYTc4WuXKY5kdZiHtcaTQo2TMyNaGo
         sNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VhphvaoMO0MSplwXzOX+UYmDiouvxFZXbU4yg9NjsGs=;
        b=SMsmSR2WkHI/Bxpb1/eZdXYQSPtzcothJkMFhtxdrTGinDXYWDNx/bmGO3mM3Q8QQf
         UCHzBpbOQQqShxYrNJTB4kB2N/f0rSXz5Macd/eZXMvKwY4QogHmbbNO/u0MO+XoAA/R
         IOBUHuXExJz53RGFUYFU8QEVpHfauH+LBbf4TKWnVnqX0O8sGP898kR1d2dOKAm3Es1X
         YaVIsbVGURDe2XbLTbnwSJFAnDzB0oWMxClJG1R5WqbtJFOk4Gic+D4inSD1QN/d6eea
         lLHs6nsZ6itxbKxi1oFSTrBwMd4LlB9QVKYms1WyWa+ykP41KaELk925jPLTmpZnrGyK
         55NQ==
X-Gm-Message-State: AOAM5326jFllrYcDjzVVdYCraKr4YRbdzsiH8roJPBJXYu0GjR42KwcK
        +dTuqd6YXytNalwGqew1ivk=
X-Google-Smtp-Source: ABdhPJx4CXf+UBZO2cerSrewnW6s0+YyK4AbWXQlVAenRYhXiU3JbrruS9bNUM4ZC/xsqO88ibUlQw==
X-Received: by 2002:aa7:cd4c:: with SMTP id v12mr85455edw.17.1610985174346;
        Mon, 18 Jan 2021 07:52:54 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f13sm9561694ejf.42.2021.01.18.07.52.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:52:53 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: rockchip: assign a fixed index to mmc devices on px30 boards
Date:   Mon, 18 Jan 2021 16:52:40 +0100
Message-Id: <20210118155242.7172-3-jbx6244@gmail.com>
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
 arch/arm64/boot/dts/rockchip/px30.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 1a73a5114..c49366cf4 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -25,6 +25,9 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		mmc0 = &sdmmc;
+		mmc1 = &sdio;
+		mmc2 = &emmc;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.11.0

