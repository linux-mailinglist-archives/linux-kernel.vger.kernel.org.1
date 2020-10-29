Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3E29E460
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgJ2Hi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgJ2HYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2B2C08EADD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:19:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so1613746pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ggrCrrOmIGShBF925Jr9ht3p0sf/ZpOgGfgHeELSUDk=;
        b=xG8AUg5lR9UPuIl5/cQbxr1tghs3wB2JkaISrLmkaEntkABNL8tAmpY1sJ6c3hs/To
         ByjAB4lw2dypASpZ29fwoHB/exjXNua5C2ExKZZGr7d9AqRLuBq0fxZ0FFVqGTl0ay2P
         rvr+7V8pozNdradZmBndARy4+ITiPJlin48FORPQ4NNpEzruUevi0PI/ydfgcdyjprC9
         NsYsPe/MuPc5hv1EyX5TWazaJK2JNZcya1bT2DeTo6L00u6csRmsiARKFuDudRQyuxOn
         WCQ8NIVAWqYVkFrOpC33rIY2C1Uk9dM0tyUms2yYQ5RM5wsnLGGk8xUZD+WE6lmPwknX
         c4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ggrCrrOmIGShBF925Jr9ht3p0sf/ZpOgGfgHeELSUDk=;
        b=UDlO9ajgnXl9uAjIvIaOjlAlNrLjYE0HhMT0V31Y9023jVcVANp71/GCv/TsHrydPR
         T6zpHRE1zAqMYX9wFYHjBxbNyftsZ1of6E56iO2fz+n34BD8A5l2R1Zj1byHvrEg6v0k
         kpdF43sZe9e3R5PGaeYk8/l8PE+rqDjcO9ShOecgzOO0W1gjRuUkQ+9xW6gb2sUSy8qx
         cLaVMbn88XiKlKu0G1pGzUDAl5X0GADWAwoTKCVFDE0MYSGT0VA3PmNHlzIFWPjZwOFX
         f36BRzJrU9MC2wcLa/HxmZN1KEXYxRg3wgyYemGe9A/JDjD5GdBPO47sbYm9Pnq639Qv
         o1Xw==
X-Gm-Message-State: AOAM533TkSd/wtoT6GiSASh+JpFzigOvRdHE2XWc3+IGr8gaEWjF3h5D
        Vaj1y3jYGQhT9vrq/PMYnjqMwg==
X-Google-Smtp-Source: ABdhPJx3I6B6twptyk6ZR16UuTALAp10mUQqmIZv8X36qH2UceadHFqVa7eGseVs8INUT6+UqkBFdA==
X-Received: by 2002:a63:4d0f:: with SMTP id a15mr2829341pgb.250.1603955998971;
        Thu, 29 Oct 2020 00:19:58 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id u5sm1633792pjn.15.2020.10.29.00.19.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:19:58 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 04/21] perf arm-spe: Refactor arm_spe_get_events()
Date:   Thu, 29 Oct 2020 15:19:10 +0800
Message-Id: <20201029071927.9308-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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

