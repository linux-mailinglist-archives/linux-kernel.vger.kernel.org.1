Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F791E06B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 08:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgEYGLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 02:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbgEYGLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:11:50 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD05C061A0E;
        Sun, 24 May 2020 23:11:49 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n141so4247619qke.2;
        Sun, 24 May 2020 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9IziVmgyfYM4YsH6OqHb3uAGAVG/qg0TjTfH8HoMiuk=;
        b=MmmC83QK+HaGsZEdKs3X2dpoX60/5ZUMa4upYpL4I37SmCRG7DhOAg2VDy6SSGUHkw
         On09QQ9AE1/qiQJUBqJIlACn9XBuRHZZdJnbOprCP/0pDLsYRwaMCVZugrf5/QAWuDPo
         lqm2Fx6bcBbkbaFZjDPf5156JT4CGkeRit0Ie2WAOn6D9nmEHL0U5O2hXrt9WwKZ9+XR
         pgM3nY9agX3CixvjaI3d+7pSMXQDGs4QAOt47yKIW3RJ7u0NFuws+ndGuhjTm2zR0CNH
         dx/Bt3I/y9qyAx205ZN4FJeEI8ntgT8qJmCgNrz8As0ROZVjSGXeoFk6q5Z6cfNSomsk
         7F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9IziVmgyfYM4YsH6OqHb3uAGAVG/qg0TjTfH8HoMiuk=;
        b=eD5AO1h80qygigpfE53PXcnzcunzG0uWMXNLT/JmASriHhnY365FypGE09QDN73dp9
         Y+wt2RdqYpXp4dsoXv19zFSv7FIzlFG4E6ru3DyGSZulsw82fiTTiY5km3K94Y87KEWI
         a0GZQWvPLKQ1E3R18VuH34HqwT36t2Qebkk5jl+y0S5CNftkpugnHDDOrPiPIiaBEbfq
         zeSukd6xIRKhb7kh9D72gG0wHZS7uIDDLpuj8epXnitUCc9pF/QDhrt66QNqRr9pwJ0r
         zhBkqBnOi0lEGkUVXOM5JKwKp0Ssez0t5oxOPw5gec/ffU2P1m69/Ry3jxPDK+wp0WM+
         b/sA==
X-Gm-Message-State: AOAM531sUElYptOttEpQ0q1aeAwSr9F6lA4dQbWu9aP24B11ovEegYvm
        7o6rYH9AQExLJzlNkS6QLT2qTZtKBut/
X-Google-Smtp-Source: ABdhPJz4W7rG9gQgXFStdiHwzFfGeyODFuXYL4YmkKJh6WuzG4oJm1BVoOlr5k6sYisCAknLIRAiwg==
X-Received: by 2002:a37:2783:: with SMTP id n125mr24350464qkn.335.1590387108835;
        Sun, 24 May 2020 23:11:48 -0700 (PDT)
Received: from localhost (cpe-104-162-195-29.nyc.res.rr.com. [104.162.195.29])
        by smtp.gmail.com with ESMTPSA id 193sm2045786qkn.94.2020.05.24.23.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 23:11:48 -0700 (PDT)
From:   Till Varoquaux <till.varoquaux@gmail.com>
To:     kernel-janitors@vger.kernel.org, pure.logic@nexus-software.ie
Cc:     Till Varoquaux <till.varoquaux@gmail.com>, trivial@kernel.org,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: loopback: fix a spelling error.
Date:   Mon, 25 May 2020 02:10:43 -0400
Message-Id: <20200518051314.1785567-1-till.varoquaux@gmail.com>
X-Mailer: git-send-email 2.25.4
Received: from localhost (cpe-104-162-195-29.nyc.res.rr.com. [104.162.195.29]) by smtp.gmail.com with ESMTPSA id e3sm8401074qtj.25.2020.05.17.22.13.55 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128); Sun, 17 May 2020 22:13:55 -0700 (PDT)
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Successed -> succeeded.

Signed-off-by: Till Varoquaux <till.varoquaux@gmail.com>

---
 drivers/staging/greybus/loopback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 583d9708a191..2471448ba42a 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -135,7 +135,7 @@ static ssize_t name##_##field##_show(struct device *dev,	\
 			    char *buf)					\
 {									\
 	struct gb_loopback *gb = dev_get_drvdata(dev);			\
-	/* Report 0 for min and max if no transfer successed */		\
+	/* Report 0 for min and max if no transfer succeeded */		\
 	if (!gb->requests_completed)					\
 		return sprintf(buf, "0\n");				\
 	return sprintf(buf, "%" #type "\n", gb->name.field);		\
-- 
2.25.4

