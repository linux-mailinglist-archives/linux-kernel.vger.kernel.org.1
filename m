Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDD2DE81D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbgLRReB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbgLRRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:33:52 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49644C0611D0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:35 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m6so1937357pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txg4LgzTONgLC7bOinTZzbCI37JS2siLcSWFwbF15Qk=;
        b=FT1wjtnmHCPECVPEQOVxWLN5IehXSRiI66FrjheH51idu4RnVyVuXK++01jSwEYClT
         KZcFQ0KFJhcsVGfoIH42EnumgM9kl6NEwU9q1v901FR335NFKd/uI3zQqmhFcU52+ZnU
         UrBN9FzQambsdleQEA8D+rYpufRq4QHqAZbw3u2I8hS4Ef79mMz71XebEFznG6UxpIN2
         EKW/X23xQvlKzToX003uherA1MKSw08scJZVf8NMCxj1EVa/iXVQZ7+M7FUbWOoBQx5V
         bNimp0NbeQwOPco7XjifzHPkmZTafaMiWHnat4Mjv2WN1m2Z993yQZMHJGR4wx/4klCI
         C8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txg4LgzTONgLC7bOinTZzbCI37JS2siLcSWFwbF15Qk=;
        b=aqaZFrk2aUS2BUeVSjZ+E40TIz0U4Hk0ogDhOxlOnY+YB7MLIGeplSdJ66F4I/4+rV
         zPvDkOlVR31NRAS1LSjKFXOMJimZqjTAj+HGAsSddOp5eJQOK2dTxg51gnaFn5tzf8V9
         2ks471zOVfwF4ypXnrABdLYJKw6fuEr67UVYx9xf/gQcZceAKPF6Mm/FKMxttsBwObnL
         ViRk9vQrD6EMdSs6uU1M/Q9ph5dniRuwA37pAFRdr3GM62FmaMYFaDw844d+7YZKXDlE
         P3rykrR4WZzMQ+3b8xhGatmAYHfeneYh5CTLBzek0EJIWS2PTYfLEu6J8uaHi0RxterO
         G7Hg==
X-Gm-Message-State: AOAM5304DyR9yDI5O1GZw33YONycnPRhkJlv4LB662bu1wd1Lh3YZjp0
        sE3XBJy/KYM15lv64zMdn5egnA==
X-Google-Smtp-Source: ABdhPJxpl9rldBP7FevfT9lA0VGRaw7OCOci0QW9tFHtQzy20O1eC9TD5qAuoEvJvgQ74t1TCRI1AA==
X-Received: by 2002:a63:2060:: with SMTP id r32mr5077740pgm.129.1608312754801;
        Fri, 18 Dec 2020 09:32:34 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:34 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/17] remoteproc: Rename function rproc_actuate()
Date:   Fri, 18 Dec 2020 10:32:15 -0700
Message-Id: <20201218173228.2277032-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function rproc_actuate() to rproc_attach().  That way it is
easy to understand that it does the opposite of rproc_detach().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f36786b47a4f..d0f6b39b56f9 100644
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
 
@@ -1802,7 +1802,7 @@ int rproc_boot(struct rproc *rproc)
 	if (rproc->state == RPROC_DETACHED) {
 		dev_info(dev, "attaching to %s\n", rproc->name);
 
-		ret = rproc_actuate(rproc);
+		ret = rproc_attach(rproc);
 	} else {
 		dev_info(dev, "powering up %s\n", rproc->name);
 
-- 
2.25.1

