Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0483C2CB957
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgLBJnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388191AbgLBJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:43:13 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E92C0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:42:33 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v3so800215plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hhWOGsCeI+HSWEvhDneQIbO6o/toOvKW/eQPadkWVL8=;
        b=sMHsqd84F90wtO1XKZOardsS6wf+SqJDnu9gf1RtjRGgzhOwjJwULiEWzy4BPtflbi
         j3kVTr2S5hnz6pOehmu8D6AL7WSyO49VlPjM9cuyvRLa1pidTb+5SSTXQMK4TPRvGlEW
         +ch9g6ht++BIyDNS3xJC531s+FYDpDrmofUUZl928V1PH6pAwCijER+QPMaybT3vPbi1
         Wcfkh1QNgPKFl7wAPYzjYom/F9St2PhRZ+OfZ39AeJ7jv5O9Gsr1WUWrsPFsFwp3BKyq
         f6prqZbWqh6Y9iGd0PgMI+0Vi75aHzHsXGcEupAHlhtjsxXQLrnaMp2Ld/JGNaWzsAqt
         W0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hhWOGsCeI+HSWEvhDneQIbO6o/toOvKW/eQPadkWVL8=;
        b=YisHBm6aTAtuiHCNOaCP3MUFuslKlage5cqLfGIJP4hhmp0rDPPDTaLdrd79Ifqoyd
         /rxxf0Dbr4DYdjARlqX2TirxYFdWhWBv4Eyfj3ElETXdhgN4dUt9U6gg+LOIs2FzUM+s
         fijL3ErsWT/CZUi38uSRoWqaDCtxeZNgekcgeK1nplBK1Rov7L/3sbhF7iaaWgUUZpOu
         P/UxYJ/hE9/m1Yts7Gt/S2rn4U79+75nNj5ZsJjAhb1wbDKmW9MkUbjxLOLuSGOIqDvL
         cemW807XZeGC94AR0qCpC3oY4x4e4g8fGAiuv4Jt9pJVHCPhZ5aGnKugDg6xWOWyCxco
         H2SQ==
X-Gm-Message-State: AOAM533dJhuT+ifXKgEZ/2inn19WGBFtlLrQSaj1klpmf8E7fYX+uV4+
        B8gYRnwi2UP5IH5grrDxD7o+
X-Google-Smtp-Source: ABdhPJx6hVG6jwueJIqdVK7OGtqBxmIW8BQLR1+MyelZ7sAyf2JOMua3gCMp51gd7FqFvqKIBhKrqQ==
X-Received: by 2002:a17:902:aa02:b029:da:a2fc:413e with SMTP id be2-20020a170902aa02b02900daa2fc413emr1786374plb.5.1606902152819;
        Wed, 02 Dec 2020 01:42:32 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:42:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 02/29] net: qrtr: Start MHI channels during init
Date:   Wed,  2 Dec 2020 15:11:32 +0530
Message-Id: <20201202094159.107075-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

Start MHI device channels so that transfers can be performed.
The MHI stack does not auto-start channels anymore.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 net/qrtr/mhi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
index ff0c41467fc1..7100f0bac4c6 100644
--- a/net/qrtr/mhi.c
+++ b/net/qrtr/mhi.c
@@ -76,6 +76,11 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 	struct qrtr_mhi_dev *qdev;
 	int rc;
 
+	/* start channels */
+	rc = mhi_prepare_for_transfer(mhi_dev);
+	if (rc)
+		return rc;
+
 	qdev = devm_kzalloc(&mhi_dev->dev, sizeof(*qdev), GFP_KERNEL);
 	if (!qdev)
 		return -ENOMEM;
-- 
2.25.1

