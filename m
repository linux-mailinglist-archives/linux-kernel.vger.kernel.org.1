Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E60296148
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368355AbgJVO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368331AbgJVO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A3C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l15so2628050wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CssZFc/e+l0lGTvpSYokUTg26avKPR7oQNMtnwD/hxY=;
        b=Et4/gkzxcmESU90Eqtzkz16Bl42HpGVE/8MncSb6YQvvbWEiIbeg/G5EgN5JyjaRGK
         6knEVcs+zVxQhAO6/ZG1f2pxl1vW2SYDEddCU0YXYN8zR1PTzmLTF9qkEOAVbh8+b3pg
         PQ/X2aBKf6OP+E9kohV4KNuopclJhDTf+fNPEe+BjJ6/EZrrkUS2RJYzg4YIGurw/A0J
         CiqCufraTW5JtVazXumwcNEfMfCTmJc4mjd4KMsOmSDatHYBdvBTptnALX+3bBZ3ZzMK
         ScrEoUblhzHQsysdJQ39HzgHgPGoq2IpzRHzyL9i6HWH+9qGZVP9jvtxIkkQMhjkPzqC
         0/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CssZFc/e+l0lGTvpSYokUTg26avKPR7oQNMtnwD/hxY=;
        b=ecS/Rdv+UTXGz0Usg43DUHj0yQZKHJWdLPgl3s/NGAQybxGeI0qRzuOc8BPrUOUaE/
         reCLhRGU8iAWw17dSsAxMmf2Fn8626GuSAQj//OmRgtOT2NdHwWQqoyIWGLrKbaQ8TeT
         ME4cPYVg35pJKR0CctG332ZCtPCXW910OYeZllMljVbdnwG3sXJbEVDTtORwkFE6291q
         0D1wZWzqp5Fm7qZY6vu6OtCu5tZJib26z+1KletdV5h4nrPmYzukHXI32zm8i6xYngDc
         GP6vq0H8O3uCJKl7uZoKG7hE78hx/w2vYW36nysmfp0i3xXNYJ8UVTBeVo8j+KFLgZYm
         0cYg==
X-Gm-Message-State: AOAM530bJFD8+jbAKFGgHJEFRPhz6LNJQNzC1tj81eoS9zmnDpYH+u3h
        lEdiAjlqTVzVVWN0IkxPFXfF/Q==
X-Google-Smtp-Source: ABdhPJyNvJbwyonOgbEi5U5RbpbYHiboI8TSW2Vt41npBujSDnSbXhZnlMHANx3kYqEgc2vJNrLuwQ==
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr2924609wma.178.1603378714594;
        Thu, 22 Oct 2020 07:58:34 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:33 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 04/20] perf arm-spe: Refactor arm_spe_get_events()
Date:   Thu, 22 Oct 2020 15:58:00 +0100
Message-Id: <20201022145816.14069-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function arm_spe_get_events(), the event packet's 'index' is assigned
as payload length, but the flow is not directive: it firstly gets the
packet length from the return value of arm_spe_get_payload(), the value
includes header length (1) and payload length:

  int ret = arm_spe_get_payload(buf, len, packet);

and then reduces header length from packet length, so finally get the
payload length:

  packet->index = ret - 1;

To simplify the code, this patch directly assigns payload length to
event packet's index; and at the end it calls arm_spe_get_payload() to
return the payload value.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 4294c133a465..f3bb8bf102aa 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -136,8 +136,6 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
 static int arm_spe_get_events(const unsigned char *buf, size_t len,
 			      struct arm_spe_pkt *packet)
 {
-	int ret = arm_spe_get_payload(buf, len, packet);
-
 	packet->type = ARM_SPE_EVENTS;
 
 	/* we use index to identify Events with a less number of
@@ -145,9 +143,9 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
 	 * index > 1.
 	 */
-	packet->index = ret - 1;
+	packet->index = arm_spe_payload_len(buf[0]);
 
-	return ret;
+	return arm_spe_get_payload(buf, len, packet);
 }
 
 static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
-- 
2.17.1

