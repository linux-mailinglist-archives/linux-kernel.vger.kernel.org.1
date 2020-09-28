Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E127AD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI1MGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1MGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:06:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB9C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:06:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so868661wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=azvQ9FU5wZxDBrB7s6WKh0KkT8JZln1NwAybqdYddW0=;
        b=m6k9RlCX6V7YfpCcQ4O9sQ+ae+Flpz91WzhJlvCDYbUphYgessf8KLON8vhiwJH4bS
         naXkM/awC5DokTWVknfYneXhHkMSp9zyFQ837pMzFmv2FEAmXuRtgCxErfueVxqk5D/p
         LMTFrwVp39H/vdzff4SKDcg4iIb78yaDWzVRaXhcp8asnTVZzdAcMCkHE7H4I4xsW1La
         UBnDxvj0vTSiTZrWeJh6mll8AhI3NizutSpmRojyhVVBRvzfTgR3SWZWnlWxAnIt4A+U
         hDBmN+GlNYOH1yXarTaFOzyxlya5yuDW34aMjU9wzgs37SrdFG4LIiFM3D4pwgNcmsxw
         3RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=azvQ9FU5wZxDBrB7s6WKh0KkT8JZln1NwAybqdYddW0=;
        b=ON78exLq3cyeaGjJLHIw0r3EwsclYTcMRS6348s+deccWV0m6vUbkXt55ts5bTv4YD
         dCFqxY3orTt4TCxr0RK8SD9Huy/zxBIdunAVQI+2q/sWiDXl1wGXmQ9k6T87so7JGdTu
         OwmFzr04Ua59dZDA5KubnvPyZwTG4S6zKkYkWs9NADrNbneWHpCCWCISZvtFDacYTeef
         b54P2hQpQ08rRyIrv99G/1tRMaBF9JD5K30HKqQEoZWTySqC6TM360EylXd3u6SYlAvJ
         Ax/byVyLrMsR0ncYjka+xXbYTKu4qIXF/Haq6ZP55SFmW5Agcn8R63XboO68JCbmYQIT
         8XLQ==
X-Gm-Message-State: AOAM531kNw9UJ4Tf2d4oS7BNcWueiCNu4tU4rW+yNrDo3qewTkHUhJQQ
        JQgHSN4TjKjJJ55qBk4alqpRbae7Hj+5/w==
X-Google-Smtp-Source: ABdhPJyzgD/siAyYnAg6FCAhv+9s5Cwx+i8n2Egf5bzwGGwN9EA2Vc8OlimNjEcZ3gLl976PaDqrRA==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr1242660wmf.37.1601294776834;
        Mon, 28 Sep 2020 05:06:16 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id w7sm1188133wrm.92.2020.09.28.05.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:06:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] regmap: destroy mutex (if used) in regmap_exit()
Date:   Mon, 28 Sep 2020 14:06:14 +0200
Message-Id: <20200928120614.23172-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While not destroying mutexes doesn't lead to memory leaks, it's still
the correct thing to do for mutex debugging accounting.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/regmap/regmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index b71f9ecddff5..5ecd7a57700d 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1365,6 +1365,8 @@ void regmap_exit(struct regmap *map)
 	}
 	if (map->hwlock)
 		hwspin_lock_free(map->hwlock);
+	if (map->lock == regmap_lock_mutex)
+		mutex_destroy(&map->mutex);
 	kfree_const(map->name);
 	kfree(map->patch);
 	kfree(map);
-- 
2.26.1

