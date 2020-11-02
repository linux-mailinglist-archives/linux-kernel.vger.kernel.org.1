Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF08C2A2A3C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgKBL6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbgKBL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:37 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6FFC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:37 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id n18so14254446wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2fWYxnVYd4dMQEHYo95aSVz8PeMkFRZn/4NbF8YghM=;
        b=Zh4g/vplVtTkAelTzd4wFC4hhvkFF0rmlU214nruA+k3ZSDuqX2UZ8K2/Z8FnbG/pZ
         x81REDDEH6RQqXcN5GqjnXgGOGWiXmb4yauuXHXXYPeQb1SV99Jfib0udv0sdYImWzKm
         +zE9V0C6NAYu1pAckr6/1Hoe3HhJZC3P37O2wV7pXrYbtmWPTHi0TT8SEQiNlWLmNsYP
         e1o9bfQ2N9sXLfOOwLksITCS4UWgOB4mC+XSa5QKlmeVgq8wTTXKGyYflUcB4kr8mjP2
         fQUM2PptyJaHZzGoe20LOLxTVgyab5XXL14OzQHvzQ0EchBJIvx3bKl/gLwjXy1STrNJ
         /VDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2fWYxnVYd4dMQEHYo95aSVz8PeMkFRZn/4NbF8YghM=;
        b=M4qxuZ5xhBOpYPh4YZB7uosBdgcay1kXXihesDnPRmVOWqxTP/d233yQhxCPpoYU+C
         dS7/vvKUPLilfauAETuH64yLo/DljzQxnXH8GQjD980nGwGhhJqYHXQFurrRy4dxLiro
         fT8p2ItV8JvUIJJEkxy/9chU39auOZhvTEYPgHJG607WJVIupNYYumf7lUNg64EBQx0F
         vAhYRgYx1ceHpVFmRmAMX1n4AzY6gY5mu0lLkqvxanQenzXokDYyaTSBgXS3d4rwv6CM
         +okwnzOMb6OnVD/eJRl0ityNSm0boFTSrvhRGbgDlhvEJPxmmt/74eMaiadLhI9PQWsX
         GH2g==
X-Gm-Message-State: AOAM532k5u0fqQX76gch+EwoG0mFXE/dDcFy09lfuwHLe6PBSxeIrqy3
        zgrs7hcO26bz1Wll/3XZ6KZO/g==
X-Google-Smtp-Source: ABdhPJxB/npfrJaxnHn/5w6uEj3NBZ1CV+fh+Re4Tv2h4Dp1LbuOJvSBbJTJERkjRXh+A8TJURvSgQ==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr18865510wro.381.1604318255922;
        Mon, 02 Nov 2020 03:57:35 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 03/19] scsi: lpfc: lpfc_scsi: Fix a whole host of kernel-doc issues
