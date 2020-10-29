Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8706029E4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgJ2HuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731716AbgJ2Hni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:43:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D01C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f38so1663509pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8u+cDEJ8AUe2fZreqSM2kctIiSNg1XEO6m83AlYJL7M=;
        b=ImwowdAXgeuskRRBCZOSYoc+noyNDsE7KVpUYFOdB/iwsNWyxeSa3KG4jvkGkcrbqS
         W+5ku5C1hxDug2UmHCXShNUvqJ/yinRCbh5r65F52i/HjK5RvAreAYThIwDpqH+neJu6
         qpLFLZfK3jNXX1A1NMJVy/f0XZcdks4BvDt7R9vRukBulBng8L6ExJT3saGcHY6Uh3oI
         HsSCwfEifi9SFo2N69TZoYyk31UBMqzsA9PiDn7sKI9BluMdq8TdPurU6JyCVqJkM88+
         g8HT//uvrMOYWqSv9fuIwhlvIJnwGhv3zTAjrOu7hCBPbCDtn4SK9gK0vU41eeL5OsFN
         m8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8u+cDEJ8AUe2fZreqSM2kctIiSNg1XEO6m83AlYJL7M=;
        b=NylZr8VsMWuxG6znhyXPs0zeewxkK38hUsk50sQuoQGpQON3ET9sz08P8iFiq/SyjV
         Die24IIizcvl9VLT29tqGoh112BljvK0dODYBAXTV72RCu4mIng2YG8x0EkK3zt8UPfV
         J/Hwp4HUZZgAQSmTMoer0DXb/BoP7O28K4Hs4QcamGv/GO48Jy0c9VJyJ2vpXqfr0UT9
         BZeoGyTmvxgjt4Fd0mSAcV/TSH0uv4qrD7LRX62PpoTupt+yb4hScOYFbcveQzGWdTF1
         Be418wqgl18SUlIpSGp31u279N6o0jA1KXhegiEaIGrb3/qpitfw4u18RyI03xrfXgCH
         flvQ==
X-Gm-Message-State: AOAM530ZAuTZIEdtspBXbHkOSDC3NWxk/qsKdc/yER9GD3Z7poO0u+9m
        v1I4PFyf/rqYOt4Jc3pmVOo=
X-Google-Smtp-Source: ABdhPJw26LSjGJv0gkcHfnY3aVLwVaP63zCatI+cHlBpP4L5G2DQaRcfDxL/I3kfzEgHZfcdG92f0A==
X-Received: by 2002:a62:1c8f:0:b029:156:6ebd:3361 with SMTP id c137-20020a621c8f0000b02901566ebd3361mr3272158pfc.42.1603957417705;
        Thu, 29 Oct 2020 00:43:37 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id b142sm1872361pfb.186.2020.10.29.00.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:43:37 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org (moderated list:FREESCALE SOC SOUND DRIVERS),
        linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/25] ASoC: fsl: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:39 +0800
Message-Id: <20201029074301.226644-3-coiby.xu@gmail.com>
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
 sound/soc/fsl/imx-audmux.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 25c18b9e348f..6d77188a4eab 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -349,7 +349,6 @@ static int imx_audmux_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int imx_audmux_suspend(struct device *dev)
 {
 	int i;
@@ -377,7 +376,6 @@ static int imx_audmux_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops imx_audmux_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(imx_audmux_suspend, imx_audmux_resume)
-- 
2.28.0

