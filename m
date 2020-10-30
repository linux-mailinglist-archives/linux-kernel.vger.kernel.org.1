Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902E72A0840
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgJ3Orj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgJ3Orf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:35 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7943FC0613D2;
        Fri, 30 Oct 2020 07:47:35 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id z16so576976otq.6;
        Fri, 30 Oct 2020 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcxJttVJPuefUSZyGyu/mOpEqxZT+d3F8rDRrStvw20=;
        b=HAg/Wot2lobXoMZzDzeRlBy6HiM7gf8w/Y1DibKsoL2Z1u5vu5Hle8J55reIPywx0g
         DxkAWrZtfKwvNLEPHpNeV0tTEkw5cS+BZFWaQ0W4R76s8RaroOFFPbexCEGAuwQQR9aa
         57JHr1i3T2Mw12C3JHLO09zgWzw0oDIgisNRqz4OwPhX7OeChhkToLGN49IOC9w2eGHQ
         Sc15BZ5CS04UhFSFpH34rOxANPGJ4NRHXKYmRbbeEr3BkSSbGZYFuREJpeWsXXMTwvgs
         1T6osRQ4wMlGruHHruI1zlnUitA+VfP1JXdKj6m8cRcK+N2xKl6VGy70mm1PdKRBkBmV
         5TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcxJttVJPuefUSZyGyu/mOpEqxZT+d3F8rDRrStvw20=;
        b=VNvUMnSDNe27u22i2v1g88bYZelTJ9G17kc0oAfp4kdVyPexNkyMhtpzcnQgOPjHst
         gi/qoax6VC6nPbB+B2OT9TbXDKsdTi3OKohb6aIamHgHgHGr6W3RrtBhFadoCcSNJrt4
         Z37BcKaEMx29uEMddPkYc3ieQIF+rL4F6QMx+A3E53EBU8qbaXIwU5Vr8tM9x8PZ3KCg
         CiCTCvNeztoqn0m6g4/J8Xt8DWnxb5WhmU96iZVZl+KkB7idteDio/PExONMnpRr+rS2
         iYjXBE6QVMAvYJut70DvptKxNmjQoxSwsRH5b42RNgxc2zL4vxo7NcGYTtj8E2AWQfH+
         9gpg==
X-Gm-Message-State: AOAM5311wecrPdI2Tp4jGphGBreBA3S8i+fHVHLB8iVzVqxLtrDrtAIU
        2Kjw79pbxSR3AnQtx7P8loM=
X-Google-Smtp-Source: ABdhPJxn9qZf+LM4hk27YO0jHAmOCxZs1cQgIQXn2jsLewVxXPBD1fXNRtSew9+I9GVm6X0MmGEJhg==
X-Received: by 2002:a9d:1c7:: with SMTP id e65mr2089985ote.22.1604069254826;
        Fri, 30 Oct 2020 07:47:34 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:34 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v10 13/15] arm64: defconfig: Enable Allwinner i2s driver
Date:   Fri, 30 Oct 2020 15:46:46 +0100
Message-Id: <20201030144648.397824-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Allwinner I2S driver for arm64 defconfig.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 17a2df6a263e..3f89f427a355 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -706,6 +706,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SUN4I_I2S=m
 CONFIG_SND_SUN4I_SPDIF=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA210_AHUB=m
-- 
2.25.1

