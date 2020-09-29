Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D0F27D50A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgI2RxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgI2Rw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:52:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2657C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q123so5329905pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SCbfk5KhIaeQlvR4Cwr7GsH4vv2lp3s8XkSFmUeV6ps=;
        b=CaelkjsyVnDqqLeG6nKa/oRVZl1X7PiGHuL9W0916QfNpvOs9PX+lbaoySwpk2SF/q
         Kkn6ok1NHNu7HryrR8N8CViiIjsYMCerfQwwV2uMXvJquYX0zQQ1sBJBoGlAeyS8h0vL
         qeROnRLFxVUhpQIowZmlrY8VpGA/Kvl97IHJ6TypHW7ssolgVeZoIJjI16Ty5GcZIl61
         LqbhpyvAZ6hcPYg1bDWflAJXdfoXp78ndiwNCVOocUmLtR7z/O0+yXUTeHOOnGfKIZdN
         3dnD5Nsc2f6t/BGOwZUVdy99YTxapLB23sy9ReHfBMRFDXqsJ3RDP9q65A12uh1oNRCe
         Xu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SCbfk5KhIaeQlvR4Cwr7GsH4vv2lp3s8XkSFmUeV6ps=;
        b=uhTOeQ/DplrclWfOGin/QZ21rblGqGn1V1w3VntMiRK5O4SFrC/lRmWabkxqdmbzl2
         9UY32CSmhfvhax6xtzmhIPCTp2NtARQG8WQbt5q9AMrSh35faQuQrgOFb5CJyeIHZZeQ
         o1gbKyAU3AX5aTunWXpgYg4wea48TEuMzYxkGXuF79D7RSh6WBxIPZttVGJr8/hv4rKO
         KcqS0ADT3LpE4iEC8ERhY6gahwTBZKuwJrWgWR4QCIx9VoZscNpDjV/3xRX5EEf9aTrP
         xvfika09VUvDUHGtIgpa2rp+JaPtsoHxCpdsKv78YvU8ZaajbYYFXUc0r/MvLi46I7pg
         TOEQ==
X-Gm-Message-State: AOAM531peg8P7UK85++I9sH/fJUdleSl1YGiVozA9+nLYHzEYjAevsGW
        VyiLqPviy4/CUQekk8ZIqKuY
X-Google-Smtp-Source: ABdhPJxOE2mlXSIh8bsmRUfCw/62BNg7cTPqhUCKLO7Sx7sTNRLHC3jBIFtywrf7iWYIhuxjaDlckQ==
X-Received: by 2002:aa7:8dc9:0:b029:150:e9ad:952 with SMTP id j9-20020aa78dc90000b0290150e9ad0952mr4943478pfr.61.1601401979194;
        Tue, 29 Sep 2020 10:52:59 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:52:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 07/19] bus: mhi: core: Introduce helper function to check device state
Date:   Tue, 29 Sep 2020 23:22:06 +0530
Message-Id: <20200929175218.8178-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
References: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Introduce a helper function to determine whether the device is in a
powered ON state and resides in one of the active MHI states. This will
allow for some use cases where access can be pre-determined.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 1bbd6e99d38d..5a81a428c4aa 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -598,6 +598,11 @@ int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
 int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl);
 int mhi_send_cmd(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 		 enum mhi_cmd_type cmd);
+static inline bool mhi_is_active(struct mhi_controller *mhi_cntrl)
+{
+	return (mhi_cntrl->dev_state >= MHI_STATE_M0 &&
+		mhi_cntrl->dev_state <= MHI_STATE_M3_FAST);
+}
 
 static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
 {
-- 
2.17.1

