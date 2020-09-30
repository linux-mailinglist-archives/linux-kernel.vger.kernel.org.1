Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4080927E946
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgI3NOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgI3NOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:14:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C5C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:14:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so2790500ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9c1NFhfwrwDPfx3wDNeBI3/9qOQnMvfv5KFBA5mSm6s=;
        b=imVfrSmnrqBOkthuTB26kRLGTmiQpg+emHIvdSBj3nu75G9IwnXD4chxU1KFDFa6wE
         QHmGCkvBRaqJvw63VRfLPfC/WTaE1on/8dX2RvD2PBwGLglwrEc5Gud/9sZ6KbECM+dA
         StSohkY0f6wCUAfStY3buu7VqMOY5zZqdQSjZJ56Ur1OXbibo5CXwLhnU1f11UlNNg+W
         Lof03PjmxOu47cNdOKRMEyN22saog9vMpZh3P0vZwh6lac0mr9kXwnKDzq4KHvCFV1B/
         WiruGMpCo9NsOsc4WqWIyIjq4RIwubuiB0G/j5guU1KJonlF2iGttYLw5S5k1iAiRTML
         Z3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9c1NFhfwrwDPfx3wDNeBI3/9qOQnMvfv5KFBA5mSm6s=;
        b=szALxhEU4fHZ6PLm/xbUC3YzVUz5uaGZo3jtaql0/fkyrtabW+3XVuPFFEpk+UeTU+
         DyODP6HN03XNao6IeybErL251m/sgCj515Oor0r8CGD2/T6LCXX2pbD5mwyQPmDlMSYA
         OWQujFjXJrYSbZguB/fUMNh1Kj1A0y8202QPm5/k9AC+OsnAlftnFfKPfCttV+YRAeB0
         gdzGL82+qCeUOltCVb75o/vzxb08iFb0rbMAvtKBRct/n8aq6+gcgDnyjk6uC8ltP4zj
         4/VYOdoLOzmbwgDSIy2uswuzaFBV1C5boVjsFTsXyZekPtwSoTTH1EXzBkRwfsngguof
         U4uQ==
X-Gm-Message-State: AOAM531Sz0q6RgWhR1oIr5qBeCqkLBwyRj81zxCoyix17WvJNEy8owu6
        OBqxnwWpYMOD+YOih3WLM7yITw==
X-Google-Smtp-Source: ABdhPJzNbHLFxX23PuvRE1jB1jYD/twldM5qfs1CVswIdqsxmkMXb88cv28lHemXM/Lnz3M/zrHK9g==
X-Received: by 2002:a17:906:d78d:: with SMTP id pj13mr2807388ejb.15.1601471655676;
        Wed, 30 Sep 2020 06:14:15 -0700 (PDT)
Received: from gkim-laptop.pb.local ([2001:1438:4010:2558:f1f0:c5ce:3610:b341])
        by smtp.googlemail.com with ESMTPSA id e15sm1431103eds.5.2020.09.30.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 06:14:15 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@cloud.ionos.com>
X-Google-Original-From: Gioh Kim <gi-oh.kim@clous.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH] RDMA/rtrs: remove unused field of rtrs_iu
Date:   Wed, 30 Sep 2020 15:14:07 +0200
Message-Id: <20200930131407.6438-1-gi-oh.kim@clous.ionos.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

list field is not used anywhere

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 0a93c87ef92b..b8e43dc4d95a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -115,7 +115,6 @@ struct rtrs_sess {
 
 /* rtrs information unit */
 struct rtrs_iu {
-	struct list_head        list;
 	struct ib_cqe           cqe;
 	dma_addr_t              dma_addr;
 	void                    *buf;
-- 
2.20.1

