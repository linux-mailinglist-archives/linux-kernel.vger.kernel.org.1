Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3F2292D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgJSRpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgJSRpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:45:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DDEC0613CE;
        Mon, 19 Oct 2020 10:45:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j17so1096545ilr.2;
        Mon, 19 Oct 2020 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eem5uSAHh4D2aBjTdDEvkmSJvzuO6QQlN2jb3gprnHE=;
        b=GJiGUJtrYBdDMPMug0XUya6WIGheu+n+MaJivoHXwU+rJQj6ZvtcEyf6FfypBE4QUL
         gJS49GrU1L0+giI393zD5HOOx/Xm25+XR/AayPEs5BoK5g0N1Nql809NgZB2kqd85piV
         02zBI0e/GOQ1cEn/EOREmtSvZbW50tXf+Od3WZH2xJzyCJ30lLqOFKeVg3fvgTxmB/dY
         rN9cH5HY3Zr6Uco5l13CI9l5xw9gRVz1l2Badg3oEKyb6VtaM8lCvFVjGmrGVDaH39bS
         upoNXRCNcjBslReh6DKpvOrElqhC9EvD6ZtYh3qkyGzxapj8ctGJAQ//RzRwPLDHII6e
         NgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eem5uSAHh4D2aBjTdDEvkmSJvzuO6QQlN2jb3gprnHE=;
        b=QrU0tfscJIXP92BMVvEu50+XogCEB6ULX+H5nNv8o/LDMplYorBrPL6Fs4ajJ1AdV3
         Yo2byJtMPYnB/8x1txpBGgTUI+2dRszTYwe75rpnQuUHr12og14YVGvmyzj22g6HdC9Z
         Uep+2FtX20SFM8xpaSoGwIpHVLiHtEhJCFUxLVWIRjCaDZWsLtxfcbgAXX2pIvemFipp
         QxFv1qcQ6ZsDAn+lmhyxB8C+AGc4NVBI9YjysvEBOk4A28snpzEM00uSRWo4sfW2MNHP
         htdALh6H6htuy4lvTDMX8F0be8twctgTT2tMvvsNmnrwrfhz86QFgJMkErsDWAVrT2Zo
         y10w==
X-Gm-Message-State: AOAM533bCmZMdhBMUD1jYQ08IrboMRTzvxnSlkInI5zrCTwHM2SKGBLg
        5U6gZv+S8BXS4R4L2ekrvXw=
X-Google-Smtp-Source: ABdhPJynrWktwEk7W7JS9J99sSyrNT+/0igsD/7FzsW66xL1IqJrEo+gKGduIrupxBkGrBvJ0S3MLg==
X-Received: by 2002:a05:6e02:1241:: with SMTP id j1mr988319ilq.267.1603129538674;
        Mon, 19 Oct 2020 10:45:38 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:75c9:416d:1d67:486f])
        by smtp.gmail.com with ESMTPSA id 128sm406261iow.50.2020.10.19.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:45:37 -0700 (PDT)
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
Subject: [PATCH 2/5] arm64: defconfig: Enable ASRC and EASRC
Date:   Mon, 19 Oct 2020 12:45:25 -0500
Message-Id: <20201019174529.289499-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019174529.289499-1-aford173@gmail.com>
References: <20201019174529.289499-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano supports the EASRC driver, and it requires ASRC.
Enable both of them as modules.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 20362359b212..804ec4dae674 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -674,7 +674,9 @@ CONFIG_SND_HDA_CODEC_HDMI=m
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

