Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804322FC162
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbhASUlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbhASUlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:41:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A954C061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:40:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c128so939785wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hqz5KkIUWAsMMr4Nkw2DHVorD8Rmr14UkHNWJhlYZr4=;
        b=jnv/+KO6i5GVy+raRH2CktGNmAyPW0kmZGHyjPRMIyNRYpsdPac9XA9MP5fazurmcq
         uCqt9zVEVQis/S9aVBLK7nY7cIsaz/HC6J+AP7AdKjkftzSD5cygQfazN6CZpkcl2NtD
         HYatepnZHhxbcuEELJSbkHVlDUDcnxBpnEIQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hqz5KkIUWAsMMr4Nkw2DHVorD8Rmr14UkHNWJhlYZr4=;
        b=TSkxJqluozQdIrA0S3O1KAN6ix8LT6s3iMMQgSz0By6AJZ9HtGWpyTua053KA07h3R
         T6TMhaN1DOlEXCywVGj60Qhen5Rq7eOfeTOcocdhVXN3WM4DKZ30Et89NGMXdJEg/OUN
         SM3Sm/zOT6RMylYSHVqQA2bt1D8VwkhvoCQr8uhgRWwWspQC+goaXQhzqLw9hvt4ZlhR
         wCKcDZXBmtNvwYkqq3qIzKnELIJJZiV8HX0Refr7DQA8STIxxO568VdGZnGWMVyqHqop
         wxHsoW9+k7CnynXHsdIDXrPwUsduwMNs9lGMDlJgtIV4IXmXmMuLRJNsczpPOkVoApbT
         eXtw==
X-Gm-Message-State: AOAM530HwNcbKiVzduB0ntDXUw/KqlrEc/zPepIfD7saQUkgpXWiiS0E
        2oG4RVUyYKMD/Gax3LcQnf1EuQ==
X-Google-Smtp-Source: ABdhPJxhg7dmzxe2FdXAxsUXYiD0FnIa6AXlhUScb/esR/2HsvsfX6Iamf+TH80zY5689pHsjLT1lQ==
X-Received: by 2002:a7b:cbd5:: with SMTP id n21mr1280568wmi.5.1611088832105;
        Tue, 19 Jan 2021 12:40:32 -0800 (PST)
Received: from localhost.localdomain (29.177.200.146.dyn.plus.net. [146.200.177.29])
        by smtp.gmail.com with ESMTPSA id x128sm6642847wmb.29.2021.01.19.12.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:40:31 -0800 (PST)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com,
        pavel@denx.de, stable@vger.kernel.org
Subject: [PATCH] dm crypt: fix invalid copy paste in crypt_alloc_req_aead
Date:   Tue, 19 Jan 2021 20:40:15 +0000
Message-Id: <20210119204015.49516-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit d68b295 ("dm crypt: use GFP_ATOMIC when allocating crypto requests
from softirq") I wrongly copy pasted crypto request allocation code from
crypt_alloc_req_skcipher to crypt_alloc_req_aead. It is OK from runtime
perspective as both simple encryption request pointer and AEAD request pointer
are part of a union, but may confuse code reviewers.

Fixes: d68b295 ("dm crypt: use GFP_ATOMIC when allocating crypto requests from softirq")
Cc: stable@vger.kernel.org # v5.9+
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 drivers/md/dm-crypt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 8c874710f0bc..5a55617a08e6 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1481,9 +1481,9 @@ static int crypt_alloc_req_skcipher(struct crypt_config *cc,
 static int crypt_alloc_req_aead(struct crypt_config *cc,
 				 struct convert_context *ctx)
 {
-	if (!ctx->r.req) {
-		ctx->r.req = mempool_alloc(&cc->req_pool, in_interrupt() ? GFP_ATOMIC : GFP_NOIO);
-		if (!ctx->r.req)
+	if (!ctx->r.req_aead) {
+		ctx->r.req_aead = mempool_alloc(&cc->req_pool, in_interrupt() ? GFP_ATOMIC : GFP_NOIO);
+		if (!ctx->r.req_aead)
 			return -ENOMEM;
 	}
 
-- 
2.20.1

