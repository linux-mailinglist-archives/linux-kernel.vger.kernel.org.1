Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5605A2DE81C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbgLRRdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbgLRRdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:33:51 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B291C0611CA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q4so1752662plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=quv8FgGcrBfpjdUziX+s2dGLHCpcEJuuhEHyCnt0I9w=;
        b=hWjlKc/uj59tXupMihyRyk6/qf5jTxj733rtsaPMHcWwyas3HRGdNDFySCMQMFDsLw
         MsQlakPxeBYW7HiRi3L/5gQsrLigaJK2SrUEYK4IGL4m/B1h6Qm7zzO/+R+qU/dxUeAc
         Z3VHqNIuAwma/8vga8q8ugF0ZpNAe3i4KndKnvjUzkaMxntPyLVi4459FM8BfHpdtIT2
         siJkUbRIB3rg+D0KZXSsl83hf6P7FheSxhm20Ku6OHJnK5lO7gXl8IvKhhroO3XgiRMb
         7yMbAakrbxAtg16bQf1fPw8aGoMA1qfQACManxDa4k9GVQxH7fNUaf1pGaBM7CksN04V
         n4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quv8FgGcrBfpjdUziX+s2dGLHCpcEJuuhEHyCnt0I9w=;
        b=AiP3A/DbijUJNLH+AAzSVpq9dSUxKi0CWYB2t60X3AwV0rp/R2zM/0DgU8oos2geQy
         3z7RheXQIZqCXreSUXfZo0fh9rEhj+etSUQaNgJ+u5E2j1DCoXEyr9/gy6ASHknIdJnt
         fLiu+qqh8gA7ZOmOvphQHResvsladcj3z2kaW2Rz1tcIDaRxTYc4Gr+ZAQNlCSCZJ4+i
         u2Ozg1W+ZNz4X7RrqAgFc3lEerACNemCKKA8chx1/lL77YyZhMRX4OgBgE+9v0d9UQVD
         8dMWCqZ6l/hAkO9SIez7W96RS7ZLulbdMVRjgUAL2rMz7JaH3eGQrLWPwJf9j8UNKiQy
         KPQw==
X-Gm-Message-State: AOAM5317VdAykkDB4AfkUodmyu9hjx715D3v8KDLd+AL5Kqyh39qTpbg
        p1UNLzzaIuvKKHkC6DpiChUimQ==
X-Google-Smtp-Source: ABdhPJwwNMzDaIJIDF40wcMocYDBjmZOfxV05QpIIQlCrh5xcj/fjQRwf5R9KrSWZAqtrnxHvxp6bw==
X-Received: by 2002:a17:90a:c8d:: with SMTP id v13mr5283889pja.75.1608312752706;
        Fri, 18 Dec 2020 09:32:32 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:32 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/17] remoteproc: Re-check state in rproc_shutdown()
Date:   Fri, 18 Dec 2020 10:32:13 -0700
Message-Id: <20201218173228.2277032-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
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
index dab2c0f5caf0..e55568d1e7e2 100644
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

