Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8B32A2A38
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgKBL6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbgKBL5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95812C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:47 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e2so9231062wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlRlfgBmVVvi0XaSviLroiHJRxOcA6L90EI31nd/fJo=;
        b=P4fR8gAshBM4dXFdYm+t+5vPzVXaxzWm1AWMvdQ24sYMf1N1Li/4B9W9jfR8Ss1l0l
         9qXAT8te9upMzJAw20SS0Z88wv2T6vc4RBQUop4xPaawSja7bybF17oPYaG8T+FJ01+w
         qJ0EjYa5rNUoaNQ27OeEt+1B7FXPzehhmmsQ5DmT9X/p/lQ3OaO0NSpLyyOkUDzvpuuf
         K9KkHy0iGxDgrtzNAEguGUAeynGL5f4aebx9hN9/aLEEOLCRLUnJ5qAyAyyjtJ91xj0K
         EK2tnUYA0ARuQ2ifupYQ2Y7Qt1uwrGK2/HoPjzJe+KPI2DSZVoebayJnMlkdmBP1e17T
         R1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlRlfgBmVVvi0XaSviLroiHJRxOcA6L90EI31nd/fJo=;
        b=pnL8NS1bk0NBIDVmYSnLeGVJqqRjofZTaKs1+oxih9u8QM2HcbAkcTPOqej7weBZ/U
         hVqrX4sRiqTYp2r0ADCzBN6kmbMF4tmAmhT90LvrUb85HvO2pKpxYV7w7/2wpRBV45U/
         fhz8pC2EoknHYhSzUmmoTJvs/rnI5owFIJdIGBQE1WJtR0Eces4CZj0+0glUwq7v9DtM
         ylsPJsaSwn6QBKmtTbUydzlJsHYWkevw+QhIn+wC9F/LaDk7mCGY1BSJi9DV1odc2nnV
         cyc3ktVjrxjChyfHMyXub+dJziQ7ckshc5Fc4EztJ7fLRQumrFxR4zLK1mpxAgrnM1Ht
         TeEQ==
X-Gm-Message-State: AOAM532KNq4pR4YfGgPcP3xVKlDKl8kxbht3MYS3eARZTSyB0BpIWOkW
        rE+2n9up/Wz8OwitPsrFzvC1OQ==
X-Google-Smtp-Source: ABdhPJyiHhmf4OAQ37vTY69rfUyoNdMIj7pbs6exez/ucZxVUyhLgtjvugvDllzmGloeV7ZpV58Ung==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr17337134wmc.8.1604318266229;
        Mon, 02 Nov 2020 03:57:46 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 12/19] scsi: lpfc: lpfc_nvme: Fix some kernel-doc related issues
