Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFED20C96B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgF1SC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 14:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1SCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:02:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD37CC03E979;
        Sun, 28 Jun 2020 11:02:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so14370031ejc.8;
        Sun, 28 Jun 2020 11:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qY5C+TN1xVJjMBjtVdjXiDPvCm8SKvhEdbrdTzcLaH8=;
        b=OLbMRE83xcsn9XFmrLcMRaeKh5tW3kJP5Z1La6S5tFxxKnjOnBthDQKS8aDDuVIxN9
         2BQM3IatzfgpXZ/0iHPOz2fMQ541phyJoGdrEFq8c2ONN01EVUZISkr4hedclixdI8iC
         l6sjBRLWgGZyXiwznuzbsngcVriuDbxXIlnXrzLsutPbMTbEdU0fKqWaq/6AknVZQ6YO
         xEGtzvCN1Ice8E1ObJTsLXKeirdpUNIsEfJOayoR5GNjUxvtdT2a015GZ7gP/xmYjg3x
         fKJXFMx9fPtHxSNTQWjyY6YKN7Bev3b8NJyfwx5i21hUDhO3IvPPounpMu8KvNO7+hg0
         +lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qY5C+TN1xVJjMBjtVdjXiDPvCm8SKvhEdbrdTzcLaH8=;
        b=WNL0BH8YDeuYZIoi+W6fQ6Aj5OBh2e3v7/D4SsVOXsUVkVEq9NACm4s/vKmknfk8c/
         Wbk9zkdbqsIW+Rr9tCaWUMBLKhzXRGLJJVOaTnYG5F0jOH6N5bBBdrbPahdvb9E1AGma
         /WUa11vYsbvZI4wx89Ck4/QtI5TuQGJMQLlFPWMLzSSYd2Du+LB75tWKvlS79J3psc6g
         8RKtV6AAL6qtrHnwTQhryhRlNChHywgyQ3nZyRVWyqMrt9A+AhY2duuEdBzlSJKnIX9l
         1TK197U/6fgPUEWY/VfFhBHgVOMEc+s+nVHyJph8f/L1P9gcRUStIs9IBt69K9XvfIng
         TH5A==
X-Gm-Message-State: AOAM531we2Xl2v5ZxjNnJibjPG1gCx5Y7LR71TEzpjwmAhmllf2QELoh
        v/mTzD4FiVCjCGQGltC2DSI=
X-Google-Smtp-Source: ABdhPJwDE48mOL4SAJkI0Dt0XPa4M3z9OsREGuMUTiO+8dOpXPXYsN1u5wJI8p4KiW5oJPglbwFrkQ==
X-Received: by 2002:a17:906:c285:: with SMTP id r5mr10638329ejz.153.1593367374312;
        Sun, 28 Jun 2020 11:02:54 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c900:f923:222e:8ecf:3426])
        by smtp.gmail.com with ESMTPSA id by20sm9461019ejc.119.2020.06.28.11.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 11:02:53 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Seth Forshee <seth.forshee@canonical.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove obsolete entry after file renaming
Date:   Sun, 28 Jun 2020 20:02:29 +0200
Message-Id: <20200628180229.5068-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f16861b12fa0 ("regulator: rename da903x to da903x-regulator") missed
to adjust the DIALOG SEMICONDUCTOR DRIVERS section in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/regulator/da903x.c

The da903x-regulator.c file is already covered by the pattern
drivers/regulator/da9???-regulator.[ch] in the section.

So, simply remove the non-matching file entry in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20200626

Seth, please ack.
Mark, please pick this minor non-urgent patch into your -next tree.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04fceaee5200..970136e262c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5021,7 +5021,6 @@ F:	drivers/mfd/da91??-*.c
 F:	drivers/pinctrl/pinctrl-da90??.c
 F:	drivers/power/supply/da9052-battery.c
 F:	drivers/power/supply/da91??-*.c
-F:	drivers/regulator/da903x.c
 F:	drivers/regulator/da9???-regulator.[ch]
 F:	drivers/regulator/slg51000-regulator.[ch]
 F:	drivers/rtc/rtc-da90??.c
-- 
2.17.1

