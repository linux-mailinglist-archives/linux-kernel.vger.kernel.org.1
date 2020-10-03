Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92462824AE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgJCOUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgJCOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F5C0613D0;
        Sat,  3 Oct 2020 07:20:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so4845689wrp.8;
        Sat, 03 Oct 2020 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmIaDgGE58XyP65chgC3iPI5GCq1dVupIq3PDHXzLnk=;
        b=PkPumPmC8UXR7M6JISSOLFp6uHxCWx5Gz8lQ4wAlK8ysxW/T/ZEawbeo874FmiIEwb
         MNURiyCbKxV7avdUuy6FogJ/SULdjfkMLiQwqkGw6QN4EQMEybZzoqbwnZqJGNqKOQrc
         wZGsKrYM6hV570Lj0yaOKTzPu9GKzkrWGpbAaoO3KRpWs+SqjNHUxyw6S115pEvyEiVn
         OoQuIvzdg6O+R1h1P65uuOrUH6bQG5S+PVAC+tuXcKnVzJwhIgyKzxACwI5X9JAwIdzV
         QPJuHqzEPAPT+TXn1vjT+duRavvo6bSRiQhn266y/Hx+Umfo/U4mdkNXNgnCy9CbfNT1
         WCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmIaDgGE58XyP65chgC3iPI5GCq1dVupIq3PDHXzLnk=;
        b=Pe0qoZkafLAKToF9txtDrvhHyupzDF9lTcC4Ros7TrxBavJpKDLKNerlBLcwQ+FBJj
         iEdcU+hr0VnlnLYy5UYggF/etgcrnBGp7I3E2ZakbtPErxOs5bj4hfKahb/4SNOBEZYP
         9BRT4USqvW1Yldl8EVVz54SjiRn8gPbjncvK5HEBe5a29uCS/1sIV64tk/egK21DBC8a
         AoJRuQlTbnjO1ajzqxHfDU2l3QPByNRVUXDD3JGGtvhnR49STp7cPom38CLndN+RpST8
         pH1NWJHgL4LN7XRnMGIf/c68eeTKqS3SsLCUCRgkYwVpdmBx5hoiEOyaARrO6YaiTz91
         UyDg==
X-Gm-Message-State: AOAM533E5TTlUi6H5+5TcwHgd009hbNazOJj+smM0OmG/lL3JFHFAXR+
        sXQlsfu4yMmPDDau9SaqATI=
X-Google-Smtp-Source: ABdhPJybDm/3+hVrfq2zldYYD/jf+UjasFjPxiRlksPrIbV02wedg3SWd4aDtT+bbjnaSEV0uoStqQ==
X-Received: by 2002:adf:c750:: with SMTP id b16mr2258135wrh.231.1601734820048;
        Sat, 03 Oct 2020 07:20:20 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:19 -0700 (PDT)
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
Subject: [PATCH v6 12/14] arm64: defconfig: Enable Allwinner i2s driver
Date:   Sat,  3 Oct 2020 16:19:48 +0200
Message-Id: <20201003141950.455829-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Allwinner I2S driver for arm64 defconfig.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 63003ec116ee..9a3c3bbe60e4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -696,6 +696,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SUN4I_I2S=m
 CONFIG_SND_SUN4I_SPDIF=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA210_AHUB=m
-- 
2.25.1

