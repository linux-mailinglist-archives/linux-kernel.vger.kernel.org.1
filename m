Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4277D2A8C30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbgKFBmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732743AbgKFBmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:42:23 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB3CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:42:22 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so2837606pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ggrCrrOmIGShBF925Jr9ht3p0sf/ZpOgGfgHeELSUDk=;
        b=Essh9JIZrqPvXOWsM7F8jE9vTtA+EVNTfRO5eiq0JBkNeNbxUbAhfWuMyJkXhtXFOi
         5rseCgYA3IH+Q2/iyAxsjXnU/7gEbQbf8gtkny0yaYKNt4kCY8LCvC8y6jH2oV+ywoGO
         Oneg8to9GgOehDKSCwV7o8TG+HRULrDyZ8kjnjE/T6b6k0KS383W6715stHPzRxcLpRz
         Xj3WlgOLYYYvzG5+KoqfvQXXtXQU8SVD6p1m7Xn20KfArSmiXoJ69IA4zjRG731ghNgK
         N7WYI+wRFsX1hNmCNHGMeSMXZasoP76tv8LI0fLODyZFYct/IQOa5M6eTPohCK9m2bwI
         rofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ggrCrrOmIGShBF925Jr9ht3p0sf/ZpOgGfgHeELSUDk=;
        b=WiDQ99DtaCDDsyZeVEkRkkGBgglzloC1k4/aa1t6/+ex1ZQLRns+7x2yWa2dbHtNmB
         5v9QD5pg/p+h8fRtmL7E77IoVxwQX8qmvkrF2JOqIfBl4pdwHCNryr8S4j7HwuDucPzc
         5c8PVOGRRQHLR0z5+0i3Wk51NDIkQdsWLv6yJi3bDZO719eMcHv6e3Hlib9ZtMLie24L
         auOO8xAxu3pCufSjW6qXjxbShJa9sfgsJvwMGSUP/apuvd8oL1zZxXFpsg/Vcf3AGfVl
         L8BU6LkisAC0eMhNRBPyzOsblLYUwDVNjf/X1lHO+1nllBpKraWr9fEK9JTPE3+20UK6
         oxBA==
X-Gm-Message-State: AOAM533WNaUxBzHhlDIY3cM5lc0rAR9moGkaTlavG+2LpSjyYWvhyPqj
        QITEc+qAblwcV12DIHqHdETbcw==
X-Google-Smtp-Source: ABdhPJwmWnoGHdVeNeiSjMg/ZMW3Moquqwubxa5LVPi1A4ay4ZrPLez61QKw8c0XGxVa0XIcR5mJbA==
X-Received: by 2002:a63:d24a:: with SMTP id t10mr5100740pgi.344.1604626941605;
        Thu, 05 Nov 2020 17:42:21 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id t64sm4182516pfd.36.2020.11.05.17.42.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:42:21 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 04/22] perf arm-spe: Refactor arm_spe_get_events()
Date:   Fri,  6 Nov 2020 09:41:18 +0800
Message-Id: <20201106014136.14103-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
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
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 06b3eec4494e..f1b4cb008837 100644
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

