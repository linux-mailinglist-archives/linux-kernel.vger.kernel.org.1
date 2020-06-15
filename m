Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D3C1FA2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 23:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFOVjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 17:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgFOVjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:39:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD8C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:39:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d6so476714pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4c38Iplb3EjQ2nl2SUevIIMHXwfjFfLx+4gWWneV7Gw=;
        b=FbJrV/2kiuluaiLm8/jBJDJwbE31GprCK7IBYSPhdMLoE2/ZZqqkB9GiKxq6XlJqvH
         47PcQ/5KarTUzTK+DLGDpGPY4sW/lu8ZyURGnd5H/xqyvCQRhyM5JDFbpPruHpZ4Bq5c
         MQ6clIHPTy8hYdFzjjC924T8RvdBvbcP7toyP7LRtWcCNXi7IlZ6D6rYTt7PnwQwEm1m
         puaJGI5c+IzfKVfNnqdddWy3aLIBc4fkQ2ZR4NhY2KznMbbrSVWfJzIqF82tG+IGJF6+
         vN6YSf4D21XZUAllfI7NOMYTwla4LF7rkjxgWt5ZsH9/t3VFDqgqwy2VizPGiML5Gy2p
         QatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4c38Iplb3EjQ2nl2SUevIIMHXwfjFfLx+4gWWneV7Gw=;
        b=lQtGC7O0f5MsnlgPDDL/C/xUeOPTJfJsicUDe7M6auXW4dvg2kD5bEYn+SpBZYDNF2
         iddvjU1g3KHLCuNP0/0kcEZ1+vRnJasxm9/TXSbmB5p8L0nspSRkVrz1HyqkfCvDEAyf
         0pSCKc/iAVoCzOmUfb1PDj7jZVVcvntNgvYT62j/HeXl5A2XE6i4uCcKxfHuvg3f2ohN
         AAkjOXxmViU6NFscd/lDLJYV+UxufFdChWIkJDGxjDkDgVgwfD/UIfExfF4iGeRFJCOV
         dMFZYmWcKa9MrJJ9f5N+vbqf+Af99fc+dZOZOrG6T21fvaLNcgM5CTyvBwswJCleiJPJ
         dJCA==
X-Gm-Message-State: AOAM530OGPL3F3xn/yAsXjncYdhZdGBnqkQ5gSA1gTbre/EyY9fQbkOJ
        opPmPpmLDAt7Q7y61jYW4yXW4w==
X-Google-Smtp-Source: ABdhPJwVyJJuL6NLyo+xZovq2Z4Tb7R4l5jvNX9RI1tZdtNTdG8WKFjoEQ5MFQrpayTlNY83EALrlA==
X-Received: by 2002:a17:90a:1e:: with SMTP id 30mr1131013pja.25.1592257143782;
        Mon, 15 Jun 2020 14:39:03 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o186sm8708227pgo.65.2020.06.15.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:39:03 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] sample: rpmsg: Print out RPMSG device name extension
Date:   Mon, 15 Jun 2020 15:38:59 -0600
Message-Id: <20200615213859.443152-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200615213859.443152-1-mathieu.poirier@linaro.org>
References: <20200615213859.443152-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new rpmsg_device_get_name_extension() API to print the
RPMSG name extension if used by a RPMSG device name.

Suggested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 samples/rpmsg/rpmsg_client_sample.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
index ae5081662283..2c5dc65ed844 100644
--- a/samples/rpmsg/rpmsg_client_sample.c
+++ b/samples/rpmsg/rpmsg_client_sample.c
@@ -51,8 +51,13 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
 static int rpmsg_sample_probe(struct rpmsg_device *rpdev)
 {
 	int ret;
+	const char *extension;
 	struct instance_data *idata;
 
+	extension = rpmsg_device_get_name_extension(rpdev, 1);
+	if (!IS_ERR_OR_NULL(extension))
+		dev_info(&rpdev->dev, "extension: %s\n", extension);
+
 	dev_info(&rpdev->dev, "new channel: 0x%x -> 0x%x!\n",
 					rpdev->src, rpdev->dst);
 
-- 
2.25.1

