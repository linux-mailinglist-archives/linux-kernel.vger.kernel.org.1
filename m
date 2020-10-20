Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3E293930
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 12:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393139AbgJTKd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgJTKdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:33:23 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E9DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 03:33:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b19so818491pld.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AuLkrHmDKwQ7qOPWrn9vSIKIU6u8iuaT4gQA+tnIAI=;
        b=uCzsmEeWXFIaM7DITCIh/gB9nnxs0qfIVziUqw/n1AT64os7ZK8VUMUKUgLYJgNU1y
         15ergUR0FUKLoDuEHQuuwj+l2A5EsyhAU+Uy0K9Dglg3gGPiCU+GCtQCKGH7pGnceGDr
         MNixKd1tdq+DiJX11xvZwHuI4SytXDmWxktjuTiVEcl4seySsshTL4AdoBunlHu2ZHS5
         6yxAXTXkm6Y9pvdE0s1o05o4OjWoBhpIL5/w5ZpAUGPidFaGD/tON5PxBU+Y+Eb+j2zK
         fMe1wVBKz2L31a4MrVfk3mOsM5s3O8NJSzk/PIb9xXJfr6NNm/PdlItLAwd91u1f5Cen
         uwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AuLkrHmDKwQ7qOPWrn9vSIKIU6u8iuaT4gQA+tnIAI=;
        b=WMpLBOKYgF7vDD2+VZtZ3p+FquSUnlwexjOBpKZDtrm/eMW6A4+okUEshZ8PVpIa9x
         F/mXi0QvA/KE+slwufOLjuMQGkd7VSmjtgRJtDx5FIa1C1HMdq9sNnYIruUk1BEgMs3T
         IQQl03n310SU5b/YwK2cU7kRb5iCr3jTjakpBebKCBmuYHf7BpNXauRer3VJjCJmYI9B
         Bl/TZMwdWRhEHCzMXyJZIkW42zgtgLcw1+E7B6asCmGeWVbNlqZ5ijzcuH4hP2sPbJjG
         NSxOywAr3S5aKditytuJCSPfSa4jwLupJTn2i16GcNZNQM8XnHNWdV/rmJ0fzVPzYddz
         cSkg==
X-Gm-Message-State: AOAM532gd7TE0wC2f5zp4CJSzUN99aPqObrxCXtPXJkozxb9Rk41mZhQ
        4nE14F1tYyNwE0Xk6NbYlCMLsA==
X-Google-Smtp-Source: ABdhPJxHK138V7xdthbOM/r50ZwxEuEj74h4Lzz/gR3nYuyED/sZUGnftpJWsS5S79icVa1ZtiR+5Q==
X-Received: by 2002:a17:90a:f198:: with SMTP id bv24mr2204169pjb.230.1603190002895;
        Tue, 20 Oct 2020 03:33:22 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id h5sm1888227pfh.9.2020.10.20.03.33.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 03:33:22 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Fix early exit from dev_pm_opp_register_set_opp_helper()
Date:   Tue, 20 Oct 2020 16:03:15 +0530
Message-Id: <be911bcddc1dbf4a152513cb3d83f8eed7d2574c.1603189831.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We returned earlier by mistake even when there were no failures. Fix it.

Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rafael: Please pick up this one as well for 5.10-rc1/2 once Naresh gives
his tested by. Thanks.

 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2483e765318a..4ac4e7ce6b8b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1930,7 +1930,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 		return ERR_PTR(-EINVAL);
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!IS_ERR(opp_table))
+	if (IS_ERR(opp_table))
 		return opp_table;
 
 	/* This should be called before OPPs are initialized */
-- 
2.25.0.rc1.19.g042ed3e048af

