Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FF428F504
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbgJOOon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbgJOOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:44:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA10C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:44:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g12so3791909wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=soOA4oYAhoT9qwZTBOd2JvR9jvEOzaqFrTAOBqyp4f0=;
        b=vlBsPkdyH8oejvdNlnl86nagXsrdmsxHvUCaJM+QjEw8FPG0xv3b17ZWs2bM2xAUR4
         vYBnXKnwfopyoMFCSfhME1KQGNKrdXSOv5N2AMthdQ7vCzdbI1DzgNho+6EEqmEaDNZF
         Z6nEw/JKGtDxDSvxRTA15F3OGOKlWgyPSg7KncoKfy38zZj/PtUER8UYermCLrShyiHK
         FfzgU+NKrN8D+pgmzW4iKfWeeLOywlzqz7PnYJ4XlAe+HY0nzNP+LZvPJH8aSI1n5RHy
         y5OKgFI6R6lHjXzlnSA0tbu5fRw9Eo1dF45crxpcUNleW0CzS38ZDy+4NYPzEAkGp45S
         5+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=soOA4oYAhoT9qwZTBOd2JvR9jvEOzaqFrTAOBqyp4f0=;
        b=NfPOO0yBvk0gFMcaMufbCN5YmMvykvYp3nP+CBsuj6BKuFV48KGznvXHvLeW71lBKC
         JklmgLgbFgLmeBUUGTrhjnmXNQbD7LJrA7V/t1hddtFMobiF2U5FHX7gLGwxaKs7bkBY
         ogvWDbEgIS1bb7npZtkTtTxOl4cSHS6sSM5jnzAg+gWWtAALm/dGckG4iOxd6ClFQMPa
         za6NLAiMUydKS9hmns7vFyEMOSdn71Z86EQ91fksoJTkW7aQTkh6AJTTFDjP/5uAXS5O
         ie5ejY3zVn4P6Kj5CIoNyfoLgmKhAqbGi3XksLtFXxEozwKd9dSFKptRRq3PwY4Z3GJ3
         wQcw==
X-Gm-Message-State: AOAM530cD2mzQavQAMuri0yGNMO0ni7yy9Bg20F1AGZtDX6TtvKNxle1
        4QIaZ4MSoKrcURBuztu7lxOsZw==
X-Google-Smtp-Source: ABdhPJzBmoNj4CR7eehnW501dpYjt5vXWvCzTXToYHQs64VPdWP4Kl1AqPrwgqU27sJO9yY17hw0ww==
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr4911757wrw.426.1602773081012;
        Thu, 15 Oct 2020 07:44:41 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-134-136.adsl.proxad.net. [82.252.134.136])
        by smtp.gmail.com with ESMTPSA id 40sm5053800wrc.46.2020.10.15.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:44:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ilina@codeaurora.org
Subject: [PATCH 1/5] cpuidle: Remove pointless stub
Date:   Thu, 15 Oct 2020 16:44:27 +0200
Message-Id: <20201015144431.9979-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuidle.h header is declaring functions with an empty stub when
cpuidle is not enabled. However these functions are only called from
the governors which depends on cpuidle. In other words, when the
function is called it is when cpuidle is enabled, there is no
situation when it is called with cpuidle disabled.

Remove the pointless stub.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/cpuidle.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 6175c77bf25e..74fdcc6106b1 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -270,13 +270,8 @@ struct cpuidle_governor {
 	void (*reflect)		(struct cpuidle_device *dev, int index);
 };
 
-#ifdef CONFIG_CPU_IDLE
 extern int cpuidle_register_governor(struct cpuidle_governor *gov);
 extern s64 cpuidle_governor_latency_req(unsigned int cpu);
-#else
-static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
-{return 0;}
-#endif
 
 #define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter,			\
 				idx,					\
-- 
2.17.1