Date:   Mon,  2 Nov 2020 11:57:12 +0000
Message-Id: <20201102115728.1077697-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_scsi.c:331: warning: Function parameter or member 'num_to_alloc' not described in 'lpfc_new_scsi_buf_s3'
 drivers/scsi/lpfc/lpfc_scsi.c:331: warning: Excess function parameter 'num_to_allocate' description in 'lpfc_new_scsi_buf_s3'
 drivers/scsi/lpfc/lpfc_scsi.c:507: warning: Function parameter or member 'idx' not described in 'lpfc_sli4_io_xri_aborted'
 drivers/scsi/lpfc/lpfc_scsi.c:593: warning: Function parameter or member 'ndlp' not described in 'lpfc_get_scsi_buf_s3'
 drivers/scsi/lpfc/lpfc_scsi.c:593: warning: Function parameter or member 'cmnd' not described in 'lpfc_get_scsi_buf_s3'
 drivers/scsi/lpfc/lpfc_scsi.c:632: warning: Function parameter or member 'ndlp' not described in 'lpfc_get_scsi_buf_s4'
 drivers/scsi/lpfc/lpfc_scsi.c:632: warning: Function parameter or member 'cmnd' not described in 'lpfc_get_scsi_buf_s4'
 drivers/scsi/lpfc/lpfc_scsi.c:744: warning: Function parameter or member 'ndlp' not described in 'lpfc_get_scsi_buf'
 drivers/scsi/lpfc/lpfc_scsi.c:744: warning: Function parameter or member 'cmnd' not described in 'lpfc_get_scsi_buf'
 drivers/scsi/lpfc/lpfc_scsi.c:986: warning: Function parameter or member 'new_guard' not described in 'lpfc_bg_err_inject'
 drivers/scsi/lpfc/lpfc_scsi.c:1393: warning: Function parameter or member 'txop' not described in 'lpfc_sc_to_bg_opcodes'
 drivers/scsi/lpfc/lpfc_scsi.c:1393: warning: Function parameter or member 'rxop' not described in 'lpfc_sc_to_bg_opcodes'
 drivers/scsi/lpfc/lpfc_scsi.c:1393: warning: Excess function parameter 'txopt' description in 'lpfc_sc_to_bg_opcodes'
 drivers/scsi/lpfc/lpfc_scsi.c:1393: warning: Excess function parameter 'rxopt' description in 'lpfc_sc_to_bg_opcodes'
 drivers/scsi/lpfc/lpfc_scsi.c:1473: warning: Function parameter or member 'txop' not described in 'lpfc_bg_err_opcodes'
 drivers/scsi/lpfc/lpfc_scsi.c:1473: warning: Function parameter or member 'rxop' not described in 'lpfc_bg_err_opcodes'
 drivers/scsi/lpfc/lpfc_scsi.c:1473: warning: Excess function parameter 'txopt' description in 'lpfc_bg_err_opcodes'
 drivers/scsi/lpfc/lpfc_scsi.c:1473: warning: Excess function parameter 'rxopt' description in 'lpfc_bg_err_opcodes'
 drivers/scsi/lpfc/lpfc_scsi.c:1565: warning: Function parameter or member 'datasegcnt' not described in 'lpfc_bg_setup_bpl'
 drivers/scsi/lpfc/lpfc_scsi.c:1565: warning: Excess function parameter 'datacnt' description in 'lpfc_bg_setup_bpl'
 drivers/scsi/lpfc/lpfc_scsi.c:1951: warning: Function parameter or member 'datasegcnt' not described in 'lpfc_bg_setup_sgl'
 drivers/scsi/lpfc/lpfc_scsi.c:1951: warning: Function parameter or member 'lpfc_cmd' not described in 'lpfc_bg_setup_sgl'
 drivers/scsi/lpfc/lpfc_scsi.c:1951: warning: Excess function parameter 'datacnt' description in 'lpfc_bg_setup_sgl'
 drivers/scsi/lpfc/lpfc_scsi.c:2131: warning: Function parameter or member 'lpfc_cmd' not described in 'lpfc_bg_setup_sgl_prot'
 drivers/scsi/lpfc/lpfc_scsi.c:4476: warning: Function parameter or member 't' not described in 'lpfc_poll_timeout'
 drivers/scsi/lpfc/lpfc_scsi.c:4476: warning: Excess function parameter 'ptr' description in 'lpfc_poll_timeout'
 drivers/scsi/lpfc/lpfc_scsi.c:4503: warning: Function parameter or member 'shost' not described in 'lpfc_queuecommand'
 drivers/scsi/lpfc/lpfc_scsi.c:4503: warning: Excess function parameter 'done' description in 'lpfc_queuecommand'
 drivers/scsi/lpfc/lpfc_scsi.c:5035: warning: Function parameter or member 'cmnd' not described in 'lpfc_send_taskmgmt'
 drivers/scsi/lpfc/lpfc_scsi.c:5035: warning: Excess function parameter 'rdata' description in 'lpfc_send_taskmgmt'
 drivers/scsi/lpfc/lpfc_scsi.c:5688: warning: Function parameter or member 'phba' not described in 'lpfc_create_device_data'
 drivers/scsi/lpfc/lpfc_scsi.c:5688: warning: Function parameter or member 'pri' not described in 'lpfc_create_device_data'
 drivers/scsi/lpfc/lpfc_scsi.c:5688: warning: Excess function parameter 'pha' description in 'lpfc_create_device_data'
 drivers/scsi/lpfc/lpfc_scsi.c:5730: warning: Function parameter or member 'phba' not described in 'lpfc_delete_device_data'
 drivers/scsi/lpfc/lpfc_scsi.c:5730: warning: Excess function parameter 'pha' description in 'lpfc_delete_device_data'
 drivers/scsi/lpfc/lpfc_scsi.c:5762: warning: Function parameter or member 'phba' not described in '__lpfc_get_device_data'
 drivers/scsi/lpfc/lpfc_scsi.c:5762: warning: Excess function parameter 'pha' description in '__lpfc_get_device_data'
 drivers/scsi/lpfc/lpfc_scsi.c:5818: warning: Function parameter or member 'phba' not described in 'lpfc_find_next_oas_lun'
 drivers/scsi/lpfc/lpfc_scsi.c:5818: warning: Function parameter or member 'found_lun_pri' not described in 'lpfc_find_next_oas_lun'
 drivers/scsi/lpfc/lpfc_scsi.c:5818: warning: Excess function parameter 'pha' description in 'lpfc_find_next_oas_lun'
 drivers/scsi/lpfc/lpfc_scsi.c:5909: warning: Function parameter or member 'phba' not described in 'lpfc_enable_oas_lun'
 drivers/scsi/lpfc/lpfc_scsi.c:5909: warning: Function parameter or member 'pri' not described in 'lpfc_enable_oas_lun'
 drivers/scsi/lpfc/lpfc_scsi.c:5909: warning: Excess function parameter 'pha' description in 'lpfc_enable_oas_lun'
 drivers/scsi/lpfc/lpfc_scsi.c:5968: warning: Function parameter or member 'phba' not described in 'lpfc_disable_oas_lun'
 drivers/scsi/lpfc/lpfc_scsi.c:5968: warning: Function parameter or member 'pri' not described in 'lpfc_disable_oas_lun'
 drivers/scsi/lpfc/lpfc_scsi.c:5968: warning: Excess function parameter 'pha' description in 'lpfc_disable_oas_lun'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 48 ++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 4ffdfd2c8604d..0f0ab86cf1923 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -313,7 +313,7 @@ lpfc_scsi_dev_block(struct lpfc_hba *phba)
 /**
  * lpfc_new_scsi_buf_s3 - Scsi buffer allocator for HBA with SLI3 IF spec
  * @vport: The virtual port for which this call being executed.
- * @num_to_allocate: The requested number of buffers to allocate.
+ * @num_to_alloc: The requested number of buffers to allocate.
  *
  * This routine allocates a scsi buffer for device with SLI-3 interface spec,
  * the scsi buffer contains all the necessary information needed to initiate
@@ -497,6 +497,7 @@ lpfc_sli4_vport_delete_fcp_xri_aborted(struct lpfc_vport *vport)
  * lpfc_sli4_io_xri_aborted - Fast-path process of fcp xri abort
  * @phba: pointer to lpfc hba data structure.
  * @axri: pointer to the fcp xri abort wcqe structure.
+ * @idx: index into hdwq
  *
  * This routine is invoked by the worker thread to process a SLI4 fast-path
  * FCP or NVME aborted xri.
@@ -579,6 +580,8 @@ lpfc_sli4_io_xri_aborted(struct lpfc_hba *phba,
 /**
  * lpfc_get_scsi_buf_s3 - Get a scsi buffer from lpfc_scsi_buf_list of the HBA
  * @phba: The HBA for which this call is being executed.
+ * @ndlp: pointer to a node-list data structure.
+ * @cmnd: Pointer to scsi_cmnd data structure.
  *
  * This routine removes a scsi buffer from head of @phba lpfc_scsi_buf_list list
  * and returns to caller.
@@ -618,6 +621,8 @@ lpfc_get_scsi_buf_s3(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 /**
  * lpfc_get_scsi_buf_s4 - Get a scsi buffer from io_buf_list of the HBA
  * @phba: The HBA for which this call is being executed.
+ * @ndlp: pointer to a node-list data structure.
+ * @cmnd: Pointer to scsi_cmnd data structure.
  *
  * This routine removes a scsi buffer from head of @hdwq io_buf_list
  * and returns to caller.
@@ -730,6 +735,8 @@ lpfc_get_scsi_buf_s4(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 /**
  * lpfc_get_scsi_buf - Get a scsi buffer from lpfc_scsi_buf_list of the HBA
  * @phba: The HBA for which this call is being executed.
+ * @ndlp: pointer to a node-list data structure.
+ * @cmnd: Pointer to scsi_cmnd data structure.
  *
  * This routine removes a scsi buffer from head of @phba lpfc_scsi_buf_list list
  * and returns to caller.
@@ -976,7 +983,7 @@ lpfc_scsi_prep_dma_buf_s3(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
  * @sc: The SCSI command to examine
  * @reftag: (out) BlockGuard reference tag for transmitted data
  * @apptag: (out) BlockGuard application tag for transmitted data
- * @new_guard (in) Value to replace CRC with if needed
+ * @new_guard: (in) Value to replace CRC with if needed
  *
  * Returns BG_ERR_* bit mask or 0 if request ignored
  **/
