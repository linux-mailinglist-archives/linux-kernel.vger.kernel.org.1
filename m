Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A02272B29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgIUQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgIUQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:10:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E366C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:10:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so43836pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3OCoOb+JFwXi2wMv6xbpF4vbDUAK9pGDZl8s+55Ok38=;
        b=BE73T3S/tyHZjhE/erv6+Fp2AzREMLo2TCynxaqXuZRJ64fC1pcsvc7VzbKjwO/I7o
         SH4cURqL4vpii33opB9A96M8Q3WRE23pR/GUhB7o+WBdHu0wbtn4DfI1rMrTeSa98Pjq
         BWP6EDopO+LBlrpZQG/P8oHt/36a6oiugbaWyU8eTE3pvuLvdUyOLmMOfu+tKWpuUtYX
         jTthi20LmO17UXV3MbexJ9FdLsv0BHCqycRGmnmwNE+B63Y7esj5GArJ8SkTkO/8rHmv
         d/bwW2iCufKpWspTgVe1D+N47MUmGBWcPhxPLI/QpQTSP6tKbaCKfFm7ZRQTqBKR0iDy
         P4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3OCoOb+JFwXi2wMv6xbpF4vbDUAK9pGDZl8s+55Ok38=;
        b=Rm+juu6k8lSRuV8UWTCprTuCusiCqfBQnMQMNecs3KYUdNRz0721fnGfW33EAnUnKc
         J9RXr5cRlZdVbrJnLmlORo08TaDkcBoMViRSYMN/kkwHUJz5R91jJCKepQ+Y6U0hzhZ2
         jnObxoRBcgyuvTxJ0KTh5QeHaN6m2+Fokw66/9w6fW6Tb3C9bmjnnZoP6wvPDeUp2t06
         c9afFmvuHq3zRwlqr57Kz5I1GxUlQ9GeNWwKylbjYsn5XNyA5KT+qd8IRJEBC1FV6d8u
         VdmGwH8sMHvt38MYI2FTC/1D0L1rM8jL4cGFKtujNMTzK5aFlKSHKETum7mrPKiAekFn
         ezQA==
X-Gm-Message-State: AOAM532aGuq2Rfaz9GNtT/I58nQDg9JbaboiHdlLSfpJQ9ORl8m84uP7
        gheCbeG9Uu51n8UUcSBhJfs1
X-Google-Smtp-Source: ABdhPJwpaVojx96jHcOWdx4H9eqAKTLKRQrWAw93+bEo8d17Qa7gp75oKV7hpU7GXAM3XfoPLDiNIQ==
X-Received: by 2002:a17:90a:e60b:: with SMTP id j11mr132113pjy.38.1600704645585;
        Mon, 21 Sep 2020 09:10:45 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6d03:bd12:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id f4sm9204577pgr.68.2020.09.21.09.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:10:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/18] bus: mhi: Remove include of rwlock_types.h
Date:   Mon, 21 Sep 2020 21:38:09 +0530
Message-Id: <20200921160815.28071-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
References: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clark Williams <williams@redhat.com>

rwlock.h should not be included directly. Instead linux/splinlock.h
should be included. Including it directly will break the RT build.

Also there is no point in including _types.h headers directly. There is
no benefit in including the type without the accessor.

Fixes: 0cbf260820fa7 ("bus: mhi: core: Add support for registering MHI controllers")
Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/linux/mhi.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index b2c0214bfbd6..008b8f6fa9ff 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -9,10 +9,9 @@
 #include <linux/device.h>
 #include <linux/dma-direction.h>
 #include <linux/mutex.h>
-#include <linux/rwlock_types.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
-#include <linux/spinlock_types.h>
+#include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
-- 
2.17.1

