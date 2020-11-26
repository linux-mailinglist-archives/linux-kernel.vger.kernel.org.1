Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93C92C5D67
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbgKZVGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388414AbgKZVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:06:47 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288CBC061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:46 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id l17so2596846pgk.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tgn2hTBqiW955JL5NPKA45JX/FzuG4XGgD1c5/FNO0E=;
        b=EJgU0yrfDUi8K8TBrpgjT/nsXFo2NQQXZN2x+vJPCyzkDxYqwcmziQyyjhr9ttVojI
         AonHYDAz2+W26V4stIv19k1UcMmylcC4/I9CgGet6RwL6Kyy2UAtfKTl0qfAIytXLqhX
         I80mt//amPrYAPJ30mKrzEQPvBJ7rmm1yEpGk/nEnef0VfU7s/1Qc42Z/Kl40xpDoJSd
         dESiphWO7uhj9Tb281SsmB4OmaJfa/D19zZLoG7bYC+c7eHkgt3LYYrudLSvRQDvTFIg
         OIkAC1WD33FWh0WsP8pEYguuVyKOJASEoFcHEDb+d5Lgd0MUj99UTtwvtWAFsePNQ3Z7
         T1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tgn2hTBqiW955JL5NPKA45JX/FzuG4XGgD1c5/FNO0E=;
        b=D3Q9MzZ2GS3U2zasAEDB+/YZZ1FcfhkrXlFWVbm9Fi+8yK9f3QLvGMfZQKJCFSPLOY
         /olE1yDKYXB3OfksI7DD6G/2ekwtjPt27tvUbybumpr8sl0D0iWPc0BpH07hwA+7TedG
         OAigwmFfhUokPGVyx36N/Hj2cDnEpf00Uvcv3MPvMP9KStm8IN44nu0ZPLhSRouD8WFy
         Y8Bq1yR5egUyh5aTj+JyVfLruS6PciJdDjZvTb6rRboz7fxi5hCR0Nalx0r42vnDszq0
         aR5DjwPNxwLDboCqrpPkyC9xGQ5P63dm1gPZbQ4Z3wHHMBG96O3liWVdU3P0biZ2ArLv
         EVcQ==
X-Gm-Message-State: AOAM531wem8p92m+0w2M6auxbvoKygk5D/TVtTdPtFMq7BJpr99lyR2g
        OcqAL5aBYt0uf6wmw2z9ejzJ4wCS4/XnXht/
X-Google-Smtp-Source: ABdhPJxxRX5T2XVObUhBwNopitD5QOQ5LaEDrJ75ibgn4vFqyaiYk50I+mOWW6AvrfKpk1GEYX69Jg==
X-Received: by 2002:a63:3309:: with SMTP id z9mr3796396pgz.243.1606424805726;
        Thu, 26 Nov 2020 13:06:45 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c203sm5612676pfc.10.2020.11.26.13.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:06:45 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: [PATCH v3 02/15] remoteproc: Re-check state in rproc_shutdown()
Date:   Thu, 26 Nov 2020 14:06:29 -0700
Message-Id: <20201126210642.897302-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126210642.897302-1-mathieu.poirier@linaro.org>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state of the remote processor may have changed between the
time a call to rproc_shutdown() was made and the time it is
executed.  To avoid moving forward with an operation that may
have been cancelled, recheck while holding the mutex.

Cc: <stable@vger.kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 46c2937ebea9..e8b901f34c91 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1857,6 +1857,9 @@ void rproc_shutdown(struct rproc *rproc)
 		return;
 	}
 
+	if (rproc->state != RPROC_RUNNING)
+		goto out;
+
 	/* if the remote proc is still needed, bail out */
 	if (!atomic_dec_and_test(&rproc->power))
 		goto out;
-- 
2.25.1

