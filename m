Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1682A2FF39E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbhAUSxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbhAUS0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:26:00 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC548C061794;
        Thu, 21 Jan 2021 10:23:30 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id i17so3641815ljn.1;
        Thu, 21 Jan 2021 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vI52iVvTMj5vx3Qwhb9RbRYQIWf8TgkxUBk2dPsjIEo=;
        b=baOFkq6nicanhOLmGDYkBVJLdJd6YMr0TVUusrYfZwGSox+gniAkb3WaT93s0JVHVW
         b1zp5ZMGxNTbiejRKNEMrORsxpW7Z0I8cZc2xBbj8s7JyiS6Lvw2aFzXH8azh86Kgab/
         q69jSkmxHZ5dbEHlgOxgmZ/Js21mT/jlUphcVpfp8bOKijrx6TdkE2PzJRcxXw56Nmb5
         STfqMUt3da8zpmlIJsowpmaRogEcSmsI70+gz11hDRjQ1Mkq+yLii2kB6/lHuBmehkqN
         Ti31YL1AkkGN2g4Ko7hu1dYq0sop5LpOmCWoFVf4zdE8OS4YzbYyc57Og6QH+yFalg99
         R7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vI52iVvTMj5vx3Qwhb9RbRYQIWf8TgkxUBk2dPsjIEo=;
        b=XzgwsyoGJbOSQA0zVy+sGOvIlO43sJSFbyZOOXA/H6ulqcs+bugyUiPZwoaq4xFxei
         GV3HMkInojbr5+TF+QHFTQYgRSiBPGLZBI+1JOlYLHXvdUQpmJNmIKKR083pyBBCOYsu
         oXvw/LmgU/NG/N3qpntVJm1dUjMhZ4CaGG8+JQu55rdAZ7gZvWJlSco8kPA37gqEUf4y
         eTfGRtJJAy3/tSdd9yOI9HgGmXdP2EBTz08RpajMZFOawxJQygkxXmO+F/CUg3/Mo672
         LwD+BZTQN3ECsPxr/xbQMvOWD1EIL0Jmtdb63OLq98Kmw6a9VU1yJAp3JqSCoI79/Tir
         NHmA==
X-Gm-Message-State: AOAM530c4ol9uEvtQP98QPITbazWPQM2qaIO1eW87aDK/on6k7MyLWeo
        6V8KsQqXjD39i0HlIdh6jcg=
X-Google-Smtp-Source: ABdhPJzymBWRuk/e5YLeWDMkpycTmpbuA2Zfk3OI2pbdS460sJEUinmrVETNy7RxT2p48fIMeclQrw==
X-Received: by 2002:a2e:9357:: with SMTP id m23mr286266ljh.195.1611253409492;
        Thu, 21 Jan 2021 10:23:29 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id f186sm600537lfd.289.2021.01.21.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 10:23:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/13] ARM: tegra: acer-a500: Rename avdd to vdda of touchscreen node
Date:   Thu, 21 Jan 2021 21:23:04 +0300
Message-Id: <20210121182308.16080-10-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121182308.16080-1-digetx@gmail.com>
References: <20210121182308.16080-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename avdd supply to vdda of the touchscreen node. The old supply name
was incorrect.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index 8a98e4a9d994..d852527db707 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -449,7 +449,7 @@ touchscreen@4c {
 
 			reset-gpios = <&gpio TEGRA_GPIO(Q, 7) GPIO_ACTIVE_LOW>;
 
-			avdd-supply = <&vdd_3v3_sys>;
+			vdda-supply = <&vdd_3v3_sys>;
 			vdd-supply  = <&vdd_3v3_sys>;
 
 			atmel,wakeup-method = <ATMEL_MXT_WAKEUP_I2C_SCL>;
-- 
2.29.2

