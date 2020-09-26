Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EE1279B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIZRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgIZRSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:18:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45F1C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 10:18:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so1560615wmh.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TWPF/+E31jT/SF9e9pWIeVEZ0ZzV1h+W9xrpsy2lYE8=;
        b=akFarIoKZv689do8big5BzIFfx9bb8mXj52ZZlFSMAIYjETXUfxzYf4HXB3HZ9KL12
         LTzQqJpLX7bNS2Sq/1P3YLaJZZ1u/lILiKdbW7hi9F0FTMN8vOaAGFHP9M1I0fr4twPp
         SyG6EjIQ51iuTKkTqAaIzClKVrDiSzBcjuhns8IPwpNAkLaYuCljrtb8o/yueaam5SPO
         1X7sW7057Rs+Bg5QYBXV21XB7AcTrXoPXTqW7t7jDaX/XHJKc1XLb4J2Llpg+78lzMqu
         TdDl+oPGSfRjRZ6Lmz3RZlun48Bi9bBvDpw3lPYJIS/t5sTc/Ud+TYrRW1GRSFup0T8t
         rtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TWPF/+E31jT/SF9e9pWIeVEZ0ZzV1h+W9xrpsy2lYE8=;
        b=K9uxAbW+GRRGcVO3a36ZcDPbX4s+GJtXNgJMwMaK0L+JFD8vBCx8KYuwacszaTUP8Y
         Zarj1v9f3CDgT0g3B/g38b9x7qvcJB3G7wUWmHB0q/DCQJCJ8YdkQk+HLLscU70aQ5RC
         7ThkQMkVo/+x2CnT0w1WX1Tv1mpjFKqWoHI/f2wXQjZYLSJXiN0jRWoGw69L2CAS0u1T
         fImp1SMvai/l4s9omzJvCFQgFgNyA5f2ssAiM3CqbAdJkZOojIQzXFnXJRC4jQtfH2wO
         xVh/DiJVlJb08ERitIlsjna56uIjAJ3RurcU7APCqJtH8xcpNuOhzmQZyHi+J3maVRo+
         jwVw==
X-Gm-Message-State: AOAM530MzH/exfWKc6P+LNPurASDzJFu0cZaVWxh7q9EdXT3uFoamBpC
        YczyZ+lvhcMoXEi/8R0muHJbpg==
X-Google-Smtp-Source: ABdhPJwZgoso8BLc4MzoELCecqgt5fmmxg2WHb+/fPwZgYYPKmer2gbdf2KDTq7B6JcOnIr1zR/PGQ==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr3320680wme.179.1601140733451;
        Sat, 26 Sep 2020 10:18:53 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id 70sm3368176wme.15.2020.09.26.10.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:18:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: q6afe-clocks: Fix typo in SPDX Licence
Date:   Sat, 26 Sep 2020 18:18:44 +0100
Message-Id: <20200926171844.7792-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like there was a major typo in SPDX Licence version,
Not sure how it was missed.
This patch is to fix it.

Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-clocks.c b/sound/soc/qcom/qdsp6/q6afe-clocks.c
index 25b409597d51..2efc2eaa0424 100644
--- a/sound/soc/qcom/qdsp6/q6afe-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6afe-clocks.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0
+// SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020, Linaro Limited
 
 #include <linux/err.h>
-- 
2.21.0

