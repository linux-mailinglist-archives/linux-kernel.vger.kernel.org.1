Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B9726C9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgIPTUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgIPTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1CC06121C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u13so4487518pgh.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HpYyj4qZKMiQrhkLmQ6jFNs4bPCRuP5wWzHJHDFeRMc=;
        b=Y2CwCZsAcwL5yqfKlkrrTLM87XSObjfgOYnf3++11MOnqNwUDN+/euYza6Jd0qJPV6
         Mxx7Gbb65RsAlajTUnpHMG64ZObFOv8JUCcn0pdKi6TThp2Pkwz3iHUXaF09EepAV/Ln
         lg06q0kdbpaYMCIx3wNYSZ4JIBwt68DptwOL7nGemLWuFeRZoJHWKJbsyYYboHo0JeW/
         HwZVeYLaMwwMoqQIOSdubsUo7GbsFchYGWsJzKoa3BqxDB+nQYuEgQ6a19oQ8d7FY0uR
         evfPC/bmm6cAH3ia6yPr+g4H8LDVVp4mi1R6srr/rSOg9J8tGEz3TrdpaXjvVyf+4IjY
         M43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HpYyj4qZKMiQrhkLmQ6jFNs4bPCRuP5wWzHJHDFeRMc=;
        b=T45kn1UVbLrP1ljfv08B7WbHo+d11UoRG8Qnj/M8NA5tmdARzSWx3aPLzLgZ53gGRu
         FPlejITMDKsT3w+EE72x9R3Pbw8uNbID1uuhsLL4vh5xt8lmnLBI7MqTVmR/zscPTBSo
         weeFLdEmbAcxT26tShI7QdFV9wAWOjDqluKUe8msb0GittpNjneTq6JwQU0EgxuNuTBG
         4l8A2RE8ft14Wg8sk+xFtxckfNj1XFKZvkuWn/cJVx3JIGlgFBEqQRi4BUn/qI1CROEu
         vpDQrLvisTeTpbkAgDTydjryv0JFJW3JXMdZGINVvkFwtNcbPcBv7hl0rUYBRRx0qFVs
         RvPQ==
X-Gm-Message-State: AOAM532NMxMRj6frj0gTgVyf9TujBfhZupnUF70rev20RqH2ti16FIxi
        mWKRZPJupgD06OYGInWUt/M4WA==
X-Google-Smtp-Source: ABdhPJxhVg9lL5+jHQDhFsvgwbVsVERYt3fgy0p5D2jJAdzA5r5HWAclfuC7mHhGrQAkWMpDAzTDOg==
X-Received: by 2002:a63:6782:: with SMTP id b124mr20671377pgc.308.1600283874707;
        Wed, 16 Sep 2020 12:17:54 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:54 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] coresight: Make sysfs functional on topologies with per core sink
Date:   Wed, 16 Sep 2020 13:17:35 -0600
Message-Id: <20200916191737.4001561-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linu Cherian <lcherian@marvell.com>

Coresight driver assumes sink is common across all the ETMs,
and tries to build a path between ETM and the first enabled
sink found using bus based search. This breaks sysFS usage
on implementations that has multiple per core sinks in
enabled state.

To fix this, coresight_get_enabled_sink API is updated to
do a connection based search starting from the given source,
instead of bus based search.
With sink selection using sysfs depecrated for perf interface,
provision for reset is removed as well in this API.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
[Fixed indentation problem and removed obsolete comment]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h |  3 +-
 drivers/hwtracing/coresight/coresight.c      | 62 +++++++++-----------
 2 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index f2dc625ea585..5fe773c4d6cc 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -148,7 +148,8 @@ static inline void coresight_write_reg_pair(void __iomem *addr, u64 val,
 void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
-struct coresight_device *coresight_get_enabled_sink(bool reset);
+struct coresight_device *
+coresight_get_enabled_sink(struct coresight_device *source);
 struct coresight_device *coresight_get_sink_by_id(u32 id);
 struct coresight_device *
 coresight_find_default_sink(struct coresight_device *csdev);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e9c90f2de34a..bb4f9e0a5438 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -540,50 +540,46 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
 	return csdev;
 }
 
-static int coresight_enabled_sink(struct device *dev, const void *data)
+static struct coresight_device *
+coresight_find_enabled_sink(struct coresight_device *csdev)
 {
-	const bool *reset = data;
-	struct coresight_device *csdev = to_coresight_device(dev);
+	int i;
+	struct coresight_device *sink;
 
 	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
 	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
-	     csdev->activated) {
-		/*
-		 * Now that we have a handle on the sink for this session,
-		 * disable the sysFS "enable_sink" flag so that possible
-		 * concurrent perf session that wish to use another sink don't
-		 * trip on it.  Doing so has no ramification for the current
-		 * session.
-		 */
-		if (*reset)
-			csdev->activated = false;
+	     csdev->activated)
+		return csdev;
 
-		return 1;
+	/*
+	 * Recursively explore each port found on this element.
+	 */
+	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+		struct coresight_device *child_dev;
+
+		child_dev = csdev->pdata->conns[i].child_dev;
+		if (child_dev)
+			sink = coresight_find_enabled_sink(child_dev);
+		if (sink)
+			return sink;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /**
- * coresight_get_enabled_sink - returns the first enabled sink found on the bus
- * @deactivate:	Whether the 'enable_sink' flag should be reset
- *
- * When operated from perf the deactivate parameter should be set to 'true'.
- * That way the "enabled_sink" flag of the sink that was selected can be reset,
- * allowing for other concurrent perf sessions to choose a different sink.
+ * coresight_get_enabled_sink - returns the first enabled sink using
+ * connection based search starting from the source reference
  *
- * When operated from sysFS users have full control and as such the deactivate
- * parameter should be set to 'false', hence mandating users to explicitly
- * clear the flag.
+ * @source: Coresight source device reference
  */
-struct coresight_device *coresight_get_enabled_sink(bool deactivate)
+struct coresight_device *
+coresight_get_enabled_sink(struct coresight_device *source)
 {
-	struct device *dev = NULL;
-
-	dev = bus_find_device(&coresight_bustype, NULL, &deactivate,
-			      coresight_enabled_sink);
+	if (!source)
+		return NULL;
 
-	return dev ? to_coresight_device(dev) : NULL;
+	return coresight_find_enabled_sink(source);
 }
 
 static int coresight_sink_by_id(struct device *dev, const void *data)
@@ -988,11 +984,7 @@ int coresight_enable(struct coresight_device *csdev)
 		goto out;
 	}
 
-	/*
-	 * Search for a valid sink for this session but don't reset the
-	 * "enable_sink" flag in sysFS.  Users get to do that explicitly.
-	 */
-	sink = coresight_get_enabled_sink(false);
+	sink = coresight_get_enabled_sink(csdev);
 	if (!sink) {
 		ret = -EINVAL;
 		goto out;
-- 
2.25.1

