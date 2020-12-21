Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1712DFAC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 11:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgLUKHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 05:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLUKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:07:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2BC0611CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 02:06:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c7so9000066edv.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 02:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U8dIwUpOcM3a85wJXVVTJLuQjf8sprpVk53MYVi4/fg=;
        b=SEinuPXcvuPCdvW0MRn13fwCWRVS8mO4UxgqBsLX5e46XSnK0CooK8WOIgDm6o0onN
         EWzNTifuBApc+G8kCehTcxsGQOL8gVRIVOWDNDXpf+lNk6Iib9EdWAtBtbfpsExC6A5/
         dQhV5pFnOIwnVPz+bhE2SRGZMEFgIhFgrAgkIqqsypM7tIBdbzEqkZWxQwEbgD2M54do
         VMoSkAlQfGnDPQMsSyhUYJW4gNfjC1JFJvYsCdpIWz4NpRJp30ovrv1wQn1SyUlHu9zh
         +dIeLO8iCtEFEC7p5tOlM8KbO+U3322ZPSUtlRcLU0EtUJn4u3sI2ANAzgVoRGBUNNFQ
         Do2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U8dIwUpOcM3a85wJXVVTJLuQjf8sprpVk53MYVi4/fg=;
        b=XRHwhBXFEf+hZxrkYXifSErGRl7fNyM5bjoLavRENYrMA2XExauhtZZ14/ukPYtqaw
         X3K398DjRcUXPVD/WKyl54MK95pSXWfn+T5x1pz81uLcedqzctbnTEIQedsH+cPK9lz4
         5rVBNxISaHVUcyk7OLXQzUmXYIQbj1i714s5fheSUSqGQnebEDYPLHGyaI43dF0fBVhA
         MswunTCiKHW9YZ84Rx+TnSzR0xbvKL97z4rZKIFO+JlW2ZdfcjeUL0X0y5+by0fttlvk
         orWrdpCE0u7GrP4huC1ZW3ujsdzlT8dQMphP+lQ9DzD85mqfJmGYpmU+wiKooGvJOs2O
         dICQ==
X-Gm-Message-State: AOAM533Fsub+lSDEu5xaTNoB2VADTEjEZL3R1hNV3qp3TJFKw+j6OZVE
        Ke4iuLmDiVENfPD9YtFPQm7QtSU06JbGEPnX
X-Google-Smtp-Source: ABdhPJyNz19N0RdiboEsDTGOmv6wgD2nlAcSqq3mfy/nTIjy7fwLPjYOlQ5FcWOL8Sg/XZLoeIFDiw==
X-Received: by 2002:a50:bac4:: with SMTP id x62mr14940862ede.59.1608544719284;
        Mon, 21 Dec 2020 01:58:39 -0800 (PST)
Received: from localhost.localdomain (hst-221-55.medicom.bg. [84.238.221.55])
        by smtp.gmail.com with ESMTPSA id e21sm28118581edv.96.2020.12.21.01.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 01:58:38 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, vgarodia@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] venus: core: Fix platform driver shutdown
Date:   Mon, 21 Dec 2020 11:58:20 +0200
Message-Id: <20201221095820.27192-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With TZ system reboot cannot finish successfully. To fix that
enable core clocks by runtime pm before TZ calls and disable
clocks after that.

Fixes: 7399139be6b2 ("media: venus: core: add shutdown callback for venus")
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index bdd293faaad0..7233a7311757 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -349,8 +349,10 @@ static void venus_core_shutdown(struct platform_device *pdev)
 {
 	struct venus_core *core = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(core->dev);
 	venus_shutdown(core);
 	venus_firmware_deinit(core);
+	pm_runtime_put_sync(core->dev);
 }
 
 static __maybe_unused int venus_runtime_suspend(struct device *dev)
-- 
2.17.1

