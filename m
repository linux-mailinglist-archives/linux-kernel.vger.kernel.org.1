Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF42A2CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKBOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKBOYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:24:18 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27E9C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:24:17 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k10so13485852wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7S7czJXKoFmUehfVFN7m7xZuWWqCXLmTUcmn4WxJNRA=;
        b=hckddZGciYNQI/ruTqugSmxaeCQFdVKoY7bMi4NhUOn/QyP7+FG7MHFkLCjeXxf6A8
         P/Q2ZKb5+WVOmYHHCQ546nhycIjUS0lS/y7iyBanpy1aSK4pNagBtR2CFgI1k0eASkK6
         ye7h3CjRsizH8NIJfUprn7MFXHVomB9fm6UfZjQR1k1WLlMn3aXe4y9V3qg+VDh3HveV
         q+ynpaS4Uw72jXzw9OQ32WwZn+V/sO4CmthSPhRx4rssOnP7sAEHCRUWBAXEMFqiSOMl
         4K2KpFYC/MUOI8jm5hJBw8Qv90r+D+kdjteSzQgr2fiPIswqwsDn9aVbL3jZH90UQhVg
         tU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7S7czJXKoFmUehfVFN7m7xZuWWqCXLmTUcmn4WxJNRA=;
        b=tAjd5I43GdGWAuu+RQQsJSJ77ao7R0OjIlm66k6cnm2Hz1QfvuVigwKSDRAu5IKifs
         YMFz4e0z49faNWocGEQaCMHzB5OFHIBGUCYO5XlaWcbpxZJXJO+meyWEiEhVvdj98fpQ
         g9sC7IL4+FQb8C69zbS42vf5RuTdyex8sDEObe/hX8vPNYfZvv2cjMQfTI1MMKMpUu4D
         uUm3fygopN9O4D2lCMr3k9LLA6oCNIvZ6Wzmsar1S7eOr04UKN7XGbjAtuNSDCD0QBOi
         KxEG95XMYojUsIKqq6MBXyeTFTe/fj/X3FQASIradvbpjtvrZ9DOBh8HmnzFfz7lTZt4
         cQPA==
X-Gm-Message-State: AOAM532prbJNNv8eLxKqd2IsTUIbcP7zarrKudQrR19CAi//qUGBEni7
        iCl4i6xWGSizoHYpDjHWSL/zwA==
X-Google-Smtp-Source: ABdhPJwGVmaJ0FERlXGI5CMfBTiQzu33duLDjQFIT+/pYqeoUneqPy4KhIliXa1MhM65Zs48UWP5nQ==
X-Received: by 2002:adf:8296:: with SMTP id 22mr20755927wrc.341.1604327056564;
        Mon, 02 Nov 2020 06:24:16 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f7sm23542501wrx.64.2020.11.02.06.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:24:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [RESEND 10/19] scsi: lpfc: lpfc_nvme: Remove unused variable 'phba'
Date:   Mon,  2 Nov 2020 14:23:50 +0000
Message-Id: <20201102142359.561122-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102142359.561122-1-lee.jones@linaro.org>
References: <20201102142359.561122-1-lee.jones@linaro.org>
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

