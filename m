Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E242A8FF1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKFHFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgKFHFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:05:37 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60849C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:05:37 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 72so459464pfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OM4R8kvz7DcEDGoVL/+jwadYBnqD63FlUWgPugvm78I=;
        b=vJ5Si/G8zW5asLYK4yzoXUH4+0noPeaZCYzJx6PYHk+ao2dzwXa9pytvIQHVFHK5Ne
         vBEoN04Ch3a1Gg8/qxcpogXvPkWOJK7Xa6Vsrg9HJ2iRgrSkLzwZzJ5HojbFqYCCbXZt
         aFK8L8fkGrFm88BWuj5hBUoXR/aSe0H1TumxaT3sDKDCMe82hj6cjfywQElRrKHacejx
         3d9cbL/yM4akOHEJ3TUOn/TniQKyGE5eQiOcAv7hO2OPghXeHc2WFIH3nzHf88MGZwTr
         AlctnMbWTwX7sMvAQcgDy0+W45oH8VVJyBoXLwuHYQZt1YYKxtFOV2vgpByiR71Aznl4
         XJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OM4R8kvz7DcEDGoVL/+jwadYBnqD63FlUWgPugvm78I=;
        b=lHVvTN/imAfeQcuUIuGu0MsjYdMDovOKCghQd4PPVRGr8HUxh8VM5YmpM3SQAmpsdt
         GaR519EjOc1tA5jAVSxc+EHgjo1+ngIOqjRdmU7u2UZGfZc4u9Lecr2vbPdMt6lxxgFC
         IEWoN9cC+lWWICnzxUyGgns6UuERVPsoKV3SNKzg/8nBO+0mgqARPnzO/4UU5Gw67shQ
         iPVZywbart90mUi2kcXxjNR4GBhriPRUkiIYDCnsqxvgdtkNUtZp723LdQHXHHNm7Ixd
         74hhmEivWXgweJB6cHZEjbROS+y0sZr6JESyI2j1fMvno9RG6FQ/kGkVH83FNZriwozd
         V1uQ==
X-Gm-Message-State: AOAM532BOu7Jc6Oet/eyeXEldhcz98qnaZnh4RMOnb0QzTFTKfzz47dX
        X9RSg7mNrL6Kt42TmunSyu4+8w==
X-Google-Smtp-Source: ABdhPJwE+7aKzU0Jx/bREINzle5y+qOHgpi0m23MkC+FXdDxSl8y9riR1SAMwq1YP0KhdPSWuKLI5Q==
X-Received: by 2002:a62:1c92:0:b029:15c:aff1:b16f with SMTP id c140-20020a621c920000b029015caff1b16fmr687698pfc.0.1604646336961;
        Thu, 05 Nov 2020 23:05:36 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id z11sm819019pfk.52.2020.11.05.23.05.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:05:36 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] drm/panfrost: dev_pm_opp_put_*() accepts NULL argument
Date:   Fri,  6 Nov 2020 12:33:26 +0530
Message-Id: <43be6d118201f9feb70fb030390fddce0852ab0b.1604646059.git.viresh.kumar@linaro.org>
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
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 8ab025d0035f..97b5abc7c188 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -170,10 +170,8 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 		pfdevfreq->opp_of_table_added = false;
 	}
 
-	if (pfdevfreq->regulators_opp_table) {
-		dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
-		pfdevfreq->regulators_opp_table = NULL;
-	}
+	dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
+	pfdevfreq->regulators_opp_table = NULL;
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
-- 
2.25.0.rc1.19.g042ed3e048af

