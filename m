Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4C2E2CD1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgLZBh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgLZBhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:37:55 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB7C061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:37:15 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id h4so4886847qkk.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QXqJG4Xi42rLd1du6fHxXPkgXhG8fFUtdz/Crhf1gtI=;
        b=f5wwSsGFQRoWh69KHBC6FBIrKEY8CZWalAfmN3jBi5yqvAnaT8w03SwPQ85FLl6S3o
         qlFLHpiZUEnTzOTtYPaaKNJCckRAlJalJV279QB5ELyyHdibjFBX9qujEJ0Kg9iJciTl
         MczwqZBQOnwqLErUqOF4ahEekg4525u9gRJ5VUjeWTVYgsg9QIKN20y1FCjJZrC7swsM
         ODMcN/QLw6p1CX/C0EIOrK7q3XPrVZmoqQyRyxHTmBJnVm+sowMrQ+1pNPwDEYZuy4jw
         VaqrwgsEdfmmlY1FBd+szEpaDn1Gouyk62d//wdgUqiQwPybM7omO6R0dqHk8Xpstjg5
         EBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QXqJG4Xi42rLd1du6fHxXPkgXhG8fFUtdz/Crhf1gtI=;
        b=YWAHpS4Dv2Pt6qmWPgg1RqbCfsR3KvfkbMOy/clpxHeNX8M8zs9cZPMi+7htwhe6eX
         pcnsqIOgsXEX16JsbNsJNmgCk/JhFZg2F5Dc1JjkuDh7H+50FFcvLpGnPYVXU7o3lfyg
         a7O307j/L80pFDCsrYAkEI40A8V8xnRL/cFW1qzm7EOJMNKYJVAHzFpp5OjsEER8T7Up
         TPvFH75a5GQ/Va7ws+JL6qtnBlU/xsB7FSYr5dpEMHAyDvEMrHOdmLScT8WcbNDUkoJT
         paHmQiT/6kxn0D8RSNF1d1lVfjItozPEiHFFE23K2G7ohfZWprAyFtVVvpHfHH5zyqjT
         7LXg==
X-Gm-Message-State: AOAM5323S6CuOuhz/nifa0GRBvUUfNPGSl1jfOj/4+QNV4qNI8weuF+R
        Esnzc34gWG8IepMC+Uxw0n0=
X-Google-Smtp-Source: ABdhPJyaJ8a2d2CmlC+iJfMjksouEpCOxQgWa9pN27pfjnwXL8X0EqQPZfykFcZ0H4u1G1ccAd2TTQ==
X-Received: by 2002:ae9:ef83:: with SMTP id d125mr35709801qkg.63.1608946634673;
        Fri, 25 Dec 2020 17:37:14 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id m8sm12290086qkh.21.2020.12.25.17.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 17:37:13 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mfd: ab8500-debugfs: Remove extraneous curly brace
Date:   Fri, 25 Dec 2020 18:35:49 -0700
Message-Id: <20201226013549.1973451-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang errors:

../drivers/mfd/ab8500-debugfs.c:1526:2: error: non-void function does
not return a value [-Werror,-Wreturn-type]
        }
        ^
../drivers/mfd/ab8500-debugfs.c:1528:2: error: expected identifier or '('
return 0;
        ^
../drivers/mfd/ab8500-debugfs.c:1529:1: error: extraneous closing brace ('}')
}
^
3 errors generated.

The cleanup in ab8500_interrupts_show left a curly brace around, remove
it to fix the error.

Fixes: 886c8121659d ("mfd: ab8500-debugfs: Remove the racy fiddling with irq_desc")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/mfd/ab8500-debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index a32039366a93..1cf84562351e 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -1521,7 +1521,6 @@ static int ab8500_interrupts_show(struct seq_file *s, void *p)
 			   line + irq_first,
 			   num_interrupts[line],
 			   num_wake_interrupts[line]);
-		}
 		seq_putc(s, '\n');
 	}
 

base-commit: 61d791365b72a89062fbbea69aa61479476da946
-- 
2.30.0.rc1

