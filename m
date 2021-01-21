Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C1C2FE6B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbhAUJts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbhAUJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:47:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C099C0617A9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id u14so931367wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gI++tdaotzFTWEtFjrYrQT/ATa/OhK5Kbs3X5CYZOEc=;
        b=wa7rs05ZwLBVT4NrU+//IeE7VH3Bh3P6pjXr71eZRYaojm7cni7eR6qIKC6+S7Sdn/
         +nR2KQCzecZ+0l5Tl3kZau/YAQzQhV57imwyLBZgiLA1kVZ+WcuBGOi0JQSAuoMapdYc
         StW3HN8o6FzCblly+f76yNmoBGUtmPCBs4w2ekNGXwYQCwI+0bvaWNBy5aPpnjCn0O7i
         YQtmzvh/PVgOtNfVAmnMaRDDEQxct2EALmN2tAdpiCkrAJ/RqogsZZoSWKzA+iD4O+Jb
         2LbYxcERfUalti9kbBk3AoJKbjSJYczMfjFrPCtx1Nge6Ufw6eBC5266soosPs/R00ur
         jyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gI++tdaotzFTWEtFjrYrQT/ATa/OhK5Kbs3X5CYZOEc=;
        b=OK+eslcQ4WAWwgQA4aX4SDXpXx/QyrwInk5ZQ+4BZdhoy8s0S8Cw4Pvgy8kvi+uFbk
         JRJ8mLbGdHPWxGVwy2zLrV9rpUFqKOD9cndiofM8ht7+tDOuVn2+1bz4k43R+IANUS5k
         7oEIczgMEmIaK9fJzMp9flesDQ2yuB536tjtgf44yJjoOvqGRijmbyiy4CniHU85xmDy
         DIr0eIgXTBfVqeR2myGfWxcpKbBdULZlNkyw7/hskcxUxE1ldQbGk+3mQeMunxc6DyTw
         7CTZfqHyFRMvgGwPWCZfAjxnBImGt2q+7XXH3UQpvwQyuPClWf9ktFB93BsKEpoPSeKJ
         SfoA==
X-Gm-Message-State: AOAM532nV/GG2t5d84pXxARH0sTtZz8zvHhLSefHamG0aFxvpOYghlj+
        R6HdQ4kNRvsRGxDUxq0vJHoIVQ==
X-Google-Smtp-Source: ABdhPJzLcptrzIXNQrmi7mv457uOgJ6M3AFulTuDrWnc7HhdLM8ljD4lIdvVhdmnjj0x3SreZ5nBbw==
X-Received: by 2002:a1c:b1d7:: with SMTP id a206mr8101992wmf.88.1611222338036;
        Thu, 21 Jan 2021 01:45:38 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 13/30] RDMA/sw/rdmavt/cq: Demote hardly complete kernel-doc header
Date:   Thu, 21 Jan 2021 09:45:02 +0000
Message-Id: <20210121094519.2044049-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/cq.c:381: warning: Function parameter or member 'cqe' not described in 'rvt_resize_cq'
 drivers/infiniband/sw/rdmavt/cq.c:381: warning: Function parameter or member 'udata' not described in 'rvt_resize_cq'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 20cc0799ac4bc..5138afca067f6 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -371,7 +371,7 @@ int rvt_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags notify_flags)
 	return ret;
 }
 
-/**
+/*
  * rvt_resize_cq - change the size of the CQ
  * @ibcq: the completion queue
  *
-- 
2.25.1

