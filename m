Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E661E272B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgIUQKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgIUQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:10:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFE7C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:10:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u13so9468102pgh.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SCbfk5KhIaeQlvR4Cwr7GsH4vv2lp3s8XkSFmUeV6ps=;
        b=rdwKiMbw15soRTNgDT16iUi/RaR4vGcj998+9ku+WxSzu/MlxUra5XX0ii3CcLXYuR
         oXCFK+OzujkmeJmFnS8TBqqZaiDmAuyRNNF7vbr2/UV4F+z697ANlhePjuktJ9Xt0ZIW
         BDTguJyeFEvUilrZ4vWLSZBsnA774lzjXW2qJKsawrJBSyBEeF8i9+MvHIH8+8Or1ngA
         xCbqZetbs/Fh4YqLUq0+OUZd1x603vy0FGzVZPxqKLxPnTGPsEnTRylJu53eBzSt0yTb
         pBgjAka1/yZaXYsqIApPwdo/y0fZexuRrl3cplfdgFzVgTcJd6MHfygzfFC6U8wURfDq
         tytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SCbfk5KhIaeQlvR4Cwr7GsH4vv2lp3s8XkSFmUeV6ps=;
        b=jaVIyKJlTctxHEomBXFM6fFuxI9429Wzd2H3xiLmgdBkG9FBfH8QUe+c/XaFNuS+WA
         brRHq3LBaYsH4An0jWQBK7ebGDKpzCwbcED7KF8RkWZX4dbwWNYCoIzrg4fwsF+jcW/j
         T6FNm4oEGvhfTbTPizLZp4y6IFs3nhfNAdAMqmlvGZapGuhCV6VS8NSu3LXojljRvK3r
         TLb5SlPcDMCnClsCV8JKGTFPLuHuIKWWIprwsEEGnCA4hrV5kHPYB2k2dcNGAqvHCaXI
         yYCMn7zwM6Vu/eUS2KA8zNl8woDqI9Y7gTXcRGHhR8mWJ3bwGKPyDAG9h4flQ09i+SVQ
         cj9A==
X-Gm-Message-State: AOAM532gaE2VTb0Mx2JpX1l/VCnvmFKxqzDVxlVTUDhzve+XJY1CbTIm
        D7QHqE67PGCK6Tg4fDt6ok+o
X-Google-Smtp-Source: ABdhPJzQxB9AAqs9pHSYgnLOqarkBdkFgsGhxoNxac2OdMjNlIPlqD4xSychnhw5DW+yGcF4q4aDJw==
X-Received: by 2002:a17:902:d3d4:b029:d1:e598:3ff3 with SMTP id w20-20020a170902d3d4b02900d1e5983ff3mr630205plb.45.1600704616562;
        Mon, 21 Sep 2020 09:10:16 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6d03:bd12:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id f4sm9204577pgr.68.2020.09.21.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:10:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/18] bus: mhi: core: Introduce helper function to check device state
Date:   Mon, 21 Sep 2020 21:38:04 +0530
Message-Id: <20200921160815.28071-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
References: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
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

