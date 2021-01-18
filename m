Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5421A2F9975
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbhARFns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731955AbhARFlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:41:05 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20338C0617A5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:40 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id v19so10224383pgj.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7d0QJMTDkB6bKO/MOq3WH9j1K0B2fh9R5NIhHxb7PuA=;
        b=KwgI+tUdmVCcvrlZTxSAcz5lBH+2tlX/nRsorjTcerilObn7PBnRp5krI64I0p8HsS
         i8ymgeitLNPrJL5Ze6JsihA1laKCSeNfKr6nA3KvOgXZ5aBZj4Uh7JbpdwdKLh/cWhBw
         RwZ71qkqx97Sdzzq99rKu/AGRWZTtgercX5InMhNK8hIWqBP+GFT0uqns3bcAGwGIidm
         Ln2uUryoMWLhhkgkgDQz0IS1t5OJrPjPUaknrkh7Hn19NNwsXXLdkmQCMGYnjjCanS+6
         IjMmXjB/X48y8b2pk3HXsbtLgFPrpHn9mE40preuZD/FgKMOBvMpGwqHyBTsqCWOBkZQ
         BJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7d0QJMTDkB6bKO/MOq3WH9j1K0B2fh9R5NIhHxb7PuA=;
        b=b5rKRRWHHXcg8P0HE8L0xkoTr2iEjknZIMbbD4Miv5/NaFmrTrr/RIbopm8Pmax8m7
         RSoVmsii60PtmMtES9xkVgTg5z6hSqrL1Ivx0RVIX45+ZaxId13dWQrfOX4Ss3zcSR/T
         0yq1lP6d/9xchFsw+s6urs1aFOeBKIQRKhsqv29ZH91VfTO5iLxNrfRrUkmwWQvZ8dVM
         tTwkkh+zzCXc9KF8yanpSEE3Exh2oOnN7bIeMf4ETPFNn4/uJdreCVdt9tkjo93oF+0j
         VqGyaUuHMlvbnQdBTuo0RN1WG0R6dnjrsIN7i89x6VXwnTw6qt9mfJi/rT+N0woLRfIZ
         pvEg==
X-Gm-Message-State: AOAM533cDcJP+MepnnfYX9fGod6XV6Os06Depvrg5Ck17aRxWi2CkfK0
        ueZSyemRRELWRwPWqkZvxjAo4DIEGFL9
X-Google-Smtp-Source: ABdhPJwr0/vws/1ANGbWbU8/OB7fLHxubDaVGVeiwic+ka5npoVikryAprgK4LmAt5anc0z54ajsWQ==
X-Received: by 2002:a62:9208:0:b029:19e:a15f:169e with SMTP id o8-20020a6292080000b029019ea15f169emr24261442pfd.71.1610948379657;
        Sun, 17 Jan 2021 21:39:39 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id z6sm14627271pfj.22.2021.01.17.21.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:39:39 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/13] ARM: configs: qcom_defconfig: Enable RPMh power domain driver
Date:   Mon, 18 Jan 2021 11:08:52 +0530
Message-Id: <20210118053853.56224-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
References: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable RPMh power domain driver to support power-domains on platforms
like SDX55.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index c9081e5afd43..32f3988631bf 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -247,6 +247,7 @@ CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
 CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_WCNSS_CTRL=y
 CONFIG_EXTCON_QCOM_SPMI_MISC=y
 CONFIG_IIO=y
-- 
2.25.1

