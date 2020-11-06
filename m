Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456B42A97FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgKFO7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgKFO73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:59:29 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89C1C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 06:59:27 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id d1so549636qvl.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRkSU/5vHT/IEZQvr5gZLhftMTatdc/swDYJz0CwbE8=;
        b=jQZsJJ9xSf5mSgSPrA0f8RWdADoPxIUsWhWrYCCtBoek351fk2mZgm1tZyj+d2AyF1
         JW2bvSMlpTjbbsCL/R53eg77FnIBfYQJubAId5NIq1FVtIQfDCmGzpvzcxRhdtwn0lUa
         kWyhFEr8le9Cy3coZMOQpWbBzYn6p9zRejmVpz6+oPSoub4GhONJS5LdEHjpwxFv1vdM
         Ww/1oA+ImlaLkp69LonTbFCwm1FKGshzXQ4v3ARRja36FN/lWO8iryweHiQsXIGrcRmh
         lknPDJYsqRfNx2KqLheKY8Y71w9wJNdQQ7b7I2A/Vi9nc0rNWT4UybKlooi1Z/2mc07k
         dWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRkSU/5vHT/IEZQvr5gZLhftMTatdc/swDYJz0CwbE8=;
        b=pSXW6wfOyeZt89ApoNxe+C140ys6oRAgspJ/e7L6UA43DWZcukUaEQ4sE36e3zyAHa
         uTu2ORDB1IqWIYDfOni84YDdRYw2vWWtyz2r4tmzMeVoSEnkz7OCG5dkmGICRRvM/C3R
         3flVlXvKCoB1LB1CMl0oLg+GNqSrHEZzI8zsIBG3PzjIoKpiip/svFxzWU//cG5PhfmS
         jZIsEbPQFzAGNImQXBG8sYsIL+ywtz1VMGW0KgrUDxe9kZghsGB91i8tNVss+IVfpaXZ
         edpYdKvF0MmCTM1nYEeEUQEKTFtT6PTisOhT7AWmuNXvuqAMC90sTWoCrwPkEH23OC44
         LddA==
X-Gm-Message-State: AOAM533mu5c3ePivsQxM+Tyw/iT5ApwKxa4RP+mmxABD8zfuRbMIoRaG
        +V5racvg2nZRWCS64XD5NaA=
X-Google-Smtp-Source: ABdhPJx3nmPKPdNUBaeU5q/r/ErzLGZ5/SkaV/YV/a/Qh0Ga7Xxlzf+SPCb93T7MX+NuDmzxPs1AYQ==
X-Received: by 2002:a05:6214:841:: with SMTP id dg1mr2016186qvb.18.1604674766923;
        Fri, 06 Nov 2020 06:59:26 -0800 (PST)
Received: from poirot.caas.local ([2605:a000:160c:8556:38d4:503f:b7a:d871])
        by smtp.gmail.com with ESMTPSA id m15sm662872qtc.90.2020.11.06.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 06:59:26 -0800 (PST)
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
Subject: [PATCH] ASoC: mmp-sspa: clear transmit phase bit for non-stereo formats
Date:   Fri,  6 Nov 2020 09:59:05 -0500
Message-Id: <20201106145905.365903-1-bkylerussell@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The transmit phase register value is never cleared during hw params.
So once hw params sets this bit to handle a two channel format, it
remains configured for dual-phase, which is not desirable for mono
playback.

Signed-off-by: Kyle Russell <bkylerussell@gmail.com>
---
 sound/soc/pxa/mmp-sspa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 4255851c71c1..52d4d8ace1c3 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -239,6 +239,7 @@ static int mmp_sspa_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	sspa_ctrl &= ~SSPA_CTL_XPH;
 	if (dev->of_node || params_channels(params) == 2)
 		sspa_ctrl |= SSPA_CTL_XPH;
 
-- 
2.25.1

