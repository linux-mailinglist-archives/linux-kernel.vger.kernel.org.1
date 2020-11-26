Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932DF2C5D51
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391608AbgKZVG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391385AbgKZVGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:06:52 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400CBC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:52 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id bj5so1667465plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtAqiIL4OGNOjCOWpJIS67EUO5pm7/BCFlTCx9jyrY0=;
        b=Cny5LHKnxJRw0cPNWlSxQxJLAOqavXYkvssYv+komoercg8UQCRqLL1Dt7dN7w10mi
         /jK2HtPu8TjYHOvz6LNUomKVqNs56Aeu6E/keXOpMJPmGO4hnrVRc8Th++2ZHOWpI/9z
         KRcnuSvQkpZvQ1rZsaJjNGubmkPscveRVANqlUSvnzOU/y8VNfcRsxznJk2dQbZXLOLI
         OlLlLzprXxRgjI65ETsbLde3wmKcelqXo7ApjN07j5dgdWrUh8rupWQZ2+G8Q87vrCVl
         slY8OqOhgTS/ro3JbICqr1YtfZjJC3lgBJGgTLU4G0Ku3Vq5P79Hhpaqg8TID0lxIqnm
         p+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtAqiIL4OGNOjCOWpJIS67EUO5pm7/BCFlTCx9jyrY0=;
        b=BX4Jh3J7BKlgqQFhv6LO4s6DFuhF2EdsH85Jsudf49NUoZq188AGKdcA70R8AE3bXW
         5ZHvLeE+LXVUxynQLS6JuYUWw38BSzO1ELgrpNbeuxh1vKT3d7Aq1fdj2Usk1kYlioF4
         hZ5Yg444w7lg5UsiYcYPoMQqNb9KfVi+fqN1ORSo1bXlydi+J5xICe1iJY4FK/C7NUlQ
         TholibtnfpmkUP503dEvJrKwb2ENatoIZAd1OhgV9OeRAAa5OYc7+WPtlivjJG966jJK
         GTFS8dcbb6nqHUTbyrQ+awznuJrlEnR6xnsDFagFyMwIrOyVi0Okv0/S4sKcsLRenmfP
         hQ7g==
X-Gm-Message-State: AOAM532gr+EE7jeMSjVpBUNsQ3oZH+uZmgFX8CuKnEEmvwRCY97zj22j
        x0ATannHMEbK5OfnMeUHdaoIhQ==
X-Google-Smtp-Source: ABdhPJzXhimwa/OrmYJEQnvo5tzdCrzQIJZMyNWoA6mBeVghxJC2zkl1KMx7mnMTN/Z1vkrQ1d35Vw==
X-Received: by 2002:a17:902:e9cc:b029:da:1d7a:f5fa with SMTP id 12-20020a170902e9ccb02900da1d7af5famr4151197plk.38.1606424811844;
        Thu, 26 Nov 2020 13:06:51 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c203sm5612676pfc.10.2020.11.26.13.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:06:51 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: [PATCH v3 08/15] remoteproc: Introduce function __rproc_detach()
Date:   Thu, 26 Nov 2020 14:06:35 -0700
Message-Id: <20201126210642.897302-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126210642.897302-1-mathieu.poirier@linaro.org>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce function __rproc_detach() to perform the same kind of
operation as rproc_stop(), but instead of switching off the
remote processor using rproc->ops->stop(), it uses
rproc->ops->detach().  That way it is possible for the core
to release the resources associated with a remote processor while
the latter is kept operating.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_core.c | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 539667948bc8..928b3f975798 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1664,6 +1664,37 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 	return 0;
 }
 
+/*
+ * __rproc_detach(): Does the opposite of rproc_attach()
+ */
+static int __maybe_unused __rproc_detach(struct rproc *rproc)
+{
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	/* No need to continue if a detach() operation has not been provided */
+	if (!rproc->ops->detach)
+		return -EINVAL;
+
+	/* Stop any subdevices for the remote processor */
+	rproc_stop_subdevices(rproc, false);
+
+	/* Tell the remote processor the core isn't available anymore */
+	ret = rproc->ops->detach(rproc);
+	if (ret) {
+		dev_err(dev, "can't detach from rproc: %d\n", ret);
+		rproc_start_subdevices(rproc);
+		return ret;
+	}
+
+	rproc_unprepare_subdevices(rproc);
+
+	rproc->state = RPROC_DETACHED;
+
+	dev_info(dev, "detached remote processor %s\n", rproc->name);
+
+	return 0;
+}
 
 /**
  * rproc_trigger_recovery() - recover a remoteproc
-- 
2.25.1

