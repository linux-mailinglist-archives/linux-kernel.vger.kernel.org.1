Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB029E4AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgJ2Hox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgJ2Hob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:44:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F30C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t22so890388plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8jpXiCRDdVAzZIis20MTViXOEmD/OZxxv4T9W35au2I=;
        b=WGv43752G20ZWCFW2dJnU7OTDDBqJHnRjacRItawB/45pQd8bZo/Jo94pL+f8Saczs
         snbxfZ5ieEjYPt7HQFA8U95p6BXyibnyHeGLF60W19Wy0K0LWCIRD5IbNyGhMrY0Wn4q
         +KBqJyu9JK0mr/RAOQJPOadPRbaz6TUL1bWqRYqGlplmQARzkl+X99F3zKItG9seZeyh
         0+JVpIl/+R+1SL+5v8GF01kxDp2UbJ+XpTmn6KVxc2XdzQPrIAi2vuIRHzGLMI51aLRh
         zBKU1vv/6fkJlRD87TIrBnW0fze3JjdKzvf4nkDTUl6ZN3OmGovDgDAAdQDk+dj2j8FK
         vtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jpXiCRDdVAzZIis20MTViXOEmD/OZxxv4T9W35au2I=;
        b=uLmYaD6OjTNoiJFy7IeUK5olnHggEbRlg9/KARMMQ5YzMhcbGYln4F2jDpDEaPVZes
         546GW6xOsoUcdxFJ7L4VBPj85GIFwm61ru+68I2AHU3LMZYSRz/SvMDX3YU4ErfEF2te
         UvbliOu/OezEokB1BWMDEJ0CWGSsUnRezlx3lfR1O/H2ACvqaYIunwk3YOo3aAwrlhY0
         sBECo4Fefv29b4t+o80SJRocuNEeVXgEIev7jM5RjnarKZ15edtivyqik+SRc1IosUx6
         hOAac+frQ88ET0HfMGFoOMKAnfEeX6gg0TGWr0T08TRRnJaOmcMwyPfGcVHGTagAbdSn
         5XnQ==
X-Gm-Message-State: AOAM530Zabkw/pKeyW87syaQwkFk5p8pmI0QfTTJG/Xtr/acDpGuloe4
        4D7csnWCRXN8/q5zvensB7I=
X-Google-Smtp-Source: ABdhPJy6bo/OOxq28BpnumOynqNEHVJ3pfP9rwwlCtI4HJlzGRADoHpABRPlFl/v/E/8HksFmQHsxA==
X-Received: by 2002:a17:902:fe07:b029:d6:88c5:f5d5 with SMTP id g7-20020a170902fe07b02900d688c5f5d5mr2125554plj.63.1603957470376;
        Thu, 29 Oct 2020 00:44:30 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id n18sm1800059pff.129.2020.10.29.00.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:44:30 -0700 (PDT)
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
Subject: [PATCH 13/25] ASoC: stm32: spdifrx: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:49 +0800
Message-Id: <20201029074301.226644-13-coiby.xu@gmail.com>
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
 sound/soc/stm/stm32_spdifrx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 1bfa3b2ba974..40262ff0c588 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -1056,7 +1056,6 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, stm32_spdifrx_ids);
 
-#ifdef CONFIG_PM_SLEEP
 static int stm32_spdifrx_suspend(struct device *dev)
 {
 	struct stm32_spdifrx_data *spdifrx = dev_get_drvdata(dev);
@@ -1075,7 +1074,6 @@ static int stm32_spdifrx_resume(struct device *dev)
 
 	return regcache_sync(spdifrx->regmap);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops stm32_spdifrx_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(stm32_spdifrx_suspend, stm32_spdifrx_resume)
-- 
2.28.0

