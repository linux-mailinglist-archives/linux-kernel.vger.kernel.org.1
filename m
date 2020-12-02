Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CC22CB963
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbgLBJn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388295AbgLBJnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:43:55 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C145C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:42:50 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id hk16so671642pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9WxRr8jkB2wGuvMfwAD98bfQ14aXLmD+0/WKbQaXe4=;
        b=hRW1WU3nt5lfKPnDD/qK8hPtS2iJyA/FB0lhozVDGDkgRCGxIkJv9GiE7lKWLm38aV
         BhPml0+XlrBr5rIf9JxjIyWMRWcPgp/1R+Z1ch1N1TWOYGYkmf6yujUpNVcv+sg3divi
         o2nViVc+PBkwR9QrtdUs+ZZI7BSdTnTlYt/DIa57Jo+10O3xqQDu5BQ6x0XDB2a0ie9f
         jnEuhiTBGn7y6YCcwmFGlyTZRmQHuLK2jKPg9lZH6yci3MlHvMx/EHXG5L0Ide5+rsVj
         pm862D6OBl56yDQuz38dqzGtfuOW7MdF/KuF0ovzYAssZzvNdLqea7eMtGGabQZ2NUQE
         4tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9WxRr8jkB2wGuvMfwAD98bfQ14aXLmD+0/WKbQaXe4=;
        b=Thn7Kshxb/HxS1N4PtFMGftshhh2LRkNcQfKlplnJcU7YfbkbhLArogwxSi0BVnwrN
         wh0Gvi4sASsy+lOpd8qHj2YZ3T3eK61/c9dMv00ycqJ7cmgYSVjapOj+VScgvX/hdQZv
         W5JR6hAVw3irMKSWS8/3PCQQLTYeAzIoxY2+ShGo2mZR696D6AcXQcP2Pu1S7CHRq+Bv
         v8z/O56QgY5MY0oMBgdSQBqQjWLzjwZa4Tp14k+CX7rcEkwGcV4SxNtSwGdLxtQCmc1f
         z83zZ/1mgYK4r2DmI+usq0PKsY9E1vfwyfj8exYctJRmwvvSRYfLnChAsfXMrW70LdCI
         EPfQ==
X-Gm-Message-State: AOAM533FyoguheOuIb9kTgIl34ofnavQlnaenR/vMBzOYw+ykgyocmm4
        Ks2ucTtWUiRHyG9v6un6jev3
X-Google-Smtp-Source: ABdhPJwde3KDGTDSNq6D1WDgvNufmTddIXeG0DH6fKN95i8L6gS2tQsCrIv5Lyx561npZyEjzfGkCA==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr1647793pjo.120.1606902170185;
        Wed, 02 Dec 2020 01:42:50 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:42:49 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/29] bus: mhi: Fix channel close issue on driver remove
Date:   Wed,  2 Dec 2020 15:11:36 +0530
Message-Id: <20201202094159.107075-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

Some MHI device drivers need to stop the channels in their driver
remove callback (e.g. module unloading), but the unprepare function
is aborted because MHI core moved the channels to suspended state
prior calling driver remove callback. This prevents the driver to
send a proper MHI RESET CHAN command to the device. Device is then
unaware of the stopped state of these channels.

This causes issue when driver tries to start the channels again (e.g.
module is reloaded), since device considers channels as already
started (inconsistent state).

Fix this by allowing channel reset when channel is suspended.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 2cff5ddff225..cea5eab83f48 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -1224,7 +1224,8 @@ static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
 	/* no more processing events for this channel */
 	mutex_lock(&mhi_chan->mutex);
 	write_lock_irq(&mhi_chan->lock);
-	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED) {
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED &&
+	    mhi_chan->ch_state != MHI_CH_STATE_SUSPENDED) {
 		write_unlock_irq(&mhi_chan->lock);
 		mutex_unlock(&mhi_chan->mutex);
 		return;
-- 
2.25.1

