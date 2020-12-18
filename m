Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701662DE81A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgLRRdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732479AbgLRRdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:33:51 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32291C0611CD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j1so1768084pld.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dhrgj6KlTsZx4Q0NhpQquJvgjz/fkM6eRvngZm9P8MI=;
        b=CCTWyUnzE1ZanX60E/iLMHT0I8ZKWfPXwPWUJWfADUGe1anX5MYdsbtqq9PzKYM9/j
         n7OFo3P1s+0nskqFjWV2eOnXUxh+q3oIlb7YjcMN9vV5TS0FghgN1ctFHNf7Rs5OaNz0
         a8foVoXrny67rmJYDx25RebAwa6Lrn/essn4udioOyBENIujDvSTMTEVSTk8Qvua6HIX
         F6eS1tPhvPc0tLr2Gt4TMUD4Gxhq6n9EZAt+jGOgvH+PUKd8fKp4GcO0SWVYVXMomcsO
         94YO06VeiG0HGk4RyldO1QnAYqBw1oQ3vmmw06P0vDdLEFM5eh910MItWLsNhZOUaYT8
         Lc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dhrgj6KlTsZx4Q0NhpQquJvgjz/fkM6eRvngZm9P8MI=;
        b=lsWrzZqZPSsLA8/afh7gA3Nk64XLVyQxf3S9Kl17n+DroCBu9/93OzZEdDqAKnUDaq
         8qcSyOWJIry/Q9E+g58gDlj9jEWbOI2/vt+b/AwVUmpaugOiXQBbgF1vZF8T9G72kFjq
         mWYTeEp0z7cKFck6yYoRzMzRrZ5au3FM95o/ftuJ8XvACW9etU6D7jnCz0qc2bSghPfE
         s1BN4mjuZAOoFUWgwgseYl1KDqV7TbpDNzFNpEo2ggJf8zQz26WILWJ6qSrU1wuinffC
         BNfpzzS22gnfuQ/AlQ0pNzxR4IGcgP53/b71I3kaCpNRzJ2ja0EbtRJ+mheZlFMqJ9zx
         jrCw==
X-Gm-Message-State: AOAM533tJCTF0/OcjM+XpnnAmlox5fMb50mpDGQgd0kjhcfl+N0z0ofR
        uAuulBe0LPbMjBoIc13G7mF47Q==
X-Google-Smtp-Source: ABdhPJz1O4ARyo97p4ERGZ8tIxm75Mh6Rpq8eLB1mpohO9enHdudp/vj45e4rQqTrMfnfxHaw63xAQ==
X-Received: by 2002:a17:902:e9c5:b029:db:d1ae:46ba with SMTP id 5-20020a170902e9c5b02900dbd1ae46bamr5424989plk.38.1608312753708;
        Fri, 18 Dec 2020 09:32:33 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:33 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/17] remoteproc: Remove useless check in rproc_del()
Date:   Fri, 18 Dec 2020 10:32:14 -0700
Message-Id: <20201218173228.2277032-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether started at probe() time or thereafter from the command
line, a remote processor needs to be shutdown before the final
cleanup phases can happen.  Otherwise the system may be left in
an unpredictable state where the remote processor is expecting
the remoteproc core to be providing services when in fact it
no longer exist.

Invariably calling rproc_shutdown() is fine since it will return
immediately if the remote processor has already been switched
off.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e55568d1e7e2..f36786b47a4f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2283,10 +2283,8 @@ int rproc_del(struct rproc *rproc)
 	if (!rproc)
 		return -EINVAL;
 
-	/* if rproc is marked always-on, rproc_add() booted it */
 	/* TODO: make sure this works with rproc->power > 1 */
-	if (rproc->auto_boot)
-		rproc_shutdown(rproc);
+	rproc_shutdown(rproc);
 
 	mutex_lock(&rproc->lock);
 	rproc->state = RPROC_DELETED;
-- 
2.25.1

