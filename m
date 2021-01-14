Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4272F5978
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbhANDkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbhANDke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:40:34 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEBCC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:39:54 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p18so2838556pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYFy3drdLKWF4Sxrfj42pwCBQFMVHVpWg2T7oMMvvMc=;
        b=nBjdV2PU9bczMEYF1gXIya60Nsq5SPgB5Lj/eOuISAGLa5iPJbePRJdSbOL2EwdUeg
         jXzOTK8gIRu+Ith9d5AWCkIoaey1TLuhBih4YOG3UWDfAmQ29b/Ki/eGFOmbq2ay3jJI
         +qIgsEET+53OqXGw+sfi46FHkUCuOv1P4WV3O7GtxFf2UdwX/8c4MrieXpMoZ+gCbJ93
         ceBAssr6QcZwK9wLEMMSKld2Fu0uepYKaSDJBkzJK/iiS4gK7V9I1qRpCBb32LhpIFet
         zF3Qutl49jwb7nGAvVjzNAI+4bA8jf8Z9vKK3cGtOTX+srQb/yjCxwEVP89mnz7/3akT
         amXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYFy3drdLKWF4Sxrfj42pwCBQFMVHVpWg2T7oMMvvMc=;
        b=UnCsh/GJ1jCEUD0gTDEtLRY7/LFluqystv2mTpmEx3zp4u7HZISdsZS1N41oIrVcaX
         W7ozlc/sPBK3cXYiO+276W/DCstkxcNcAEGFdYrW9LWXZmgeMToqk7ciFY7SqpjEJAxs
         3kAAGUohetHrytdLE7s2tiouMqOgoOOSEA//Zqrj0wTQjgoMdOlOvHnMKdKdcTtFN1+r
         eMLsDa35lBg+cZ6EwWGLgYqRs0W18xpEy94pvp3tqwVRdIQpLYXvZAhQk+GARTmF+VfY
         GqVWk754qeucW2MfLSWoiVET6BqBImYUSsdzG8ivATyudlkPK69zcg8enYe/AiHAMdxB
         05sQ==
X-Gm-Message-State: AOAM532NFkyvdI4Lyud80MnnJ5UuHpzs6+i2njjvORDd0s9v3Szv2F32
        qjB3btXO29YrUQtVxg2gNyFITQ==
X-Google-Smtp-Source: ABdhPJycH98lHk420/hQhh7s1347OJzsx/7cToPa9IAo4tBk62ecK8vIY3nFPi7UB/3b8niS59kGiA==
X-Received: by 2002:aa7:8583:0:b029:1a9:39bc:ed3b with SMTP id w3-20020aa785830000b02901a939bced3bmr5407787pfn.48.1610595594204;
        Wed, 13 Jan 2021 19:39:54 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id y1sm3795863pff.17.2021.01.13.19.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 19:39:53 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/5] perf c2c: Code refactoring
Date:   Thu, 14 Jan 2021 11:39:34 +0800
Message-Id: <20210114033939.164538-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is for several minor code refactoring, which is
extracted from the patch series "perf c2c: Sort cacheline with all
loads" [1].

There has a known issue for Arm SPE store operations and Arm SPE is
the only consumer for soring with all loads, this is the reason in this
series drops the changes for dimensions and sorting, and only extracts
the patches related with code refactoring.  So this series doesn't
introduce any functionality change.

The patches have been tested on x86_64 and compared the result before
and after applying the patches, and confirmed no difference for the
output result.

Changes from v2:
* Changed to use static functions to replace macros (Namhyung);
* Added Jiri's Ack tags in the unchanged patches;
* Minor improvement in the commit logs.

[1] https://lore.kernel.org/patchwork/cover/1353064/


Leo Yan (5):
  perf c2c: Rename for shared cache line stats
  perf c2c: Refactor hist entry validation
  perf c2c: Refactor display filter
  perf c2c: Refactor node display
  perf c2c: Add local variables for output metrics

 tools/perf/builtin-c2c.c | 173 ++++++++++++++++++++++++---------------
 1 file changed, 105 insertions(+), 68 deletions(-)

-- 
2.25.1

