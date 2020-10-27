Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF63629C774
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828535AbgJ0Scf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39096 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828410AbgJ0ScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:32:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id y12so3033592wrp.6;
        Tue, 27 Oct 2020 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Q1L59OjiDLpqGnNODju6fMwtd7Ss5Fh+8syeSPkSMs=;
        b=qr4NHz6bm05lZeqaartO3EjR8pFWyaqj3VDBOvDv8jBjxAuQCdrUzUcGSO0hbOFZbI
         cQW/AwGJU4gSV8ALHf077Te761/PN2Y4liN4ZBMbhead6bYJCIqkzDD8WTkknmQhNguh
         2uyKgReepohknYihfBJBbPDoq/Rp8T8yLhzQ3nxtYwaDF44utBCuDdHlnr+/PFmc1wNv
         VPOwRxDPBnCu833tyKv+gMTrbOnZOjLf7xFek3sNzgQOdNwCO4uwPqeegehvxMiB03lI
         JwCvlS3xBOe0WgggzWjpNpT/AoTfBla6sU5JDEMDfqtRHf8L5IGCl9OK3PXkdKXI/Ahw
         s5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Q1L59OjiDLpqGnNODju6fMwtd7Ss5Fh+8syeSPkSMs=;
        b=YKkFFon3WXtkWUfqD7aLz9Twhsorfhbm+0oYLZHIU3z1F59014aDwsUUgnkn2eya4S
         TOskEN9ioFjxYkQVQdbyETox2DbBzSNWt3UU+Kvxhqt2ruduQfwxAuyNLk59QZZbKGGt
         XF+Cv7Zgyp4HTXvmncA6vo92i4v7nie7ZwEBTdyYSAvoQD4LibovfyRbhT+FHRGv5GKH
         eNbg+4LWdQla6JYr282cSKNHgAasqEAaqVnoy4oa6btbHsrfJSf78GJhKvm18vZsXerx
         RMynqrGb7Ne1v+TsKC+0mi76qaNmU72+AcBD2lFgOR/0MwHNzz8s6vV2bmjieQkVIG5y
         DljQ==
X-Gm-Message-State: AOAM530J0SuyEXX3A5DljxjSfw6s5iVxLFnOd/Ceo05jrtguqlS4IqsI
        15EUytve8T4EtI5svZoUUZM=
X-Google-Smtp-Source: ABdhPJw6yj+heMDTliwHemk6LvJ/wQOTTX6O5m3SvjVsdUREddIGSEd28TtoCEP2g2DrMfqI/9VHDA==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr4631760wrs.342.1603823525818;
        Tue, 27 Oct 2020 11:32:05 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:32:04 -0700 (PDT)
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
Subject: [PATCH v9 12/14] arm64: defconfig: Enable Allwinner i2s driver
Date:   Tue, 27 Oct 2020 19:31:47 +0100
Message-Id: <20201027183149.145165-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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

