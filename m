Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8580229E4E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbgJ2HtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731843AbgJ2Hnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:43:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C57C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:55 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j18so1665475pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jaZN7uq6O01jrWfQxHpgtRmb0Gb7gUhtZJtDfvvhJ7c=;
        b=PGf6dq+p2oOvbusQem443qtzdvhBWli1vPwCNwRQauHczKlGVDO8iheu7TDaCQOMUT
         ZSD28bFk+QbEOsrpRnYyrCcQ3xFlildoAUpDn0NfLGsQ+hYBm5hqTo1axD3uZFr9ds8Y
         55S+ImBATyrOHYV3tVVpr57zs7U0d1xDpEO+KqJjC5OgWoC1tAiFkUc/2M98wf5pX6Ol
         MJY3swSjgBnJ9/kr7p3mM4LAKu7IBAzIxnODqJxoArtQgnQcAJ+xff36LWOtdRYHw9ag
         SDWCvPtBP6EsmHRTlt3lyFbntprdnyTgseIv2VLT3OEe27gN+eQaSBtc2KAQdRG8VCuz
         524A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jaZN7uq6O01jrWfQxHpgtRmb0Gb7gUhtZJtDfvvhJ7c=;
        b=tUl+CniYlPUPHXD3mbSF72QF+BAOsIef4Pzs8kZhqPR6cbBNpHs6+FEay584xn3aM4
         2QEuwSoXblSWaWKXsiIVSNT9wkqonmsAIBm1m65osJJ8cOTnhD45dCuo6sFt8XruzXSR
         lDFll39YPA2sd1oa+W6QQBjI1Q5yqHIkffdoQsEdrHOxGsIDl8OnuP+bzrXY1+1cIXEJ
         WNqJxk5c6O7+svks+a7vP5SiFfq/v6hoI9jyU4bqchcm9R/GVOryaZnXayvzYFc4c+ld
         d7gG5xkl60qS63ogpl7WOJqx4Wc2FzzITRWVEl/95Om9C+sFg4DNb+hRVODCRuwJ+3KU
         baww==
X-Gm-Message-State: AOAM533eUPq7aMRWmYgsoTrKda7v2uZFMeF/Co9X/I2unqiRXfeVfMEo
        wsrc7CThywRcj8qaxD7ZPIQ=
X-Google-Smtp-Source: ABdhPJxZrPCuwMP0s8yJdpRCq4IbmG/ZNBJz/5uBLQ30gGijnR/FLOYvomcsc4KxDgTZMtldI8oUtg==
X-Received: by 2002:a17:90b:17c3:: with SMTP id me3mr2702800pjb.56.1603957435363;
        Thu, 29 Oct 2020 00:43:55 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id a4sm1865321pfa.65.2020.10.29.00.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:43:55 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/25] ASoC: img-spdif-in: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:42 +0800
Message-Id: <20201029074301.226644-6-coiby.xu@gmail.com>
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
 sound/soc/img/img-spdif-in.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/img/img-spdif-in.c b/sound/soc/img/img-spdif-in.c
index 46ff8a3621d5..bb73b7fc35da 100644
--- a/sound/soc/img/img-spdif-in.c
+++ b/sound/soc/img/img-spdif-in.c
@@ -823,7 +823,6 @@ static int img_spdif_in_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int img_spdif_in_suspend(struct device *dev)
 {
 	struct img_spdif_in *spdif = dev_get_drvdata(dev);
@@ -863,7 +862,6 @@ static int img_spdif_in_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct of_device_id img_spdif_in_of_match[] = {
 	{ .compatible = "img,spdif-in" },
-- 
2.28.0

