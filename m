Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE8C29E4F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgJ2HuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731374AbgJ2Hnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:43:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE4BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 13so1650257pfy.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tubacnQpwB3/W2PhhRu24urvA3DZqPuQW1vT0viMV9c=;
        b=qelMKJ2WSeEmQYBOX1ZKDe81Ga6Ri3W0Vyv+XB3IPPvJcxS32qo9MAPakdGNGTBBbq
         zrqOzulmZraX3Q7qsRKvDDYFQk7udvuSECmgQJGPxjaJ6Dr+7I+ILcb+r8U1KjI8UTmf
         qxc5S4bAEM1nkq0i7esFIzTiCzQOfn0OVOaxCogYvzwU4DGlF/Z9ok/mfJXLwovnkcZ0
         3C4yEoqwfNwBYF6tlPYKL63YLgSKl5BnMVy/m82jOBhOcCQ1eL7fINId/h/LLGtWaYUW
         LErPqdvsFq6LiV/7vIWgSrlgaxcgFLkvhhD1mZlYPmchGJHRK7ThN521grVT1fGzcAz4
         kvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tubacnQpwB3/W2PhhRu24urvA3DZqPuQW1vT0viMV9c=;
        b=TYzhOpUhr4ugcYCpFysCiiDnCftyAKIQij4Yy9BlxAJaomfxEHO0zJSSlAHdAlUZsc
         R/dILHvy4uv6goRbQfMYhvNjAD1az301XiqQ+ReBboA48GCZvftc52QxElaabSAw5Kdk
         drCfUPE4V+BXaD0VNFdxsYcXdO8HivjYye01VKhuBET1oQP7YvMvybXKan8NFXhixe7z
         RpCp22a6Pn+M13tZ46Gxlb2JAf999fGd4L1si8ZBziY0X5sOJaxVvhOXDMiE5oEupt4m
         3lGamlELJnsO4lpppas47i9rdmMDfXRo++eVOF1pTPlCP/PoTLydjV8LwGa74CX+Q95g
         9+Gg==
X-Gm-Message-State: AOAM530WLGeQVQiNZRopV4CWzx0hIXhm08hY3xqkgth7Z+2Pl9lqLmJz
        6cTrofkS5Uw/ypiNQvqg24k=
X-Google-Smtp-Source: ABdhPJwfCpKPCpSPUWy+Lzj+iwnX+ql0BPKlVGcGxkFcgc7JIGCDlh6SjXrSCFSf54pnToB9lwi7Hg==
X-Received: by 2002:a63:7e4f:: with SMTP id o15mr2971579pgn.428.1603957412989;
        Thu, 29 Oct 2020 00:43:32 -0700 (PDT)
Received: from localhost ([160.16.113.140])
        by smtp.gmail.com with ESMTPSA id v4sm951756pfm.57.2020.10.29.00.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:43:32 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:FREESCALE SOC SOUND DRIVERS),
        linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/25] ASoC: fsl: fsl_ssi: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:38 +0800
Message-Id: <20201029074301.226644-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 404be27c15fe..065500a4cbc1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1669,7 +1669,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int fsl_ssi_suspend(struct device *dev)
 {
 	struct fsl_ssi *ssi = dev_get_drvdata(dev);
@@ -1699,7 +1698,6 @@ static int fsl_ssi_resume(struct device *dev)
 
 	return regcache_sync(regs);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops fsl_ssi_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(fsl_ssi_suspend, fsl_ssi_resume)
-- 
2.28.0

