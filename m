Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2628D2240BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 18:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgGQQmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 12:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgGQQma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:42:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC78C0619D4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:42:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so11853342wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uf8bzKAkN9OCCDfHeegI3pqxuhYTL3n6jrxOgpitcxs=;
        b=e2YzeDrsy9g/TykVozOONhF8n8NR0N3bSvPoLKREGAOIv04Oh1OeVj/d2Zl5iZnGB7
         JZJ/NyA3lz+4fOZTnN7lBDfWN7SpL05GrAkRSKteAaL299ZOj8GFuW9hLzJ+9AdosSlo
         VVPT5m1dZlQkSvN9dj4oq+hFPlrAqGlQzOadz+6lSorgatkdZh1JUL4qHg9iqlrOf6pJ
         97Yz91dTs/I8QdlnNFyuTXv7tLPY533N88zGnEsLAH6jA+2ZMzN3RJyX4r+RyPP2vTkW
         AmUfE9drvd5qEpy8/EOhNIJ5i2f1X+FQ0+O/pobNalUzXEzVAwVlYFBCQzuvU3XssIRR
         cc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uf8bzKAkN9OCCDfHeegI3pqxuhYTL3n6jrxOgpitcxs=;
        b=spQnVrqYdJhvfJgmGXsrJjdtEecQfEV7mus5mFVdAUhc09Zj04QS8h7MmBLw6BG31Z
         1eoIrYpdYVYF1Bc8NlUMt/XWlWY3Wm+qPMSpGZppHhRr9bvwDY/18Jw+veIK2Ld1Lqq9
         loz5F/G4t2lxf3yrCVOn5JEJvrT9ymz/pUzPEJ3HTPZHgedes/TJ+aLI+pE9To74dkxL
         +fFZJkpehdxED922X0vDmSXqfsvT9rfiwmLB50SWpWGdO5dtzyvnhduc18RkqsOfJI7S
         7zKT5g26FxViXofVGnMFTJQ5JKELvkFyU1lGRbj1tsI0OVq6dPx3vkJMKIIKvvWZZYrK
         /oSA==
X-Gm-Message-State: AOAM5339oZJH/Qjaikg8KrQEFt0KY87T48qn+jJw1Bh+dIE3W/I9ggeQ
        OlXuSS/pLeqmAoHrXmncyLYhSA==
X-Google-Smtp-Source: ABdhPJxPd7iCY+hsRcY6KNpNMkoDYU2RJT5i7Bi5H6fXUVMxabIOEjAzIJGqw097rU6IOJDwIru/fQ==
X-Received: by 2002:adf:f203:: with SMTP id p3mr11318444wro.331.1595004147174;
        Fri, 17 Jul 2020 09:42:27 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id q5sm15312610wrp.60.2020.07.17.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:42:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        m.szyprowski@samsung.com, amit.kucheria@linaro.org
Subject: [PATCH 2/2] thermal: core: Move initialization after core initcall
Date:   Fri, 17 Jul 2020 18:42:17 +0200
Message-Id: <20200717164217.18819-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717164217.18819-1-daniel.lezcano@linaro.org>
References: <20200717164217.18819-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic netlink is initialized at subsys_initcall, so far after
the thermal init routine and the thermal generic netlink family
initialization.

On ŝome platforms, that leads to a memory corruption.

The fix was sent to netdev@ to move the genetlink framework
initialization at core_initcall.

Move the thermal core initialization to postcore level which is very
close to core level.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c2e7d7aaa354..79551bb6cd4c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1617,4 +1617,4 @@ static int __init thermal_init(void)
 	mutex_destroy(&poweroff_lock);
 	return result;
 }
-core_initcall(thermal_init);
+postcore_initcall(thermal_init);
-- 
2.17.1

