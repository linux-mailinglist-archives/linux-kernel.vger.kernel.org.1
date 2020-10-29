Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24DE29E4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbgJ2HqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbgJ2Hpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:45:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6315CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:45:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b12so909756plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Srt9Zr3sbLPIZI2HZoMYv5lnjbmkxnLms7pVPF5Blnw=;
        b=Zvww3hgNnlo7R8RXwg3FMc6GgW//WUoWYaeeb+tehUfljZXqY13AQsHzLcoEbLdYZA
         kg5DXmd3ZuwmTcwsZiw8aqCFCvbfqN9xIw2VMXx0bbY4xlbNEEwJXE2K8Eqq4hEMqxLw
         6nSTktTnvIh8FvzhCAaOPwR/KpXgXRgS6XRqUvoRSaB9/EO3B4GNOSPMBpzpnJpWMNuY
         hUBdxcl86x0a2vzgffUal9Aht4eFqe69Zmotg9OHgBvs2/G1KuA61XJ5g2khkHb5SAGv
         KQpun9GiE7hZSIc3hFygJFY2BW5yEyLacpcJat7zdpad1+0z69MFlryNwKPz74H2Lzlx
         qcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Srt9Zr3sbLPIZI2HZoMYv5lnjbmkxnLms7pVPF5Blnw=;
        b=W1fqDeeUBg1a+grXDwF0TefrO4UaK9cCagL6d8NKbRdyjBIgOkrXxG+Fes+g14TBuF
         pkrjUs2ffIX6BxtepMtaFaYflHa9OZt6tikMIcODli/HFrQehCbRUNBsgZnbNxmVnmSY
         IcRjFZFIaSd+ooipKEuIib1L0HOKyU0G1l9KtzGGL6AZlZL11PI2Xcy7S7VPEQDcP0Mh
         rnFqiSsoEQmcLoSaskecZCHxRJ98KhE9L29/E3cWO9KJ6Vl7b0elSF1H4IX2kUjewIsE
         92Ce7mBgcKYbGpSDw+U21TCItAUXJQWT+2YFHILCr07iR/O10ccrZsY00z0tuZalLr9s
         Qckg==
X-Gm-Message-State: AOAM5315qtjdg31x3rpsFJXwNVC67ZgNt2o7euldTBxJjUHA9qD2zOba
        M2iHhkhkQno8zZ6xjcKlxFw=
X-Google-Smtp-Source: ABdhPJy/XS1AXFlInVXO533UQqzhqOpm34bFyUnt7mcdz6zM+v9F9snWZUyres15CNwXot89r2kIAA==
X-Received: by 2002:a17:902:c113:b029:d6:944e:fdb3 with SMTP id 19-20020a170902c113b02900d6944efdb3mr12157pli.4.1603957555029;
        Thu, 29 Oct 2020 00:45:55 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id n7sm1599220pgk.70.2020.10.29.00.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:45:54 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Barry Song <baohua@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/CSR SIRFPRIMA2
        MACHINE SUPPORT), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 19/25] ASoC: sirf-audio: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:55 +0800
Message-Id: <20201029074301.226644-19-coiby.xu@gmail.com>
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
 sound/soc/codecs/sirf-audio-codec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index a061d78473ac..b6a101ec6e7c 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -522,7 +522,6 @@ static int sirf_audio_codec_driver_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sirf_audio_codec_suspend(struct device *dev)
 {
 	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
@@ -552,7 +551,6 @@ static int sirf_audio_codec_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sirf_audio_codec_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sirf_audio_codec_suspend, sirf_audio_codec_resume)
-- 
2.28.0

