Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0DF2FAD8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbhARWtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388912AbhARWk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:40:56 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E51C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:39:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id s24so659770wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lb2XS7ZcCtCLtyoYlVUinWRuYfofz6JXw77zijmyJYg=;
        b=Ldiw4Gf0MTjFaVnLoy3BL0N2vcjdNOhGNDXm7HKgYWZRvPPxnQstMp2LQDiAGHnwgX
         Jaj9bPk6owNN9mKasD6NHZSDfeWyaYRx4gMG4PTd8Dyxy5r8OSEqODiisiHXlhdafqL9
         DVKIPa4txhh9XEBj5AMRtH+X4xk2RjjGiMsLAl03tRb/dWQ1z54l0iQnNUWi5S7O6wFx
         MCPcEqlRAyOCJaXek9qWZGK50J5nEzQYpAbY6qkcWby8h+Gs/15bfzHPt6kwRR9Spr5/
         tTCJT2bOKwVR453Ieax62/Xi868qYEXWf0s4F1akX2jTxtEseA+nX8nw/0IRAmyor8IM
         dnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lb2XS7ZcCtCLtyoYlVUinWRuYfofz6JXw77zijmyJYg=;
        b=g44rVvV12jyo+EbrPgvyGczEwCgLpdAkSd+v52a2gMqWdg7GT8CSEB6detaBtLFOS0
         8Wetdmmcp9ZRStn/tCzFazIxmFmoZBl/nXObIEGzb5nufIe9eY5rhtiV9Wk7GW2HXh6h
         NsW+Tz7TJex/gsud6dee8MfoYrKFgS59Vm7OCQPr/b/bayuV1ILmPVu9K5suK/3XK6YS
         tC/gEV/Cg9icuC8y8OwIHyF5aW+5bvQ8Vk8jdmmO/nvjnsR3eili+vEYla5dyUJqJNEE
         YpXpnMU0eVaBTIV05mGJFZ/3+Mpt9rpEvW1MuIAOFVJlsWQ0r7M/HOwxLdNpnoVrM8Gn
         mwvg==
X-Gm-Message-State: AOAM530gnqiW4UzAT9ynQil/mqxakLh/qQhm5EMuUC62zCXHoNqc57ws
        C6eELm6F0yHYA7xVfPE6ko3YjAhISFYKrHrw
X-Google-Smtp-Source: ABdhPJzb2OOIk7V4VE8x9T/jFz45lKgw4h05aD3bvL6OmlPKNIuUnLRRIpHwQBtKJzWQ/FxLNp0Zvw==
X-Received: by 2002:a7b:cbd7:: with SMTP id n23mr1314240wmi.116.1611009575415;
        Mon, 18 Jan 2021 14:39:35 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 02/20] RDMA/core: device: Fix formatting in worthy kernel-doc header and demote another
Date:   Mon, 18 Jan 2021 22:39:11 +0000
Message-Id: <20210118223929.512175-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/device.c:1896: warning: Function parameter or member 'ibdev' not described in 'ib_get_client_nl_info'
 drivers/infiniband/core/device.c:1896: warning: Function parameter or member 'client_name' not described in 'ib_get_client_nl_info'
 drivers/infiniband/core/device.c:1896: warning: Function parameter or member 'res' not described in 'ib_get_client_nl_info'
 drivers/infiniband/core/device.c:2328: warning: Function parameter or member 'nldev_cb' not described in 'ib_enum_all_devs'
 drivers/infiniband/core/device.c:2328: warning: Function parameter or member 'skb' not described in 'ib_enum_all_devs'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index e96f979e6d52d..3d08373c77979 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1887,9 +1887,9 @@ static int __ib_get_client_nl_info(struct ib_device *ibdev,
 
 /**
  * ib_get_client_nl_info - Fetch the nl_info from a client
- * @device - IB device
- * @client_name - Name of the client
- * @res - Result of the query
+ * @ibdev: IB device
+ * @client_name: Name of the client
+ * @res: Result of the query
  */
 int ib_get_client_nl_info(struct ib_device *ibdev, const char *client_name,
 			  struct ib_client_nl_info *res)
@@ -2317,7 +2317,7 @@ void ib_enum_all_roce_netdevs(roce_netdev_filter filter,
 	up_read(&devices_rwsem);
 }
 
-/**
+/*
  * ib_enum_all_devs - enumerate all ib_devices
  * @cb: Callback to call for each found ib_device
  *
-- 
2.25.1

