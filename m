Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491C72EF48D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbhAHPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAHPLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:11:21 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32780C061381;
        Fri,  8 Jan 2021 07:10:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id b9so15055277ejy.0;
        Fri, 08 Jan 2021 07:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzMaZRLeE+na0Be52jR8ekSOBZawObKqnkIMNOZOsBk=;
        b=ApZh3a/jqPTCJS6WQmD6BsU3CBI57p/9NZZf9ZdU2QBik1vJnwIxKN/3dd8B7nPpd9
         7Pw5jC5SHJjbRwv2BcL16Xuwq2d7JTjilV6nFAiBccB8FCg/c/j4ZD6/kERtLBMdM7xE
         rkt/0jEsbHbgMNl9Q5EbWXxq/USsUZ/Rl022eUWsBE3U58G001pr8lH6CqbAu/+IRdUh
         Mii+NOg5UEZAKNjKPk0wz90gizkFwIpQ2FyHiI0+JK3pFxVXS7G4pT6/ArDhWOzlWSWc
         UfTb6LfWP59CVh85rb9MkVvcb4A8C7bdt8DTRGgyW7bSvEz4l0rip0IzUI+mJC4IPl6y
         IT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzMaZRLeE+na0Be52jR8ekSOBZawObKqnkIMNOZOsBk=;
        b=GW47z1RH4DAFGF6puzZEFU9BsQ3MrlJLcFrg2qhcFowuRxiLqCOpA88lRzPq9SyOZ8
         xlyDgc6xVtlCQwwOF6hh6mdXXm8GOyG8x90oCgh5ktkUxDFij4sHcQ/HuJBPYrx5L16d
         8S9gXH6nsUaGMLe3MKIf9SVYbcO4cJghYaYXJ0O1pinQx8ixG6C+jgLSR0NMUT0YM8CR
         MEnx4JiYpTvUxIii5yHPXjkTiIc0QZZLmgIvyHrJLNl2nxVtfPWTQmcVt+wvmjtseMg0
         5NjG0vMRPimLS+1P/woMiIlDuaZnlW0S1s1cMjqX7DiqF/xanGxf6nBBiG/iUyvFuB+o
         7y9A==
X-Gm-Message-State: AOAM531hYOh1ojG4PJnjGMY7VvESpSIQENzW96IPypGaHxlRqXS67zGi
        Ce+HFHXBXp4IBOC8Pe7Dlw==
X-Google-Smtp-Source: ABdhPJyNHoMFIaUrKxspFlQKw5hyBXogwLWUnAmujtBMyPp0WFF1vrJRHKcwdWRpWA+MxZV+bwZqPg==
X-Received: by 2002:a17:906:3781:: with SMTP id n1mr2924175ejc.296.1610118639944;
        Fri, 08 Jan 2021 07:10:39 -0800 (PST)
Received: from demetris-TA770E3.lan ([212.50.117.154])
        by smtp.gmail.com with ESMTPSA id oq7sm3669286ejb.63.2021.01.08.07.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 07:10:39 -0800 (PST)
From:   Demetris Ierokipides <ierokipides.dem@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Demetris Ierokipides <ierokipides.dem@gmail.com>
Subject: [PATCH 1/2] ARM: dts: rockchip: add gpu node to rk3288-miqi
Date:   Fri,  8 Jan 2021 17:10:35 +0200
Message-Id: <20210108151036.36434-2-ierokipides.dem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108151036.36434-1-ierokipides.dem@gmail.com>
References: <20210108151036.36434-1-ierokipides.dem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Mali GPU node to the MiQi device-tree.

Signed-off-by: Demetris Ierokipides <ierokipides.dem@gmail.com>
---
 arch/arm/boot/dts/rk3288-miqi.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
index cf54d5ffff2f..713f55e143c6 100644
--- a/arch/arm/boot/dts/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rk3288-miqi.dts
@@ -123,6 +123,11 @@ &gmac {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
-- 
2.25.1

