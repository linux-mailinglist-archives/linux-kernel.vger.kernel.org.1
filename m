Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA22A6998
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbgKDQ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbgKDQYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:24:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86906C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:24:49 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e2so2901117wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9NHmedOCRIc2xnnGH01/ejWH5JuRMMipEGdnpJjxqx0=;
        b=ihd4cjor+G6rX1ggGASF3+GjYf0ln8/wEy6pGL3SzwMX98KaSj0EcyR7Y/WGIfYp3M
         pUXD2dcjMEKpJjTL01KRKr99ewg4xK2se+OWdpfjcJ5PSe5fuGbw2exkIwmXaSV6kHNY
         yqYExKB+gb0ewMroVbBS2PXG8MBBORwKRNhVIAyNYdJeG9REXbflyKQC2cYt2I8zK+OK
         ojfUkUN9Bn8gyxPfgZg4FJo36TjcrGVu67tKHfiE1KvqCuwWLLRcVre0wGyIiDU5CJIs
         w9lAnUddYUvAtb5Ur8D8e3n4BFYwb1OIjRX3obRAPXRL6lJ0UjnTSyDBS0YK6QNbsgCJ
         rYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NHmedOCRIc2xnnGH01/ejWH5JuRMMipEGdnpJjxqx0=;
        b=rj+7Zv8mHcx5t3gWsntFQ8xLwhm4gV0I3Ii6aTJ+9fAA5WWpDFXbzj8KvZujNYiJOS
         s/Bgzszx3dbl2QKD+A1FFzbZjdThv0fDiE0DlUlR1H7n2qbiwP8mRzL5fSUa0/20OITg
         X8twJoO7Aqh83C8dIBIcXDVMLydyiz3dvVaL8cN27DN3o+VaRAXe4sSPDR2FJ956c1mI
         cEMor6xMI7eNBjeY0zyoTsZaTQ4QYzZT5gbuCvnxdMOJt6Y2uf3qHF/BInIghMZhj3Lo
         zHmjognmxcbAfYuja4KR+edKmOWxeuY4uAkD7g6SBUutgmR6OaLvvvrfqyVrFecYpwzl
         q1ww==
X-Gm-Message-State: AOAM530cctk6qiqSt3pAHknY1H4t/z1mk4dCcwk1wI/hArAwf85mICDB
        tG2OVy3cNwDweybvIUvARJSwTQ==
X-Google-Smtp-Source: ABdhPJzN5pQ/mhwlh+PDZoLgd0UVb2djL7JMH20PolKMy8rlUhESY4VSUAiZsRqeTBcInCSLAH7P3g==
X-Received: by 2002:a1c:8087:: with SMTP id b129mr5455110wmd.10.1604507088195;
        Wed, 04 Nov 2020 08:24:48 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:24:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 05/20] input: rmi4: rmi_f01: Struct headers are expected to start with 'struct <name>'
Date:   Wed,  4 Nov 2020 16:24:12 +0000
Message-Id: <20201104162427.2984742-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/rmi4/rmi_f01.c:106: warning: Cannot understand  * @ctrl0 - see the bit definitions above.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/rmi4/rmi_f01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index e623c956376e3..23618fcb1f322 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -103,6 +103,7 @@ struct f01_basic_properties {
 #define RMI_F01_CTRL0_CONFIGURED_BIT	BIT(7)
 
 /**
+ * struct f01_device_control
  * @ctrl0 - see the bit definitions above.
  * @doze_interval - controls the interval between checks for finger presence
  * when the touch sensor is in doze mode, in units of 10ms.
-- 
2.25.1

