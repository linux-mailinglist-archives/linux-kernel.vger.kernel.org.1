Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7819928AA55
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgJKUXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbgJKUXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:23:08 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE63BC0613D0;
        Sun, 11 Oct 2020 13:23:07 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c13so1257255qtx.6;
        Sun, 11 Oct 2020 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmIaDgGE58XyP65chgC3iPI5GCq1dVupIq3PDHXzLnk=;
        b=E1MPRRzYIZ0aDki51ehofhrFm0Z1ux7C0kpocp/M+H9BhF/SlNPQ+jvdyfcPL9eLVi
         5j8UE6I0kCIaDZ1ewOz7jYzt4PjZ63iIaik8J12Dsfh+sOlxx4EYCdkN82YfM5D2zy9Q
         W+xgyiYdn/D2X+EVly5WW5zrYT3RT6j5NFQgvjU7cgRcv9ym44zGZowtvgC+nIgOOeH9
         hj+7MW8N0jpHS3148x3RGsq/0/CkxoF6TuhukEXkGW1VfxFgK2BZjFXHvEmfYKSEJWH1
         Pa/KLyV1h5iUbXQT0oGVqh7RlDWoQyU034X3Vvk/QQjwQqUwIceJ3sYvkuAkebF7G5Nt
         3zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmIaDgGE58XyP65chgC3iPI5GCq1dVupIq3PDHXzLnk=;
        b=cqJpmGedz53B1hXHu0jzHogrAxAXhClY6h49ftHYlmOfNUxozaagOZ4fxesRZicZSC
         oUhEA3awRtQz4HTbR75tPuumMswyTPqzqvm/1gGR5DdueF75YRC8XXXWRcuEiBK9WEq7
         +duAE587jjB1yQKl8rByhp7cMAR8+hM4BsKmd7XW6fu+s+oMmCo5EWkG6MWe93kykWxT
         gNaqji63qqK1IN3YQz4WGIDy7RiznOtc0RRblgL7CG3PDGUdlkYAA7B8+QmPERwDX0bH
         Udh7A0IwNec4MaKeqzaOofx3ZM3cr5Wnv9MabnCYnmK7QqihgxX6Ovm8SPzl7CyOAOFW
         h4Hg==
X-Gm-Message-State: AOAM532TkiPTyUVcYLoglsJ94Jrakq8y+3pNhHZs2dx7kB1a+XIYi1cg
        F4TkDJLy2JKX31X3sRH3+0Q=
X-Google-Smtp-Source: ABdhPJxhdeNH575/RufpVe+3KodyGx2Vfirr3hdmfoXYz448UP5h87uNHm7gqw2mfihQmAbA/mA59g==
X-Received: by 2002:ac8:e8c:: with SMTP id v12mr6980888qti.329.1602447786934;
        Sun, 11 Oct 2020 13:23:06 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:23:06 -0700 (PDT)
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
Subject: [PATCH v7 12/14] arm64: defconfig: Enable Allwinner i2s driver
Date:   Sun, 11 Oct 2020 22:22:22 +0200
Message-Id: <20201011202224.47544-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
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

