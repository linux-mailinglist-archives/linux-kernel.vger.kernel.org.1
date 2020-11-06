Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E350C2A8C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbgKFBmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732744AbgKFBmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:42:09 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240CCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:42:09 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r10so2684531pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=YSnOeZsIzaD5WSYGkcie5T7nhBEGkWS2vM/S6OPIWEpgnUGWXHVLBUJT0XN0cOUF0Q
         98wovmzX9cXzHlvxIUWGXq6lmlxuIr+ythRPFmyBHHxDsTayXC3f1aKDYjEK6cmmFPUt
         H0Ka2KqqwCfrEngBnz1JzUbN7HaDW+xK/0tLU5lHDOPIlgicYfWrRUoqamvgE092nqA/
         6meVsy6PxVD2rBcEUaosgH4EdaN7qHr14EbN0lxWigEVNg5IEf6ODF751q+RlLwTBBqm
         8upBsqg7uon7daC97TBrdmBNJfu8RuQr7FjXOkK8njsw2JxWaFjsfp6j1wKU2b6mo5/3
         J1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5b97MaCIffm6PJd9EUIhld7F+TNSmmJN70H4AU5anE=;
        b=ngQJXRlpizGARgjZUXR6ecrt7hAgD7SKYNRuBX1QBtGaJZpv8P5yd6rsYS5TUcZ78C
         xinm+fJiPiQJVMK0vQ7mn6oKkZ/iN0CK2c/uHDY3ZFvXKaTddhpLsWCImu6yFjrGFl/s
         F67FlV4ldK5ENsbIKXuzNA+YyW5YMiX2KpnaOiAbrlTvZJ0Diudl7ExsGLiDHmQkclOd
         8sFKfnqdLBkrV6s4GkowF+KVjdIu+B9RSh7P46jWuxnatZSnQFz/CF2yzdogqnP/LJ7A
         pkYzfkTFjctjTa2nCLwdIFJSq67KVOOK+eYqLqfbWrAa2COuDAAEt0fflnjCLl9JJd0t
         vrAw==
X-Gm-Message-State: AOAM533szRnrWlkwmJN+lUwvBNqk4ns57Q5JoMNp1uson5ekKAVKsQPE
        p6JAhZCkbFy2TUEbdJawGyYEig==
X-Google-Smtp-Source: ABdhPJw7N+jstV9LEJJIq1FcLppEQbRobk8oJkYexwBEdkoMl0gnFaIGt/g04EbCSoLk/tJVHrHPEw==
X-Received: by 2002:a17:90a:1901:: with SMTP id 1mr1957073pjg.30.1604626928732;
        Thu, 05 Nov 2020 17:42:08 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id y8sm4175037pfe.41.2020.11.05.17.42.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:42:08 -0800 (PST)
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
Subject: [PATCH v7 02/22] perf arm-spe: Fix a typo in comment
Date:   Fri,  6 Nov 2020 09:41:16 +0800
Message-Id: <20201106014136.14103-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo: s/iff/if.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 46ddb53a6457..7c7b5eb09fba 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -142,7 +142,7 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 
 	/* we use index to identify Events with a less number of
 	 * comparisons in arm_spe_pkt_desc(): E.g., the LLC-ACCESS,
-	 * LLC-REFILL, and REMOTE-ACCESS events are identified iff
+	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
 	 * index > 1.
 	 */
 	packet->index = ret - 1;
-- 
2.17.1

