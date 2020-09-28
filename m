Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D3C27B1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgI1Qfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgI1QfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3214C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so973639pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKxXl3MciKAKZSXIF+TmSJQtPsXbnsXWSEMuZ9mJPpY=;
        b=wX2X5i59Q63zjV8FYOMQuBp2F1hmgrLrZqqrLaKd4BDNrFbhimrmks4UAk17E/DdEs
         0b3VI/DqBsXAS9EKSrgz4xpOwh/vYMpG5MQnmTbfelr5mKyG6t/Pj+QJTxGGC3oyAd7d
         Fa9fVMlDS3nHJ0ZuHq1Xm+0QP3tTrmrdvlsM2epdkuUd5WlhVCHLzWQ7EoTMxlX7JZFq
         8ExavDjFgiiwaQ5L6cXoQYvbqkl/IFVHVoD6aGO0HSyFqo++UiNjX7og4SNffWb6oZ4z
         vEPhZJ98iwTd5zQHZlCNvraJkehqL6SMQqG75AOw+eeEjW3mSA6ZS/E4ERKLWBsnoe0w
         OcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKxXl3MciKAKZSXIF+TmSJQtPsXbnsXWSEMuZ9mJPpY=;
        b=RfIphKXPcDjlM9nAD3VahKFphT2YzFTDi+HgjHj+F13MDFqfGUfIcWTJ6oJjUvQvK1
         FNzn3CkbcNhkClDTsfScOo6dy/32bIaSQtDVLXjCLuDvOvA+thHQVcdQMz4YgqaBqZll
         rXXQaAl2vQxbCpV7ddewJt5C2Nghmb1bpeYUsyfFGGXwsYVI9meoxhSrPw/bwdy0vJbv
         vfvmeM/P+voYc+8l39/MLJnybY/csIdZVWOYPuewk+SV85mxHqWGnchVeX5/SuwnlF3D
         4kE7TlC1R/rzp5LaT+BxVR+ySD/upViPX2qGjXy8v7z7BNScw+zO4iuYqPoGu6UHb9vB
         0a+w==
X-Gm-Message-State: AOAM531Sf5PnWm6ZFE+WDgEa7OGiwKdkVOwmlPc3RBuYEXyGnKC58uIe
        Nq7hrr6QX5wkLlB6Ydlbz6syvw==
X-Google-Smtp-Source: ABdhPJwrpxepEEUzeifXDPbPFvqwiotsmJUpk/W7hkbqpR5y3xYF10rN2TWZlLJ0q9069FY8ZMGULg==
X-Received: by 2002:a17:90b:1988:: with SMTP id mv8mr133408pjb.23.1601310923548;
        Mon, 28 Sep 2020 09:35:23 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:22 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/25] coresight: etm: perf: Fix warning caused by etm_setup_aux failure
Date:   Mon, 28 Sep 2020 10:34:56 -0600
Message-Id: <20200928163513.70169-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

When coresight_build_path() fails on all the cpus, etm_setup_aux
calls etm_free_aux() to free allocated event_data.
WARN_ON(cpumask_empty(mask) will be triggered since cpu mask is empty.
Check event_data->snk_config is not NULL first to avoid this
warning.

Fixes: f5200aa9831f38 ("coresight: perf: Refactor function free_event_data()")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 644805e0a9ec..47894a0dcf5e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -126,10 +126,10 @@ static void free_sink_buffer(struct etm_event_data *event_data)
 	cpumask_t *mask = &event_data->mask;
 	struct coresight_device *sink;
 
-	if (WARN_ON(cpumask_empty(mask)))
+	if (!event_data->snk_config)
 		return;
 
-	if (!event_data->snk_config)
+	if (WARN_ON(cpumask_empty(mask)))
 		return;
 
 	cpu = cpumask_first(mask);
-- 
2.25.1

