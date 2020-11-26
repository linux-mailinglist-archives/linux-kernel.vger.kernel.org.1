Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3612C5D49
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391732AbgKZVHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391457AbgKZVGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:06:54 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DD3C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:54 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b6so2607959pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bQf9W2GrtRWRw1UMEUEbP7Yk66JacHQ8dUdbgr755jw=;
        b=ROaGQAgMsA/abXfS91CGQGGuQokMfOchYq5XVlU/8OU7aCMqmfxZCbQRQl7XA0eJ0e
         hNi8wP945LU5aw0+vIwQSKhLSZ2tN5y56TbEFyTNBdhLlIdX2MSApMNqqBGUZ4rGU7Ub
         m6eNo9+EKzc7PjAvaKUPmLPF6nQVZ02qw+0kyGA/ALcn4WkChxnwtrVpUKlUvNPlPhEw
         KmP8dEva90/SACGZjupGXY7E7Fc+SOunYw4CejxaRbEctkcJxukr0mgewUw6zfFcJazj
         lmMITQUkIby8vqYFAud7FL4iQWgHRwryKf7JYykGRf2Hb2N4jPpPYBxjOC+yDyba1N6j
         Xg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bQf9W2GrtRWRw1UMEUEbP7Yk66JacHQ8dUdbgr755jw=;
        b=RZFuKMsB0DSm82WDtZ769MDWsE+2eRZ6of/omYEQV7ojfbVf4rq2APiFSY6m4SCTXA
         RGukI845vVeo72bAUMoN4iaCIX9ZNK9L6M7vH1rHw1Uqn41oaIkmqXzH31pWR7aqpCI7
         lwm5/C+nmNXubOpSp9X2CxL+DobMEJ4sVXtTv8xRHGjqLgGyIYBQ3zB6iuFkLL/VdNeb
         gY+S6RVgpAl7DyCL6TlfMz8OOOcCXvaVSbO2bdP77AuapO+2BW14t3ldzQRR7UGZJiND
         Pg0Itup1AodvDUUI49YQAoVOyX+xGnAcPwqZ8p3PJynkrsW2jgGKd7nHQN2gLITWRsQF
         Hp3Q==
X-Gm-Message-State: AOAM53302zbvYu+0WxWNPH+biWUdBhFnYjUQEVc4jhlYReE5/uOsRCc9
        o1SwANBa8IFuJmQ4tC5J/ZTbqg==
X-Google-Smtp-Source: ABdhPJyiqSrTkzqO02d3qgd65iKD/t0Xtvxw0gzJxg9grb6KMK9e1UcnP3SJhC57jSCTDfe9r6UesQ==
X-Received: by 2002:a62:768b:0:b029:197:dea6:586e with SMTP id r133-20020a62768b0000b0290197dea6586emr4196300pfc.44.1606424813863;
        Thu, 26 Nov 2020 13:06:53 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c203sm5612676pfc.10.2020.11.26.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:06:53 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: [PATCH v3 10/15] remoteproc: Rename function rproc_actuate()
Date:   Thu, 26 Nov 2020 14:06:37 -0700
Message-Id: <20201126210642.897302-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126210642.897302-1-mathieu.poirier@linaro.org>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align what was done for rproc_detach() by renaming function
rproc_actuate().  That way it is easier to figure out the
opposite of each functions.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f5adf05762e9..b54f60cc3cbd 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1416,7 +1416,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
-static int rproc_attach(struct rproc *rproc)
+static int __rproc_attach(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1541,7 +1541,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
  */
-static int rproc_actuate(struct rproc *rproc)
+static int rproc_attach(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1581,7 +1581,7 @@ static int rproc_actuate(struct rproc *rproc)
 		goto clean_up_resources;
 	}
 
-	ret = rproc_attach(rproc);
+	ret = __rproc_attach(rproc);
 	if (ret)
 		goto clean_up_resources;
 
@@ -1825,7 +1825,7 @@ int rproc_boot(struct rproc *rproc)
 	if (rproc->state == RPROC_DETACHED) {
 		dev_info(dev, "attaching to %s\n", rproc->name);
 
-		ret = rproc_actuate(rproc);
+		ret = rproc_attach(rproc);
 	} else {
 		dev_info(dev, "powering up %s\n", rproc->name);
 
@@ -1916,7 +1916,7 @@ EXPORT_SYMBOL(rproc_shutdown);
  *
  * @rproc: the remote processor
  *
- * Detach a remote processor (previously attached to with rproc_actuate()).
+ * Detach a remote processor (previously attached to with rproc_attach()).
  *
  * In case @rproc is still being used by an additional user(s), then
  * this function will just decrement the power refcount and exit,
-- 
2.25.1

