Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1082EFD99
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 04:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAIDpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 22:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbhAIDpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 22:45:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACBBC061757
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 19:44:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v1so4716295pjr.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 19:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uB92DUbwohcnWwVtbyujXH7Yz0oL9MOyb3SwRnmiePo=;
        b=ZH83PzSw6BIe8d/gDKZbJ3TGaNxxV8mPkaTkEnHVw2p4eFmTYUJmXhg4Z0OqN+ev8Q
         n5nK/kYnOJVmhs6JHUwKxVkErgoLJB5xvTGTcEjQ4lwzX33GbUnLmhRJt+1k/1GyYEoL
         P7FXOaLeKr+p5xlN4YOr1aFDzN712XzDyR6eMYVDkNFO/QVq4/Ii3VtpeCYEwYfmuo63
         nZR0cm+cTkxILfm3wGRkUX2QkVonbIUtWY1+IVeR6XyfrxfB79vnPAGjpjNub6dfFX3F
         Fjob7Z36mV9QXDiNwWYBz/pRCdfHLcI/gr+99suxk2CmxN/xG/oKT7N4kxq1vsTkKrxX
         xxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uB92DUbwohcnWwVtbyujXH7Yz0oL9MOyb3SwRnmiePo=;
        b=POF/Cftq+Sq39513FCfJiHDxweHMPS4JoHtcPsyqUCSR7XGtjHxRIQ9bfF5vPmUYlu
         lth6be5V4CEq3pE/jqvAEG8OW67F6UnVb1UpJGWi285gWQR1QXq6MWKHMVGJJkJqr7OV
         DrUmpsjNQYVVwKE2WZfptNnSZSva1nSjZd6WaOf5HWydXWu/0MsDD9c79bbz83B6jKx3
         bf9EHt0GCW9Jbub4OAkODIKII+tsdXl6E0XYqKchwxU5gksUKrVURhVFPbDi7ysKmY8l
         842DMQ0iP8igiH+mu0wt/fR/foLvnX4Mhr3HcatLF5pAsZMq2OxJ2y/7AueaI9vsCOAo
         cKLw==
X-Gm-Message-State: AOAM531iD3HshXztg2ZYlQ3ikRDV/rzZTB53JVKmEgjJ/PEpkq3irvyH
        EIqP7QKuud3VunGf31dehjVNOq+xKUrApg==
X-Google-Smtp-Source: ABdhPJy7/bAYzdNNmr61Zjr56SHx1fNrknsK8odyIFCPYl80ubIOMXYQATWQICuH69Pz+TBfaJgZiQ==
X-Received: by 2002:a17:90a:5911:: with SMTP id k17mr6976465pji.152.1610163898789;
        Fri, 08 Jan 2021 19:44:58 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.171.27])
        by smtp.gmail.com with ESMTPSA id q12sm10770952pgj.24.2021.01.08.19.44.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 19:44:58 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] ASoC: soc-pcm: return correct -ERRNO in failure path
Date:   Sat,  9 Jan 2021 09:15:01 +0530
Message-Id: <1610163901-5523-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below error ->

sound/soc/soc-pcm.c:2523 dpcm_run_update_startup() error: uninitialized
symbol 'ret'.

Initializing ret = 0 and returning correct -ERRNO in failure path.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 sound/soc/soc-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 481a4a2..29328ce 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2432,7 +2432,7 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 		snd_soc_dpcm_get_substream(fe, stream);
 	struct snd_soc_dpcm *dpcm;
 	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
-	int ret;
+	int ret = 0;
 	unsigned long flags;
 
 	dev_dbg(fe->dev, "ASoC: runtime %s open on FE %s\n",
@@ -2441,6 +2441,7 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	/* Only start the BE if the FE is ready */
 	if (fe->dpcm[stream].state == SND_SOC_DPCM_STATE_HW_FREE ||
 		fe->dpcm[stream].state == SND_SOC_DPCM_STATE_CLOSE) {
+		ret = -EINVAL;
 		dev_err(fe->dev, "ASoC: FE %s is not ready %d\n",
 			fe->dai_link->name, fe->dpcm[stream].state);
 		goto disconnect;
-- 
1.9.1

