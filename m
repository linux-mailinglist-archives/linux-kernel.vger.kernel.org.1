Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB12A2CCA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKBOZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgKBOYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:24:14 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B1AC061A49
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:24:14 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s9so14806196wro.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJ/LOjMku45L05ImuriGkJJnEcZ0YQY/VNlADFyGWZ8=;
        b=JmCQqHYioQuOSTa0wh7XMjtz6O+WrpRl0wDmJB4Yzj14frBYjV/8gUqkNzkcYs5kBX
         dt2+BVZjdCbj/aMeQClwa2nnU6JcirankbzQ7hiBKOgI1IxrJLTcgNVnIKpRprP4cq0K
         XdNSP3a/Mz5d8oYtJRB27SIy+tmzF42ADeLEMGY0Kk+05v/cy2zg17/MvlqO0au+USZj
         VY1JTd9vFwgLE3GBPgcwtfOu7LOnDIJUwktioIfvvGZoaPPXO1KrFnjPXxNszR0wNBHd
         gPaeGdBM2pyZv0ITqknZPIlpJTpc5BiRG7r5p3W24gOXmPGtCNMUeGWdAbkurbyA9mOf
         d6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJ/LOjMku45L05ImuriGkJJnEcZ0YQY/VNlADFyGWZ8=;
        b=GQ70G4ZTdfUxg1862QiPFM2m2DEWpzNfOdU0/7c+/ZGtU500fH1PiuWF21qHchJh7R
         8wmiBoVlMxvtZ6j+5bni8J6vzCdGoD+euYFQOn+2SJuAT+ERT6C8qLpSOnh04txYxgnQ
         Wu7GITJcVA2vpDJCL+PIa4wy5d+P9fTcvA9p0EX2Hanq+s7tQxf2VzRyTStR6Fwuqq1H
         lexVMhEpGkJHRQP1DjCbP+9WakDfBS8w7xAJQUgSxrEgB3mS5jl6sbyrFn/gh+PmfMit
         l418aBIWJtLVSxddpNTt6cECo0q9Z3sT6wSpDeoGk8to9YiKre+OERrchEHR2e9bJqsC
         lKaQ==
X-Gm-Message-State: AOAM531FHr9g1pllvLFi4Bsddjed7JejUnA/RW0FYAMZjnjepIgFy0YB
        oe8kJgq8MLZBv3TqfbbrAybiow==
X-Google-Smtp-Source: ABdhPJwr++JFubsc+a4CRccQfKmS1YyaJ2OqPZalLE6DCOaMrfb/6qZSQWeSn51M4MV33skLxc9nUg==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr20403765wrp.312.1604327052849;
        Mon, 02 Nov 2020 06:24:12 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f7sm23542501wrx.64.2020.11.02.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:24:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [RESEND 07/19] scsi: lpfc: lpfc_bsg: Provide correct documentation for a bunch of functions
