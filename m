Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8D296C69
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461815AbgJWJ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461719AbgJWJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:58:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D7FC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:58:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so842522wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxohQKBvb3GUQ4FxSbykrXuPjhnG3MBUNJ9DSLhuLjw=;
        b=UxLyK6oKIRTBIldHNdeAS+DKqkLJXJ3VEQxW/9LJmMlH9O/NM+t8YW7sGMEqoKXhfr
         9c4BIVumnwdgGcX5HUC4PyPSWB2kKvUJ1x2RJFn5TArCC7SuYveLGqvEa2fespacREsX
         o3oEFQLJsunVyK75MYb+HM3UOF3T2vsnl9LP0fnVbGHibu/Ah70kvuojNG6clLklYPKI
         wNt7qHboBGglZ1gelM5GY7cT8Pk0nzZAxzy5qBJB2xDxhjB94inFuXOYmwUiEAgtctHc
         dYvKlNPCcEPV4aWGkJks1jGwowF/nHxY7MBZujEjsotFkbFLSjF93ms8uUxVVzvCBnU1
         tHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxohQKBvb3GUQ4FxSbykrXuPjhnG3MBUNJ9DSLhuLjw=;
        b=uZyC8MNuhrgvdmzLILzxbK5gErGFswUHQAdPs/Jdo/IcH7tH7PaV/GmKCgVyBkBwY0
         WrMHEzfMD6V3YWJWNsq0ZrBjUiAECxtaufzlZSOiI2m/yeIOJ7w6A6X0HyxTadEUmKho
         colAHaWLOET42fHvHLm6Iy28kmGuyVq3qZF3BRM+LeYC8QW4Iq667E75Ls88cWxCTkkw
         mzcypYrX+BA+Ojueuv8Iyzx+twUGB7Fyu+biugIZTJpt0T4xVquBczROklm47OZBssDH
         M9qnG/aemp1DmBGCM3e3lBGJtaLgVjUIBAW9Fw3gV63o3EkOYe29FUqMP4wVkbQEKtUx
         NILA==
X-Gm-Message-State: AOAM531SRhuksZ/Q21mjVdzJzc7L3g6jp5CJSTrqy4KHoj1zIMaIZKVT
        w58dj3Qe6tXHxcB2U6Odtd1ezQ==
X-Google-Smtp-Source: ABdhPJzqTNcUTOqYP502Jyth4LVEL5M3woMGdz0XtNLqm5lVr0ZAxKrhneb3fmBu0eHp6jHsRQ9B2Q==
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr1482900wmj.88.1603447132098;
        Fri, 23 Oct 2020 02:58:52 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id f139sm2311579wme.47.2020.10.23.02.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:58:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: sdm845: set driver name correctly
Date:   Fri, 23 Oct 2020 10:58:49 +0100
Message-Id: <20201023095849.22894-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the current state of code, we would endup with something like
below in /proc/asound/cards for 2 machines based on this driver.

Machine 1:
 0 [DB845c            ]: DB845c - DB845c
                       DB845c
Machine 2:
 0 [LenovoYOGAC6301]: Lenovo-YOGA-C63 - Lenovo-YOGA-C630-13Q50
                     LENOVO-81JL-LenovoYOGAC630_13Q50-LNVNB161216

This is not very UCM friendly both w.r.t to common up configs and
card identification, and UCM2 became totally not usefull with just
one ucm sdm845.conf for two machines which have different setups
w.r.t HDMI and other dais.

Reasons for such thing is partly because Qualcomm machine drivers never
cared to set driver_name.

This patch sets up driver name for the this driver to sort out the
UCM integration issues!

after this patch contents of /proc/asound/cards:

Machine 1:
 0 [DB845c         ]: sdm845 - DB845c
                      DB845c
Machine 2:
 0 [LenovoYOGAC6301]: sdm845 - Lenovo-YOGA-C630-13Q50
                     LENOVO-81JL-LenovoYOGAC630_13Q50-LNVNB161216

with this its possible to align with what UCM2 expects and we can have
sdm845/DB845.conf
sdm845/LENOVO-81JL-LenovoYOGAC630_13Q50-LNVNB161216.conf
... for board variants. This should scale much better!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
I will post the ucm changes once this patch is merged!

 sound/soc/qcom/sdm845.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index ab1bf23c21a6..6c2760e27ea6 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -17,6 +17,7 @@
 #include "qdsp6/q6afe.h"
 #include "../codecs/rt5663.h"
 
+#define DRIVER_NAME	"sdm845"
 #define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
 #define TDM_BCLK_RATE		6144000
@@ -552,6 +553,7 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	card->driver_name = DRIVER_NAME;
 	card->dapm_widgets = sdm845_snd_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(sdm845_snd_widgets);
 	card->dev = dev;
-- 
2.21.0

