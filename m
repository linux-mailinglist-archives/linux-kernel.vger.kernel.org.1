Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4B229D409
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgJ1Vsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgJ1Vsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:48:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0297C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:48:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t3so652278wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qzgYKCsiMnXsmskR2AeWiZoW4TSnZRw9RpEp8cpRUVw=;
        b=zxa2ZHORY/A1Hr3hXOTaXqDjjIcP/pSLHPanPTJq+q08uv+4c7dgB5z5XrtECu4TQH
         egJMTGCQpVLL/2QX/6D5LL7cH/1v6elTs5fiOkKOWqWqaFgEvxB/xaSkkTXmpS61TieF
         r/zyhYeIEmYCZaUJPsGj7p2w7+c/lPcj1esiLkyrV6pWuYfzGIP4dt73r14bT2/NiATM
         +1eJ/Ho4IKlSCSAQ3EjGhc4OrYh0vMEv1PG7O6nrmydP15LWHLEYPRR5WcPnpzT/jdAo
         OGmda/NjACcen/ScNKdvYz8Y8DigfN3LzSZ6evYtbeCTmzVPy5TmkpQLxrYKI7jbOrbJ
         kZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qzgYKCsiMnXsmskR2AeWiZoW4TSnZRw9RpEp8cpRUVw=;
        b=NmAjiZ/GACrz5JB+ct/Q7VnHMSSVn16NZiqZbGX+VC5TnCMnOZcXOwenBQqP61r8rZ
         ztpyJjp5zzFczttrwaNNwA+80DaJwBNYIXzcI65qJzm2d3da8nlMDW/iapuTNdxSpmKq
         G+kk8SvxJFsTxBtGDBZ73OBJcalqYFaWV8tOBsebflC/YpIs2fpa4zCbuIScHMvgBuUY
         EUgQAGROoCRyyIAbOL7rlWzc/z/Fe7PtTmvVT0+T/IKdbNvo8FxMtvW4DgzUr591LQ5Y
         CA3AG1uMkhtaQb5mVR+9ja5vu/o0PHb9iPiOANrQY3YW0Zh18qxMlBpW+ZeXA9Vg1xJQ
         rKSw==
X-Gm-Message-State: AOAM532L0zEGoDhwf93rLxrrB2lwEgzaVWa05QUjDLRSAb6mwW1gIRVP
        JMQtJofkAAW/Q8zrLoAMAwGpa/qAYLjYWQ==
X-Google-Smtp-Source: ABdhPJyJ7qJQ1CG2LCPBx9KM44hsM8+B9d4qehnbpLRnkp+zVDEweTVPGs84koksBhyMdRzWQnlwWQ==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr618021wmi.50.1603906984838;
        Wed, 28 Oct 2020 10:43:04 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6801:1801:1071:bc1a:781b:f835])
        by smtp.gmail.com with ESMTPSA id o4sm405104wrv.8.2020.10.28.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 10:43:04 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        lcherian@marvell.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] coresight: Fix uninitialised pointer bug in etm_setup_aux()
Date:   Wed, 28 Oct 2020 17:43:01 +0000
Message-Id: <20201028174301.15033-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit [bb1860efc817] changed the sink handling code introducing an
uninitialised pointer bug. This results in the default sink selection
failing.

Prior to commit:

static void etm_setup_aux(...)

<snip>
        struct coresight_device *sink;
<snip>

        /* First get the selected sink from user space. */
        if (event->attr.config2) {
                id = (u32)event->attr.config2;
                sink = coresight_get_sink_by_id(id);
        } else {
                sink = coresight_get_enabled_sink(true);
        }
<ctd>

*sink always initialised - possibly to NULL which triggers the
automatic sink selection.

After commit:

static void etm_setup_aux(...)

<snip>
        struct coresight_device *sink;
<snip>

        /* First get the selected sink from user space. */
        if (event->attr.config2) {
                id = (u32)event->attr.config2;
                sink = coresight_get_sink_by_id(id);
        }
<ctd>

*sink pointer uninitialised when not providing a sink on the perf command
line. This breaks later checks to enable automatic sink selection.

Fixes [bb1860efc817] ("coresight: etm: perf: Sink selection using sysfs is deprecated")
Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index c2c9b127d074..bdc34ca449f7 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -210,7 +210,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	u32 id;
 	int cpu = event->cpu;
 	cpumask_t *mask;
-	struct coresight_device *sink;
+	struct coresight_device *sink = NULL;
 	struct etm_event_data *event_data = NULL;
 
 	event_data = alloc_event_data(cpu);
-- 
2.17.1

