Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893622F2A09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405499AbhALI3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbhALI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:29:53 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA797C06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:29:12 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n25so979940pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SfqrhXJQaqJjV61wcgC7ZOTiZJR50oZXFU0ulC256Rg=;
        b=SSeKiG1+oGN18d1S1UvrOUNw2yc6VlsVtOpm9dV6u77sKiqJRN6MtpyEKvFQ91QWJL
         VSWO9fxox36y9noWQm4jBkR2wlVkE72NXF1Sj45u0PJ/QLXcNyjRu5IeZWhsW1PZeQHG
         YxwOhVc3+j79pyiiUhhPM3fL0EA2rubMm+3ff6PkJWTEv+dzC7dbisYrRF4d2lL4h+fY
         rIm7X7BGkuywk+CNe+3jtWnEHslHChb4HFq9qJV3zEXEWtgrEjErf5OpOm7h8ltimaIR
         jvgkLAIUuK6MiLiNrleVFOJTmGuxjI+zkIKeX1tRdtAWcO7PxZAMKcl/cCvLZhfmPUJt
         2JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfqrhXJQaqJjV61wcgC7ZOTiZJR50oZXFU0ulC256Rg=;
        b=QAFcGYZ994eQ6e0DMg05sIE+kCx1lhJfYK+FIUCYvg1McvVL5qZ44IcQHSzQt9Y71z
         rqvgcVRSL9C0WLlujzah1L/zwIplA2QBtHILQMCr11fAhBb8ytfYxPjpStqrV3GzC4m4
         teX8uWXF74BXwFuhEN3knX5/NdQgrMudulh0DHocA/EK/rq7xzjoplAkWr7zlo7gbC6r
         Fgc/1H714vBAzgjxvKN5Fq2rYQ3V6LwZKpQbl8tSf7+phdhnYQKFqpCk5Kxn1tMTgFz+
         vF6oDpoh7Q8LRfW6z74DcYXY8JJyAAx1PA1uw3xpAqUrxU9MWoTNHPb4GBzMqKi0CrMg
         lLbA==
X-Gm-Message-State: AOAM53343iIWfxONdrsEcXCwPbEiWo1tP9n5d9uCmWYEapo13pNaqqAL
        gQXFCzXfa4VlDrpVt4nbgTbapA==
X-Google-Smtp-Source: ABdhPJxFkHeC8OHW0Dxcc7ncPQ7CFcioS0xfREvooC1RtufXlqhwn8QMMerrJaJbijSvOERSCurUkQ==
X-Received: by 2002:a63:1f18:: with SMTP id f24mr3684261pgf.133.1610440152283;
        Tue, 12 Jan 2021 00:29:12 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id i2sm2244541pjd.21.2021.01.12.00.29.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 00:29:11 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH V4 1/3] scripts: dtc: Add fdtoverlay.c to DTC_SOURCE
Date:   Tue, 12 Jan 2021 13:59:00 +0530
Message-Id: <a1587678b2d5e23c4a3e6248825e285a403f3ad1.1610431620.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1610431620.git.viresh.kumar@linaro.org>
References: <cover.1610431620.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will start building overlays for platforms soon in the kernel and
would need fdtoverlay tool going forward. Lets start fetching it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 scripts/dtc/update-dtc-source.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index bc704e2a6a4a..f1c802011e1e 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -31,9 +31,9 @@ set -ev
 DTC_UPSTREAM_PATH=`pwd`/../dtc
 DTC_LINUX_PATH=`pwd`/scripts/dtc
 
-DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
-		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c \
-		dtc-lexer.l dtc-parser.y"
+DTC_SOURCE="checks.c data.c dtc.c dtc.h fdtoverlay.c flattree.c fstree.c \
+		livetree.c srcpos.c srcpos.h treesource.c util.c \
+		util.h version_gen.h yamltree.c dtc-lexer.l dtc-parser.y"
 LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
 		fdt_wip.c libfdt.h libfdt_env.h libfdt_internal.h"
-- 
2.25.0.rc1.19.g042ed3e048af

