Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5232B9620
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgKSPZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgKSPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:18 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC092C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:17 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p6so734800plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oR0P4SqSunF7MLRCBYZbypsc+vvGTSsTPUDSK1boJO0=;
        b=SsP81HhvvUdeLLrVeQ+9w5LXjOHGLDiJq4TJ+E3Jm1Qf2YLAmwOZWWVNndlS86NMG3
         CZOs0OsvdzQyhdtifjw4wf1i/k65jpt7skUB1GdmA97rQZbPskvBTOSTfgdHT6Ajy65M
         JLShaGLZbXGdxBk/5i9l8SUV6UjPTk/oY5+uMU1qbfjleo4sUuWMNyJTXuYGJ/OzNKNi
         HkOvWkp9yGIFr4jIj4OPVPEDxS8DhplHQDe5/LQLb6pnR9efKXBdhxVt9Srs64E4sA3p
         IjFTQXdTxnEpQmBZrUclNaH+cm6seo7Fq1A2GttgwGWOqpvhAIYD/yJKLR9v2iN0nbbk
         jlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oR0P4SqSunF7MLRCBYZbypsc+vvGTSsTPUDSK1boJO0=;
        b=Eh6V6h2DzqqpKNVutVY/hxeGtY5clyqDO8nDsAs/M18NMOOW5tn+GV4bLrUZ83SwAL
         W02nsC1k52ZL7jYMI0hNjqIMCqdx4qIOkinFITpwJX/tj6EST/6wahHehDNXNirgntDH
         Q7ZHoNVmolSksqRbJlcD0uo0RqQxGYiAnU5QtPq3RcfXKG2684AfOXI9C+3wq6Y70ggJ
         846KpdZtPr0pjG0Ho4ZytH5CJBy5Na4MaOKNu2boE5GHCY5ewO02gEodxW/+QOOUvpoo
         u4fndrudeUejkx4r3r9iSoxz8/Sv5sN/B7S0UvlGVLyNsBWlOiyCAxafzjeOLzlPy/k5
         nNow==
X-Gm-Message-State: AOAM5327CZ3KG46zaF90mp/cTnPEoV4bRkkwxsIvcoZgLDzBRHqXuPCY
        1idnVqMSfE2hhBTSnHxVVjM9CQ==
X-Google-Smtp-Source: ABdhPJwZKJOHZeya+U2mPQRz6hYHrLIxpehiADlh6glVgtjksHiU9B9/msjBgGqHcSsl4rD4lfTqsw==
X-Received: by 2002:a17:902:aa4b:b029:d8:f87e:1f3c with SMTP id c11-20020a170902aa4bb02900d8f87e1f3cmr9052560plr.23.1605799517397;
        Thu, 19 Nov 2020 07:25:17 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id 23sm389pgs.19.2020.11.19.07.25.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:16 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 06/16] perf arm-spe: Refactor context packet handling
Date:   Thu, 19 Nov 2020 23:24:31 +0800
Message-Id: <20201119152441.6972-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor refactoring to use macro for index mask.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 +-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index d37c4008adbc..978f5551b82c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -136,7 +136,7 @@ static int arm_spe_get_context(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_CONTEXT;
-	packet->index = buf[0] & 0x3;
+	packet->index = SPE_CTX_PKT_HDR_INDEX(buf[0]);
 	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index f97d6840be3a..9bc876bffd35 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -79,6 +79,9 @@ struct arm_spe_pkt {
 #define SPE_ADDR_PKT_EL2			2
 #define SPE_ADDR_PKT_EL3			3
 
+/* Context packet header */
+#define SPE_CTX_PKT_HDR_INDEX(h)		((h) & GENMASK_ULL(1, 0))
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

