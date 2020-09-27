Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F13127A2B3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgI0TaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgI0T3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74152C0613D4;
        Sun, 27 Sep 2020 12:29:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s12so9507159wrw.11;
        Sun, 27 Sep 2020 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmIaDgGE58XyP65chgC3iPI5GCq1dVupIq3PDHXzLnk=;
        b=d7tabAeEQcbWpIcf8bNpbfx+YiUYroDJG3Mpuft5m+pZXAm53fT4rIrfX5RyaH/+0U
         fES9PX0yez+Y0BwKocC8M+j0DG/b1hBw85XPyTKT0bEWevWR4ZlUYxDM2BBezH43ftds
         kKSBWrB98qLZ9gPhzqiVQNvMgzG7xh4iVLOhnEDc04VYwcaDHFbPTi/eEeiXGK/Y//qy
         VtcgkElSkGfTaUnnvkjUOffMfx3MXOkrSTLR9NYMkts5u3imN80VjOGI+1MQML867Eb7
         H7aWNftVjvgH2gYS08pOfCSswsm9PXcBk/P5cK/BS9ARUuXBvq6U3ltRDTWJQBkCHVO2
         o+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmIaDgGE58XyP65chgC3iPI5GCq1dVupIq3PDHXzLnk=;
        b=mep32nWnAAmdWSmYXZCpQo45M5pqEDryw0Z4XqTBQ+yZsuJVecAkgIDPBCNfCFxGyq
         HnOyTl1Wf9e5vZqoWXqXjn/YfAH1IPtuGpcBgeozJeITeiz09Kg2zgxtBiq2FVRRx9hJ
         pDgxL0alcBzduWnbgmdPjLhpgcaTg06K9ZU4j76ogS8qteVhKZtBjV11/kcN8mwcmd30
         3C2EmFwkbkSmW5pkxrVObzro26mZlVDbZjlY++rEWp6Qj8SLaTEjn53rwXVOn3YP430J
         UFw/zkbNwZb/nIMyoBzTNoVI12U8vKPAwresuw6N1Nr1uPM7uKXwFw9FjCJu/6GHQitg
         A4tQ==
X-Gm-Message-State: AOAM532U9dKgGrYgz34mFwCHni0Xq7e2ZfgmyVH6I4z8k74XknK6+f31
        kAhbsCDeMEwU7E/snQU2JYdrP6lV8JkriQ==
X-Google-Smtp-Source: ABdhPJwljJVskiQ1Pj0MaM/KEgYjDiPvS3aD+BnOt1B+mZDbPaEY644Sj7saJphk6yqLypNH4WrKhQ==
X-Received: by 2002:adf:fe08:: with SMTP id n8mr14997891wrr.159.1601234979015;
        Sun, 27 Sep 2020 12:29:39 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:38 -0700 (PDT)
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
Subject: [PATCH v5 19/20] arm64: defconfig: Enable Allwinner i2s driver
Date:   Sun, 27 Sep 2020 21:29:11 +0200
Message-Id: <20200927192912.46323-20-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
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

