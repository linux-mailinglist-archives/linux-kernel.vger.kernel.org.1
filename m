Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487692AE9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgKKHVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgKKHNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:13:52 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BFDC061A04
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:09 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id gv24so252048pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J3PGGD7UkKVLFxEYvztjP00F73+2coedCJ1RfmETQT8=;
        b=DqxX1qaIOEplecz9OFokxJvKLHoR73AWif1ZFF+azKXsurHyxYmCbIdF/TAZqY2Ing
         ZKoOdl/a4q4naY0vpZLP1g97PgZ8+8AF78kRYVPnfS60D6dMiev0pO7Qr/HEhwXfSiVN
         KFfXt41ydna2oUcwQgPZJXfXKxW6iEy8XesMz3L4o64TiiXFvkN6TgFxJWzZiz0m1RKw
         cSdQckxaDZYFr+PQWSoIPqklJ5c7gI9Dzjo12/aycrn8Ld2HCCnxCa4q5AAcNB2dmdQg
         QYKFWNXKXoI/1ekHNZ+xon6dztzyOp1Ntl8ie3uIsldJP6mSL4aehRi97RZAjSFh7Vjl
         xmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J3PGGD7UkKVLFxEYvztjP00F73+2coedCJ1RfmETQT8=;
        b=qzCCWhoP5c+RY1avNjLoMDzFtDwGp5OSA0Pok4+iKxvGUnP69tXKl4Xh3PYT+7OUxk
         gA5RLExqqugScYY7pMKeKPzo8GA0C4/GIkIJX+ic7yOPqp8xnG5iZRe0oeUGBOzGoTr4
         NvJ+QsUUkamJ63izZPgNbLPpgZ9+T5H7FX5eJ/5V/V+oCxF9w8Uj9xwQ39UxYVR8lDX4
         7tYE/RiVGo6WeOb+q8tUUxwbjvp8aFp9ljsSg+jwhLO+3WqEqyS/bjhZEL68qWKIAQor
         lnG3EU+FWhOoewEEzag3psbj8S+z+OEv/0ibX9BUhH+ZmuPh+68owxoIdd9xt2cngW5s
         WQnA==
X-Gm-Message-State: AOAM532VLx8bUI+ptmUquecMm8B0I1MjadkbfallU52EXO7GlJGtNekx
        Hf/Miieh9tQP2VV1JCi5WlFKrg==
X-Google-Smtp-Source: ABdhPJwYlcsgX1bKJri+Hb1Wg1eGFtp8HBajwCEHEibnHYCWM0GkhqZxtH1aZDcIBR1BPwVgCVnWIg==
X-Received: by 2002:a17:902:8a87:b029:d7:cf56:ce1f with SMTP id p7-20020a1709028a87b02900d7cf56ce1fmr16479550plo.22.1605078789145;
        Tue, 10 Nov 2020 23:13:09 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id k8sm1339643pfh.6.2020.11.10.23.13.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:08 -0800 (PST)
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
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 13/22] perf arm-spe: Add new function arm_spe_pkt_desc_counter()
Date:   Wed, 11 Nov 2020 15:11:40 +0800
Message-Id: <20201111071149.815-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the counter packet parsing code from
arm_spe_pkt_desc() to the new function arm_spe_pkt_desc_counter().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 43 ++++++++++++-------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 7b0f654e5cd6..e8c9da1d4280 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -322,6 +322,33 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 	return err;
 }
 
+static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	const char *name = arm_spe_pkt_name(packet->type);
+	int err = 0;
+
+	arm_spe_pkt_snprintf(&err, &buf, &buf_len, "%s %d ", name,
+			     (unsigned short)payload);
+
+	switch (packet->index) {
+	case 0:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "TOT");
+		break;
+	case 1:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "ISSUE");
+		break;
+	case 2:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "XLAT");
+		break;
+	default:
+		break;
+	}
+
+	return err;
+}
+
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
@@ -414,21 +441,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 				     name, (unsigned long)payload, idx + 1);
 		break;
 	case ARM_SPE_COUNTER:
-		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
-				     (unsigned short)payload);
-		switch (idx) {
-		case 0:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
-			break;
-		case 1:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
-			break;
-		case 2:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
-			break;
-		default:
-			break;
-		}
+		err = arm_spe_pkt_desc_counter(packet, buf, buf_len);
 		break;
 	default:
 		/* Unknown index */
-- 
2.17.1

