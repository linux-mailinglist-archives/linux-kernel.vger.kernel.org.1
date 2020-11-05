Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886182A7EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgKEMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbgKEMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:50:02 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE87C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:50:01 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x7so1632964wrl.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+C+hFQf4fR17sqAg53ZRGOMsBqw3qEsg3zbacKAW2d8=;
        b=f8u26zDOnu1BHe89VUV3H5l7cWUXq3IOJJDl3y9WOFjOWmn9enFSVWlENWcnFAVlyf
         FWW36yGMR49eouTFeMSwwlCN0RzZUoO7J+ZmVG5zfNzP7UJ0IyjS9lEF0PxD8Mg7U8yb
         3TuvgD62sf0Q6+wkpvAPJ7QiZ1jKRwJceI6KW7o9o3iGSISI0HrZi719NZTNn9YaEPBq
         n0q5VzdIkgpGpMmdadSqhXACzqhgQ0hdCvY/ifc3feBtkPGkTxhOZOjjnIsyZGaPmsXr
         pnj/+6oNEMgEaNaZkEEXX5paKK17nM+/J2NZl5aWlAeBCzybf4uFAQhOQuyB+5HfSeO3
         gv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+C+hFQf4fR17sqAg53ZRGOMsBqw3qEsg3zbacKAW2d8=;
        b=L5WKp6wRfOWKDBJmkrBdahLGCFjwDpLzZ9bmrsRXrejeFRB3m/d7fTVuup0lFvEFgL
         AA/zdfyYbUvETpTTX63z4MwZ614dXfpNjnHa7K8UxzdJL/zLBZefHCKNynK6pG0TXOqN
         K6mQs1LeGegwpPYJQKkMx17XXACXkbu0zwMZdPmI0pSmGQnGfJMJE6RTYmlSN/elALxA
         YJxGxMX1CPp0KqvMJzwfEu3S/plU9TWDvUgA/9IvyDLbD8u78VZZDJDajZQAjVrb/g8C
         S58Pv5WC4I1Y5uuthfBikPf+28lEKsMD2CCW8TOBnkfd7tWDG4b2bcp51ZcnSgpF2VQe
         dEow==
X-Gm-Message-State: AOAM533bAFfXf1qrMQSQQSOAaqoj0ltwKijHvtYk8pJnBln3Zv2MSFzr
        vnae1CQvnDVDwo1YTu7xVNY=
X-Google-Smtp-Source: ABdhPJy/qX5s2E/jLJsvII8+siT5LuOIrYywzGOEyLvMOrkQ6pRobv0L+e6n83dwD/3JM2IetjjaRA==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr2744512wrv.36.1604580600491;
        Thu, 05 Nov 2020 04:50:00 -0800 (PST)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id n17sm2188378wrw.69.2020.11.05.04.49.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 04:50:00 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: mediatek: mt8192: Fix build failure
Date:   Thu,  5 Nov 2020 12:47:47 +0000
Message-Id: <20201105124747.18383-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A build of arm64 allmodconfig with next-20201105 fails with the error:
ERROR: modpost: "mt8192_afe_gpio_request" undefined!
ERROR: modpost: "mt8192_afe_gpio_init" undefined!

Export the symbols so that mt8192-mt6359-rt1015-rt5682.ko finds it.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

build log at: https://travis-ci.com/github/sudipm-mukherjee/linux-test/jobs/428486008

 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c b/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c
index ea000888c9e8..fbbe9ed9adb3 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-gpio.c
@@ -160,6 +160,7 @@ int mt8192_afe_gpio_init(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL(mt8192_afe_gpio_init);
 
 static int mt8192_afe_gpio_adda_dl(struct device *dev, bool enable)
 {
@@ -304,3 +305,4 @@ int mt8192_afe_gpio_request(struct device *dev, bool enable,
 
 	return 0;
 }
+EXPORT_SYMBOL(mt8192_afe_gpio_request);
-- 
2.11.0

