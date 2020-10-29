Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871A029E4AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgJ2Hoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgJ2HoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:44:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5EFC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o7so1656854pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVqH6ZdDZsxjhz6ACxTIa4F9n2pNeqLVCfy2un8GTaA=;
        b=TkJ1akdfIG0oF27sYc+gc8WT0yjtsPijZW5V4jOCBNoMk3VeHalSL2CyeLWeT2FEL8
         I6Q1Cj2eSEz4INHzkIZuePaC7S86drVW9TDaVxNS2PWkqc5eckuuAWzdTxpSp3yzfV6i
         5nbuNAJQB5dSfCGWywWkWo+j36Mvdt1UpiDiLfGFEOCcX0PMKUBpngEqIKDSP06MtHQi
         1FPCuRdZjfcV8VHzvRerkB6Kqq2D91okuEuDNWXX8nmXfVCMULqI6HcDujDqOqVEteqE
         Cov05UKf9ZngGAHfEGIljZ/T0AQcjjlzfX0zQwW1mv9SL5fcEx63QNS2Q0++I6J7gYVc
         VtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVqH6ZdDZsxjhz6ACxTIa4F9n2pNeqLVCfy2un8GTaA=;
        b=Qe0jyKthJU/9tZP2K6BRDmdVlwPOV0ZBaG9iBduybSoxgknAmbdEljE5pf9vg7WbvN
         HNyB8nNKs6S0uJVXZpjtKKa5DI3pquE6zXUukyWSI8zUH9r42KRERS7Gko5YKqg47dfN
         i+C9JxjjkLn31oMtbQ4Pnvm4XlJucHTGsPms2wCkrV4ZnF1b+TPcFJHL/CyI/wS4ftBC
         51ieH1hln+bX6bgVGCch/QxiD++JalQ6JVxw9XAdZQs/28zHCzpoWrnxfPQxQDHvkFz8
         zNvJ/szvqSyQNo0lLjI9sPB8VO/QNZFFtW9Xx5KH1zxNvL/UYc/UYfpqT/i4hGb1TDNH
         WfMQ==
X-Gm-Message-State: AOAM532chqZBc9iGh83tY4MqZjIDdrOoop2O4wEg0IHTnNjWGFFJOkXI
        Zn9Z3Q7XnkZYZEgCHBmyfMg=
X-Google-Smtp-Source: ABdhPJzXC8sP+c39Xx1NVeZuvBhUppi3iLLlmqr3BQXMvhyTNMf7wD/5G8LbipRnbyxWoNz0D3NnRQ==
X-Received: by 2002:a17:90a:784b:: with SMTP id y11mr2950425pjl.165.1603957464479;
        Thu, 29 Oct 2020 00:44:24 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id o4sm1855935pjj.38.2020.10.29.00.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:44:24 -0700 (PDT)
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
Subject: [PATCH 12/25] ASoC: stm32: sai: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:48 +0800
Message-Id: <20201029074301.226644-12-coiby.xu@gmail.com>
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
 sound/soc/stm/stm32_sai_sub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 3aa1cf262402..38dd7e30af1b 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1582,7 +1582,6 @@ static int stm32_sai_sub_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stm32_sai_sub_suspend(struct device *dev)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(dev);
@@ -1616,7 +1615,6 @@ static int stm32_sai_sub_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops stm32_sai_sub_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(stm32_sai_sub_suspend, stm32_sai_sub_resume)
-- 
2.28.0

