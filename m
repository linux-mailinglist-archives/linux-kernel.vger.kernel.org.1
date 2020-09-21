Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09A2720FB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgIUK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgIUK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:28:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91291C0613D4;
        Mon, 21 Sep 2020 03:28:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so12065582wmm.2;
        Mon, 21 Sep 2020 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmIaDgGE58XyP65chgC3iPI5GCq1dVupIq3PDHXzLnk=;
        b=FMXBOj5hKys6EaNWpeo+myfbNl//8YvnBN89BFoEEHUJZlceUP906hxpjtJv5e75w5
         oFW5sBEhNYpIKj8775dDM5YYj7mswOuI+WsmnkqXSRH4hjLRtmEYMujDq1Ge4jy+qz/7
         NLvqF8zfp/aFb23VqoQWG9laqbjpHqhxNQxmiFyYAHUvntfbU4VczKFBB8t55weFtR7T
         Pc2AOrKl7/B/qGR1Tnmf8elBIkynsAyjVj6iUKkXT9F7ThCel4C4qYj8OhF1oTKdjX3L
         NZXp9yA85wHNIITHL7XoTRi4ShYw3DdMZMaIU0W5v8CvrITpByv3t10VleWdDzsc24PW
         H3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmIaDgGE58XyP65chgC3iPI5GCq1dVupIq3PDHXzLnk=;
        b=cTOR2QzdJ/VwvK2cG79cJt8BwTpYi00DEaIN4pdDh2ObK0FAau9xhbtjJbaDbtx0vL
         TrD/BNUtZI9Hw1SKyRaAlE4PVcmd+2Y1ztw2pVztPkC1rA9B3T7WjkXub5iG/qD+rjHU
         lwuibQg70xPEQ3eywy95swibjRv+H2G7HCh/w5EFO7mQZmu+UdkobFVsQAa7qGeHVqKA
         xgst+n7ypBxqcoB7oEP1upqkCN3ptPNK+bQxPa91YI38GjcDXdZO4yGhNDXxhMfs5+oy
         OxCTOn4Ya2gJDym9dcrco8lc56agFmTN2/cs8ESsbTSo+I2to879AROJB1Ht6ueIAOQa
         4kRQ==
X-Gm-Message-State: AOAM531hPzJm8+pVuguqKgnpydMvizD7yxRNX1bqcF5+dySuSD7KUBn/
        R1/pJZoRcTnLKfI+QQC8ANc=
X-Google-Smtp-Source: ABdhPJw1ABUKhhXdwUXKiHV3VKM/RDi97yjnt2ISW/EICG8i5o86SQj2o9UaSjhO3bGot+0lItDZAQ==
X-Received: by 2002:a7b:c1d9:: with SMTP id a25mr30621915wmj.4.1600684081195;
        Mon, 21 Sep 2020 03:28:01 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:28:00 -0700 (PDT)
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
Subject: [PATCH v4 21/22] arm64: defconfig: Enable Allwinner i2s driver
Date:   Mon, 21 Sep 2020 12:27:30 +0200
Message-Id: <20200921102731.747736-22-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
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

