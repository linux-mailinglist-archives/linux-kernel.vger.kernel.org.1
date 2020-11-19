Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF92B8A75
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 04:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgKSDlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 22:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKSDlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:41:22 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF7C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 19:41:22 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so4153291qkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 19:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UCTGtt+l2lmrlAsUlkjZzOKonkqwxx/4Smutp8nZw0=;
        b=R6+L1rYPzj0XjToNYfEyf+qnVRlLesTCejrvpsabpzRduFu34B8gDJ8kEbW1lJi2Rq
         AKukapca3tSWy1eAHxBbSztzVMuT+dW6YivMpRTn+AVZmLt/n0iiNY6g3r2tGGgDe/jw
         mp9ox1nkEroETCXZrlabKP0L+4SGjxOinZnBvVzRJnEaKcy5TETl0cxVD37H+xrPSDKQ
         Tt/yskp/7ROYyTTqWDsQieMjPUycaQ+rYXNkNwIHsk5c2jI7Q90IkEpOYFAxcoTJaSyt
         2blmtJ82ocx6/cMYVI8mOS2TBG4s/O4jp/QxKzbKRbZYgXKZ38A4TbAnHb5oaag7/TeK
         xBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UCTGtt+l2lmrlAsUlkjZzOKonkqwxx/4Smutp8nZw0=;
        b=Wv6kA4tL0//lfEqLl0DenwoCkIEl4KwWz11V7ZiohCqAUS9JbXOQWft5AN5Wx14Jqb
         SpcEggOvX5HJ6dzHk4sTPhirU9LQI0t42S10t9aN3XFsGRjfewjb4EMYHJsfN0Zqg98c
         J9peJTpK6vd+6XRWE3IcChmuQUb8Wk+klLZa2SxUB4bMomXcO4O0taRF7CRzVu8JgtA6
         ibu+S3HFsePd/S7+dSwehvropvAQm7csEpL6joOFRdEcrLg5SXo2SSKjKZB4p7SycwMg
         /JjoGz92gphBOnXN/JOoU1g5Cx2MqW7f4yFbIm8DUjneqoZwESzVMBjKqTrOe1f61bwF
         vL7A==
X-Gm-Message-State: AOAM531Gy1aTSMYgaj29R5W9YCA8Wy+J6hoyp/qRlotEY27Hk7nn+zWC
        ku8wvy1tL9LvgCXnyLqhptY=
X-Google-Smtp-Source: ABdhPJyUe0CbtxiicmCBRxdGXq3RoSyTYtrrDryq2yNPJPCjIo4oTU78Q1lySKnSzmhaHc4nlapvCA==
X-Received: by 2002:ae9:f507:: with SMTP id o7mr8769974qkg.420.1605757281743;
        Wed, 18 Nov 2020 19:41:21 -0800 (PST)
Received: from poirot.caas.local ([2605:a000:160c:8556:986:68fc:88ac:e7f2])
        by smtp.gmail.com with ESMTPSA id d12sm16800173qtp.77.2020.11.18.19.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 19:41:21 -0800 (PST)
From:   Kyle Russell <bkylerussell@gmail.com>
To:     broonie@kernel.org
Cc:     lkundrak@v3.sk, Kyle Russell <bkylerussell@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mmp-sspa: set phase two word length register
Date:   Wed, 18 Nov 2020 22:41:06 -0500
Message-Id: <20201119034106.1273906-1-bkylerussell@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hw params enables dual phase transmission, then the word length for
the second phase should be set to match the sample format instead of
remaining at the reset default.  This matches the configuration already
being done for the first phase.

This driver already sets the phase two sample size, so this should complete
the phase two configuration.

Signed-off-by: Kyle Russell <bkylerussell@gmail.com>
---
 sound/soc/pxa/mmp-sspa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 52d4d8ace1c3..4803972ee655 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -246,6 +246,9 @@ static int mmp_sspa_hw_params(struct snd_pcm_substream *substream,
 	sspa_ctrl &= ~SSPA_CTL_XWDLEN1_MASK;
 	sspa_ctrl |= SSPA_CTL_XWDLEN1(bitval);
 
+	sspa_ctrl &= ~SSPA_CTL_XWDLEN2_MASK;
+	sspa_ctrl |= SSPA_CTL_XWDLEN2(bitval);
+
 	sspa_ctrl &= ~SSPA_CTL_XSSZ1_MASK;
 	sspa_ctrl |= SSPA_CTL_XSSZ1(bitval);
 
-- 
2.25.1

