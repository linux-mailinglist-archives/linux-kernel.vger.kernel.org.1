Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723B72EE9DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbhAGXfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbhAGXfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:35:44 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ECCC0612A2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:34:13 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id h3so774193ils.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jp4jA5VOpxCAdanHFN3bi6TajwKIp0Iz6erEpMOg0cE=;
        b=G7cxNq+GNEp76ltapeUdfzfbwkmXQwvIBuF7CJ5zql10JvmpHwE9AA9/xxGXRqAWi3
         9QkFg+MiWsOG/IoQqpkKsSn+Kfb+dyEFbpOuqV1MmnwoC1U2cdiLzZftDmx6e11ienxK
         vbJkvQ4qhHeEGHfEfXxWmahSmAVXPTcbw1cDHSkt4jrEo8jiht8U5JaBcgVQNEAUCWs7
         f0+NwVlTdxO8uEfRDe5zRtVbY30d72Tz37ebFxkZvpKejibIrpKrwvsYkNRoD0fRRi2r
         EsLygg1b6i+tD1nNQ85Nw7yP9ssMOqIgNdg/cJ6xYa6T6ZrML2qsCdouizqpwsRMOLN5
         xhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jp4jA5VOpxCAdanHFN3bi6TajwKIp0Iz6erEpMOg0cE=;
        b=aO70tixm7OW5xHAti+Tq29XMUgTUNElFGuTlg3xF84xM2ah9pKWSqJ+TwH1s1nhXJe
         5lQL/WaCN16MAFILzZwX6MnIAe4tXVvCKutNbu2BTWD7x2tHny5AfkZeaOiA+7pd4VtL
         sghObb1Kz0lfW0loRjxPXgFLK7MR+GjZ1rXlYvSyosJykPVXQpSm/cyz+7A8FPNHjoZw
         frmv2/ORPeNLZfsDiSdeGp6ydS8eVu7P32TSuQGo1rP/7UDrHwxEe3I5dAa1UsrWGA+p
         98TcZh9JMRTTqEhmfXRq0Xz1rNlQDfgsS7m177IIf6al9b2MgfQ8E5wUzadDtDe8pjUA
         UaBw==
X-Gm-Message-State: AOAM532crZAxlC3P+3u+xQdgOtiCnvZVrnlcuPt2wuaR3Z+UKRGXwjnt
        RG7b0fUupm1lRxLsn5M6kkv3sA==
X-Google-Smtp-Source: ABdhPJwG3GNNIK3srbianIUC1W25DLdDH9iWzkTwJGbge+Xv/NoW4qdFKPzz0woU+/1kXEkxBu3FlQ==
X-Received: by 2002:a92:9e1d:: with SMTP id q29mr1192638ili.289.1610062452573;
        Thu, 07 Jan 2021 15:34:12 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o195sm5648521ila.38.2021.01.07.15.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:34:12 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, ohad@wizery.com,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: ipa: support COMPILE_TEST
Date:   Thu,  7 Jan 2021 17:34:04 -0600
Message-Id: <20210107233404.17030-5-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107233404.17030-1-elder@linaro.org>
References: <20210107233404.17030-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arrange for the IPA driver to be built when COMPILE_TEST is enabled.

Update the help text to reflect that we support two Qualcomm SoCs.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
index 9f0d2a93379c5..10a0e041ee775 100644
--- a/drivers/net/ipa/Kconfig
+++ b/drivers/net/ipa/Kconfig
@@ -1,9 +1,10 @@
 config QCOM_IPA
 	tristate "Qualcomm IPA support"
-	depends on ARCH_QCOM && 64BIT && NET
-	depends on QCOM_Q6V5_MSS
+	depends on 64BIT && NET
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
+	select QCOM_MDT_LOADER if ARCH_QCOM
 	select QCOM_QMI_HELPERS
-	select QCOM_MDT_LOADER
 	help
 	  Choose Y or M here to include support for the Qualcomm
 	  IP Accelerator (IPA), a hardware block present in some
@@ -11,7 +12,8 @@ config QCOM_IPA
 	  that is capable of generic hardware handling of IP packets,
 	  including routing, filtering, and NAT.  Currently the IPA
 	  driver supports only basic transport of network traffic
-	  between the AP and modem, on the Qualcomm SDM845 SoC.
+	  between the AP and modem, on the Qualcomm SDM845 and SC7180
+	  SoCs.
 
 	  Note that if selected, the selection type must match that
 	  of QCOM_Q6V5_COMMON (Y or M).
-- 
2.20.1

