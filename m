Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBF2A7DA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgKEMAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKEMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:00:06 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE0C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:00:05 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id p15so1274094ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hD+jTA+3CFbm6Cc6YXWQOBtuekF/Hqs80WB365oy6RQ=;
        b=se/DLfBpwBk2kG2zcKQ1QbC/k7rlYtozlHPB89l89B0J9DJimFbaCvwAaqaqjuU1VS
         1z1yJM5RfY9UqOKj+y1YwINuAWbr66pWiPOTFbN5dK5K3cwnzj73z7jMz4Akxx8TTUNB
         mIXU07VN1CWxp0VJtD9+oH2qV7rskSX21CWBjOuHFMQ3x9zCzd1ROXjSTaCadav4J4j/
         4diuQfz0ntcAdVMQw+ZIa5s55VCU5PiCsLnTuErkY9GxmUBIwmeQsM5d7SruoK1oSf2V
         3OpI+j5s34L7QbupBHwew6QWVlszJBXpIlZKUaY9wf5jHiYzGfXZh9icMVFtWYUvMebp
         V5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hD+jTA+3CFbm6Cc6YXWQOBtuekF/Hqs80WB365oy6RQ=;
        b=BDM1T5kZwydedUjOy99OjXQUSBvSLXbM8hXs5K9tFk6H+yFjGaKEX14KuCWMTv3jor
         Jija239pGF4+YtPpZlDqCWobGHqHlbzcfpiEiAozBTQ0nKb3WkRDVtiDXNCx9u0gn+TK
         VGf31S6rUO9H4aE8TVCK2+mU8bG+WaFhAhxd3HN1dmiLNpwYld6YZkgVyUO+WZVKNyPm
         aUZO4+Dwuw9L/j3BPxYEDvvOEqH5DB1y+uDC4VADbQSC2gGDo9zf5ZwB7RrRp0aRRJRs
         QaDA7ufkZvnANQX/xluNK/aKNapie6rqZe0zJKfhHmtQByGE9auHHzWRdWfzXhf51x8f
         lFWg==
X-Gm-Message-State: AOAM530ouczFIjgD50k76hshgSVnufisQMljHFlmgFzMPssJm72/Jv6C
        a3N/5rSzzyMAS71SznHPYCWFBg==
X-Google-Smtp-Source: ABdhPJxeGuSBmYyt3qkq1O4rs5PG3FDY0/PQS6egAACC/rH4szeNgwoAH/lrBc6CgnyvcOW6aXZ/FQ==
X-Received: by 2002:a2e:854c:: with SMTP id u12mr709140ljj.297.1604577604283;
        Thu, 05 Nov 2020 04:00:04 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id s5sm161307lfd.58.2020.11.05.04.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 04:00:03 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] sound: soc: mediatek: mt8192: fix modpost ERROR
Date:   Thu,  5 Nov 2020 12:59:58 +0100
Message-Id: <20201105115958.1850123-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=m the following
error shows up:

ERROR: modpost: "mt8192_afe_gpio_request"
[sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.ko] undefined!
ERROR: modpost: "mt8192_afe_gpio_init"
[sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.ko] undefined!

Fix the link error by export the symbols mt8192_afe_gpio_init and
mt8192_afe_gpio_request.

Fixes: 18b13ff23fab ("ASoC: mediatek: mt8192: add machine driver with mt6359, rt1015 and rt5682")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c b/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c
index ea000888c9e8..0286c95ed2b8 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c
@@ -160,6 +160,7 @@ int mt8192_afe_gpio_init(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt8192_afe_gpio_init);
 
 static int mt8192_afe_gpio_adda_dl(struct device *dev, bool enable)
 {
@@ -304,3 +305,4 @@ int mt8192_afe_gpio_request(struct device *dev, bool enable,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt8192_afe_gpio_request);
-- 
2.28.0

