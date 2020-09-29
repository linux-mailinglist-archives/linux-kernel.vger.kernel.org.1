Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6127D501
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgI2Rwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgI2Rwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:52:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245AC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d13so4463711pgl.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bmv3vMkNMLZAUojDUc5hK8E8LQxr3ViBRDic1DDVfzI=;
        b=CcAtM72OxPK+o7dqPeHsUK9HxRfxj3JUGhIgI5F1VOy+BcyAkIwKkoDG1jZWqrK1G0
         x08iK3XgDIL2R8Y65CmwnXDktN+ZHDlRNEYYwcy8huYwVpzQnhS/aoIMjEFXehSrEWhf
         GEm7oPb2vKtjUH58mgTUr8KPLAvFhTxGwIfGzpC6H+n962TMGexu97/pjvF8YpDKPSZb
         cj9BVqRKoVO54x2edIHT0NGEJHFSpL0SMw3z0UR7oBYzimrIEuALkRCaBd1BHG0PSYqE
         ysaw117ird8+vi75KRQxGr4Dn/hE2RQqV3GIGcx6S6zqYHyZps0/WewLZj6s1vpB5a5z
         V87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bmv3vMkNMLZAUojDUc5hK8E8LQxr3ViBRDic1DDVfzI=;
        b=hLCbkoixN2FkSxnm6a72eBAV9E/gEeAPYdfIjxhUvKzvkoR8V/fkDV5XXGMJpvLlUM
         W8ImEb8w0RTfVHU2N/D1xfFBo99GYe1SJxYHl5M+BJYmsy1HR4KW1atkfTY81i/LUAZ+
         DSjk2g7eRyx76ouZBqYBS/lmqnnkjKDzdFcGPAThd5XvFZ0Qc74gBEVrtZRuMMHAZFgK
         npl5ZB2PLS6ZosTA/0i3t8h+nsSTgHzCN1TvGaUuYRU1z2Esi59qgUfOhoOLukLWdb5w
         5PDkUwJUfb/6PvKYY1xT6pFXM6VMXfvFIUU6+yhETqFProBBqIF5Xb4+hGJXyxQApMXW
         vBNQ==
X-Gm-Message-State: AOAM531fEdl/ONQS4NK8YInA4i9SJmnjGzhjvGwN/F9ElijeJ2ySyADl
        M7JK1csElVZFSNopGKpXlGOL
X-Google-Smtp-Source: ABdhPJzL4g5H6yv/k3A+TZkQEkeTCfWweO5Yw8Dj0uw679bCHOjzMVEy8Xk9y5nOBq741rWsP4OT6A==
X-Received: by 2002:a63:f342:: with SMTP id t2mr4227953pgj.313.1601401959385;
        Tue, 29 Sep 2020 10:52:39 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:52:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 02/19] bus: mhi: core: Remove double occurrence for mhi_ctrl_ev_task() declaration
Date:   Tue, 29 Sep 2020 23:22:01 +0530
Message-Id: <20200929175218.8178-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
References: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

mhi_ctrl_ev_task() in the internal header file occurred twice.
Remove one of the occurrences for clean-up.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index b1f640b75a94..bcfa7b6558ef 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -592,7 +592,6 @@ void mhi_pm_st_worker(struct work_struct *work);
 void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl);
 void mhi_fw_load_worker(struct work_struct *work);
 int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
-void mhi_ctrl_ev_task(unsigned long data);
 int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
 void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
 int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
-- 
2.17.1

