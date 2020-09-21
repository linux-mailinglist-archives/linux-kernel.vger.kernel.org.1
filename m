Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500AE272B18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgIUQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgIUQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:09:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C77CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:09:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o25so4502536pgm.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mLM1ooiBRvHKnVHboD9nW5AfyUuBhafQkkCUD3MREGQ=;
        b=RTlt+ko60rK2/zapD8GKHlZvzBuw1IGAKR8ZEb2qajV5uohv9e9M77T+SlQGPWBnxV
         dOzDqtx6vXcsSro7q5q6lQhS2gsLQEH6TAt6jcWc09Uwvj4aDKHlrpXb+K0roAtRKV17
         HqC4djsJ3cOGTI7UdKjOsf0HS2nJoTRi6emifrbWYvwjvTCnJENFdrkNxh2HI9c7Di5f
         M3J+KJjssFOFv2wBnk6DcQ83ICxaSw5cyAikweh9EtCTOH+UsDaiVNJQqHF/JTrSU2l0
         UQSDrjZVgeK0uIoh72jfs/2FUuzAsmQ4pKgbd2EFEPGMh7Ima6r1YeY5eZOKMb4A3eP1
         tWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mLM1ooiBRvHKnVHboD9nW5AfyUuBhafQkkCUD3MREGQ=;
        b=S6mV/ALQy1utQ6nzhYG32hObQsK0+MoyM/nllLWSgPx34IJG2yRLkkE0w4zK1QtZsB
         Z8yFwFhfgaFo3hnxRlPmZr4TnbsEpOg2BCdSlcmndb/LRyMeo9sGWeUDHXfMssmfsedK
         UW8A8STTJP96JTcjxWktl6S8tCkhC7pKDabJ5o3rH083iBik6+bFux2LsjBDss7RgAMl
         hX1Bjw6MCAkeJcBU71HEJM6xC0hv5mZanxMAP7XDTBqnQYc8me4SeHSrws3qUbyGYfvj
         SgZySuEwgdUkfBejuFIBVo7b6kpJT2GJP4mZarNhTVy5ROQgq0GAvU1xisqKn43dgCQC
         Qq5Q==
X-Gm-Message-State: AOAM531sYN7woe83CYCE6yMeOl5evF+nzouXXy3cNoqB8ccXWKkGm7uw
        8A/3jVvA07k3Bw4vi9Gd4s7S
X-Google-Smtp-Source: ABdhPJxiPuI+p4Gw7kYi2ZVYeBdeqDIkwnTTAcKk8jfDI9JInlNlEiN3rqVRTgui3onFEznWXs+LMQ==
X-Received: by 2002:a63:4a19:: with SMTP id x25mr308949pga.56.1600704596746;
        Mon, 21 Sep 2020 09:09:56 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6d03:bd12:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id f4sm9204577pgr.68.2020.09.21.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:09:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/18] bus: mhi: core: Trigger host resume if suspended during mhi_device_get()
Date:   Mon, 21 Sep 2020 21:38:02 +0530
Message-Id: <20200921160815.28071-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
References: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
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

