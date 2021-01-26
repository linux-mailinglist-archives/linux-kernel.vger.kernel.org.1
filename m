Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C18A303DED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392572AbhAZM7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404094AbhAZMtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB63C08E85D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m13so1882301wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=deIr3conzzcAnJ0iN+eWlZZAsgdUd4uaIBytevHZc9w=;
        b=Ni/X8P7dw/EUpGfKcK7INpqiGEkSO6stlLXETIJ9Hsc/eStM7kQmSqPWWRyjR9SDwS
         6NJH+glOQ4t8RTs7UT2S8vsZ1V0hB1TtCNjWE8cucBwdlxuw6me0cYMy5XcDDD+ec6BR
         0laMB2dQnbQjPTvB85Ah0CtYslCYRVb/TDFiw/GBAuPOJsewXFiB1L+GsNlwGt+Uu68k
         lHbZsGj5OKqgsLZywAQFeKXZ0SfFm9JuTvfDpgsgUJ/MLu2H3juUdiWlhn1G+xtNkQ2R
         fUo0CpQJb+EJJOEECV8GXxp8A7YRkt3iu6tBgz549wF2GIiZPFpdgDUq+L3vqUzwngJW
         36WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=deIr3conzzcAnJ0iN+eWlZZAsgdUd4uaIBytevHZc9w=;
        b=YQfyRTvH8uigv057HryqRMnKV8PRKPUw8bg9l5fthUoowK/l8IaJkDGQRY5F+WNVY6
         pU6Mi+/I9Lmzs6ajaq1pY2x2xwVwE1QLmHSTifcIcz87fpa31iFCSk4ktNfJ/86ghTVc
         UIu5VBn8GOwIMVNrF1ToyNuCtAZb/uGblgy2avlAUBr3W3+mlioPKJ/Mun78c6wGioT4
         0VM1CyfQMs4K0e+R3wQM1aZkR72zJAoFggvT+K1TEjw1MkCbzD/C2sn9rh0bdfqD++zb
         e5YaSAFSzzSaGNXlRen7v9lufvg8zgWBpdJKqIVr09NG5CKrtUS1WlerNZmLkOjHK+Dd
         rtyw==
X-Gm-Message-State: AOAM5309Wm5fmd+HSQDjZrxacizMnxeWR1yANiibnTybLE9ADt7PWwz5
        ZkbavfX1ZxL9NyQFB1reTZaYLQ==
X-Google-Smtp-Source: ABdhPJyu9yO8Y+a1f2EmA3BEdiSu8PkKvmgcnmyJjujRPzhuUqTg9MHXepuGkl+jLmhdpXe0Yfv8sQ==
X-Received: by 2002:a05:6000:1565:: with SMTP id 5mr6039531wrz.109.1611665265817;
        Tue, 26 Jan 2021 04:47:45 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 09/20] RDMA/hw/hfi1/pcie: Demote kernel-doc abuses
Date:   Tue, 26 Jan 2021 12:47:21 +0000
Message-Id: <20210126124732.3320971-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/pcie.c:343: warning: Function parameter or member 'dd' not described in 'restore_pci_variables'
 drivers/infiniband/hw/hfi1/pcie.c:402: warning: Function parameter or member 'dd' not described in 'save_pci_variables'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 18d32f053d26e..6f06e99205037 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -334,7 +334,7 @@ int pcie_speeds(struct hfi1_devdata *dd)
 	return 0;
 }
 
-/**
+/*
  * Restore command and BARs after a reset has wiped them out
  *
  * Returns 0 on success, otherwise a negative error value
@@ -393,7 +393,7 @@ int restore_pci_variables(struct hfi1_devdata *dd)
 	return pcibios_err_to_errno(ret);
 }
 
-/**
+/*
  * Save BARs and command to rewrite after device reset
  *
  * Returns 0 on success, otherwise a negative error value
-- 
2.25.1