Date:   Mon,  2 Nov 2020 14:23:47 +0000
Message-Id: <20201102142359.561122-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102142359.561122-1-lee.jones@linaro.org>
References: <20201102142359.561122-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_bsg.c:917: warning: Function parameter or member 'phba' not described in 'lpfc_bsg_ct_unsol_event'
 drivers/scsi/lpfc/lpfc_bsg.c:917: warning: Function parameter or member 'pring' not described in 'lpfc_bsg_ct_unsol_event'
 drivers/scsi/lpfc/lpfc_bsg.c:1484: warning: Function parameter or member 'cmp' not described in 'lpfc_issue_ct_rsp'
 drivers/scsi/lpfc/lpfc_bsg.c:3900: warning: Function parameter or member 'job' not described in 'lpfc_bsg_sli_cfg_read_cmd_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:3900: warning: Function parameter or member 'dmabuf' not described in 'lpfc_bsg_sli_cfg_read_cmd_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:3900: warning: Excess function parameter 'mb' description in 'lpfc_bsg_sli_cfg_read_cmd_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:3900: warning: Excess function parameter 'dmabuff' description in 'lpfc_bsg_sli_cfg_read_cmd_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:4088: warning: Function parameter or member 'job' not described in 'lpfc_bsg_sli_cfg_write_cmd_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:4088: warning: Function parameter or member 'nemb_tp' not described in 'lpfc_bsg_sli_cfg_write_cmd_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:4088: warning: Function parameter or member 'dmabuf' not described in 'lpfc_bsg_sli_cfg_write_cmd_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:4088: warning: Excess function parameter 'mb' description in 'lpfc_bsg_sli_cfg_write_cmd_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:4088: warning: Excess function parameter 'dmabuff' description in 'lpfc_bsg_sli_cfg_write_cmd_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:4254: warning: Function parameter or member 'job' not described in 'lpfc_bsg_handle_sli_cfg_mbox'
 drivers/scsi/lpfc/lpfc_bsg.c:4254: warning: Function parameter or member 'dmabuf' not described in 'lpfc_bsg_handle_sli_cfg_mbox'
 drivers/scsi/lpfc/lpfc_bsg.c:4254: warning: Excess function parameter 'mb' description in 'lpfc_bsg_handle_sli_cfg_mbox'
 drivers/scsi/lpfc/lpfc_bsg.c:4254: warning: Excess function parameter 'dmabuff' description in 'lpfc_bsg_handle_sli_cfg_mbox'
 drivers/scsi/lpfc/lpfc_bsg.c:4403: warning: Function parameter or member 'job' not described in 'lpfc_bsg_read_ebuf_get'
 drivers/scsi/lpfc/lpfc_bsg.c:4403: warning: Excess function parameter 'dmabuf' description in 'lpfc_bsg_read_ebuf_get'
 drivers/scsi/lpfc/lpfc_bsg.c:4474: warning: Function parameter or member 'job' not described in 'lpfc_bsg_write_ebuf_set'
 drivers/scsi/lpfc/lpfc_bsg.c:4600: warning: Function parameter or member 'job' not described in 'lpfc_bsg_handle_sli_cfg_ebuf'
 drivers/scsi/lpfc/lpfc_bsg.c:4600: warning: Function parameter or member 'dmabuf' not described in 'lpfc_bsg_handle_sli_cfg_ebuf'
 drivers/scsi/lpfc/lpfc_bsg.c:4600: warning: Excess function parameter 'mb' description in 'lpfc_bsg_handle_sli_cfg_ebuf'
 drivers/scsi/lpfc/lpfc_bsg.c:4600: warning: Excess function parameter 'dmabuff' description in 'lpfc_bsg_handle_sli_cfg_ebuf'
 drivers/scsi/lpfc/lpfc_bsg.c:4645: warning: Function parameter or member 'job' not described in 'lpfc_bsg_handle_sli_cfg_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:4645: warning: Function parameter or member 'dmabuf' not described in 'lpfc_bsg_handle_sli_cfg_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:4645: warning: Excess function parameter 'mb' description in 'lpfc_bsg_handle_sli_cfg_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:4645: warning: Excess function parameter 'dmabuff' description in 'lpfc_bsg_handle_sli_cfg_ext'
 drivers/scsi/lpfc/lpfc_bsg.c:4723: warning: Function parameter or member 'job' not described in 'lpfc_bsg_issue_mbox'
 drivers/scsi/lpfc/lpfc_bsg.c:4723: warning: Excess function parameter 'mb' description in 'lpfc_bsg_issue_mbox'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_bsg.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 5b66b8ea83635..abe7c53f8caa4 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -902,11 +902,8 @@ diag_cmd_data_free(struct lpfc_hba *phba, struct lpfc_dmabufext *mlist)
 	return 0;
 }
 
-/**
+/*
  * lpfc_bsg_ct_unsol_event - process an unsolicited CT command
- * @phba:
- * @pring:
- * @piocbq:
  *
  * This function is called when an unsolicited CT command is received.  It
  * forwards the event to any processes registered to receive CT events.
@@ -1455,7 +1452,8 @@ lpfc_issue_ct_rsp_cmp(struct lpfc_hba *phba,
  * @phba: Pointer to HBA context object.
  * @job: Pointer to the job object.
  * @tag: tag index value into the ports context exchange array.
- * @bmp: Pointer to a dma buffer descriptor.
+ * @cmp: Pointer to a cmp dma buffer descriptor.
+ * @bmp: Pointer to a bmp dma buffer descriptor.
  * @num_entry: Number of enties in the bde.
  **/
 static int
