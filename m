Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC7329E501
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgJ2Hul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgJ2HnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:43:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59094C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s22so1639055pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ByQRRqSOS0s9pNTpOtt//gM7iDqhPG0HzrMizgfaGV0=;
        b=R6KbsFBJ7AGf6UFZEd4Vf7yH5UZW8brSqoW1Xe9CLwUdFHKUtWJjt6NIgy3eCUmeOG
         QtRfCio4ewGz+maSTsyOVbge3tdNBLrvpAggSW3CfBow/g0deLUu2vM89stbtfPSHIq9
         mXfUNwhYDV9lRsqNqW/MfQlVff57B/xlD456fkNR8qUz8K58XsUMehnKLBtpvTwax9xP
         q359Uacwp5fwdN0AUQCuypMoNlt5yshUotW3KYlqjZbTuWCV6n8uwQeRt1fPs1W5kvWS
         XeKh+h5vPaxqEBiP3FPm8USLMG6P4tDiykdk1HUiLuMWm6d8BV5kiVP9AwOA7A/WlWLx
         8ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ByQRRqSOS0s9pNTpOtt//gM7iDqhPG0HzrMizgfaGV0=;
        b=o+SEIm69PKP0qlIa7acosYzbqBI4xJWDZKZ9k944Crfi6zRN5Uq8CS8glKCUM+djc4
         lQjSZ33MRWu8E87LAqnabJpdstmprnl2jH9lfEms17oEjZW6ad7lBEHAloVM/l77Tjev
         SFIYrkStMVXw3tCB2LwYPTHpK2BlCFGl+KFPnms2OQJvdOEgpGtwys9cUSYAnZDads+4
         7wjw203y3MC6Nr6zMP4HjfhUhAxwTInJEbduGP9jj8TFVYbY7ojLuoWoDwm5i0Z6THoj
         +QlNVfFzGWkFopjL98BRZcl1toQcYhqYwrZ4qXFYl5ncoZeKYzMw9tiRqKPClVOfq/EO
         i52Q==
X-Gm-Message-State: AOAM531r3mr39xhW82wZ3YSJrIQG/tS1ZURdx7aEC7C1Qhy1YjoRpauO
        TV3h17Bl/ff5Dg38NBDrOKY=
X-Google-Smtp-Source: ABdhPJzqW9+vkDhQYC2zinHRRJ2vcxLo2Fsw8j+CEUVBMEU9yIiZZoEMGG/itZzsejxJ4or4GBJz0Q==
X-Received: by 2002:a63:7e4f:: with SMTP id o15mr2971078pgn.428.1603957401923;
        Thu, 29 Oct 2020 00:43:21 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id g7sm1707066pjl.11.2020.10.29.00.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:43:21 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/25] ALSA: core: pcm: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:37 +0800
Message-Id: <20201029074301.226644-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 sound/core/pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index be5714f1bb58..5a281ac92958 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -599,7 +599,6 @@ static const struct attribute_group *pcm_dev_attr_groups[];
  * PM callbacks: we need to deal only with suspend here, as the resume is
  * triggered either from user-space or the driver's resume callback
  */
-#ifdef CONFIG_PM_SLEEP
 static int do_pcm_suspend(struct device *dev)
 {
 	struct snd_pcm_str *pstr = container_of(dev, struct snd_pcm_str, dev);
@@ -608,7 +607,6 @@ static int do_pcm_suspend(struct device *dev)
 		snd_pcm_suspend_all(pstr->pcm);
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops pcm_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(do_pcm_suspend, NULL)
-- 
2.28.0

