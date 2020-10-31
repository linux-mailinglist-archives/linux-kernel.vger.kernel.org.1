Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B712A179C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgJaNXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgJaNXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:23:43 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD3C0617A7;
        Sat, 31 Oct 2020 06:23:42 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id v18so8998323ilg.1;
        Sat, 31 Oct 2020 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isaSRmv2eXQr4dOSaaj56npZwLAZlT7EbE9+h5QtXuk=;
        b=Bnx7pF3qWmZvjIR3PR7xag6SOLIQBvaIEZdZBlzXDOuxmKl0iZvYnsZALyUkhKHTUx
         MMm/mUGprQl3iTW6pVW6bbhEArxwQL7+b/kl88wTOpcbbmBFkgi83SXQ7YlTGQHxHupV
         4xBBP1101TzP9D8/25+3Jj8OeLwdw6n0j5kRKUnBOyNtbE5OOqeQ8Gj7/9BSUAXJz2HZ
         1vUxROj9FVDV1UsR+sndnuCYyT/FiHUEd2aAOise0knZWP+vVAbqcGzHWmsobxs2Foj9
         jEg6j9tScSkq8wSZRiJMLBFwhOiFkxYgxYSzd7k5L5ScIlMgq0gvgZGfF1M9EbvIPZxv
         JL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isaSRmv2eXQr4dOSaaj56npZwLAZlT7EbE9+h5QtXuk=;
        b=l8HzDhRRdeBXpSKQLq4isRYC2nHtfZbZQW8lKrY4QTnRHfEzxt3XInNF307DPCTOTH
         XXyjmdIJKiF4h7pg+jLV57PyhiZXwVvpvrCgQpAlcMHXIv53f0ICB67IgflXNdeF3Zlc
         nNDkwwH8PiosXWN8LQClPu/LNp7KRUmiOnOk/LXCm4DnCqk79FDDIrt+/PO3napRzFoR
         ndV5Qb82MNB3W0tigvNJ9Z/cjzAmN2Y7+xbZOP23FR9deYm5UCgZm4PbHmlzlAAyOzq1
         am40bCfnWypXi+2zeYkkAsDJk3eLkPPGOfe+T80cIYiilJE5AFQXL0qEMuN8nSFenKEr
         tkiQ==
X-Gm-Message-State: AOAM531cH3a7vqxc64Moun53Z1iM6QeXobeENEXcCGpt4KrgQK2/At3a
        xJJeiAb6/ViUCkDAkMpon08=
X-Google-Smtp-Source: ABdhPJwiVLbalppXK7hQKZomiwjRcoqtziwfqysT7nNitz7LOFMiwcQzhmsS24/YQwntW5qKLfmHQA==
X-Received: by 2002:a05:6e02:87:: with SMTP id l7mr4827882ilm.60.1604150622257;
        Sat, 31 Oct 2020 06:23:42 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c107:3b4f:7176:6aff])
        by smtp.gmail.com with ESMTPSA id y3sm6804655ilc.49.2020.10.31.06.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:23:41 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, marex@denx.de,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] arm64: defconfig: Enable ASRC and EASRC
Date:   Sat, 31 Oct 2020 08:23:25 -0500
Message-Id: <20201031132328.712525-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201031132328.712525-1-aford173@gmail.com>
References: <20201031132328.712525-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano supports the EASRC driver, and it requires ASRC.
Enable both of them as modules.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 844d8817e6f4..270d326d5f28 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -694,7 +694,9 @@ CONFIG_SND_HDA_CODEC_HDMI=m
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_SOC_FSL_SAI=m
+CONFIG_SND_SOC_FSL_ASRC=m
 CONFIG_SND_SOC_FSL_MICFIL=m
+CONFIG_SND_SOC_FSL_EASRC=m
 CONFIG_SND_IMX_SOC=m
 CONFIG_SND_SOC_IMX_SPDIF=m
 CONFIG_SND_SOC_IMX_AUDMIX=m
-- 
2.25.1

