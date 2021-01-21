Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3282FE6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbhAUJrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbhAUJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:46:06 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7178C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 190so873812wmz.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJ33o4tgodcPX4COD9SPtmLKlxciPGqpB+G6YKGSIJU=;
        b=qpboCo6Jn4F2KnFbGAFSpZ3Z+ZIt1BPReMS4x7K68RtMci3SjRk0oS6255uZFpOK2W
         aJpDGAD4eOiRN5oyF/O4L7D4sAew4VHKYjj6Mb0ZzmqbLkMtV4Sb0n7SwB8qUnMBXjwL
         An6/bpLCThSMN4TXuV84ciDR+7UAdSg4Gt+e+Lcdz0mAKv9r4ozbQnCvulyeGaakeCAS
         IfHhwsxGx7wyI/rbPKHLl7TT3G7kBh5av16hAHMNCMEaLjF59eYkXBT80CLnhgTPj+ML
         lKIBv5L5xDRa/KxrXn1fu3Km6ueUNZTeyxynnOxHO28l2HCsWP01X997cEHL80e0Vutn
         rKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJ33o4tgodcPX4COD9SPtmLKlxciPGqpB+G6YKGSIJU=;
        b=WO01+4jJSVz7/lNkh5VoUljEyTDEH2lA8F0EX51VPg4I/v/7Z5cCpbJHJxxRCpwIzP
         R0kh0iO2ThC1O1jgaaIEaU3a2rFl39jFUVZ925fboIIJ8jBJqKI7iqDhOK2snHifTdiV
         Z2Pb2NsOhprW93/WB/NVc/lDGsl4/+d7/3YBCodXCIfCu5BYAYBzdMamN9fwe9LEQnwm
         ENBaDtX5NTQ+LE0s1SvgJ9vmss+J6GALkPQvL/QpQgj8CSpXU6IAh3U6HPssP/79MmbL
         DlqdxttUUnH5U/ScL5TjykRi4dF2k3r1hb4qPOIL/qfebLP+ysu2Q5npvEHbPWGIgCLk
         beNw==
X-Gm-Message-State: AOAM533ffmvTQ5pPFirJGstpgDZBeYooO/QHE4aHSNmpd+h1OD8AZsn6
        AgrWNh3QRhTw1SYKj+dZs05K5g==
X-Google-Smtp-Source: ABdhPJzLatP3nSzaG3gu3Zq9S87pzShfBipjh2qaGsUDLMVOi1AGC6tbdhTzGv40b+h971zvRsW6Eg==
X-Received: by 2002:a1c:6741:: with SMTP id b62mr8216797wmc.21.1611222324492;
        Thu, 21 Jan 2021 01:45:24 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 02/30] RDMA/hw/mlx5/qp: Demote non-conformant kernel-doc header
Date:   Thu, 21 Jan 2021 09:44:51 +0000
Message-Id: <20210121094519.2044049-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/mlx5/qp.c:5384: warning: Function parameter or member 'qp' not described in 'mlx5_ib_qp_set_counter'
 drivers/infiniband/hw/mlx5/qp.c:5384: warning: Function parameter or member 'counter' not described in 'mlx5_ib_qp_set_counter'

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 0cb7cc642d87d..c916e48b2e529 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5376,7 +5376,7 @@ void mlx5_ib_drain_rq(struct ib_qp *qp)
 	handle_drain_completion(cq, &rdrain, dev);
 }
 
-/**
+/*
  * Bind a qp to a counter. If @counter is NULL then bind the qp to
  * the default counter
  */
-- 
2.25.1

