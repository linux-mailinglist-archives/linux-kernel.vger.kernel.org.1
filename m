Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67934303E03
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbhAZM7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391300AbhAZMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D9C08E8BB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q7so16302863wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnUOXuaDVhzv+JRzF2N3phcXKpl5z42SkYZrTN+HwL8=;
        b=MqNVz8RNxX/zGJoBvGZbRzmox2XT2+Oo/kNZZVSP2zXsRlIQkB6mQwDoEBKNS+SK4q
         Z/4yHb7RqDDLXtoV7Rl536qDZwv7sYfZeavJ9tMpe+Ksv1Ss4RMNynaIgYmnCjSGWGsF
         3HiYTJDeO+PRz9SVF6G9UzhTAwOJSAWOtGC+eGgr9wfCHNVoNzlL7j9NDn9SUsa5uPbi
         6YEDTLtk6bftJmna9JYd7xBUpLEzK5bn6EcKNrY6GWQ7h/M1NeyNVZOkfxXt+SMg+Wgh
         /wOOjdsMNBbmv2tmNmERZuUae9CxU8/Vg3xFbF/Ip/K+RnHJZRZBY7hHLbW0jKAt2bub
         Kk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnUOXuaDVhzv+JRzF2N3phcXKpl5z42SkYZrTN+HwL8=;
        b=ohOleDCFBhKIJ9iz9JBe20hrTIo3OxTdB3sQ03F+VIWWAdUN37+X1vcPbJ4/cWLfCs
         DyL11Dm8e4bhcssrA77o+AucISoIunOfw83DEPbEF/RDS0yJQa28u3krqNfohMVkRZJ2
         5z96XgZMW3nd7zZfpB6MUSNFNmxdhAoMhjD1PFTxH2zuK/Af9vsC8oB53YIdQXCIN8mC
         WCIbg5zmx9g0PofDCMeaOnR00WqR7G7GO8tlj6a2qsmJV0uVt+WdlM/Xkeu9HoWUaUVf
         +fBhcwUyd5gYqSkannAtJl+8iviJiUCue/UPbn25Kl0+8Y+uOpiCi3Sp1IBR2tqAYt8Y
         I2DQ==
X-Gm-Message-State: AOAM533BD5O+W6k0HE+BSNgByUhKDQBFjEVeceC3a5KQBxI+JPTS8dnB
        lu277gXNsPwGH2wjiaIVk6NeHg==
X-Google-Smtp-Source: ABdhPJyLudmPTC3h2iicIMU90/lCacPFTuduSuKUdXae8KM5eDTxCucVccuknk2sFWP6UvfheL9vuA==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr5883891wrj.225.1611665268097;
        Tue, 26 Jan 2021 04:47:48 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 11/20] RDMA/hw/hfi1/rc: Fix a few function documentation issues
Date:   Tue, 26 Jan 2021 12:47:23 +0000
Message-Id: <20210126124732.3320971-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/rc.c:430: warning: Function parameter or member 'ps' not described in 'hfi1_make_rc_req'
 drivers/infiniband/hw/hfi1/rc.c:1387: warning: Function parameter or member 'packet' not described in 'hfi1_send_rc_ack'
 drivers/infiniband/hw/hfi1/rc.c:1387: warning: Function parameter or member 'is_fecn' not described in 'hfi1_send_rc_ack'
 drivers/infiniband/hw/hfi1/rc.c:1387: warning: Excess function parameter 'qp' description in 'hfi1_send_rc_ack'
 drivers/infiniband/hw/hfi1/rc.c:2008: warning: Function parameter or member 'aeth' not described in 'do_rc_ack'
 drivers/infiniband/hw/hfi1/rc.c:2008: warning: Function parameter or member 'val' not described in 'do_rc_ack'
 drivers/infiniband/hw/hfi1/rc.c:2008: warning: Function parameter or member 'rcd' not described in 'do_rc_ack'
 drivers/infiniband/hw/hfi1/rc.c:2554: warning: Function parameter or member 'rcd' not described in 'rc_rcv_error'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/rc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index 1bb5f57152d35..7194236aec8fe 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -421,6 +421,7 @@ static int make_rc_ack(struct hfi1_ibdev *dev, struct rvt_qp *qp,
 /**
  * hfi1_make_rc_req - construct a request packet (SEND, RDMA r/w, ATOMIC)
  * @qp: a pointer to the QP
+ * @ps: the current packet state
  *
  * Assumes s_lock is held.
  *
@@ -1992,7 +1993,7 @@ static void update_qp_retry_state(struct rvt_qp *qp, u32 psn, u32 spsn,
 	}
 }
 
-/**
+/*
  * do_rc_ack - process an incoming RC ACK
  * @qp: the QP the ACK came in on
  * @psn: the packet sequence number of the ACK
@@ -2541,6 +2542,7 @@ static inline void rc_cancel_ack(struct rvt_qp *qp)
  * @opcode: the opcode for this packet
  * @psn: the packet sequence number for this packet
  * @diff: the difference between the PSN and the expected PSN
+ * @rcd: the receive context
  *
  * This is called from hfi1_rc_rcv() to process an unexpected
  * incoming RC packet for the given QP.
-- 
2.25.1

