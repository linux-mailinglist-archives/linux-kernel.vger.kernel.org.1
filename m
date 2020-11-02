Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76A42A2A2F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgKBL5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgKBL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:42 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6677C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:41 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k10so12917950wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJ/LOjMku45L05ImuriGkJJnEcZ0YQY/VNlADFyGWZ8=;
        b=vc0kVOFQ0610LDIeI4a3i3i8iXUt/2oAVhmVgIe4GSbeEABh+VPjuJPokjY/x80pk1
         raAo6AtK868sIlXaxMjgpavvUrpVs2FWagE7RD5pr92BzVqeGW7j4SxUb2561X4kMo1b
         VNgjbQU2BB3SBXYy/CkX04C/v2nZoyn5RpLHC2jlNYqevnX3AmFK7g4quC8cKVBj8cwC
         oaeXl32Mmz0mNfKbBo/WcKIMx/p8g5Nn+rkdiU5GzodlSY2FE5jQhVaHRUWn5rYZ769l
         6ijGgOzu0sfrXaCpduGNO0VO1Rvkf9JUufPNa82m/nYW/SpDSdjGqoaPU9Qldacmlb5R
         7DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJ/LOjMku45L05ImuriGkJJnEcZ0YQY/VNlADFyGWZ8=;
        b=s3X0TQaWGnJ1N5HhAAbdceWTGnMnIrafu0Epe8R9DTDr56G832pBv6cYh48ndbMj1R
         G+LbS8f33uYgSZQyyQdouwujd7qd8mAfwhZWPI3OHK4UPe0JuZIw6usEKsyxWZL7NDxV
         piinf394x8THLrXjBI/tcUiXtnNM/dIprcULNfatA4LfLypoNYzQUVyJsny7yJbl550E
         9GHurFO6i5nVBvGmsQRZS0HW8ppKA4DfyIq0ysqPx52GRdiLJEW6vg0JVvkklSnwox19
         jMWLIZyhtWZ0Za7n8KnsP2Vf+1+djr1m/rBDoevyuLziDjj7KQ1b5H3rLnT+BR76nFBq
         Torw==
X-Gm-Message-State: AOAM533oSDf2DFHWo26hqKScsyS3kLxdA82lXTQFn9t709gZ/pVskcfF
        vq3HXUknOlikr836r8a0Uou5Qw==
X-Google-Smtp-Source: ABdhPJxbT6Et2YJZh6vFVbRQP38i6pO7TplyZKcI//SIzzYr2FW1CVU49+zM1pZQE46K9b9A4eoIgg==
X-Received: by 2002:a5d:6741:: with SMTP id l1mr19227431wrw.309.1604318260454;
        Mon, 02 Nov 2020 03:57:40 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 07/19] scsi: lpfc: lpfc_bsg: Provide correct documentation for a bunch of functions
Date:   Mon,  2 Nov 2020 11:57:16 +0000
Message-Id: <20201102115728.1077697-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
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

