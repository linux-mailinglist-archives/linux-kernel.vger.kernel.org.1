Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D62C5D64
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391785AbgKZVHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391194AbgKZVGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:06:51 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47303C061A48
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:50 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b63so2591672pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F0fzZSP3VuvALU3rn9jJyyj4XDT1VCM3xuR6CeVfSK4=;
        b=oKXhRb7rgRQ8Ff9EtJYzAcI9JIJBalQFImYaa+IHstrrVGKyeUsId9/pRSs7VBxEpM
         CfBW0UCgA0J5xT/t90eZ4Xjw4bhCzbfRoQefGUdC5tBNWIMDntsiRYprxSmapZ9Sh8qy
         b9RRPwP+M836Y8JOcTBdTyjCKDyBG5D7fAzODfc/mvellMd67kKcWmPKwM19l1Xjr5xU
         ZtDCWs4lknP6tZsneZH6ifkAPRzXx3PNAzhl16fufpW8yQpE2A+s0wPaKZ/HbHr3dD1U
         6Q6IswulcAgUChgGeZ93HbyamFASpKZNNhKIMLDkZNInZVMxKTdrdoODNWfq1wi2Deio
         whcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F0fzZSP3VuvALU3rn9jJyyj4XDT1VCM3xuR6CeVfSK4=;
        b=TlhxIfXv6idQ77wtDVgipiRT7SE9EptGQDJbWFGNj+l+QciJIhc/FpbDAnFlcLL1v3
         4NojSOAL07Itph/TIkbIT9/0FW9Y0/KSm36CRxlN1YkRRQ2gDqdz2NQ21wcTdCe0JAJq
         ZlgpCU7Zs97Am6N/p6COTfW9jQtZOniFs6lYbz/Hb8heHbAGUyk574f3D6uJTB4pZl4N
         tWAgyQ8FTYp7cojfuVDLB2beU1be6z27DrPd1p0uS2eOcv51Lt7hEQDBVoa1dpSV6vt4
         KuRj7zdJFHepQnu0TowteBYcD/TVyVXraQrqGIsiJZvoYtKZ+VyjJx5B5bMugtJTpkZf
         Dnpw==
X-Gm-Message-State: AOAM530UEA//CSMLFbfH623v0XEiahJQCQnA3sBtNEkrJ7IyuwF3FSiU
        xM6cAIHmPZsneDTIUxAormCmpg==
X-Google-Smtp-Source: ABdhPJzXTmqMXkaYZRrrfJKztyJYpaaqKcM7twnog64qKN3eoCQYY3b7rEjmGEl0B69DmTDuJVSKgA==
X-Received: by 2002:a62:8448:0:b029:197:9ab7:9fdb with SMTP id k69-20020a6284480000b02901979ab79fdbmr4161012pfd.49.1606424809866;
        Thu, 26 Nov 2020 13:06:49 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c203sm5612676pfc.10.2020.11.26.13.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:06:49 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: [PATCH v3 06/15] remoteproc: Properly deal with a kernel panic when attached
Date:   Thu, 26 Nov 2020 14:06:33 -0700
Message-Id: <20201126210642.897302-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126210642.897302-1-mathieu.poirier@linaro.org>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panic handler operation of registered remote processors
should also be called when remote processors have been
attached to.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 300785a18f03..539667948bc8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2471,7 +2471,11 @@ static int rproc_panic_handler(struct notifier_block *nb, unsigned long event,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(rproc, &rproc_list, node) {
-		if (!rproc->ops->panic || rproc->state != RPROC_RUNNING)
+		if (!rproc->ops->panic)
+			continue;
+
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			continue;
 
 		d = rproc->ops->panic(rproc);
-- 
2.25.1

