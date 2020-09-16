Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB02F26C9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgIPTl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgIPTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4CC0612F2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so3715760plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3pZ12hyTPUbEewJ2vo5m/+iaoNS+QCjKSOOA3CDCSbA=;
        b=uz9UmhCU59o1i0ZyaHwAVp/P3DPyDzCFGSNqI/pgzewML7SW5Iw+rwSRPblApPA85S
         6Y48LZ4ro8MjjqtD6eRWAFh8pQwGkK8+AleZGgf+DXSCvS4uZ/2GeNic+8xdKxhh1A6y
         mzFUM4RtJeJdAZR83Dsvakh6kSAz4uOjeqbzbHBGauG59xDq86+juLKcOcm9r+9OrxW+
         RUUys+ECWzZoJFSuM8jsvaf5NNRnyS1HlSkECXGPXRBF+xM9cZ/gS7IkJ0brnLwqGODp
         3bEMPqbsuhuNEjtvxlNVKmwe5RVDNMLuW918kVVbNL/rQWReInaoVuCTfQUVcV4i24bY
         84Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3pZ12hyTPUbEewJ2vo5m/+iaoNS+QCjKSOOA3CDCSbA=;
        b=XTPOvIdgyKMjXlnEasdVZC72x9jL+RN0104r6yRd4InUzp//5o37mJDB7jtF1kYReo
         zIDb1TZo7mqi89uKlEH2XNUL8I0hdXD2yymuiQ82TpUMGKIb9mnmKiEhz6NBSmt+D0Xh
         Gcqh7BlF8uxwnU12EOE0P1LcIqysDwOTxbGaZ4YMFOSnH71wt2NPx/Qsry2fs7rzUNvc
         mhpD/yUr6G1ZZIbrFGRYGY7f2Kx/mGwjY6bRVrskn8wqlLfN/gjyUwrOAFE2UsDT3jOp
         KuWj5WX/Q32P9u27ToJQKZxKT14JKipq3nz3x3rYZor27N3LWgNXpveFoUmh4Ji/g2MD
         8eoQ==
X-Gm-Message-State: AOAM533HzDv2W9OW/Jur/Qi3CZXeNEpRp4jGAST8HGLQxuziQ/grojBO
        SygVOZ438djUEwLfl0ss2ps5qQ==
X-Google-Smtp-Source: ABdhPJxbdvq0wppKGz04055Y5+Xt0cmUDntX1qlg5ZVAhPgd+wbp41Lx4eRytRYrTTtXiPCASRM4vw==
X-Received: by 2002:a17:902:fe98:b029:d1:e5e7:be1a with SMTP id x24-20020a170902fe98b02900d1e5e7be1amr7927010plm.77.1600283873686;
        Wed, 16 Sep 2020 12:17:53 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:53 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/16] coresight: etm: perf: Sink selection using sysfs is deprecated
Date:   Wed, 16 Sep 2020 13:17:34 -0600
Message-Id: <20200916191737.4001561-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linu Cherian <lcherian@marvell.com>

When using the perf interface, sink selection using sysfs is
deprecated.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 9d61a71da96f..b4e5758b6c12 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -222,8 +222,6 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	if (event->attr.config2) {
 		id = (u32)event->attr.config2;
 		sink = coresight_get_sink_by_id(id);
-	} else {
-		sink = coresight_get_enabled_sink(true);
 	}
 
 	mask = &event_data->mask;
-- 
2.25.1

