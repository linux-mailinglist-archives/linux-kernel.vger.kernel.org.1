Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692C82DF9FE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgLUIhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUIhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:37:40 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD6C061285
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:00 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g3so5257603plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OUdu1wye/C1GZtkVvh2jlptUp2HTtIud4HosapGIaQ0=;
        b=AS87dDhZzHwsw+ps6bhcSqVFqLaczqT1Ez98b58t0yDTndO9F5fbWfo0GpUPDjDHk/
         9OCMa+AVVGTcthihbHFhnqN10kuTIh+pLOSF6CcuVPR7mj4P/ZDzpNQWsh4+LwmL8ppM
         ZEK1Vb1+b62OrPIOuCCjwl7JliPk3hraKwLa6K0aLug8yejfa14uKnr/4wnZBG/2NQiE
         D5DXt1oOHo000Gxrd5KG6PGi+DYGtZvV77FS89NkeQV6jbGTOa0Ume4s1n68uroBgbiW
         frs0bmLrtTS8sREjPOxf4zbuM2EKrzP/6L2TWMLLhTbB4zUvPDe6jOZLUFr4Aog7M1Re
         XaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OUdu1wye/C1GZtkVvh2jlptUp2HTtIud4HosapGIaQ0=;
        b=DaZrDPJu1tl3gkKY/eW1dyYhG9r1A94VBbYpGfkV5BkRH+U6Vryjjq1XrnhbpBed6J
         xSt6LHpJwK6mEEuT0mNA8N/G+iKRLOowSuqtja6ug2+j2dn48APnWUsVDJXeES6YQqod
         FKO5FiN4hRULeOTa9HuL5TjJebM4VEn+hWnG++Ko2xsbtecnCJcv+CLi7c9x2NL4JfNV
         yAWiB62msI1D1pQpwm5/wgsHEE1rZ7FtijH+VwAfs8YBSw7fJnB6wUnC0C/fE8dK8QEz
         qxIReuLsJfunVLHD2YIONfkJkyDM5EbzdrhQe6JjEkxoUySPKC89+NC0GjQTtZb9T4r2
         5ltQ==
X-Gm-Message-State: AOAM533p7Wk+/eFYP/SbRN89D15SkpdJwMoAP9YJNrTG2QQPithwr3T7
        HKEq4NK8QnWfbYmZnjyWQMWyDg==
X-Google-Smtp-Source: ABdhPJwtcFmc3OOG6s0frz1rf7JGcz1zYqy/7aO1DxrJtzyyT2rWZfZQuCKwV3J2C7smuZ0dmOUnqQ==
X-Received: by 2002:a17:902:b097:b029:dc:5c:a986 with SMTP id p23-20020a170902b097b02900dc005ca986mr15354009plr.59.1608539820196;
        Mon, 21 Dec 2020 00:37:00 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id k64sm15822023pfd.75.2020.12.21.00.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Dec 2020 00:36:59 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/7] perf arm-spe: Remove unused enum value ARM_SPE_PER_CPU_MMAPS
Date:   Mon, 21 Dec 2020 16:35:51 +0800
Message-Id: <20201221083557.27642-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221083557.27642-1-leo.yan@linaro.org>
References: <20201221083557.27642-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum value 'ARM_SPE_PER_CPU_MMAPS' is never used so remove it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 98d3235781c3..105ce0ea0a01 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -11,7 +11,6 @@
 
 enum {
 	ARM_SPE_PMU_TYPE,
-	ARM_SPE_PER_CPU_MMAPS,
 	ARM_SPE_AUXTRACE_PRIV_MAX,
 };
 
-- 
2.17.1

