Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A292FE7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbhAUKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbhAUJr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:47:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30EDC0617BA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a9so1055272wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4lWsX1/HMWo9e2h+pWPHWU7/13R9cTAE/+8ZINfLr8=;
        b=ScRTv9wJ+i/WWqoj5qdXsAVNJgIefZzJ7qKjwF3BXsDzblOmxnzAyBC9JYi1rNS5jH
         CKZczGXBrR/G63fNlKwXytTljWa8Lqi8dLYjFF710lzxfm1S5GwiVWt5HRMaMpvi5SDJ
         SC1Nc0fdBor+jNndu1vuhXYY42tH8qbbaTSjw8K+ZWuWqD9D/BBnW7I1u5S/ykBwKUmZ
         sQie9KA1cXarCU35luoIzbQNiRdDFOswnSE0gQYKrNah6+i0tKpPgVDnPK64pWpsIBwp
         ZwUtuEoqx5+48c5EIPpff1msG781IGPZiFh2p15nyH5/AEmPtaZjw/B3ph339hVjXK4D
         mJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4lWsX1/HMWo9e2h+pWPHWU7/13R9cTAE/+8ZINfLr8=;
        b=nTFWY3jqAxtSReH7V8UGdtamAPOBNRFOR8rkwNQwZkf5lBhE1n2HiHjACOSze9lkUH
         6OZ5qDn+x1g9lNTGUqcFIjEBcqaEIwOsD0jcKRzzcSeQK7CCCyl3fy1c5QUjdilnVXOH
         KaleRAvArsLV5F3wwIZh7IJ/FYrcMtUS3C/L5K5nTdsa6wtNsU9bZEG+vE0f60FTJXz4
         ahCBCn4SJAMIb5y4vbYd7MPb4LSyEXZxvjhGAvJr5n4wYNwDCLYwAtGcG8bLZmaYr4hm
         EJK3Q1nbwM1K4nxN+qmbNnA2Y8JjREURrCFCM8yn+dxijEzS7oHIGKGL2MRT20BNyJ3/
         275A==
X-Gm-Message-State: AOAM533O5q4Noa5xiExX2mmdmWJU134zqWvgFKc7QzyoZA4nrGUgtDsQ
        nsPU6/blS/IyX5t3kfcXCm2Uzg==
X-Google-Smtp-Source: ABdhPJyEfsOYnrJQ5QY9vXKSK3jdn1xNP/R9pYUB3pJz4ZQIRAiHBZc3WYoVE2GOJnaVWPnTJ+/5CA==
X-Received: by 2002:adf:ee90:: with SMTP id b16mr13298698wro.221.1611222342589;
        Thu, 21 Jan 2021 01:45:42 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 16/30] RDMA/hw/qib/qib_twsi: Provide description for missing param 'last'
Date:   Thu, 21 Jan 2021 09:45:05 +0000
Message-Id: <20210121094519.2044049-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_twsi.c:175: warning: Function parameter or member 'last' not described in 'rd_byte'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_twsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/qib/qib_twsi.c b/drivers/infiniband/hw/qib/qib_twsi.c
index f5698664419b4..97b8a2bf5c696 100644
--- a/drivers/infiniband/hw/qib/qib_twsi.c
+++ b/drivers/infiniband/hw/qib/qib_twsi.c
@@ -168,6 +168,7 @@ static void stop_cmd(struct qib_devdata *dd);
 /**
  * rd_byte - read a byte, sending STOP on last, else ACK
  * @dd: the qlogic_ib device
+ * @last: identifies the last read
  *
  * Returns byte shifted out of device
  */
-- 
2.25.1