@@ -1381,8 +1388,8 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  * the specified SCSI command.
  * @phba: The Hba for which this call is being executed.
  * @sc: The SCSI command to examine
- * @txopt: (out) BlockGuard operation for transmitted data
- * @rxopt: (out) BlockGuard operation for received data
+ * @txop: (out) BlockGuard operation for transmitted data
+ * @rxop: (out) BlockGuard operation for received data
  *
  * Returns: zero on success; non-zero if tx and/or rx op cannot be determined
  *
@@ -1461,8 +1468,8 @@ lpfc_sc_to_bg_opcodes(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  * the specified SCSI command in order to force a guard tag error.
  * @phba: The Hba for which this call is being executed.
  * @sc: The SCSI command to examine
- * @txopt: (out) BlockGuard operation for transmitted data
- * @rxopt: (out) BlockGuard operation for received data
+ * @txop: (out) BlockGuard operation for transmitted data
+ * @rxop: (out) BlockGuard operation for received data
  *
  * Returns: zero on success; non-zero if tx and/or rx op cannot be determined
  *
@@ -1533,7 +1540,7 @@ lpfc_bg_err_opcodes(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  * @phba: The Hba for which this call is being executed.
  * @sc: pointer to scsi command we're working on
  * @bpl: pointer to buffer list for protection groups
- * @datacnt: number of segments of data that have been dma mapped
+ * @datasegcnt: number of segments of data that have been dma mapped
  *
  * This function sets up BPL buffer list for protection groups of
  * type LPFC_PG_TYPE_NO_DIF
@@ -1920,7 +1927,8 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  * @phba: The Hba for which this call is being executed.
  * @sc: pointer to scsi command we're working on
  * @sgl: pointer to buffer list for protection groups
- * @datacnt: number of segments of data that have been dma mapped
+ * @datasegcnt: number of segments of data that have been dma mapped
+ * @lpfc_cmd: lpfc scsi command object pointer.
  *
  * This function sets up SGL buffer list for protection groups of
  * type LPFC_PG_TYPE_NO_DIF
@@ -2094,6 +2102,7 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  * @sgl: pointer to buffer list for protection groups
  * @datacnt: number of segments of data that have been dma mapped
  * @protcnt: number of segment of protection data that have been dma mapped
+ * @lpfc_cmd: lpfc scsi command object pointer.
  *
  * This function sets up SGL buffer list for protection groups of
  * type LPFC_PG_TYPE_DIF
@@ -4465,12 +4474,11 @@ void lpfc_poll_start_timer(struct lpfc_hba * phba)
 
 /**
  * lpfc_poll_timeout - Restart polling timer
- * @ptr: Map to lpfc_hba data structure pointer.
+ * @t: Timer construct where lpfc_hba data structure pointer is obtained.
  *
  * This routine restarts fcp_poll timer, when FCP ring  polling is enable
  * and FCP Ring interrupt is disable.
  **/
-
 void lpfc_poll_timeout(struct timer_list *t)
 {
 	struct lpfc_hba *phba = from_timer(phba, t, fcp_poll_timer);
@@ -4486,8 +4494,8 @@ void lpfc_poll_timeout(struct timer_list *t)
 
 /**
  * lpfc_queuecommand - scsi_host_template queuecommand entry point
+ * @shost: kernel scsi host pointer.
  * @cmnd: Pointer to scsi_cmnd data structure.
- * @done: Pointer to done routine.
  *
  * Driver registers this routine to scsi midlayer to submit a @cmd to process.
  * This routine prepares an IOCB from scsi command and provides to firmware.
@@ -5015,7 +5023,7 @@ lpfc_check_fcp_rsp(struct lpfc_vport *vport, struct lpfc_io_buf *lpfc_cmd)
 /**
  * lpfc_send_taskmgmt - Generic SCSI Task Mgmt Handler
  * @vport: The virtual port for which this call is being executed.
- * @rdata: Pointer to remote port local data
+ * @cmnd: Pointer to scsi_cmnd data structure.
  * @tgt_id: Target ID of remote device.
  * @lun_id: Lun number for the TMF
  * @task_mgmt_cmd: type of TMF to send
@@ -5664,10 +5672,11 @@ lpfc_slave_destroy(struct scsi_device *sdev)
 
 /**
  * lpfc_create_device_data - creates and initializes device data structure for OAS
- * @pha: Pointer to host bus adapter structure.
+ * @phba: Pointer to host bus adapter structure.
  * @vport_wwpn: Pointer to vport's wwpn information
  * @target_wwpn: Pointer to target's wwpn information
  * @lun: Lun on target
+ * @pri: Priority
  * @atomic_create: Flag to indicate if memory should be allocated using the
  *		  GFP_ATOMIC flag or not.
  *
@@ -5717,7 +5726,7 @@ lpfc_create_device_data(struct lpfc_hba *phba, struct lpfc_name *vport_wwpn,
 
 /**
  * lpfc_delete_device_data - frees a device data structure for OAS
- * @pha: Pointer to host bus adapter structure.
+ * @phba: Pointer to host bus adapter structure.
  * @lun_info: Pointer to device data structure to free.
  *
  * This routine frees the previously allocated device data structure passed.
@@ -5740,7 +5749,7 @@ lpfc_delete_device_data(struct lpfc_hba *phba,
 
 /**
  * __lpfc_get_device_data - returns the device data for the specified lun
- * @pha: Pointer to host bus adapter structure.
+ * @phba: Pointer to host bus adapter structure.
  * @list: Point to list to search.
  * @vport_wwpn: Pointer to vport's wwpn information
  * @target_wwpn: Pointer to target's wwpn information
@@ -5782,7 +5791,7 @@ __lpfc_get_device_data(struct lpfc_hba *phba, struct list_head *list,
 
 /**
  * lpfc_find_next_oas_lun - searches for the next oas lun
- * @pha: Pointer to host bus adapter structure.
+ * @phba: Pointer to host bus adapter structure.
  * @vport_wwpn: Pointer to vport's wwpn information
  * @target_wwpn: Pointer to target's wwpn information
  * @starting_lun: Pointer to the lun to start searching for
@@ -5790,6 +5799,7 @@ __lpfc_get_device_data(struct lpfc_hba *phba, struct list_head *list,
  * @found_target_wwpn: Pointer to the found lun's target wwpn information
  * @found_lun: Pointer to the found lun.
  * @found_lun_status: Pointer to status of the found lun.
+ * @found_lun_pri: Pointer to priority of the found lun.
  *
  * This routine searches the luns list for the specified lun
  * or the first lun for the vport/target.  If the vport wwpn contains
@@ -5884,10 +5894,11 @@ lpfc_find_next_oas_lun(struct lpfc_hba *phba, struct lpfc_name *vport_wwpn,
 
 /**
  * lpfc_enable_oas_lun - enables a lun for OAS operations
- * @pha: Pointer to host bus adapter structure.
+ * @phba: Pointer to host bus adapter structure.
  * @vport_wwpn: Pointer to vport's wwpn information
  * @target_wwpn: Pointer to target's wwpn information
  * @lun: Lun
+ * @pri: Priority
  *
  * This routine enables a lun for oas operations.  The routines does so by
  * doing the following :
@@ -5944,10 +5955,11 @@ lpfc_enable_oas_lun(struct lpfc_hba *phba, struct lpfc_name *vport_wwpn,
 
 /**
  * lpfc_disable_oas_lun - disables a lun for OAS operations
- * @pha: Pointer to host bus adapter structure.
+ * @phba: Pointer to host bus adapter structure.
  * @vport_wwpn: Pointer to vport's wwpn information
  * @target_wwpn: Pointer to target's wwpn information
  * @lun: Lun
+ * @pri: Priority
  *
  * This routine disables a lun for oas operations.  The routines does so by
  * doing the following :
-- 
2.25.1

