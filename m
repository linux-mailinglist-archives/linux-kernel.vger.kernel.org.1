Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4856C2A2A32
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgKBL5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbgKBL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:50 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F65AC061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:49 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b3so8350873wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiKuxEo/wRHTJJqPU7mxaF4N92praJWOsPzk81kg8ns=;
        b=yM+emhrIeEfzL1Bz63c1hPo2yrG0KGAWmuAOGCXfF/z9J2fKyEZ5yTgHFGHfGdy9Jj
         a5kpHtROfAJ8pZ60D2E8+dxSkiEj0Yug60W6R8BAY0Qw+ghbCkfB5Bl4ZjeRXZ7OR/P5
         fuwnM+LbyI/2egVMgaBf92+c2x1v2e+Uf9pKmKUDu+XYjEfat9Z20mQWA26GgqWRxfJi
         V29FyBcfqQxEB5u2Oee0Z0ODVU/uHNLdzagAizUGgPsijNotokm8sx8A5iCFE9Q3rrQZ
         YRIuj1UJiNAmZJVZzzeqz6ojWcxsIijmJvbz/frtPUcE2LqqBcWHOSPcuJ3NuSMVTQwE
         htTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiKuxEo/wRHTJJqPU7mxaF4N92praJWOsPzk81kg8ns=;
        b=DqoUjxw6M4abFC3qmBdy9Gq2dwfIfavRoE7EVRZil6r9NY0tXWTt4eqX1ktQv30guu
         VZojOZHervk2siNJc+izZZhHcDmG33Ur/mRiPq81H7UNHATkUInBP5jHC9lLereZ2KJS
         MjGEaj3znSxAeVc+4MBsKnAse5aPQnOQYXWaJ9DAvESrvq8m0b4pvMTtsHt/JXkaOXNK
         mzEdb16A6aZcMpqlMZnwAakJDAVj43eim+vSBiWJcp+Xlh9jtMCdcJK2CIQEE3P36vGp
         Wf8EaIP1nhWQ5sOdFpnOhVxW+LirAFIi4pYweOClifWugmLcuCOQG/8YXoBi7xIV0zZL
         DQow==
X-Gm-Message-State: AOAM532XfMmRnS4F5w8E84QU0gQLzkgda+HQp44qqhle+i+IWwOXNOOd
        SSlMmuAUFze4+Wrv4w0pEAvbuA==
X-Google-Smtp-Source: ABdhPJyCgpi1qViGLhtNa6Zo+tOXmuRtILv61oil3D0icMFCurTx0gewDfqJD7KDjKJ0zKAAHGmZfQ==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr19578819wru.110.1604318268356;
        Mon, 02 Nov 2020 03:57:48 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 14/19] scsi: lpfc: lpfc_nvmet: Fix-up some formatting and doc-rot issues
Date:   Mon,  2 Nov 2020 11:57:23 +0000
Message-Id: <20201102115728.1077697-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_nvmet.c:386: warning: Function parameter or member 'ctx_buf' not described in 'lpfc_nvmet_ctxbuf_post'
 drivers/scsi/lpfc/lpfc_nvmet.c:386: warning: Excess function parameter 'ctxp' description in 'lpfc_nvmet_ctxbuf_post'
 drivers/scsi/lpfc/lpfc_nvmet.c:386: warning: Excess function parameter 'mp' description in 'lpfc_nvmet_ctxbuf_post'
 drivers/scsi/lpfc/lpfc_nvmet.c:1310: warning: Function parameter or member 'targetport' not described in 'lpfc_nvmet_ls_req'
 drivers/scsi/lpfc/lpfc_nvmet.c:1310: warning: Function parameter or member 'hosthandle' not described in 'lpfc_nvmet_ls_req'
 drivers/scsi/lpfc/lpfc_nvmet.c:1310: warning: Function parameter or member 'pnvme_lsreq' not described in 'lpfc_nvmet_ls_req'
 drivers/scsi/lpfc/lpfc_nvmet.c:1350: warning: Function parameter or member 'hosthandle' not described in 'lpfc_nvmet_ls_abort'
 drivers/scsi/lpfc/lpfc_nvmet.c:1350: warning: Function parameter or member 'pnvme_lsreq' not described in 'lpfc_nvmet_ls_abort'
 drivers/scsi/lpfc/lpfc_nvmet.c:3607: warning: Function parameter or member 'phba' not described in 'lpfc_nvmet_invalidate_host'
 drivers/scsi/lpfc/lpfc_nvmet.c:3607: warning: Function parameter or member 'ndlp' not described in 'lpfc_nvmet_invalidate_host'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index d4ade7cdb93a9..675253093e877 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -371,8 +371,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 /**
  * lpfc_nvmet_ctxbuf_post - Repost a NVMET RQ DMA buffer and clean up context
  * @phba: HBA buffer is associated with
- * @ctxp: context to clean up
- * @mp: Buffer to free
+ * @ctx_buf: ctx buffer context
  *
  * Description: Frees the given DMA buffer in the appropriate way given by
  * reposting it to its associated RQ so it can be reused.
@@ -1291,10 +1290,10 @@ lpfc_nvmet_ls_req_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 
 /**
  * lpfc_nvmet_ls_req - Issue an Link Service request
- * @targetport - pointer to target instance registered with nvmet transport.
- * @hosthandle - hosthandle set by the driver in a prior ls_rqst_rcv.
+ * @targetport: pointer to target instance registered with nvmet transport.
+ * @hosthandle: hosthandle set by the driver in a prior ls_rqst_rcv.
  *               Driver sets this value to the ndlp pointer.
- * @pnvme_lsreq - the transport nvme_ls_req structure for the LS
+ * @pnvme_lsreq: the transport nvme_ls_req structure for the LS
  *
  * Driver registers this routine to handle any link service request
  * from the nvme_fc transport to a remote nvme-aware port.
@@ -1336,9 +1335,9 @@ lpfc_nvmet_ls_req(struct nvmet_fc_target_port *targetport,
 /**
  * lpfc_nvmet_ls_abort - Abort a prior NVME LS request
  * @targetport: Transport targetport, that LS was issued from.
- * @hosthandle - hosthandle set by the driver in a prior ls_rqst_rcv.
+ * @hosthandle: hosthandle set by the driver in a prior ls_rqst_rcv.
  *               Driver sets this value to the ndlp pointer.
- * @pnvme_lsreq - the transport nvme_ls_req structure for LS to be aborted
+ * @pnvme_lsreq: the transport nvme_ls_req structure for LS to be aborted
  *
  * Driver registers this routine to abort an NVME LS request that is
  * in progress (from the transports perspective).
@@ -3596,8 +3595,8 @@ lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
 /**
  * lpfc_nvmet_invalidate_host
  *
- * @phba - pointer to the driver instance bound to an adapter port.
- * @ndlp - pointer to an lpfc_nodelist type
+ * @phba: pointer to the driver instance bound to an adapter port.
+ * @ndlp: pointer to an lpfc_nodelist type
  *
  * This routine upcalls the nvmet transport to invalidate an NVME
  * host to which this target instance had active connections.
-- 
2.25.1