@@ -3867,9 +3865,9 @@ lpfc_bsg_sli_cfg_dma_desc_setup(struct lpfc_hba *phba, enum nemb_type nemb_tp,
 /**
  * lpfc_bsg_sli_cfg_mse_read_cmd_ext - sli_config non-embedded mailbox cmd read
  * @phba: Pointer to HBA context object.
- * @mb: Pointer to a BSG mailbox object.
+ * @job: Pointer to the job object.
  * @nemb_tp: Enumerate of non-embedded mailbox command type.
- * @dmabuff: Pointer to a DMA buffer descriptor.
+ * @dmabuf: Pointer to a DMA buffer descriptor.
  *
  * This routine performs SLI_CONFIG (0x9B) read mailbox command operation with
  * non-embedded external bufffers.
@@ -4056,8 +4054,9 @@ lpfc_bsg_sli_cfg_read_cmd_ext(struct lpfc_hba *phba, struct bsg_job *job,
 /**
  * lpfc_bsg_sli_cfg_write_cmd_ext - sli_config non-embedded mailbox cmd write
  * @phba: Pointer to HBA context object.
- * @mb: Pointer to a BSG mailbox object.
- * @dmabuff: Pointer to a DMA buffer descriptor.
+ * @job: Pointer to the job object.
+ * @nemb_tp: Enumerate of non-embedded mailbox command type.
+ * @dmabuf: Pointer to a DMA buffer descriptor.
  *
  * This routine performs SLI_CONFIG (0x9B) write mailbox command operation with
  * non-embedded external bufffers.
@@ -4222,8 +4221,8 @@ lpfc_bsg_sli_cfg_write_cmd_ext(struct lpfc_hba *phba, struct bsg_job *job,
 /**
  * lpfc_bsg_handle_sli_cfg_mbox - handle sli-cfg mailbox cmd with ext buffer
  * @phba: Pointer to HBA context object.
- * @mb: Pointer to a BSG mailbox object.
- * @dmabuff: Pointer to a DMA buffer descriptor.
+ * @job: Pointer to the job object.
+ * @dmabuf: Pointer to a DMA buffer descriptor.
  *
  * This routine handles SLI_CONFIG (0x9B) mailbox command with non-embedded
  * external bufffers, including both 0x9B with non-embedded MSEs and 0x9B
@@ -4374,7 +4373,7 @@ lpfc_bsg_mbox_ext_abort(struct lpfc_hba *phba)
 /**
  * lpfc_bsg_read_ebuf_get - get the next mailbox read external buffer
  * @phba: Pointer to HBA context object.
- * @dmabuf: Pointer to a DMA buffer descriptor.
+ * @job: Pointer to the job object.
  *
  * This routine extracts the next mailbox read external buffer back to
  * user space through BSG.
@@ -4444,6 +4443,7 @@ lpfc_bsg_read_ebuf_get(struct lpfc_hba *phba, struct bsg_job *job)
 /**
  * lpfc_bsg_write_ebuf_set - set the next mailbox write external buffer
  * @phba: Pointer to HBA context object.
+ * @job: Pointer to the job object.
  * @dmabuf: Pointer to a DMA buffer descriptor.
  *
  * This routine sets up the next mailbox read external buffer obtained
@@ -4569,8 +4569,8 @@ lpfc_bsg_write_ebuf_set(struct lpfc_hba *phba, struct bsg_job *job,
 /**
  * lpfc_bsg_handle_sli_cfg_ebuf - handle ext buffer with sli-cfg mailbox cmd
  * @phba: Pointer to HBA context object.
- * @mb: Pointer to a BSG mailbox object.
- * @dmabuff: Pointer to a DMA buffer descriptor.
+ * @job: Pointer to the job object.
+ * @dmabuf: Pointer to a DMA buffer descriptor.
  *
  * This routine handles the external buffer with SLI_CONFIG (0x9B) mailbox
  * command with multiple non-embedded external buffers.
@@ -4614,8 +4614,8 @@ lpfc_bsg_handle_sli_cfg_ebuf(struct lpfc_hba *phba, struct bsg_job *job,
 /**
  * lpfc_bsg_handle_sli_cfg_ext - handle sli-cfg mailbox with external buffer
  * @phba: Pointer to HBA context object.
- * @mb: Pointer to a BSG mailbox object.
- * @dmabuff: Pointer to a DMA buffer descriptor.
+ * @job: Pointer to the job object.
+ * @dmabuf: Pointer to a DMA buffer descriptor.
  *
  * This routine checkes and handles non-embedded multi-buffer SLI_CONFIG
  * (0x9B) mailbox commands and external buffers.
@@ -4688,7 +4688,7 @@ lpfc_bsg_handle_sli_cfg_ext(struct lpfc_hba *phba, struct bsg_job *job,
 /**
  * lpfc_bsg_issue_mbox - issues a mailbox command on behalf of an app
  * @phba: Pointer to HBA context object.
- * @mb: Pointer to a mailbox object.
+ * @job: Pointer to the job object.
  * @vport: Pointer to a vport object.
  *
  * Allocate a tracking object, mailbox command memory, get a mailbox
-- 
2.25.1

