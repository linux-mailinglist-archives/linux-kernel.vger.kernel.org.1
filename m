Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CB921A1AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgGIODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgGIODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F52C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so1945358wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ciy3HDqvKk5PARaiKZGCtCw2SjWa+ryFuI+p7pTDJCM=;
        b=qUw4vwuSn+ptn4MbZwbW/4JcHgMoD6jfSrQjR2v5avUDM1fN1z5f4uplCFgKWNQsqS
         9aSMrqGg6d4qt8j0eitxmLT/3ywxOWQM76Vt5A3z+Ag+D2q4SDr3vNE+S46BDS2b9Be2
         p5D8baGzBdcaQyO8TRciSqYeuYLqn94NSm4twhD9ziglGI7ZcFB58mQwu2qAIo+EEdu+
         lms38xcgyOUDkJ9xnZ4/nLvXWMfCkA7dA9OkWy73/l3JO/RoNhesHEXRB6dITXHboR9Q
         m8+6N6pmfpBYorORnGQKIASx4qS+ecxsFpajjw/YQ0146QyzAuO5ExH1bD5iu9oHF3v2
         l1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ciy3HDqvKk5PARaiKZGCtCw2SjWa+ryFuI+p7pTDJCM=;
        b=R9GRn45wbz5qEbLUMkZ+oIuLf/BaJWQrhYfNLrUN3+sScEpGZtIz8iiZC03nTFxmU3
         9kBbqA8gKeWGnPzaE+mkulKvL9AYuwpeOaAwHwDqZ39Svq71mj/z13gzzmj0s/AyefJR
         pontn150/6rcqdNrIzp1m8DUGuCi3N5XDN27eRqt7/l63LITumTelVSHlBiyb5kQ25GY
         z70NgqrJTZu1p7+AII12HJBTXi5XvrM0BZw6R55Kx0XPyWaq5KHrkgoM34Q6EUneVk5c
         7lwhfpovohiBy0pbmlFfh7s2LwA3G51AagcrFBy5NPvoPb+bGH4OAIC8tql36o9raqEw
         P8EQ==
X-Gm-Message-State: AOAM531lgBvd15dEz1duBXmy7OvJYrRzpY9x+86OnscX3z7H+eVwq/F/
        vEOm3fogwhgou718ubzwrCM=
X-Google-Smtp-Source: ABdhPJxXQ2zcpVry+tBbqOjdH8BhqmMtk4qHHwoxi4Ph0toh3/O+Dx0OhluRkSrLaCze2KElp1CKFg==
X-Received: by 2002:a1c:4183:: with SMTP id o125mr134976wma.101.1594303408531;
        Thu, 09 Jul 2020 07:03:28 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:27 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 02/14] drm/panfrost: clean headers in devfreq
Date:   Thu,  9 Jul 2020 16:03:10 +0200
Message-Id: <20200709140322.131320-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709140322.131320-1-peron.clem@gmail.com>
References: <20200709140322.131320-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't include not required headers and sort them.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 1b560b903ea6..df7b71da9a84 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -1,18 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2019 Collabora ltd. */
+
+#include <linux/clk.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq_cooling.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
-#include <linux/clk.h>
-#include <linux/regulator/consumer.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
-#include "panfrost_features.h"
-#include "panfrost_issues.h"
-#include "panfrost_gpu.h"
-#include "panfrost_regs.h"
 
 static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev)
 {
-- 
2.25.1

