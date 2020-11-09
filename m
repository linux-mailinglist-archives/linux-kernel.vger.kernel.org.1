Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34932AB03E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 05:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgKIEmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 23:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgKIEms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 23:42:48 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34621C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 20:42:48 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i7so6027132pgh.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 20:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3xtpI1EBxPhJxIcZHK2eGfg5u5iKSoTtd80UNVJC+I=;
        b=Pns2fdtGPzS0b9eX++ESbEGT00VDj64DaUhUUvg3XPJoqY5WeFm7mg/DTHRxzZtxOh
         NrfQPM9DzIG3B2O94Xb82TCITirxBS82JXmASRXnkSOyq+jvv+ChOFlD0Ck1s6pkTO3C
         xjbhKpi94oUS/FgGof3HDZX+YLa8fQRF7T6mlgZS7mI1gB+s/lYQmxnBMpP6MEyMmRbp
         KkMLeVuW+kAPPi52ivbdlq99Vuf6V16LD3SYpSIUHW/UnDI3DbXOfWezOp+Os1rCAGc1
         G2iZJUaJujDqEoykGj3YPNYWHBL22KXfDUQiEnlHdJNdAsLCbjWUzSIXrU/qd8XGFaWC
         m9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3xtpI1EBxPhJxIcZHK2eGfg5u5iKSoTtd80UNVJC+I=;
        b=mg2GiYMcKBVXaEBI8ZCHFUBDMiRaft+oM39RWM3zBUQ7q/XgtSTtAEV/7odK34s+6E
         ToA7SZjynJ95CUNkL7Fmzumkb916kEvl0G3j+qfelm8FsFnJ1XTe9yIzTwt5eaSxs1wJ
         RsMJYanc6lnp2++cGrGkSOgl6opNcUZS676t5d4KRbcArIKKc8NhBxgfrfl4nALCxnX+
         XTcpe/UohoPpDBxWamaMUoNF1lG6OR8KtgE6XHIba5puneX5J1oHN4a27pFiW6f1C1Dl
         E5U9VkiNjcYLk3wOpf0uEtKuNxVl5yPuUOzgQ3q2eoOhLWeRBPg6V2btplBSOgUkKd/7
         PeMQ==
X-Gm-Message-State: AOAM530YzWLgP0FjG0TihDSoT0tRGzzDAchugXmVnlqTb19qmmaUqwlI
        EvQdRxWNycbpJygt2FmBNoQ=
X-Google-Smtp-Source: ABdhPJxINtKfg/KYH4TaPv3u5uOyVjvpn78XrzW4L1bT9L8pfcr/Shi3ft+pKp0PNx0wqGX80NgsKA==
X-Received: by 2002:a63:6bc7:: with SMTP id g190mr11149504pgc.250.1604896967743;
        Sun, 08 Nov 2020 20:42:47 -0800 (PST)
Received: from 1G5JKC2.Broadcom.net (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id m12sm9329209pgl.90.2020.11.08.20.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 20:42:47 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>,
        linux-kernel@vger.kernel.org (open list),
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/2] arm64: defconfig: Enable ARM SCMI protocol and drivers
Date:   Sun,  8 Nov 2020 20:42:28 -0800
Message-Id: <20201109044228.6836-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109044228.6836-1-f.fainelli@gmail.com>
References: <20201109044228.6836-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the ARM SCMI protocol and the common clock, cpufreq, reset and
sensors drivers. Broadcom STB platforms (ARCH_BRCMSTB) implement SCMI to
provide support for CPU frequency scaling, clock configuration and
temperature and current sensors.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5cfe3cf6f2ac..5fcd09e505b4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -93,8 +93,10 @@ CONFIG_ARM_IMX_CPUFREQ_DT=m
 CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
 CONFIG_ARM_QCOM_CPUFREQ_HW=y
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
+CONFIG_ARM_SCMI_CPUFREQ=y
 CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_QORIQ_CPUFREQ=y
+CONFIG_ARM_SCMI_PROTOCOL=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
@@ -522,6 +524,7 @@ CONFIG_POWER_RESET_SYSCON=y
 CONFIG_SYSCON_REBOOT_MODE=y
 CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
+CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_PWM_FAN=m
@@ -865,6 +868,7 @@ CONFIG_CROS_EC=y
 CONFIG_CROS_EC_I2C=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_CROS_EC_CHARDEV=m
+CONFIG_COMMON_CLK_SCMI=y
 CONFIG_COMMON_CLK_RK808=y
 CONFIG_COMMON_CLK_SCPI=y
 CONFIG_COMMON_CLK_CS2000_CP=y
-- 
2.25.1

