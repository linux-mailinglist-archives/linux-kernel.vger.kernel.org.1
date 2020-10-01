Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E727FA3F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbgJAH1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731578AbgJAH1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:27:09 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79504C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 00:27:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i1so4558421edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0OWQkdQ23g4BsaoKLtAWNrzzIwJHuREo+msXMwV6ps=;
        b=CoF9K8jnsLrYEQxtFaaK/kVWDXSev8UhkbXyoSoq3+aQmdZ9rWd5OvgVyXnM9zY0+W
         /2gwZ2MewRHpAs7SbqxK0Etxy4xfqBBjqTL2bRr4A3PTza9WAoBBpwFmCX0Qd2pbyhRk
         cgiztyIjl99xFczNpz8jXz5Sxp4xamCVQFA2lSuncjI40Fg+l+IQmEpfOjQvd/WLhMXt
         quk3I9H/akcKiaHXU9duIGIym+M35gQOIItKj9l5EMLfjm+QdFgaoMDUg6FlsYMG0ZVO
         c2EUf36lif1e8SfWi8GDyWVFlEt5RK395iij5bWr4Bq7QSH4kVaNcSl1CV+oAK2ZwnBW
         bXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0OWQkdQ23g4BsaoKLtAWNrzzIwJHuREo+msXMwV6ps=;
        b=QI0OEIlxlFEkbaD9Jj+XbY+WE/JuIZjPtGj4dyWWWwixf4DcylSXzyWmWCPx3r24k3
         IOtLCMcBn10lO7ITd+aY7HGEhog4sOHB7ALC0coslKVNbC40nM1LSBTHbLnszY5QXx1A
         /e0ybM5gINrrnr2TUjQaxYwFy5dCUy0pkkYm9YBs8XcUyDqWHXzYmCOwkpQfRA8IXNke
         12zh9m2Ubqxlu2VjU4dOrul+O1856WAj0eEWJDGRdVuCol9yoqvWcJDyU8OrHUDcWi/m
         cojoNfnPUTZnY0HAie5y9bYFtfSQHjhyPWU3KEZs5V0z2exFnRiR844U+MRqZ4MUscLY
         Zm7w==
X-Gm-Message-State: AOAM530Z8zFzkaiy0I1NAp6gxqKCnI6LAzlNEdja1Cmr5hqfzSyrGLCX
        Hqv+UHpGtpF199XDfHwn1Rtoeg==
X-Google-Smtp-Source: ABdhPJwQVt7yCdMmkj+vHBZGkI4/Ulj+oPSNtq7/mJiQoyzRmIU5iFG36knXAtn/EoQ2FFQfhf8o2Q==
X-Received: by 2002:aa7:d8d8:: with SMTP id k24mr6667944eds.97.1601537226102;
        Thu, 01 Oct 2020 00:27:06 -0700 (PDT)
Received: from gkim-laptop.pb.local ([2001:1438:4010:2558:4cea:8c37:1548:493c])
        by smtp.googlemail.com with ESMTPSA id p25sm3420920edm.60.2020.10.01.00.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 00:27:05 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@cloud.ionos.com>
X-Google-Original-From: Gioh Kim <gi-oh.kim@clous.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH 2/2] RDMA/rtrs: check before free
Date:   Thu,  1 Oct 2020 09:27:03 +0200
Message-Id: <20201001072703.16256-1-gi-oh.kim@clous.ionos.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

If rtrs_iu_alloc failed to allocate buffer or map dma,
there are some allocated addresses and some NULL addresses
in the array. rtrs_iu_free should check data before free.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 5163e662f86f..ca2d2d3e4192 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -61,8 +61,12 @@ void rtrs_iu_free(struct rtrs_iu *ius, struct ib_device *ibdev, u32 queue_size)
 
 	for (i = 0; i < queue_size; i++) {
 		iu = &ius[i];
-		ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, iu->direction);
-		kfree(iu->buf);
+		if (iu->dma_addr) {
+			ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, iu->direction);
+		}
+		if (iu->buf) {
+			kfree(iu->buf);
+		}
 	}
 	kfree(ius);
 }
-- 
2.20.1

