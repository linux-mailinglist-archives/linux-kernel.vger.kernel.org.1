Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC882A2A39
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgKBL61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgKBL5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:45 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5EBC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:45 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 205so1475792wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7S7czJXKoFmUehfVFN7m7xZuWWqCXLmTUcmn4WxJNRA=;
        b=kFNAKNCA1RhcYvhFZOK8tXDvNi+iD5SJlRNMhs+0jpLmGCMKX7TskA34yf1oA1vyIp
         rIjLmsdFktfOqWsbD99erXk5pxiaw4plY/I+HAZ8Lz21nwLUA30skpVOHYhonUilM+Zw
         9F7eyCGl367ASegiEnZ3dD478wXaizcDJV7nqcSogNsT1aZRocgH6wUXooLkR2m9Z+Kw
         5yMwlqwdtBrQHOiye1MhnAEIms/g571fSg1drk820mIvZydBxTJG4JmRv08CvRgYU966
         9rZ6Z5dgmtiJ4hkIACEuzihPttQ+CmkhpM9nwffGjPRgpWlYec48QpU3YvNM2GDCNe3D
         CUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7S7czJXKoFmUehfVFN7m7xZuWWqCXLmTUcmn4WxJNRA=;
        b=qpMLLtlskP44EaEv3WV3UFwDLEkyqcPGMjUJO0fuO2mRiHBkWZTB7q2WYZ9cw8hTeO
         CO88SQBgyjbIfNKLjpvC1JUS3EgXvX5kQLyURXA4xjSmx0tIiKWfajIKNA16PZXbNvZ/
         96Rx6Fw7GyvxTBZe23z2Ojj1WSKwflavJw1mDY47tEZRzooZPZ9i0pUt7nItD7BCLrpo
         x+Eo83l/9VkFA+l5deKIdu0Hf//Je0dY0QR066x1tbk6cKCTD78INZblc25ZGXbl9yZu
         gQjq80c+N4UnuO4NxRgGkHomYdriKj4dUmduLU1qMmv09uTIoJRYmxUv6Ny0PKbA4tS6
         RyIQ==
X-Gm-Message-State: AOAM530pjacCkm1d9EzW0XLo4JYBreVuDI2AMeQuxtXkMqlDsgiHD5hD
        ASubbab76MFVYRmPG2gwvaF02lQspal1yA==
X-Google-Smtp-Source: ABdhPJxxglwM3H9z2EQTDpbbQEebxK/CZuV4qfUfOlYW+JyafgJOeZ4rwEPL3jwNNBgHgofDtBSIhw==
X-Received: by 2002:a1c:309:: with SMTP id 9mr8839272wmd.80.1604318263815;
        Mon, 02 Nov 2020 03:57:43 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 10/19] scsi: lpfc: lpfc_nvme: Remove unused variable 'phba'
Date:   Mon,  2 Nov 2020 11:57:19 +0000
Message-Id: <20201102115728.1077697-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_nvme.c: In function ‘lpfc_nvme_ls_abort’:
 drivers/scsi/lpfc/lpfc_nvme.c:943:19: warning: variable ‘phba’ set but not used [-Wunused-but-set-variable]

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 69f1a0457f51e..33d007ca5c8e6 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -940,7 +940,6 @@ lpfc_nvme_ls_abort(struct nvme_fc_local_port *pnvme_lport,
 {
 	struct lpfc_nvme_lport *lport;
 	struct lpfc_vport *vport;
-	struct lpfc_hba *phba;
 	struct lpfc_nodelist *ndlp;
 	int ret;
 
@@ -948,7 +947,6 @@ lpfc_nvme_ls_abort(struct nvme_fc_local_port *pnvme_lport,
 	if (unlikely(!lport))
 		return;
 	vport = lport->vport;
-	phba = vport->phba;
 
 	if (vport->load_flag & FC_UNLOADING)
 		return;
-- 
2.25.1

