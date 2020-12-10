Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9082D5A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgLJMQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgLJMQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:16:03 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C6AC06179C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:15:23 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so4443647wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wWauJdDE029YC8Y+yIe9jMzg8qCBhdzScMeoKibGnOs=;
        b=vgszwTHwXKWqOF0ocWWs9BDB0fhJW0g/L4FInCzZg9O1Gn1XdVp6H3XNzsGzEkE3Ww
         qoJ8SLKt9uFFvp/v63bnE5ZDv4cO4j2C0uDBQVaSelhwfCqLNFikkDBcvT0s/6/etzow
         Ycy8rcq5QyPeyygBFoZS1vNUYSJG/Fm+84Pj3WBNHJJ/k20P2QaBqDd39i3tiidkbf6B
         1KLOSAMBbBBQp/6mJfPr96yt/GyZn70bIkeFpBD8N/PRvgJmLbzCEtJBsvL0oh0HnxAD
         s0EqdB/FlCw/mL8rHvsrya2AK6I+h4CwTxGHqPMSU5+nEvzhgnHZ0gPqIjK+ohx+uFtX
         jmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wWauJdDE029YC8Y+yIe9jMzg8qCBhdzScMeoKibGnOs=;
        b=UYAOzxivscBWIno7zSJdiAqSxF6SlxW36pvtTrCdmQ8GM14S6zMUQrBHL+QZRK1GRw
         9CMi5hGQfDbPKOLG3ISqC2mVp90J2dPq4F7dV1T2bCBsj0sDn4CLUGpSnJ+UIa6PzTj5
         NHZNt5/9bxV112ApN0rQxCi+ITfQKaaKV1emnOygcxdj3qGeocOCmGwUsg7JrCPGjDy3
         wU4Lv/Y1QbJMCadoPzgLi1s6I+3MWURMmKArhdWS0su1sw2ZQ18BvSi/264BEzrZIjAH
         FLKnkaq679mwyLGb2M+RQFmUkUEPQI5HY35PPLBmej0ow1F3TE3O/iwdJ8pW4O9WBx4R
         OOkA==
X-Gm-Message-State: AOAM5331tAp7CMHxqaZS2ctOhAB4ZsMZZVYr5NCvwkMCvDoeX24jHSR/
        dC9mHwr3jN7bKxOeLXwCEFmchw==
X-Google-Smtp-Source: ABdhPJyJjEN3VJvRUYYKAJlErYRFonZu+sAZtxiJbJSR6V+0ZNn5+wGcE9vWgE1CNMZdbV1ZbHqdlw==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr8014199wme.85.1607602522205;
        Thu, 10 Dec 2020 04:15:22 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id k6sm8412863wmf.25.2020.12.10.04.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 04:15:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, lukasz.luba@arm.com,
        srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 1/5] thermal/core: Emit a warning if the thermal zone is updated without ops
Date:   Thu, 10 Dec 2020 13:15:10 +0100
Message-Id: <20201210121514.25760-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual code is silently ignoring a thermal zone update when a
driver is requesting it without a get_temp ops set.

That looks not correct, as the caller should not have called this
function if the thermal zone is unable to read the temperature.

That makes the code less robust as the check won't detect the driver
is inconsistently using the thermal API and that does not help to
improve the framework as these circumvolutions hide the problem at the
source.

In order to detect the situation when it happens, let's add a warning
when the update is requested without the get_temp() ops set.

Any warning emitted will have to be fixed at the source of the
problem: the caller must not call thermal_zone_device_update if there
is not get_temp callback set.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index dee40ff41177..e6771e5aeedb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -548,7 +548,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 	if (atomic_read(&in_suspend))
 		return;
 
-	if (!tz->ops->get_temp)
+	if (WARN_ONCE(!tz->ops->get_temp, "'%s' must not be called without "
+		      "'get_temp' ops set\n", __func__))
 		return;
 
 	update_temperature(tz);
-- 
2.17.1

