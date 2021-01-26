Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4E0303A72
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbhAZKf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730729AbhAZBpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:45:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8388C061223
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:37:28 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id q8so20596358lfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2onhwU3NGN48TGwEtG+WOFx1Rxu7aFi2BaPq35If454=;
        b=OgSkIcCVpKTCPe6BSISGgqz9yOi2y3GJmOUJXtcagbsb6WDC3W+d7abxlHW5e7pg3K
         lH+Fryns/Y/2q8eDt+EmH2DC9bVAFgSQmWDm9Hckuwp2Qwk2xrlux8KpwZqya+Y5EPnl
         1oniMdmPn4KmfLcy5kMhwVHSvSBJG0UuVc/U9HEqcrdkS3yh9TDDGpAEvucKAYobw9CH
         vGBRvzo57J7KkJGwSX9f9ZRNrvf/SRJEslFcYQE7oIimrCrmoBdaHK2LGkSVMsrfZPK5
         Y0VohXtDNKya2ayzxUtYHFghYpk1hzLXaPxehQ7ZJnMnTF5IRaDWVeEAsKDrXG3yNW1H
         QGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2onhwU3NGN48TGwEtG+WOFx1Rxu7aFi2BaPq35If454=;
        b=CL0ays6dRyvZtkePXx50JFEvFs/63pB0kyPHB+Vdg3GLuvY+kBxHGtrXZSx6ZJlp7O
         SRg8yjf5KwMGnlkvm5KB+hWfasnN9J6Pphp/sZ3MHe1U0kplhT1t10Qw7IA5MfzIz99a
         XTpakxL6SsmWDvfO9AElpjjVJPwM8BKok6t76foe6FJrMvlk78HDbOVUFIznesESqHF7
         szJwZWzZRok2uJYPQr0sd6y8fyPgKP4Q/keCAgaRMujsfglDLqewyS+WHhEZ0hEUshCQ
         P9HPYERjYp7oFoW2U1wnUczfO1YitmS1xfkX3e2boU3KecwtKn0GjvcWM9K+5PgrzSzI
         Lzsg==
X-Gm-Message-State: AOAM533JlubNhWHh+CHG9d2saq5ytnMm1u9Br6i4RnO2rPB9VLiQfHYB
        cNFb/weAYJKJ4D/oHACP5AI=
X-Google-Smtp-Source: ABdhPJxdKuglsvM83wEfg9aBbS9iKvJFZPcCLSjSZKg9eZz7iWnL+AXotJP82ozSrjGADD+w7WeFaQ==
X-Received: by 2002:ac2:5e81:: with SMTP id b1mr1503396lfq.473.1611625047312;
        Mon, 25 Jan 2021 17:37:27 -0800 (PST)
Received: from localhost ([2a02:a310:53e:fc00:4aa4:72ff:fea0:3782])
        by smtp.gmail.com with ESMTPSA id o4sm755532lfo.231.2021.01.25.17.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 17:37:26 -0800 (PST)
From:   Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Micah Morton <mortonm@chromium.org>,
        Gao Xiang <xiang@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Cedeno <thomascedeno@google.com>
Subject: [PATCH 2/2] groups: Simplify struct group_info allocation
Date:   Tue, 26 Jan 2021 02:37:16 +0100
Message-Id: <ba9ba5beea9a44b7196c41a0d9528abd5f20dd2e.1611620846.git.hubert.jasudowicz@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <155995eed35c3c1bdcc56e69d8997c8e4c46740a.1611620846.git.hubert.jasudowicz@gmail.com>
References: <155995eed35c3c1bdcc56e69d8997c8e4c46740a.1611620846.git.hubert.jasudowicz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine kmalloc and vmalloc into a single call.
Use struct_size macro instead of direct size calculation.

Signed-off-by: Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
---
 kernel/groups.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/groups.c b/kernel/groups.c
index fe7e6385530e..787b381c7c00 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -15,12 +15,7 @@
 struct group_info *groups_alloc(int gidsetsize)
 {
 	struct group_info *gi;
-	unsigned int len;
-
-	len = sizeof(struct group_info) + sizeof(kgid_t) * gidsetsize;
-	gi = kmalloc(len, GFP_KERNEL_ACCOUNT|__GFP_NOWARN|__GFP_NORETRY);
-	if (!gi)
-		gi = __vmalloc(len, GFP_KERNEL_ACCOUNT);
+	gi = kvmalloc(struct_size(gi, gid, gidsetsize), GFP_KERNEL_ACCOUNT);
 	if (!gi)
 		return NULL;
 
-- 
2.30.0

