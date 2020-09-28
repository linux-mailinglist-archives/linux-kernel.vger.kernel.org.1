Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF02127A62A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgI1EKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1EKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:10:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7EBC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:10:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q123so2936049pfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mLM1ooiBRvHKnVHboD9nW5AfyUuBhafQkkCUD3MREGQ=;
        b=uj70iwN7Om8mBXDBHTyn3n9uBZav9OQBi2ibF4cPRnAJv1Fgmjp9d0PA6yKsUNCo8p
         Zml8+Jr/GHooh+CAQ62UnpDtJprVYnoQJvt9i/W9gvJMCjmg9Zgb8i1CgpZV78PNZgar
         p9F3oueAZEnQdSOBNtQjH0YdD1YAGs6JQcs/pcpqNcw3s2p+PWQGYROh2eMBgJDJ3Vu+
         smGF3vvG+kv/tTi6lEoaGsKQ9h3dtE4Uj2JSDZ/FtYMFlblSPE0IhtSrCY8Bo98IBZad
         S05NDWDclJIxPKPpbKFojFRRfq10cLNTh6LD2Osnyck3cAGVwRKUPzKFFYjXImFN8dih
         /W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mLM1ooiBRvHKnVHboD9nW5AfyUuBhafQkkCUD3MREGQ=;
        b=G409AsPMpkmPP9uXBVBfT7G2lscnEi7A/zed3K+1WJRLIrK4b3mIzJMqlHEEhi8aGn
         O6TP5KysmHgmHQzqcFXGNXXawoB0nNYfsJ+VY6+WRRVrDrCja0WGWBL3812LyrIyHFFi
         EtASJUREl4VixG7HOzurtZAy7FBpGF/caLtkNxFoEieyEzxXmeyzYuEiX1ts7lTXhtOM
         1jPCTlJuOL+D63zQJbNIGcBMCC/GBjegW3sBNXY937bnI7usRDI+nd4JwrmSy+gZfVL3
         uQ85ENar5Y6v2CItP36xBh6V+4s/uB80kdBypST07BpKanbRcCKjxkMQFjhWSGrDOXqO
         fOWQ==
X-Gm-Message-State: AOAM533I+rK5c2uXnxB5IEo/RruPs80WJo+jnVMMng+ZpJlCQYsKSR0F
        BPD7tbMGjf3C54/HcLjjgS5W
X-Google-Smtp-Source: ABdhPJymDsdfy18yONaUhpTsOEGUG1/Au6IP4UUUgdj7FzjnwfJppAc1PWzIrjCdRn1IjWFRxHaMgw==
X-Received: by 2002:a63:e655:: with SMTP id p21mr7539114pgj.420.1601266250974;
        Sun, 27 Sep 2020 21:10:50 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:10:50 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 05/21] bus: mhi: core: Trigger host resume if suspended during mhi_device_get()
Date:   Mon, 28 Sep 2020 09:39:35 +0530
Message-Id: <20200928040951.18207-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

It is possible that the host may be suspending or suspended and may
not allow an outgoing device wake assert immediately if a client has
requested for it. Ensure that the host wakes up and allows for it so
the client does not have to wait for an external trigger or an
outgoing packet to be queued for the host resume to occur.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index b227d415e937..27bb471c8f4e 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -1112,6 +1112,9 @@ void mhi_device_get(struct mhi_device *mhi_dev)
 
 	mhi_dev->dev_wake++;
 	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
+
 	mhi_cntrl->wake_get(mhi_cntrl, true);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
 }
-- 
2.17.1

