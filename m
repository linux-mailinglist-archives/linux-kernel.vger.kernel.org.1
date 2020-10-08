Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2834B287DEC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 23:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgJHV1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 17:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgJHV1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 17:27:40 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0344DC0613D3;
        Thu,  8 Oct 2020 14:27:40 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g7so7906092iov.13;
        Thu, 08 Oct 2020 14:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSyjIzYbBigGT0AzTfXLoS02VDK6YwDiuu+biIO3XI4=;
        b=UM0fMrHomjTawuqPBKKxJ3ndD3+6WawB6vEGpTjXPLxlWmrG/e4+ma+349sIcEX2xW
         iQOM8vvYgysbprsfGQYZ9ZfphYPuJHQ5eWofrScEZzWpwwcT0FoKWBzx8pvC4sO3yXnZ
         96CxvZBnMHgcDweiaD7n+n8dNa4QwOfou2THGRKskF+B0yaZaYnUAruQtKsJhK+lPg2j
         dUtszfdhHGz80uNHdAtULr67mNNgxbtLKIgBAJK9q+PeC8AGhX2xt9DP2ESQ+NPrJ7b0
         /JZu1XWIz2fOuCk0wuu7i5HE92aySngLaM7S3Lsg6LCwHgV6LnxzSDEv2nIX2AkSt8TN
         SXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSyjIzYbBigGT0AzTfXLoS02VDK6YwDiuu+biIO3XI4=;
        b=tT+eCgwgKYcnQqyStQTa7h/ucDL42d71AQpyeJq5N5IwVAuYvljsmLgRoPAinNByRI
         n48Zu/WZqI5hkd8awhKqxM5Uow8z9ZH/1sibZpGvGFKKP6uNb8ctI//vYaR7bZeTIwnM
         2Y0iMEEWvvwbd8Xgbxo9E6BiDJkzHGwPEQYm4SjvSy80XT8ZwlC+dVBTRkTtRT/WG4Xj
         a2noF5++7vZYdIg29OADVOJ3g697gq9wobNPzOSkchkW8HgqyS2/XZcvhxNQl5fIjVlq
         cCenXprhrn3pfUgXnOnJH88TxKKc2JcZfOJrxc8giRk4kFtVfJ3oacINNNoRSqM2lNK/
         xojA==
X-Gm-Message-State: AOAM531Z3aqTclUN0uM92JTxhE+yD3m2PWnsAe2J6LXJZUqzoySCl9GA
        IR30zBgd79zj/GkVo4BFjjg=
X-Google-Smtp-Source: ABdhPJznfkzthNXZDou0V1pe+KZJJi52F7DyY5i6obOBnMPB2EDY8Tj3xoqewJ6q2FRzZyUkS9elPQ==
X-Received: by 2002:a5d:8787:: with SMTP id f7mr7234798ion.79.1602192459023;
        Thu, 08 Oct 2020 14:27:39 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7c62:dd9d:b755:cfbd])
        by smtp.gmail.com with ESMTPSA id o72sm3067090ilb.6.2020.10.08.14.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 14:27:38 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: defconfig: Enable additional sound drivers on i.MX8M Mini
Date:   Thu,  8 Oct 2020 16:27:06 -0500
Message-Id: <20201008212706.870115-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008212706.870115-1-aford173@gmail.com>
References: <20201008212706.870115-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini has micfil and SPDIF support but the drivers
are not being loaded.

This patch updates the defconfig to add support for these drivers.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e0f33826819f..20362359b212 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -674,6 +674,10 @@ CONFIG_SND_HDA_CODEC_HDMI=m
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_SOC_FSL_SAI=m
+CONFIG_SND_SOC_FSL_MICFIL=m
+CONFIG_SND_IMX_SOC=m
+CONFIG_SND_SOC_IMX_SPDIF=m
+CONFIG_SND_SOC_IMX_AUDMIX=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_SDM845=m
-- 
2.25.1

