Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69329F209
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgJ2Qqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgJ2QqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:46:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8404C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:46:03 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g12so2810458pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7bva0Kz5DObj8A0pJjXfLrYcgFYUG/4s5PLhbnBJJc=;
        b=Vb8sYjuSR93wpGAF+QW0qHX6s7Ea1wJO2JmanNX1/eJtv5JwhWxpqjP5GWKdH9LKvv
         BETIVmS99TGyeZ3bRHFC1roW4rSoFaPFVwwZNsEQUsscS/IFkfHqOacJ6t5P1sYIW26k
         51mlN3bfEou4WLzpIBP+E7kuppgdUvtSGemNTHR1LuvUp57h+uBWwmf8gvKpDEdHO5jh
         CSpeSegN9Es7d3ndqvSdx3vtPP7gJBZuUBziN35gmeB/Ek9NBIXaQ35Q9YqGrojJHMWR
         DeLLC78exKMaJLyQMhWSOKEusnnkcixn4G7hCKwEDxWjNPQe7Ugd8PZPJL4bjm0hmOfi
         ChRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7bva0Kz5DObj8A0pJjXfLrYcgFYUG/4s5PLhbnBJJc=;
        b=n1rQea9ybV+8YkUko0ye7D0PPu0AJQ5gUiJWjDhayWBOJ+0ukm9czerNO2p0Lm2Fga
         obsuF5JDiYE5ZhdIa4K7lyBue/U4BbmwqMGusEL3sixOPBF6OzZ6ugbJqKf4EmMd8Nrb
         r5ZamYUW2X2GsZN9Eof8zDqXsAfFhnmu7oocKTrHgWafU0dg2Q4HnMMFikxXAhplVxs7
         5eYF64IKutZ8dXVZtWSPNup1UNPsLWQao308aAcPgnUkinXZz5W12LhfcJuoPqB7+0di
         LOTSoAFkF9YCNmrFix/vp8kARGk1ZRA5GYn7wXkliggxT8RiC/5ICo2AZa0HAWprl63I
         0AbA==
X-Gm-Message-State: AOAM532u2d/wnNSVl8PNsVm/C2S4/u5GlWZE9ZkLIMmQYpDBRwNenZ7b
        FA8yOsoMU2dDxTN6hRtHTDggug==
X-Google-Smtp-Source: ABdhPJwxAWLqmCga1pWNt8vcAjFLdgfeSA5KToKbMHjzF9UQcsIIyVtH/PnM0x6V0yr3EAVOwjnyJg==
X-Received: by 2002:aa7:8b17:0:b029:15b:c0ba:f2f4 with SMTP id f23-20020aa78b170000b029015bc0baf2f4mr5126512pfd.22.1603989963483;
        Thu, 29 Oct 2020 09:46:03 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b7sm3625415pfr.171.2020.10.29.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:46:02 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] coresight: Fix uninitialised pointer bug in etm_setup_aux()
Date:   Thu, 29 Oct 2020 10:45:59 -0600
Message-Id: <20201029164559.1268531-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201029164559.1268531-1-mathieu.poirier@linaro.org>
References: <20201029164559.1268531-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

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

Fixes: bb1860efc817 ("coresight: etm: perf: Sink selection using sysfs is deprecated")
Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.25.1

