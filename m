Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F362FC5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbhATAei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbhATAct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 19:32:49 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122D1C0613CF;
        Tue, 19 Jan 2021 16:32:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id q8so142967lfm.10;
        Tue, 19 Jan 2021 16:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gasc7AXG1NBfUNBujKx9TV2RfDYXzc6wKO2J8rBre4s=;
        b=mkV3pAohbA40bFz9L6eJJypQxBLBcx3Cm8XIM9oiyjuQRBcNRdH222lrN9dSYJx4Ec
         7K1upo/DcM2QwlzeqzCpA/pZ121uoEpOrrq21ud+VUxWvkXuMWXBzTJHWJQXX4Q2yK52
         2N+8+nldvqSqacB2eyAyKlyCmY4BUC9K4EufF0uMmd5fSEN3bwKZt9QK3d9aVIvA0e1A
         bbhjNCEtD8HjQTk3PyZPkhaYxrgd+5voqEVx17Q5Finqp2q5kBBptbmk2Q/AIJvLqS9b
         pkT+zYtJwaGpZZ3+s8J+3a0fX4VlDRFxXekKb/+JqChYmSWdgUNX7+ZsCKEXYBuAe3wQ
         CiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gasc7AXG1NBfUNBujKx9TV2RfDYXzc6wKO2J8rBre4s=;
        b=Ub/7mw4r+3ZPADUSGzfp66WSqTFznt/izWdry/4lb7p2P8sj1QEOpct8BFzpJyEuCk
         2muTGFnSG+4he/S0AJTrnYpeLu0VG0qv1LBGGKpAx1BmQmViGb7BRpkT1xZ8Q4Sn44UG
         mvcRwz0PUtmg7Qm5ylu0DcthCxpdU0bQKuITUEAC1LU3dJbfzZervkXOoTu2MKJFt47Y
         VOiIFlHEEX2pheDqNj+J2Qe3oYg4bQpCMGuRuRaqGwUkY3QHhrhfBOJoUFTqRynRnD/h
         6JYFfy1auLLe+QJMYauoYGZwgRdYHSwA5M9zR2wWTXquBdNQrALR7973Ll4X4VksVTpR
         f39w==
X-Gm-Message-State: AOAM531XKz2N1hRrAIVsLHCTlZNl6lpY/Dr16cipW8NOaRjPZFO4uGbo
        ffDfwljF+0t5Mt9OrY3YcMdzPWhNJaE=
X-Google-Smtp-Source: ABdhPJyRRN7rv/LuasYbbuHgPNKP5uJc3S87xRG9nXi6G1X9PH6IYShiTkIxv0xqI2pErkM617osaQ==
X-Received: by 2002:a19:154:: with SMTP id 81mr271043lfb.178.1611102726609;
        Tue, 19 Jan 2021 16:32:06 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id s27sm17710ljd.25.2021.01.19.16.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:32:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] ASoC: tegra: ahub: Add missing resets
Date:   Wed, 20 Jan 2021 03:31:52 +0300
Message-Id: <20210120003154.26749-5-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120003154.26749-1-digetx@gmail.com>
References: <20210120003154.26749-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AHUB driver misses D_AUDIO and APBIF resets. CPU hangs on trying to
access hardware if resets aren't de-asserted. This problem is currently
masked by the tegra-clk driver which implicitly de-asserts the resets when
the corresponding clocks are enabled. Soon the implicit de-assertion will
be gone from the tegra-clk driver, thus we need to fix the AHUB driver.
Add the missing resets to the driver.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30 audio works
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30 boot-tested
Tested-by: Dmitry Osipenko <digetx@gmail.com> # Nexus7 T30 audio works
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # TK1 boot-tested
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra30_ahub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 156e3b9d613c..8c32333cc08c 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -337,6 +337,8 @@ static const struct {
 	const char *rst_name;
 	u32 mod_list_mask;
 } configlink_mods[] = {
+	{ "d_audio", MOD_LIST_MASK_TEGRA30_OR_LATER },
+	{ "apbif", MOD_LIST_MASK_TEGRA30_OR_LATER },
 	{ "i2s0", MOD_LIST_MASK_TEGRA30_OR_LATER },
 	{ "i2s1", MOD_LIST_MASK_TEGRA30_OR_LATER },
 	{ "i2s2", MOD_LIST_MASK_TEGRA30_OR_LATER },
-- 
2.29.2

