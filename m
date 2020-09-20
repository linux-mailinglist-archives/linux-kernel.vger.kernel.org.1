Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650052716BA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgITSIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgITSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44A3C0613D5;
        Sun, 20 Sep 2020 11:08:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so10328572wme.3;
        Sun, 20 Sep 2020 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmIaDgGE58XyP65chgC3iPI5GCq1dVupIq3PDHXzLnk=;
        b=Kvwn4sNJQYuWLBfag/klu96kR4p1T1dbYI/SHohvz+RB/nWXh9sO5BS8n+cIC19Qd6
         D5aU4ByOv/tmN00RXPYe3xL5gNikDawJSQ3kTlWIoKqosNhNByOFam6pLtNNxmUM1lJP
         LEk4sQhd+EzOS6Ck8T8/TmBlMj9gRs8J69Hl2/EGOcnrkhwNhUAoH5rrOaYNUq+N+kzp
         f6/DrY56c11ylNeTRgB4gGfD4BEWjZmEK5HBt3chyxza1W1a06oxtEIAXYKsevZAdPuC
         W0aM4hkEDiRR3IxFvj40oV9aE6U2/Mri03ff4zm7ZqNjYN1WPcY8+WxZnHv5u8FnKNYq
         XlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmIaDgGE58XyP65chgC3iPI5GCq1dVupIq3PDHXzLnk=;
        b=Yidjep6HOY4b47gqM7GNaidIFUAsB8pROd3YrGFRRm9veGqIT9FrPoMe8HdRnD8bvn
         mGzu8n48JaOJ4PqbXHfM17O1uLEkw2D8HlUq0aWtT+jDau4GFpw1xxw0TJtWvxKT2ox9
         Dc6h/1EUYwjCIz9jCP4QaCmW0W4UVZ/ka1Rj63G7ZIO80UY7O8Vdj+UvrimcUM/N7ke+
         puXCztccXyE8a/U8dIdPojWbOvEI9smSfNLfcYuzFpwh5jrRAsOHT1nnyR6Nzds/oeR9
         T975HfzPPYUqjhu60hUrxkpxKr7ELJV4oTZArtr7tcgQdXX+st8IRuBinRde6stRIuQp
         +Dgg==
X-Gm-Message-State: AOAM5302UE39Wk4PWl7FUSH52V9Jxqq4ppxZJsgGYWI7vJNA2xFUnJWZ
        HbO+VJXsk7kTKnpaT3Fp4t8=
X-Google-Smtp-Source: ABdhPJwAe2vy7tX/cnWUUnWL7dwVD8OT/VXAinHq8vTpV8XOOkgDupS5Raec4D0ogrKe86Bfena9FA==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr26174993wmc.176.1600625315363;
        Sun, 20 Sep 2020 11:08:35 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:34 -0700 (PDT)
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
Subject: [PATCH v3 19/19] arm64: defconfig: Enable Allwinner i2s driver
Date:   Sun, 20 Sep 2020 20:07:58 +0200
Message-Id: <20200920180758.592217-20-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
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

