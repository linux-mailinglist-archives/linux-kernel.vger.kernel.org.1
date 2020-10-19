Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB2E292BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgJSQu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbgJSQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:50:55 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54711C0613CE;
        Mon, 19 Oct 2020 09:50:55 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q9so418342iow.6;
        Mon, 19 Oct 2020 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o44n/E2UP78CKYzuphkKwAc4T0bUKfv/iHopNulX/aY=;
        b=FYv/fQ94YQhd8HbVWhVFtkrFbWHQumYBH7JK51j7o/F3jZJ8J84fyBaJ+nWir408fo
         GKMWL265G2eMjx9vOeMn8LlUs8dBQ9L0hceccM24Z369oeGY7lOLjlwm9ZbtxV5YGgrK
         ecNJ9RXJJ+UmCmO6cy6Pmou5FV8G3/Lkh5+XSQOaKtSwO68CafaR1VTLaeePxMbv1P1+
         bZUL/EiIF3CLXPFyxulrMSFIkcu7cZiCXvZmScYGhgy+B8p38WlgPDL5cV9iSysvLwR/
         3nh3LGVheBYXM5zJe74QA+gOBL8vCKdy/OGuZ7rVckK9n7lj7Q2q/uz9Msl/AqBWxKo/
         NvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o44n/E2UP78CKYzuphkKwAc4T0bUKfv/iHopNulX/aY=;
        b=KmKXmohMNHXG9qcg7+la0foZzX/Uy3DpplXyzzJjpu+nK4WF76carRy3JjlvJo7LvP
         qcFQdAAy554iL8mMwZ24N3/Yuz3+Jw7sB9svN36VNvjs1LDSf/QWkA3eW2aCKa1Z+h23
         l8jiijMDgumVBGepHnpi4v3VsDoS6db4+sMFNyVZcvs4mtUe7VKImcnx9R+GPcqRZOId
         pWt9fSQV8vZ5q9MvcbtzyNjbpIyKVo20edXlMRjZjxreFW+580StwUaNyp+PNSj9/A/F
         uLrgn9FZ1fQo/uxOHpHyeW1WZQl7RhSrlablXtt+ptSmNmrQlXoEU0w2DFqAF+85zjKn
         YuLA==
X-Gm-Message-State: AOAM533vnTgipSV2Qve9Xgr1rlR5WEylbCy1+925lEzjEkSdhqYJR7MG
        ViugDIYcBw4uncYspqXUNkc=
X-Google-Smtp-Source: ABdhPJyGadKo4fA2deFmtwfg1b/lOCqdG0qoG7t0n10yzg5qCHUM4+Bcd3Kwvgxn3NgZQ8duk2JKTw==
X-Received: by 2002:a02:3093:: with SMTP id q141mr743842jaq.88.1603126254555;
        Mon, 19 Oct 2020 09:50:54 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:75c9:416d:1d67:486f])
        by smtp.gmail.com with ESMTPSA id p17sm212839ilh.34.2020.10.19.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:50:54 -0700 (PDT)
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
Subject: [PATCH V2 3/3] arm64: defconfig: Enable additional sound drivers on i.MX8M Mini
Date:   Mon, 19 Oct 2020 11:50:38 -0500
Message-Id: <20201019165038.274164-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019165038.274164-1-aford173@gmail.com>
References: <20201019165038.274164-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini has micfil and SPDIF support but the drivers
are not being loaded.

This patch updates the defconfig to add support for these drivers.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

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

