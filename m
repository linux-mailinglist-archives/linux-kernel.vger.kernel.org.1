Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794AA2A8FEF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgKFHFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgKFHFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:05:35 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63189C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:05:34 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id v12so439015pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehPUCc4BBH4w6xwbXHXZ9YzZ1LHDSwHspwqvBRHLfG8=;
        b=o5Zr52H5GnqwIwaEUT6XGHpZ+Rk+X0IvKQ47cS0hprikNcIhQd95tQWJJ9xoEnMC6a
         qq0CgW4B20Qmt6WOLolyORfkDV888lAdzgcGn74AVqm+Knjd7N42MMbPeXXOyU1tL0J4
         7GWqIJq+ACgU+jrTV5fuw+yggsYOAd9L/MAjYtgC1nzSfvtVI2U9LNiyJN2qZeqPGwJT
         kTg9vCMFltVucT2XqAblwjqtX1+OttYzVhENqzJfjyUNCk5Q0u9WKxarQa1qqwrWbPQC
         AB8UTDeC1bGUO/Eya7Tey2URIlSqyJuMquf4COHmuHqW+TX8lkHBRXwAhDKO1VIf9w9g
         W0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehPUCc4BBH4w6xwbXHXZ9YzZ1LHDSwHspwqvBRHLfG8=;
        b=OQIJHYgtt9Ipzvxal/TFjTPq8+o4pS3zEzJbchLNamHmOC8OCQVCDWm4c5RHFqsS45
         M04AAY32KEfuoc+eujwvhxxAuR5T5HOJJKn4T5akwE3k/l0HhTf/PFsrIqdw6AatytJa
         T0Icid6Yq1W9kioY/8guBVDuC/M0zccjfFlCaxAljA+PhLLDY3mF//zwaJC/+mpdeKjO
         Bic49Aac/Ib0aTubMNwKPO70i545fOWqoSOTPoPSjQ4hrjFTNLUMZvkfs/5faA7KZIFH
         mUO1ddxu0rZ6VUFzTs6V7nAhFvFS0pDylRfHKK70jnsmd4CjG5X95glvtsqgTDsBp2Km
         qVgA==
X-Gm-Message-State: AOAM530it3HDiwaFHuTJt9X8eXgobaHFgOTw+w2EQXo6vteDIY20Rzs4
        jWSmbB64vnLDcHQ0vtYiUDE6x5O7mP+WJQ==
X-Google-Smtp-Source: ABdhPJxV4aG+pPSqQiArJqkvpC3VHdnMlXqz893y069PmwZUjFiCvQoM0e21aZD+0OKoStOt+zy0BQ==
X-Received: by 2002:a63:1212:: with SMTP id h18mr621177pgl.196.1604646333997;
        Thu, 05 Nov 2020 23:05:33 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id m6sm793084pfa.61.2020.11.05.23.05.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:05:33 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] drm/lima: dev_pm_opp_put_*() accepts NULL argument
Date:   Fri,  6 Nov 2020 12:33:25 +0530
Message-Id: <2518c14df2f16cc3c4fee35499895a32513c174b.1604646059.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1604646059.git.viresh.kumar@linaro.org>
References: <cover.1604646059.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_pm_opp_put_*() APIs now accepts a NULL opp_table pointer and so
there is no need for us to carry the extra check. Drop them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpu/drm/lima/lima_devfreq.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index bbe02817721b..e7b7b8dfd792 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -110,15 +110,10 @@ void lima_devfreq_fini(struct lima_device *ldev)
 		devfreq->opp_of_table_added = false;
 	}
 
-	if (devfreq->regulators_opp_table) {
-		dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
-		devfreq->regulators_opp_table = NULL;
-	}
-
-	if (devfreq->clkname_opp_table) {
-		dev_pm_opp_put_clkname(devfreq->clkname_opp_table);
-		devfreq->clkname_opp_table = NULL;
-	}
+	dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
+	dev_pm_opp_put_clkname(devfreq->clkname_opp_table);
+	devfreq->regulators_opp_table = NULL;
+	devfreq->clkname_opp_table = NULL;
 }
 
 int lima_devfreq_init(struct lima_device *ldev)
-- 
2.25.0.rc1.19.g042ed3e048af

