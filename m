Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84E921FE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgGNUFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbgGNUFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:05:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4FEC08C5DB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:05:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x9so7482062plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHRO/0KjGNxIcLdu4Nprxq06C5XRM7DNFyiZUQDkaSQ=;
        b=HpKSrt/sw9Twx4HYSQuRe7qY2HexRKWuCG6/YkmnOA1TfIJTbMVco+HycC/GnXMpqP
         TZjyyRVe2FYTRm6E0s1cgTTjq+iiCo3g1yeKhd0cWSLw3rA+TxicbTqNBW0/wNK0siox
         +4ufU5GgjwoozEWZ7ZG+coKhws4dDc1NiLjSoEp6fJFDtEtjlbLGjaJK4nwdHstyPfK0
         Ir/2CdmVsKStSv9gbs4F3IEeC5GR7ZYr/BNed2kbgBJWjQO4HqrpjfdjU/HcWhDO1G0u
         eqQ72tDURayiZEW86/BZcasUcGJL3JXeC8E9ACR7ZQ+INM8BG+R5MIswuWu8usBVk0be
         FBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHRO/0KjGNxIcLdu4Nprxq06C5XRM7DNFyiZUQDkaSQ=;
        b=KpdZNwNdKjU9J/puAhBsxRJjSKjB+W4KcSK10x+L+4kgA/p++Ba9S+jU9CHmS5UfIc
         U/5YPkbClcHfo0O4Bx9EgTIhM6x8oloN5BUR2dsMFlvuA9d7EKgBF39nlHG+XnXiZHI1
         z9BCnwROhKOmILi3m9dWMDFMYHKc0xuDTcw4UxPCFPzTTB7hZnpvzz155HV86SkRUU2o
         3f/lr7axKXqPaC4pQ69sUg899TFmhrpT6MzOiUBbe4TWjZsKz91apw0EeOyXjg/ojX/+
         7G51KSXj5Uuj8LyuBSlsLUihL4LkeSy2oydOJr/FY6/KESZJFBSBgjF/MhTzLGbYkAqS
         N1Wg==
X-Gm-Message-State: AOAM5329Z43/L9R6CtMEtouLgNPMnnCipuruKOWZngWLVceJR789lQ/O
        SMmhN8c63F3W0Qsz71v41s5Fbw==
X-Google-Smtp-Source: ABdhPJzf7Ljcc070FSCCrVZHXRqFKMPunWgU55weQAyEjLHUA8bgjcOZIqobpXzGVURx+JoT/+hOTA==
X-Received: by 2002:a17:90a:304d:: with SMTP id q13mr6267566pjl.73.1594757101831;
        Tue, 14 Jul 2020 13:05:01 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t13sm3262959pjs.17.2020.07.14.13.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:05:01 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 11/11] remoteproc: stm32: Update M4 state in stm32_rproc_stop()
Date:   Tue, 14 Jul 2020 14:04:45 -0600
Message-Id: <20200714200445.1427257-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
References: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the co-processor state in function stm32_rproc_stop() so that
it can be used in scenarios where the remoteproc core is attaching
to the M4.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 7145cd49616e..f4da42fc0eeb 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -504,6 +504,18 @@ static int stm32_rproc_stop(struct rproc *rproc)
 		}
 	}
 
+	/* update coprocessor state to OFF if available */
+	if (ddata->m4_state.map) {
+		err = regmap_update_bits(ddata->m4_state.map,
+					 ddata->m4_state.reg,
+					 ddata->m4_state.mask,
+					 M4_STATE_OFF);
+		if (err) {
+			dev_err(&rproc->dev, "failed to set copro state\n");
+			return err;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.25.1

