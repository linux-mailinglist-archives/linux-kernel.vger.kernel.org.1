Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAE42B9DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 23:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgKSWtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 17:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgKSWtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 17:49:40 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD46C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 14:49:40 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id t13so6903088ilp.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 14:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Xvc6yFy3B6RA1AySob/CnSMzPD16sI2RoCdvJ3slvY=;
        b=CZHDJnV8efZpm/8lO8PTOPbfKNf1/Rc4jo96XFcyZu+uYmp1lTzFjpdpUGFZ+os8uO
         DFIIKYOL+Qos0m7imSxRMXr37leU+WFEER2FHEpH9y+sBikbiDF9wSqe/TPPsYEma9L5
         8QXp0ZVqKv36WsFUhypN3o7VVhb4uizFC+b3M8ryxV3HJ9EjSZXxlab06RjFIw/Shzsd
         xCvPmSjaYDAFP54qlDkI8nprljSXC+TyAvAJIVSurxjlzRF9ZBuXLnlJbbcIYVVBW4z6
         1yIMBGC11Q6DYBvWOTTkCuFFvPhhXALqHzTbgVjD4QZEYjWcqXd0cRefBlyNfYs2PSSY
         n0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Xvc6yFy3B6RA1AySob/CnSMzPD16sI2RoCdvJ3slvY=;
        b=A8wqgb7znDVgr5wPFEsCsJLPNtvuKrn7CBPlGGCsyklWxeYUajKvFfuFKAiZVKq0VQ
         SbCOfLMWBH0D9lgwtXdxPlFlcXxxBY9DcnDYbDPXKGnbB1CWzmZq2BBS+Zx2z7YRNmhi
         MUrkfrB9rcWghzhH4BBM58fJSlPJJZ+d3kW47nkgMOsQLojn0h4SoFx+HabPhE0/tsB+
         LwcsSfYXoCc2SwSCytO56Cz+/ZjeHdZ1BBfuCWectBKeuVmsHaOxfV81TvajVutTtKDX
         m6apbNZ5r1AOgSFsNVtiuu51vx3DO97A6dMpPXmHxfZggiOIu8YTW0vEIRUZrMhDGo/D
         59SQ==
X-Gm-Message-State: AOAM531au4v+6dSV/zpUe1T/fQbO6jJkG56H1hvP3Bpkz8LKbw0z5Web
        qBuQQ4LVQpZvGjflTQng7EySMw==
X-Google-Smtp-Source: ABdhPJyFUZ5g1QunsNuhtnyHZ00MCE4682v8aWwXfV5R5KdG6QhtnDGoVwVlYosEGl1C4k6sXFE39A==
X-Received: by 2002:a05:6e02:92f:: with SMTP id o15mr23903000ilt.169.1605826179758;
        Thu, 19 Nov 2020 14:49:39 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id i3sm446532iom.8.2020.11.19.14.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 14:49:39 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] net: ipa: retry modem stop if busy
Date:   Thu, 19 Nov 2020 16:49:28 -0600
Message-Id: <20201119224929.23819-6-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201119224929.23819-1-elder@linaro.org>
References: <20201119224929.23819-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA driver remove callback, ipa_remove(), calls ipa_modem_stop()
if the setup stage of initialization is complete.  If a concurrent
call to ipa_modem_start() or ipa_modem_stop() has begin but not
completed, ipa_modem_stop() can return an error (-EBUSY).

The next patch adds a driver shutdown callback, which will simply
call ipa_remove().  We really want our shutdown callback to clean
things up.  So add a single retry to the ipa_modem_stop() call in
ipa_remove() after a short (millisecond) delay.  This offers no
guarantee the shutdown will complete successfully, but we'll at
least try a little harder before giving up.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 3fb9c5d90b70e..9f4bd822ac625 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -864,6 +864,11 @@ static int ipa_remove(struct platform_device *pdev)
 
 	if (ipa->setup_complete) {
 		ret = ipa_modem_stop(ipa);
+		/* If starting or stopping is in progress, try once more */
+		if (ret == -EBUSY) {
+			usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+			ret = ipa_modem_stop(ipa);
+		}
 		if (ret)
 			return ret;
 
-- 
2.20.1

