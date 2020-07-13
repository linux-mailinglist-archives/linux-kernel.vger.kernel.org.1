Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0621A1B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGIODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgGIODb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32651C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so1939486wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkW9l8coJNpZK7uX8c6xzFbB2l+pGmfP62kLElQGlUY=;
        b=W+v8x9+FNPWAzpyi5MQPB137c+NQkkyrDsBman9ISVngwRPnGJzp0t8AEW0o+7nM+F
         Y00ECIFPX8z+r8390mu7JtnC+/G2lNt/VpETuByq9w66musgFxqBf0G3AFYSx7WAuYpc
         pol244/MK4olowGHH2GjWw3dMA9gbFkkswKYKkCGNtgNNKS6eyCA06El6ujw7BDlWi6Z
         jiuplLH27xfXHm5o0Vn/B19yq7/+Y8gdWpWQos668zhdX9d2PevOtHIxvyybq5fRGFRF
         dZ3YsugPsbm1W7okkJXJ0EADWXPZ4XkRxZ5rAhjCOl/MtP/sGn1sALP/KGND+8h9BxT6
         F6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkW9l8coJNpZK7uX8c6xzFbB2l+pGmfP62kLElQGlUY=;
        b=nuEQVkhDaRDb+1e08oKOjGcnbqlePk3zu7DEDgD7Ec6WVF2TFxmzh1yNQD25e+2Few
         7kKYfkcN3nx2WVGiNNVaZR6G4mkDaQmtXg+uAvjU22IWhjLBV3/OyDZfo8djIl+1k8Yc
         DJHHHRQBnJXpwb1S/EjIxoLSXxqDexMeXUL6cqwB6n/LlXomIWBCB59/pqF3JUsiWryN
         YzGZJ+wstcnMDwYlAX0xzINDu7Wzvpnw2KLleWZxy8E714Eger5JajBMgFX/2Z6aUhbT
         jjbnfycziGNSxkHMClpT0qgbQH6rBsSG99ojkJEevyD3y/DLLnsv4iKct3BaOaiH4Or9
         wevw==
X-Gm-Message-State: AOAM533J7WLNNCP3ud7ua0fuyMMkL6ZfdHI0r2uqPwAYshUW1HfYqZgI
        KSZlnG5pjzaiHgJXxE/IPmo=
X-Google-Smtp-Source: ABdhPJwbsZeBCrJpIlgXGSJrKOqiQ7CzbHa36MSGND6Bj1J3HOXltsXkbGpTDH2sVn5b4QQN7SbBjQ==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr189941wmc.60.1594303409857;
        Thu, 09 Jul 2020 07:03:29 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:29 -0700 (PDT)
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
Subject: [PATCH v3 03/14] drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
Date:   Thu,  9 Jul 2020 16:03:11 +0200
Message-Id: <20200709140322.131320-4-peron.clem@gmail.com>
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

This use devfreq variable that will be lock with spinlock in future
patches. We should either introduce a function to access this one
but as devfreq is optional let's just remove it.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7914b1570841..63e32a9f2749 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -581,10 +581,6 @@ int panfrost_job_is_idle(struct panfrost_device *pfdev)
 	struct panfrost_job_slot *js = pfdev->js;
 	int i;
 
-	/* Check whether the hardware is idle */
-	if (atomic_read(&pfdev->devfreq.busy_count))
-		return false;
-
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		/* If there are any jobs in the HW queue, we're not idle */
 		if (atomic_read(&js->queue[i].sched.hw_rq_count))
-- 
2.25.1

