Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2889B2A9608
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgKFMNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgKFMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:12:58 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDC0C0613CF;
        Fri,  6 Nov 2020 04:12:58 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so1225870ioo.7;
        Fri, 06 Nov 2020 04:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6H1fFozyeKKcyb7FCmptp2YIUA7XL8+rjQnzk8u6gE=;
        b=e48OD3+xHZYJO0wiD2HikrNndReP6JHTnQ/It4WuemT1dVcevYBpMc8Gc+2srbFvAC
         ekvQ5BXCTS9zB7m7z/b7uRfCf40BcmUGQSl7NsvMNwZFCGwt63JKSD8aVVQvr7JDrWwy
         YBgDwxkBpgOCp+1WHmwunJ1YlG1G00t31H4YaPsbQI1OEJOqsIj9ii0ckMLyMyogpjVA
         hqBHGQ5ku514TGVUzl8w3SMP6nFPi62f3F5TGIODfIUT+Rg+naKR6f8ffI29NB1MBt6+
         u8dru7Ed5pBVMLqrq7P7YJAo7FbBwdJLNo5Loc7iILNkN3Sx+ikVzD5jkVspD2H+Rc9+
         Frdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6H1fFozyeKKcyb7FCmptp2YIUA7XL8+rjQnzk8u6gE=;
        b=Kd7I0+PuW2VLKkN//2l2ID307Sy6nDAHkpHPg4titLPykoiLMjWXQkTRT0qR0Bql8x
         NBK/ImcpzDZVhq+2H/EB2heOPrv8Txz+uQn1cFDJzMarOvqoie+YVsWw+doSl9nQfmB+
         np1mltV0FhN4BLHQR1c6lAlfCPw3vn7vDBjBUdMmyfh2VV/2Qeto0/HxYAFyew/ozXAc
         /Q3QmP2csD8aIMuDsU8GgjYGcbjxOXzUtzHnqhUCf4hIQsvawaFueBIRpVA+yDsqq4zQ
         xLKxK5jU/X0ucvVAikWJWT3H3KjnuT7oDahe+1f4IUSYKbTFiWso+Ng2OZi1TcpU9o+s
         mNfA==
X-Gm-Message-State: AOAM530jt/Vkmh3AaRh1yLbW1NkOBUd3So4d0zjORuK+j6VMQCBKx9aD
        BlQBKXm3F1K9jQMLxc+xy2g=
X-Google-Smtp-Source: ABdhPJwwSKSQiPoLLG8/TX8+m0rwSpl/qtyR5HuVCoo5OOVMhifHRYr9oG6QhlnI4u4dR4eM1sObcA==
X-Received: by 2002:a02:ce30:: with SMTP id v16mr1309374jar.33.1604664777977;
        Fri, 06 Nov 2020 04:12:57 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8492:7d60:7e29:2784])
        by smtp.gmail.com with ESMTPSA id 9sm1102935ila.61.2020.11.06.04.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 04:12:57 -0800 (PST)
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
Subject: [PATCH V2 3/3] arm64: defconfig: Enable WM8962
Date:   Fri,  6 Nov 2020 06:12:37 -0600
Message-Id: <20201106121238.1814427-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106121238.1814427-1-aford173@gmail.com>
References: <20201106121238.1814427-1-aford173@gmail.com>
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
V2:  New to series

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

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

