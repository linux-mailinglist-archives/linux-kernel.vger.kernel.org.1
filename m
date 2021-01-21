Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33D02FF36D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbhAUSOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbhAUJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:46:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176B7C06179F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:34 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v184so939107wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+H03APXDfdyL7LaFA/b0g0zCzrZS1ohEeqXf8bvJDzc=;
        b=gHfXC3dpfxVrG1AHvM5pWZgIn/rUAADDCIUSmEHMDfEsPyUGK+N/+uqhpMtMNwkLi7
         3UXIcgVHSXd/IoQuekp10s4hm/O7L0/q8vh3SzksXOq+sQ6n0UtldsQgwjtoL+bfGVoe
         zm2jQNnnmC+XwQYvYiO1jsfPaaDIegC1eKzMmnFctK7pJN3Oj7QAUm8wECvwZ4dsseYf
         YdJlaJT3b3pss8AlG02O+VaBL4BZX6U6QHThsZgvINWbazBEoshNQ+P7GVDoo7wm5hOL
         B7G4UwUTsk1lb2syfCslJWPn47KuYJzHcA+/zHDc28F4tBB+9GLzAsXWhYJbH11mfmiG
         h8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+H03APXDfdyL7LaFA/b0g0zCzrZS1ohEeqXf8bvJDzc=;
        b=nYaAjIgG0lREETdclthuzpJ+ocobMFiGFJrfgXSQLQlAfT6T7AVBXwn57MvG9HYaQm
         RlmDICNgGBr1HoK/dflfL2Xq2i90idPvdpflDqTj1EWtCDwrj7ZdUFBW+dmENzPyr7RJ
         kf6W/RJyjgaIEGVlNPPYxWLLH05x+62srvRYAL9FfsxxIedhsr9PFSEEY3ucMf1Svevn
         7SHDq1tfCl8ifloiabmU3VdncOSAEkEG0AdciTIDVs2F2ssO8PbpmDroqvuXLHWG0j2h
         TiJVw3Pgx6+Mvf4NZkt9jyBOQEwq+KO65mZk+ygRSHucRIaF7BRE00DTBOK2D4M4tJuj
         C8lw==
X-Gm-Message-State: AOAM532/H5WKetzXtPano0YUWymdWyanjfD/76Erqi66kSO8qOpPkDVt
        koY28tyEaZgzrhKFOgmBmDTH/g==
X-Google-Smtp-Source: ABdhPJxqr9xHKchQbaXjh71PW8euM5LCZv2yrvaYhwC6CnOhV7vk3K4gwav0E881INC9hql6/FvDYw==
X-Received: by 2002:a1c:de09:: with SMTP id v9mr8437204wmg.0.1611222332813;
        Thu, 21 Jan 2021 01:45:32 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 09/30] RDMA/hw/qib/qib_mad: Fix a few misspellings and supply missing descriptions
Date:   Thu, 21 Jan 2021 09:44:58 +0000
Message-Id: <20210121094519.2044049-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_mad.c:896: warning: Function parameter or member 'ppd' not described in 'rm_pkey'
 drivers/infiniband/hw/qib/qib_mad.c:896: warning: Excess function parameter 'dd' description in 'rm_pkey'
 drivers/infiniband/hw/qib/qib_mad.c:926: warning: Function parameter or member 'ppd' not described in 'add_pkey'
 drivers/infiniband/hw/qib/qib_mad.c:926: warning: Excess function parameter 'dd' description in 'add_pkey'
 drivers/infiniband/hw/qib/qib_mad.c:2365: warning: Function parameter or member 'in' not described in 'qib_process_mad'
 drivers/infiniband/hw/qib/qib_mad.c:2365: warning: Function parameter or member 'out' not described in 'qib_process_mad'
 drivers/infiniband/hw/qib/qib_mad.c:2365: warning: Function parameter or member 'out_mad_size' not described in 'qib_process_mad'
 drivers/infiniband/hw/qib/qib_mad.c:2365: warning: Function parameter or member 'out_mad_pkey_index' not described in 'qib_process_mad'
 drivers/infiniband/hw/qib/qib_mad.c:2365: warning: Excess function parameter 'in_mad' description in 'qib_process_mad'
 drivers/infiniband/hw/qib/qib_mad.c:2365: warning: Excess function parameter 'out_mad' description in 'qib_process_mad'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_mad.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
index f83e331977f82..44e2f813024a6 100644
--- a/drivers/infiniband/hw/qib/qib_mad.c
+++ b/drivers/infiniband/hw/qib/qib_mad.c
@@ -886,7 +886,7 @@ static int subn_set_portinfo(struct ib_smp *smp, struct ib_device *ibdev,
 
 /**
  * rm_pkey - decrecment the reference count for the given PKEY
- * @dd: the qlogic_ib device
+ * @ppd: the qlogic_ib device
  * @key: the PKEY index
  *
  * Return true if this was the last reference and the hardware table entry
@@ -916,7 +916,7 @@ static int rm_pkey(struct qib_pportdata *ppd, u16 key)
 
 /**
  * add_pkey - add the given PKEY to the hardware table
- * @dd: the qlogic_ib device
+ * @ppd: the qlogic_ib device
  * @key: the PKEY
  *
  * Return an error code if unable to add the entry, zero if no change,
@@ -2346,8 +2346,10 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
  * @port: the port number this packet came in on
  * @in_wc: the work completion entry for this packet
  * @in_grh: the global route header for this packet
- * @in_mad: the incoming MAD
- * @out_mad: any outgoing MAD reply
+ * @in: the incoming MAD
+ * @out: any outgoing MAD reply
+ * @out_mad_size: size of the outgoing MAD reply
+ * @out_mad_pkey_index: unused
  *
  * Returns IB_MAD_RESULT_SUCCESS if this is a MAD that we are not
  * interested in processing.
-- 
2.25.1

