Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED642B1DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKMOv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:51:25 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB6C0613D1;
        Fri, 13 Nov 2020 06:51:25 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f38so7264491pgm.2;
        Fri, 13 Nov 2020 06:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FeQh4FdOZwVhx4i39hlguo34HgLhuLiBD0/DOQQq4rI=;
        b=R3fMTtxIF543Ih5YOs+n3v5kt1uVu6ewdLPwgczWBuGSJfOhwmfZiQfCHlaz2+OeQE
         nnYOwy71jqOodTVzkTszDyxcCDm5i4Bryf++//u2YyXwtjw6jBCD39PayLkmI4aihFrk
         3xNkhZqdUVSms+ssnsGbgfPF12JbAsrvYs0MjEqwYSN8IOZFGfXl20ibyHdpeQhwiUNd
         cGJWBv+Gr6q0I5ynGKbMeIs9iBLkE4kxH0S7B6z6wjsPmwjrYuTyqNA0QzrUNo1hNgsM
         9BEwlZ7tRTz6n2ML4TMokaV9hyc5BzLch7SVYXvend25kRyA3kE5w0qKux0lxXzCEGme
         sHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FeQh4FdOZwVhx4i39hlguo34HgLhuLiBD0/DOQQq4rI=;
        b=q6d9Vo9N4jE0EjQpbKWwXrg+87+f7U/o+qA/hJNHbLlrYPgNp63AT51go3HI/bL47q
         Lv0JE795SYJu/KPcC7zEJmNOhsKkLMVWB4Dtepbcq0KgJR3U82FXDS9Wn3GsB0C0cK0M
         jsyvGq085ds01P7TpvsA535BdFeVE23xjD3tnbxARrV3p3rS9awtvWWwRQ3XV4MXfHYt
         ojnjyr8jDfv6N9T4c3Rd+gDCXv/udbOuLCCPPInm/KNYc3ailxTSmsrXeD+feUg7Cz0j
         uz1aVUu/pZzt0PPBk3N4GXLXeyQnuagGmIhIMCXEyYNzPgNuiFU/zsz8xMwrjTHS3C8D
         C6tA==
X-Gm-Message-State: AOAM532ssUP3EbOipRLq9MvUHN0/SpGfaDDBJKGCxBnqPfTY5k0BVzBV
        caPsEhcImA3Dp576c5Xu8ew4mVfjpcoL
X-Google-Smtp-Source: ABdhPJy16wOevtvij+fqDb1WHcMwi+goNOVnFva8Xzhl90PTNfWe+5pi0V/uwYGgWXjDZXxe/ARIGQ==
X-Received: by 2002:a17:90a:f189:: with SMTP id bv9mr3571491pjb.174.1605279084911;
        Fri, 13 Nov 2020 06:51:24 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id t9sm12818965pje.1.2020.11.13.06.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 06:51:24 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     krzk@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] ASoC: samsung: remove the unused variable value assignment
Date:   Fri, 13 Nov 2020 22:51:19 +0800
Message-Id: <1605279079-6416-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of variable ret is overwritten by the following call
devm_snd_soc_register_card(), so here the value assignment is useless.
Remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 sound/soc/samsung/smdk_wm8994.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 64a1a64..1db5b59 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -160,11 +160,9 @@ static int smdk_audio_probe(struct platform_device *pdev)
 		smdk_dai[0].cpus->dai_name = NULL;
 		smdk_dai[0].cpus->of_node = of_parse_phandle(np,
 				"samsung,i2s-controller", 0);
-		if (!smdk_dai[0].cpus->of_node) {
+		if (!smdk_dai[0].cpus->of_node)
 			dev_err(&pdev->dev,
 			   "Property 'samsung,i2s-controller' missing or invalid\n");
-			ret = -EINVAL;
-		}
 
 		smdk_dai[0].platforms->name = NULL;
 		smdk_dai[0].platforms->of_node = smdk_dai[0].cpus->of_node;
-- 
1.8.3.1

