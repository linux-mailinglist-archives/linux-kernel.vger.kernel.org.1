Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0578629E4B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbgJ2HpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgJ2How (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:44:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B440C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x13so1635432pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4m44KFmOk0eNak9iaIXUK5dhQnw6EEz9bAOQ7LV+kgQ=;
        b=Z32XblI1UwfpGeY8IGKRoOCREAJBv4Wxmzx/PLQRnyG9iRBWogbO/1HMCzCTfeM0nn
         oOUKxXvcMs67QtS/qOVos3656g5Jru9a1AHxBB7pGVLZsWUcn/TZ0zZZ5Byco4SUgk0h
         vGFKD7MjWb3EH5ezFm9ywERMaTOFjjtZjCTN7NhYZE+RPKUCIMReGzXZZgNxr9CqBKMs
         WLBf3tg31g9bfiem+WrEr8Oy+AcIC95wj21pLn5u0J6QaPk92dPGhyS+JWobMgU7rCsS
         YN5VGPSvTqYgAvGoQZQgHylg7ECE9n9yJh3oNq4tF6RstGsRSVhUQn2FXlbQPw/lUoBk
         DIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4m44KFmOk0eNak9iaIXUK5dhQnw6EEz9bAOQ7LV+kgQ=;
        b=oA7I83oKRmaHVmr9tWeZzD1k+j7/FmK31UVb1Prch4DMuIgfmJKTunS7JSfJjsYch0
         LGm1KQzRXja6ZijxUuW6vq0RPMuoYcuHdvOLwIUweSNPNjOUBAzpl+9Ghmq5ZtUpmGxy
         y6N/jmi5FWiHZmEObMrdahPBXJR/UqpSUqR/PWqnM0TeryhPd2xM6bin8v7ZlmpWdi0i
         3oO8qv7xelR0wRg44sa/sX2wJgcGfQg806Ok9QfdHvZZZwauAkzcWErCi0q0akMZaJgI
         BQCiptJnp0ij6SjenHmsiI6LeHMLCOZGV+zzor+xumeQUrnruOrUAjFxtFne/w2q1bYE
         43Lw==
X-Gm-Message-State: AOAM532vGmOY8OWDe/UxykoI8R4cVfUAhBbHyb+7Unptpo9plhgGz01y
        9U7vwJJRCQY9VO9X4wvahPE=
X-Google-Smtp-Source: ABdhPJxUStiKBOq+y2Ae/MQ+HXEPed/8Ir9KaIDXM7129LlFpnxTXtwP3ZWBQNm6V8CiZ8tUgGLDjA==
X-Received: by 2002:a63:490e:: with SMTP id w14mr2951099pga.275.1603957492230;
        Thu, 29 Oct 2020 00:44:52 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id s11sm1960068pjm.4.2020.10.29.00.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:44:51 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org (moderated list:STM32 AUDIO (ASoC) DRIVERS),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 15/25] ASoC: stm32: sai: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:51 +0800
Message-Id: <20201029074301.226644-15-coiby.xu@gmail.com>
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
 sound/soc/stm/stm32_sai.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 058757c721f0..40c9e554a3d7 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -245,7 +245,6 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	return devm_of_platform_populate(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 /*
  * When pins are shared by two sai sub instances, pins have to be defined
  * in sai parent node. In this case, pins state is not managed by alsa fw.
@@ -280,7 +279,6 @@ static int stm32_sai_resume(struct device *dev)
 
 	return pinctrl_pm_select_default_state(dev);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops stm32_sai_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(stm32_sai_suspend, stm32_sai_resume)
-- 
2.28.0

