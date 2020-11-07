Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0512AA509
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 13:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgKGMeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 07:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgKGMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 07:33:55 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17A5C0613CF;
        Sat,  7 Nov 2020 04:33:54 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id j12so4670711iow.0;
        Sat, 07 Nov 2020 04:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=msH8q+VSlJjhchFCpfyMO1x0f/ft0f4m3DT/7oi5wDQ=;
        b=Kd9LT7jLidLbhDbmENmULktvetaCuBBNACpdnJT7E+Q4jQBG5IxMbJxXMhXL6maGN+
         o41SlH/Pep6yQ1FXytG9NsI6aq6dVM1txDRNrFQEsFJRLh59AJhqepDPd6lSiIDV2PQJ
         chome8bGQSv66vtfi57OMQPz16i3AFANILqwqE5UoaRYjyPxjISQ5pGuKDQoVUoBE9fF
         SZSU8Bkjkxv4bP8VMYSRg1PrxDu0coQGzVhE/wOA8dStU4QgrBVP661cH/3ja+8lHlWk
         EgWnQRBktLdL3cdyYYFLnOzvTlg1XqPfp1JEU7DVq5SRZf9hN+HRc71ik9gngLuOtWk0
         Le1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msH8q+VSlJjhchFCpfyMO1x0f/ft0f4m3DT/7oi5wDQ=;
        b=ZiCxcqUQ0yR8Bs5DH3YVo9m6V+v+KehsB8gyTDUJxCPgDyh+Hh4/MeFz5SQYY2vFg8
         hzFrUS1G/1bS2lbqP/UjWqJQkteVRkCFWqu/E5G46/WKOb/xf3+1th0CGIbzQOv/RtSN
         8NuB4MSTUAKTCAP7zBIDpiPHIW+gNUFndXQSZ0DFqiZ95cKRYta3KUTN4m+ZnWKlBRZO
         yqVgk+H/YY/08evj5158QhVEW6TyTsMj7Z/sgTAaXGZpmgTIsM3vLtTLhAZwqKTF5WPY
         IbCqz8KOPX7I1grHL3M40GG0TMpFuvlof2EeRFACIQv6YagLrfGkOXh+fhXXMkha0c/4
         Romw==
X-Gm-Message-State: AOAM531a35mQvlyaMoIRHKA2C8a0UueNe9/wPrDMvf9EBHDoOlh1K0XH
        r4omcHq9SLo18qFHnpUtqcM=
X-Google-Smtp-Source: ABdhPJwn85YLC8DbjzosRFDIkfM2H4eO9Ry4GyUr9qkr5VsV8BS0Iol2ejzMISloEJ//XGUfogi5gw==
X-Received: by 2002:a05:6602:5de:: with SMTP id w30mr1108148iox.64.1604752433954;
        Sat, 07 Nov 2020 04:33:53 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id w12sm2830592ilo.63.2020.11.07.04.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 04:33:53 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, krzk@kernel.org,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/3] arm64: defconfig: Enable WM8962
Date:   Sat,  7 Nov 2020 06:33:33 -0600
Message-Id: <20201107123334.1868360-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201107123334.1868360-1-aford173@gmail.com>
References: <20201107123334.1868360-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Beacon EmbeddedWorks development kits supporting i.MX8M Mini
and Nano have an WM8962 audio CODEC installed.  Add modules for both
CONFIG_SND_SOC_WM8962 and CONFIG_SND_SOC_FSL_ASOC_CARD to enable them.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  No Change
V2:  New to series

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 821b21a56ad7..00357f5c6fa5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -701,6 +701,7 @@ CONFIG_SND_SOC_FSL_EASRC=m
 CONFIG_SND_IMX_SOC=m
 CONFIG_SND_SOC_IMX_SPDIF=m
 CONFIG_SND_SOC_IMX_AUDMIX=m
+CONFIG_SND_SOC_FSL_ASOC_CARD=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m
@@ -728,6 +729,7 @@ CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_TAS571X=m
 CONFIG_SND_SOC_WCD934X=m
 CONFIG_SND_SOC_WM8904=m
+CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
-- 
2.25.1

