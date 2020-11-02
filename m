Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B500F2A2CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKBOZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKBOYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:24:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371DBC061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:24:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k10so13486247wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiKuxEo/wRHTJJqPU7mxaF4N92praJWOsPzk81kg8ns=;
        b=tbjF9ZU5V9QQwA7I40gxdrkwTvBLFOqeWGReA3201tpEwPfps0rEKTURYPc6d5P5pM
         5UBLpjxpqej1MQ1XjWiUbSNdxWGozwxXrb7Qf9cAqD8DkKbQzfuBvODPNf6T/icrg6Wr
         bGGL6vz56QVMnfpeQ1FqIXwxHgeqpPGdwFeOzM6+9NLh9lM6CPMA/SVCm4OZFqlqSv4+
         LqjCg5QG2eAxonev8i4VGcavO511CS2k9mk062USbmTCughEToBclX3L6qJVPaOLiH8J
         tFKHCWASs4zfGKb92o6Ay3gQgM7hczy/HtM3PN2e7p+13Q2YOTEWucY2I/FMnniKlCzI
         COMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiKuxEo/wRHTJJqPU7mxaF4N92praJWOsPzk81kg8ns=;
        b=HNxboyd/4vd345/ndL9A2n7IltafrphUai6+WgLWRD9iC7RgDE4it9yv3eoVDkbJVy
         h6tFtovv1YKzLCcZo5uExJR6+wqW607jRtzl9+7RQMTSyrB+CDzZ9Q6Ip0Za/VbvUlth
         cIR9tsbWN1GGwXc56HOQUGxAS322jlc/CbbdtlZ0sionbpuZNHMVI358gSCoO3YtbPuR
         jb9Ojx4ZkQ6bjEF0v2WWvJCLsVrxc937KH46JtDrWilckd0dt7koLp/EI85IKUnF+pL5
         u1g+KShPZAIHE9mH4jfi1O4XqETTAjPiFbbU8C97O9sa7cEaS6zOiRU/jNR+67ACUv4A
         5Vtw==
X-Gm-Message-State: AOAM5331KOTOrSYTf/aClrFiLZnwqNjXOnXSpsGVc2+70+G+0u170L2O
        u911u9kaoPkLaxnF1OMeRuD/2Q==
X-Google-Smtp-Source: ABdhPJz0WN8Bx9yzKpxS+qQtclExNDAebvE1c+5gQ2g/maOWMn7FFA68UYuUlqX4pemgNEhzHevjqA==
X-Received: by 2002:adf:eace:: with SMTP id o14mr21089866wrn.308.1604327061915;
        Mon, 02 Nov 2020 06:24:21 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f7sm23542501wrx.64.2020.11.02.06.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:24:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [RESEND 14/19] scsi: lpfc: lpfc_nvmet: Fix-up some formatting and doc-rot issues
Date:   Mon,  2 Nov 2020 14:23:54 +0000
Message-Id: <20201102142359.561122-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102142359.561122-1-lee.jones@linaro.org>
References: <20201102142359.561122-1-lee.jones@linaro.org>
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

