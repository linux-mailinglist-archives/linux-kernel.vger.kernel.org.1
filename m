Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3E92169D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 12:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGGKRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 06:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgGGKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67292C08C5DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so33431975wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j306gyjagAnal9NO9hxv+ks7W0GYhjttqc5twDw7Zos=;
        b=TiDsFIcm82IMvKsBQX6/HNIU30n+rKxa8eOMBrBbtxHEawE+hUYaWGDqNZoQzgpzb4
         wpE/sDK5PJm5+ErIRCpPTGSUTLT2mQ4GwVCK9zcD8joRnlHa/IE4X6h8QBtW5pgd3UOg
         2JBLfOVGlUI+hRpujRyLnkTE2sf9blsqOfFszV7jUptZQ9MVIcjeN+ARhm+N6nVTdjrv
         5xPaYCX979M0/5uJ3eAAy0fUcI3h2hXJxoeADLr1m0Ju4iJ9a//jAnT8D9VglIw9PoGn
         5ti+fmywLzKuP10a61cwSFPawXqydZJ/TEqUsZT3Ruw+bpOLVIRvfRrdqIg5PO9hU9hN
         hwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j306gyjagAnal9NO9hxv+ks7W0GYhjttqc5twDw7Zos=;
        b=DKrlVUHdFM/now1Z/AVyRuD8N4gzZlycvDzB12nkhxRoR24Jm1iExgxrUMd4SiwpPX
         L1kP5fTMnbZNTBUCFAIVxRGdMYYcNMdP/sr6X5IV5X3lC5fHL8icHXwYsa62bnaQFYjq
         1HJWKGV69TCG6CGQpNa1rRWXmTwxz+KQkv/HJf01zcB2IjOQTcxjpqWt1YyoLRRT8ftE
         OnDzoYOhZ3g8AUhwC5ataLKbp+dN4FR39rHUQw/vyvxFKanWAobZ+/4vaaxLwgaXjaUG
         DLNOWvFJv560ScWM1xzXKTMEYDNyTWtHo/Zse6gWQTwk5nVOxDGEpWj8CmrcQc0zHCEX
         zdow==
X-Gm-Message-State: AOAM530F6fQ7RE2TNQwjlOOnmuVNzLta9YQkZBBhvn/tIyUHHPuNJXdl
        YBNfsMh4MbdcBnphHMcqpU/wqQ==
X-Google-Smtp-Source: ABdhPJw5fQ+cD4J6acJX9hjTuDH1yBuLxCoSudpJcORTNYjASKSRDv3BMPijf/xqeQ+Ze5JdnB5tow==
X-Received: by 2002:a7b:c4d7:: with SMTP id g23mr3603144wmk.17.1594117022067;
        Tue, 07 Jul 2020 03:17:02 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 11/28] ASoC: pxa: pxa-ssp: Demote seemingly unintentional kerneldoc header
Date:   Tue,  7 Jul 2020 11:16:25 +0100
Message-Id: <20200707101642.1747944-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the sourcefile and full
descriptions are not provided.

Fixes the following W=1 kernel build warning(s):

 sound/soc/pxa/pxa-ssp.c:186: warning: Function parameter or member 'ssp' not described in 'pxa_ssp_set_scr'

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/pxa/pxa-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 6a72cc1665b7c..d1e09ade0190d 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -178,7 +178,7 @@ static int pxa_ssp_resume(struct snd_soc_component *component)
 #define pxa_ssp_resume	NULL
 #endif
 
-/**
+/*
  * ssp_set_clkdiv - set SSP clock divider
  * @div: serial clock rate divider
  */
-- 
2.25.1