Date:   Mon,  2 Nov 2020 11:57:21 +0000
Message-Id: <20201102115728.1077697-13-lee.jones@linaro.org>
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
 drivers/scsi/lpfc/lpfc_nvme.c:256: warning: Excess function parameter 'lpfc_pnvme' description in 'lpfc_nvme_create_queue'
 drivers/scsi/lpfc/lpfc_nvme.c:804: warning: Function parameter or member 'pnvme_rport' not described in 'lpfc_nvme_ls_req'
 drivers/scsi/lpfc/lpfc_nvme.c:804: warning: Excess function parameter 'nvme_rport' description in 'lpfc_nvme_ls_req'
 drivers/scsi/lpfc/lpfc_nvme.c:1312: warning: Function parameter or member 'lpfc_ncmd' not described in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1312: warning: Excess function parameter 'lpfcn_cmd' description in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1416: warning: Function parameter or member 'lpfc_ncmd' not described in 'lpfc_nvme_prep_io_dma'
 drivers/scsi/lpfc/lpfc_nvme.c:1416: warning: Excess function parameter 'lpfcn_cmd' description in 'lpfc_nvme_prep_io_dma'
 drivers/scsi/lpfc/lpfc_nvme.c:1594: warning: bad line:  indicated in @lpfc_nvme_rport.
 drivers/scsi/lpfc/lpfc_nvme.c:1605: warning: Function parameter or member 'pnvme_lport' not described in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1605: warning: Function parameter or member 'pnvme_rport' not described in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1605: warning: Function parameter or member 'pnvme_fcreq' not described in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1605: warning: Excess function parameter 'lpfc_pnvme' description in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1605: warning: Excess function parameter 'lpfc_nvme_lport' description in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1605: warning: Excess function parameter 'lpfc_nvme_rport' description in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1605: warning: Excess function parameter 'lpfc_nvme_fcreq' description in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1852: warning: Function parameter or member 'abts_cmpl' not described in 'lpfc_nvme_abort_fcreq_cmpl'
 drivers/scsi/lpfc/lpfc_nvme.c:1852: warning: Excess function parameter 'rspiocb' description in 'lpfc_nvme_abort_fcreq_cmpl'
 drivers/scsi/lpfc/lpfc_nvme.c:1888: warning: Function parameter or member 'pnvme_lport' not described in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1888: warning: Function parameter or member 'pnvme_rport' not described in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1888: warning: Function parameter or member 'pnvme_fcreq' not described in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1888: warning: Excess function parameter 'lpfc_pnvme' description in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1888: warning: Excess function parameter 'lpfc_nvme_lport' description in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1888: warning: Excess function parameter 'lpfc_nvme_rport' description in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1888: warning: Excess function parameter 'lpfc_nvme_fcreq' description in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:2089: warning: Function parameter or member 'ndlp' not described in 'lpfc_get_nvme_buf'
 drivers/scsi/lpfc/lpfc_nvme.c:2089: warning: Function parameter or member 'idx' not described in 'lpfc_get_nvme_buf'
 drivers/scsi/lpfc/lpfc_nvme.c:2089: warning: Function parameter or member 'expedite' not described in 'lpfc_get_nvme_buf'
 drivers/scsi/lpfc/lpfc_nvme.c:2193: warning: Function parameter or member 'vport' not described in 'lpfc_nvme_create_localport'
 drivers/scsi/lpfc/lpfc_nvme.c:2326: warning: Function parameter or member 'vport' not described in 'lpfc_nvme_destroy_localport'
 drivers/scsi/lpfc/lpfc_nvme.c:2326: warning: Excess function parameter 'pnvme' description in 'lpfc_nvme_destroy_localport'
 drivers/scsi/lpfc/lpfc_nvme.c:2544: warning: Function parameter or member 'vport' not described in 'lpfc_nvme_rescan_port'
 drivers/scsi/lpfc/lpfc_nvme.c:2544: warning: Function parameter or member 'ndlp' not described in 'lpfc_nvme_rescan_port'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 33d007ca5c8e6..42eb144fed0d1 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -235,7 +235,6 @@ lpfc_nvme_prep_abort_wqe(struct lpfc_iocbq *pwqeq, u16 xritag, u8 opt)
 /**
  * lpfc_nvme_create_queue -
  * @pnvme_lport: Transport localport that LS is to be issued from
- * @lpfc_pnvme: Pointer to the driver's nvme instance data
  * @qidx: An cpu index used to affinitize IO queues and MSIX vectors.
  * @qsize: Size of the queue in bytes
  * @handle: An opaque driver handle used in follow-up calls.
@@ -787,7 +786,7 @@ __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 /**
  * lpfc_nvme_ls_req - Issue an NVME Link Service request
  * @pnvme_lport: Transport localport that LS is to be issued from.
- * @nvme_rport: Transport remoteport that LS is to be sent to.
+ * @pnvme_rport: Transport remoteport that LS is to be sent to.
  * @pnvme_lsreq: the transport nvme_ls_req structure for the LS
  *
  * Driver registers this routine to handle any link service request
@@ -1290,7 +1289,7 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 /**
  * lpfc_nvme_prep_io_cmd - Issue an NVME-over-FCP IO
  * @vport: pointer to a host virtual N_Port data structure
- * @lpfcn_cmd: Pointer to lpfc scsi command
+ * @lpfc_ncmd: Pointer to lpfc scsi command
  * @pnode: pointer to a node-list data structure
  * @cstat: pointer to the control status structure
  *
@@ -1398,7 +1397,7 @@ lpfc_nvme_prep_io_cmd(struct lpfc_vport *vport,
 /**
  * lpfc_nvme_prep_io_dma - Issue an NVME-over-FCP IO
  * @vport: pointer to a host virtual N_Port data structure
- * @lpfcn_cmd: Pointer to lpfc scsi command
+ * @lpfc_ncmd: Pointer to lpfc scsi command
  *
  * Driver registers this routine as it io request handler.  This
  * routine issues an fcp WQE with data from the @lpfc_nvme_fcpreq
@@ -1580,16 +1579,14 @@ lpfc_nvme_prep_io_dma(struct lpfc_vport *vport,
 
 /**
  * lpfc_nvme_fcp_io_submit - Issue an NVME-over-FCP IO
- * @lpfc_pnvme: Pointer to the driver's nvme instance data
- * @lpfc_nvme_lport: Pointer to the driver's local port data
- * @lpfc_nvme_rport: Pointer to the rport getting the @lpfc_nvme_ereq
- * @lpfc_nvme_fcreq: IO request from nvme fc to driver.
+ * @pnvme_lport: Pointer to the driver's local port data
+ * @pnvme_rport: Pointer to the rport getting the @lpfc_nvme_ereq
  * @hw_queue_handle: Driver-returned handle in lpfc_nvme_create_queue
+ * @pnvme_fcreq: IO request from nvme fc to driver.
  *
  * Driver registers this routine as it io request handler.  This
  * routine issues an fcp WQE with data from the @lpfc_nvme_fcpreq
- * data structure to the rport
- indicated in @lpfc_nvme_rport.
+ * data structure to the rport indicated in @lpfc_nvme_rport.
  *
  * Return value :
  *   0 - Success
@@ -1837,7 +1834,7 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
  * lpfc_nvme_abort_fcreq_cmpl - Complete an NVME FCP abort request.
  * @phba: Pointer to HBA context object
  * @cmdiocb: Pointer to command iocb object.
- * @rspiocb: Pointer to response iocb object.
+ * @abts_cmpl: Pointer to wcqe complete object.
  *
  * This is the callback function for any NVME FCP IO that was aborted.
  *
@@ -1863,11 +1860,10 @@ lpfc_nvme_abort_fcreq_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 /**
  * lpfc_nvme_fcp_abort - Issue an NVME-over-FCP ABTS
- * @lpfc_pnvme: Pointer to the driver's nvme instance data
- * @lpfc_nvme_lport: Pointer to the driver's local port data
- * @lpfc_nvme_rport: Pointer to the rport getting the @lpfc_nvme_ereq
- * @lpfc_nvme_fcreq: IO request from nvme fc to driver.
+ * @pnvme_lport: Pointer to the driver's local port data
+ * @pnvme_rport: Pointer to the rport getting the @lpfc_nvme_ereq
  * @hw_queue_handle: Driver-returned handle in lpfc_nvme_create_queue
+ * @pnvme_fcreq: IO request from nvme fc to driver.
  *
  * Driver registers this routine as its nvme request io abort handler.  This
  * routine issues an fcp Abort WQE with data from the @lpfc_nvme_fcpreq
@@ -2070,9 +2066,8 @@ static struct nvme_fc_port_template lpfc_nvme_template = {
 	.fcprqst_priv_sz = sizeof(struct lpfc_nvme_fcpreq_priv),
 };
 
-/**
+/*
  * lpfc_get_nvme_buf - Get a nvme buffer from io_buf_list of the HBA
- * @phba: The HBA for which this call is being executed.
  *
  * This routine removes a nvme buffer from head of @hdwq io_buf_list
  * and returns to caller.
@@ -2172,7 +2167,7 @@ lpfc_release_nvme_buf(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_ncmd)
 
 /**
  * lpfc_nvme_create_localport - Create/Bind an nvme localport instance.
- * @pvport - the lpfc_vport instance requesting a localport.
+ * @vport - the lpfc_vport instance requesting a localport.
  *
  * This routine is invoked to create an nvme localport instance to bind
  * to the nvme_fc_transport.  It is called once during driver load
@@ -2319,7 +2314,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 
 /**
  * lpfc_nvme_destroy_localport - Destroy lpfc_nvme bound to nvme transport.
- * @pnvme: pointer to lpfc nvme data structure.
+ * @vport: pointer to a host virtual N_Port data structure
  *
  * This routine is invoked to destroy all lports bound to the phba.
  * The lport memory was allocated by the nvme fc transport and is
@@ -2538,7 +2533,7 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 #endif
 }
 
-/**
+/*
  * lpfc_nvme_rescan_port - Check to see if we should rescan this remoteport
  *
  * If the ndlp represents an NVME Target, that we are logged into,
-- 
2.25.1

