Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04B52853E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgJFVbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbgJFVa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:30:59 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F103C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 14:30:59 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m17so75884ioo.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SeRQNuUdnOGTder7Ky3iLwHcr5kl6r9wzx3ytZhXRHM=;
        b=fJ1d5oEdTTRDoZEZYc7+uJD9E26J1Ulv2STtWruQ/rVOpCh8/JQoD7CeGhsVDMUUzq
         vWmfmY+74UnmgTAVJ/cAhw7QTP1Y48rz5/yZE+HIviCHEu+NKvrfmDMQLFmveT3isahZ
         iX8we2w3S6LOpPexhnjQK8dWXziqzgTAn2FB+y/74qTiRdhKCLzeFFGrISK9B83XIwrn
         rRlBZUmnvFVFuSXXTnaKd55jKDSxP/hqVxA4ZlWQCps3BazpNfdmmnx5Al9AF6j5HPJB
         iHaZiDgnrGi8Vn4pFZhS0uUUEKkjiSCECvP9HvvmzlGgf4Lp9M714NlzDU+CG1UqLZZf
         UVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SeRQNuUdnOGTder7Ky3iLwHcr5kl6r9wzx3ytZhXRHM=;
        b=AKuQyLRTJewEu6H1BkmI1td73qUo3lRmBS13amuFMUXoeurTElI/1hFOfUpsPO1X9E
         +JtH3GpNXhUU2MtiH/p8QqRa0nRaC5E6UITiEA2o0wYw+aBlA4l3nCC49yIE6FMOlc+O
         WetK4f9zQ9udY7/8n1Ipf5qwrCAInv90tudFADZnYhfLwsojOfFmeYu8dXLnpL8j6/Fx
         XQPnd+4z6cTS9Ywj8vySvbAIDiI+3lpEQaPCJH03MYAvxsC15Wjlhe0h6vCDaqrnhG9t
         6HNlolUNw0Nw7LAfgEWS6SVjph1WXwIe3YFmBifih6dUjkngam7qH6lctXo7AFKNOydh
         U2pw==
X-Gm-Message-State: AOAM53364IaUiyEbjSSjFW808rMmZryQr8ZeHZC/5Duti7g6m1oj7uig
        NYgnGmRcuqP8eA/KMBWFZTkN9g==
X-Google-Smtp-Source: ABdhPJzDr4PRceMlDmLxQwdrbTzP3K8MGoWz3gki9rB86SibkOnGYFFTCykXgk1plTn1ocsbTsCDkg==
X-Received: by 2002:a05:6602:2f07:: with SMTP id q7mr2795506iow.191.1602019858519;
        Tue, 06 Oct 2020 14:30:58 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z20sm2043215ior.2.2020.10.06.14.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:30:57 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        mka@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: ipa: skip suspend/resume activities if not set up
Date:   Tue,  6 Oct 2020 16:30:47 -0500
Message-Id: <20201006213047.31308-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201006213047.31308-1-elder@linaro.org>
References: <20201006213047.31308-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When processing a system suspend request we suspend modem endpoints
if they are enabled, and call ipa_cmd_tag_process() (which issues
IPA commands) to ensure the IPA pipeline is cleared.  It is an error
to attempt to issue an IPA command before setup is complete, so this
is clearly a bug.  But we also shouldn't suspend or resume any
endpoints that have not been set up.

Have ipa_endpoint_suspend() and ipa_endpoint_resume() immediately
return if setup hasn't completed, to avoid any attempt to configure
endpoints or issue IPA commands in that case.

Fixes: 84f9bd12d46d ("soc: qcom: ipa: IPA endpoints")
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index b7efd7c95e9c8..ed60fa5bcdaca 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1471,6 +1471,9 @@ void ipa_endpoint_resume_one(struct ipa_endpoint *endpoint)
 
 void ipa_endpoint_suspend(struct ipa *ipa)
 {
+	if (!ipa->setup_complete)
+		return;
+
 	if (ipa->modem_netdev)
 		ipa_modem_suspend(ipa->modem_netdev);
 
@@ -1482,6 +1485,9 @@ void ipa_endpoint_suspend(struct ipa *ipa)
 
 void ipa_endpoint_resume(struct ipa *ipa)
 {
+	if (!ipa->setup_complete)
+		return;
+
 	ipa_endpoint_resume_one(ipa->name_map[IPA_ENDPOINT_AP_COMMAND_TX]);
 	ipa_endpoint_resume_one(ipa->name_map[IPA_ENDPOINT_AP_LAN_RX]);
 
-- 
2.20.1

