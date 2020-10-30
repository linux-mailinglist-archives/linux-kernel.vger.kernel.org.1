Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5B29FBD0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgJ3C6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgJ3C6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF64C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x13so3973608pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ggrCrrOmIGShBF925Jr9ht3p0sf/ZpOgGfgHeELSUDk=;
        b=Vu4z4Cqln9FGVzr7ocIV2iUz9NosWL3bVBrjundp4l4N9WZ0JqbQbhpz6O6foDwMuO
         lPZQOsLUZK4uO+V/pAHOoTH0qjBS6uJ/Hh0PHjtBjd0hatISqCfckYNYFHrdF01jYdv6
         Kq1BgBosv4KweYIXgyvNNG5OfVi3n/VIf9rW2I+AfoMpVyH8kJXGj8wjXlQ2dVOF3TES
         BETLhm4q1J8ipMBmvMH/6gEp6HrDfJ9oaT6c4C98G0XYlXgbqE3vcMtNnb/R523eppyW
         4xXWzK7H97GsHaCZT7dxJVey1wXRYqMYjs7UlSXpdkJ2jLUkWD/oZoSPCQc4NWPE/P+F
         jt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ggrCrrOmIGShBF925Jr9ht3p0sf/ZpOgGfgHeELSUDk=;
        b=RlY9U4V3W7VF9QPnBDCX2WsT7td9xM01JM3clesBAASWw5kRjnMwa5iZLK6eLv81LO
         UfF83HOTRnmRgn5Kx8vhRhLiJLz1furZT6wO+RuhDH+rsr8Pjp4wfl4mFWhWuEq/dzG0
         dVkgkILs4Ris0fR8YA6ZLFFI55CVCXDIVIX4ghAb79Rl8VkZOcAjLS/b5I/v4Lacf9T0
         nl6wjDQnK9k8wS9RhpGP0GR7PuMDZVC8L03kazG5qbIkV+Z4mCzL1/tyeByN/mf0KFhR
         9Ayz3vnsHNPzxtnUH17qAumQR1MZ1kgdB5euPphISzmSF0wo2CtfeaD74PnTlaDE3qFp
         C8KA==
X-Gm-Message-State: AOAM530+OczLSVDkeIz8ZSmuT1a0J9jFJEoH1OyAXy3RUvSNpCwqg3z9
        Yfn4JWUnK5x/45lV5KBkX0C24Q==
X-Google-Smtp-Source: ABdhPJz42MmG17roSt+j4+pcGFvo/MjAn6NGD/ul2IqUvZy9VIh2gmDUv5ep2GD5ic73p4iJdKAiQw==
X-Received: by 2002:a63:af08:: with SMTP id w8mr281450pge.419.1604026684582;
        Thu, 29 Oct 2020 19:58:04 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 145sm3918986pga.46.2020.10.29.19.58.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:58:04 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 04/21] perf arm-spe: Refactor arm_spe_get_events()
Date:   Fri, 30 Oct 2020 10:57:07 +0800
Message-Id: <20201030025724.19157-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
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

