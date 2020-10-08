Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B57928763A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgJHOiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbgJHOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:38:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9301EC0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:38:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e18so6873906wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WgNDcH66XgUR5xvlin4vgOc3vaLahNaQFK4he5fif9k=;
        b=VBCYDrWwfKpjCC9cjowky2P9uUdpZLV3HYyKQwXB4FUs2ZGzR30L3E84ciUkr8vZxI
         iCURge4wpInCm+QH7mEvl8g4Ob5YmewXbBYqfOT6te+pO/gQkRzs0ek0U0ETdf6bxjqx
         SppH/aQ8oKZRQtaCSg/OGoav0prhqqoeSMDBs/wU1nvDjWWrqS3NZYsOHKuXFInLdQ6/
         FpTq6fSWZ94QjZXirNCmccnp+i7eLR9WX5V2CmJ4xvZYss4rBlCb9T9mYB6jDM1S5KZW
         NG7iWSdr7VRpgSPC+2e3l1wMXBKPnRcm5f21b0LGLKRTkwxJmNtFfMAnvBWuOvtELFcY
         0z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WgNDcH66XgUR5xvlin4vgOc3vaLahNaQFK4he5fif9k=;
        b=aif777hBxFZxNe6z7uJPIWR/eP3CpXuat2te5Sb40SmZ13T7lhTlzUQJlssl+yWboz
         MX0QQQAgmK64eGZULs6dx54T/Qar/pL0YsPn46FaDRfkxiENAtAvLgHJkysgDq66nUxk
         V/n43zdI4rn2eNzfMDAcwOn/YLwMuxzwUoJDOyAKzVot3XzmNp35v3MXtuSflG3WjUfV
         /er15ntqusjmT0lPbLXBzfG8CBhlQfko+/5uC0lRulABaWx8IGvtmXejIpmAKxhiEwKI
         Or5PtG9PRk1Vstv3tcx28ykmYayDkD0eHmxWEPeZQb0xC59LY3iZ2RO/dcPwwDbrfK1f
         gJqA==
X-Gm-Message-State: AOAM5322pabL7pFingwFhw9HlvsM3KJCBcv8RAK5BHzyYveduK9eCaSF
        EBLvaT919pCVkUqwH3O+NA4QMrKbhJDsmb/hD5M=
X-Google-Smtp-Source: ABdhPJxEGhaFlmgD1zG31MpnbwTI/UoqOHHNEJ4n2LgcKuln/yIhIQHMUndaHQL2u6qpfD9P/cmTQg==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr9783275wrq.225.1602167925062;
        Thu, 08 Oct 2020 07:38:45 -0700 (PDT)
Received: from lmecxl0524.lme.st.com ([2a04:cec0:11c8:908d:6533:9100:d943:8b22])
        by smtp.gmail.com with ESMTPSA id y14sm6926942wma.48.2020.10.08.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:38:44 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH 5/5] firmware: arm_scmi: fix ARCH_COLD_RESET
Date:   Thu,  8 Oct 2020 16:37:22 +0200
Message-Id: <20201008143722.21888-5-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008143722.21888-1-etienne.carriere@linaro.org>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ARCH_COLD_RESET according to SCMI specification.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/arm_scmi/reset.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index f063cfe17e02..a981a22cfe89 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -36,9 +36,7 @@ struct scmi_msg_reset_domain_reset {
 #define EXPLICIT_RESET_ASSERT	BIT(1)
 #define ASYNCHRONOUS_RESET	BIT(2)
 	__le32 reset_state;
-#define ARCH_RESET_TYPE		BIT(31)
-#define COLD_RESET_STATE	BIT(0)
-#define ARCH_COLD_RESET		(ARCH_RESET_TYPE | COLD_RESET_STATE)
+#define ARCH_COLD_RESET		0
 };
 
 struct scmi_msg_reset_notify {
-- 
2.17.1

