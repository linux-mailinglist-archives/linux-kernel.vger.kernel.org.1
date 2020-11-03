Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC52A49CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgKCP3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgKCP3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:15 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B0AC061A48
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:15 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e2so13188712wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1lN7RjqJKaj+07aGaEEkPtdWfQk91SehnYtAfxyeBB4=;
        b=liD2cJ9CwzZ2SYd1CLIe0i4bfS9o8r4eF78uxOpEtkZq0rwRkTnXN/vEj2kz119Kk7
         mCI/1yhdosjvPEpLnFx0SyWL/Ggod4R4H9x7TCSndD5ie8nm22eu6NCNicd3JYel6tru
         sFMU11YlXRMrUm6s+jLVtWDCCHX4QO46isavJjp1ah1UzeEv22JMSSgO3HFuFHrdjBUL
         crllpnSY8/MDMZBWfkdxyXDBVloK4HImxpDS/B2/5VniI3KTQ3BhtI7o23IlNDk9TwHb
         3uv/AH+3yNi/EeZl5VdzXdxbiS0KwmcDSgCXY0C/EEzfgKO8q7Iq/9NPgrwdhqUu93PH
         1pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1lN7RjqJKaj+07aGaEEkPtdWfQk91SehnYtAfxyeBB4=;
        b=WufXhNibQ2n/btSxcVzsb777T2Pe2wVXvc5ZupOk5bqlWqtXQvl2sDg8eCT/Xg2MrT
         6sykc2QTL1k3JtDvHS+W7Mq8VrvMbgl17UOsgRxx+MUJIGfYplEzBmn1H169V5sk3ZaG
         POfMtJX5YLgLo+ARSo3pV6kja7BJJ5+CM2q4UpO7sbei/FiBuxnv1AL+z4TPD4lomskE
         to9F3GeLE8cR0Qr1WAKl7XweBtzkUeS38x+WgqyQO9UOSs3aih7ZpbuXAY7gc8agIbrO
         Zkhxn0oanVzlrEo6ET5LnKRobbM4PzqpVEEdWg3g4IO/1IDYbH2Yit0XKrGZCyNbJHUa
         bn1g==
X-Gm-Message-State: AOAM5314Jjk9ahRgazBjBaWeWXUKMJkL8jlqkdAO00btsCwFiI/r0FCF
        2geSpQVF5cssjjX2f74CEcBlFw==
X-Google-Smtp-Source: ABdhPJz+K+q59aUgF/pQskK2VHpT36t7WbvwACmmLQuDLZx9VC7mzOZb8J9bhjgG1ed4t79TfGL+5A==
X-Received: by 2002:a1c:b487:: with SMTP id d129mr356032wmf.38.1604417353941;
        Tue, 03 Nov 2020 07:29:13 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 03/25] soc: qcom: qcom_aoss: Add missing description for 'cooling_devs'
Date:   Tue,  3 Nov 2020 15:28:16 +0000
Message-Id: <20201103152838.1290217-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/qcom/qcom_aoss.c:86: warning: Function parameter or member 'cooling_devs' not described in 'qmp'

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/qcom/qcom_aoss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 83589756cb1f0..b5840d624bc6e 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -65,6 +65,7 @@ struct qmp_cooling_device {
  * @tx_lock: provides synchronization between multiple callers of qmp_send()
  * @qdss_clk: QDSS clock hw struct
  * @pd_data: genpd data
+ * @cooling_devs: thermal cooling devices
  */
 struct qmp {
 	void __iomem *msgram;
-- 
2.25.1

