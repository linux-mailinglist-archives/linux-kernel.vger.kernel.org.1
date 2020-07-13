Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8BA21A61D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgGIRq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgGIRqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:46:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B236AC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 10:46:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so2757464wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pfHqz62aOBK6PBea5QXT7uvBZ9qWm4NsoFX/E3qCoE=;
        b=ZI3QoqNz9orLSt6V862HwCKiM/cBnCKp9Rvr/uW/DsBAGBN3vfdkBYBLvo/zd89LDB
         jiuOPC57djAuSaW34tQMv3Hj9TUItaRafT+7eO/1r94LKluWhYZ4IlsiP5bT9GteFcxU
         IZzNMa1TtRDJoIFzjtrrL6iTiYaDg1ykYGJm4Rmit1Loy52KIMVk4ahC+kUxXVoeslOd
         AhbetjvXIhDnwHNaVccuaDxXspuadvgKGlxf5DdQ1p2W8GoYzQgverK5fKDGlvGg/YQh
         bgo/RTkfqQzG7s+0P8B3kt08MHfDKMBp9VHAaKsycLbXElAi1t/sr+e3tRA7KiUCuzfS
         1IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pfHqz62aOBK6PBea5QXT7uvBZ9qWm4NsoFX/E3qCoE=;
        b=NgWYtoyKfQA7TAGDsOGKbxcvXq+F76P6w0IZiXmgdzxL1AlZKVepZLItWIphvF/iLn
         KmFTZjBi6iyu3NIvjGrAlT2jBAakwHc34E4w3tY066nIjAnfxuIob7vny88qPegAvSBX
         GtEGdPh/So801eQV1zLxiy31NtmJwjFhrA2WXa8xw+1VoHpqz9htSnRPN/8VAudkG/nl
         vJXkdWW9yRbxKPewzIQK+Zs1RObq4EZv6vz5OMl0V6G9kr8Y5w22zLqqS1j6HINhJ/qD
         5e2t1z0RkyOPY6niF6Mic9ud/lm5ay1761rA/ihNh+oq1QOL5ORvpB0bHGqvF+qtEXOb
         OCVA==
X-Gm-Message-State: AOAM533TzIMmC+NI5sojP7OkmejRJsxGAwELbt3XEbsypo0xf9s73zXN
        Qn8M6Ph2bCGlKSTdp4bxgfXS9w==
X-Google-Smtp-Source: ABdhPJy3N0OJ0FKzXRa7/mNiWFrcZH+cTR1AeIVfOS3Ek3UWvtdis93BLjjWtGWLJQcMnRU1V4KGHg==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr1281588wme.16.1594316782230;
        Thu, 09 Jul 2020 10:46:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id f15sm6063854wrx.91.2020.07.09.10.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 10:46:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 20/24] scsi: lpfc: lpfc_nvme: Correct some pretty obvious misdocumentation
Date:   Thu,  9 Jul 2020 18:45:52 +0100
Message-Id: <20200709174556.7651-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709174556.7651-1-lee.jones@linaro.org>
References: <20200709174556.7651-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Either due to API slippage before the driver was mainlined or copy/paste errors.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_nvme.c:254: warning: Function parameter or member 'pnvme_lport' not described in 'lpfc_nvme_create_queue'
 drivers/scsi/lpfc/lpfc_nvme.c:254: warning: Function parameter or member 'qsize' not described in 'lpfc_nvme_create_queue'
 drivers/scsi/lpfc/lpfc_nvme.c:254: warning: Excess function parameter 'lpfc_pnvme' description in 'lpfc_nvme_create_queue'
 drivers/scsi/lpfc/lpfc_nvme.c:311: warning: Function parameter or member 'pnvme_lport' not described in 'lpfc_nvme_delete_queue'
 drivers/scsi/lpfc/lpfc_nvme.c:311: warning: Excess function parameter 'lpfc_pnvme' description in 'lpfc_nvme_delete_queue'
 drivers/scsi/lpfc/lpfc_nvme.c:689: warning: Function parameter or member 'gen_req_cmp' not described in '__lpfc_nvme_ls_req'
 drivers/scsi/lpfc/lpfc_nvme.c:801: warning: Function parameter or member 'pnvme_lport' not described in 'lpfc_nvme_ls_req'
 drivers/scsi/lpfc/lpfc_nvme.c:801: warning: Function parameter or member 'pnvme_rport' not described in 'lpfc_nvme_ls_req'
 drivers/scsi/lpfc/lpfc_nvme.c:801: warning: Function parameter or member 'pnvme_lsreq' not described in 'lpfc_nvme_ls_req'
 drivers/scsi/lpfc/lpfc_nvme.c:801: warning: Excess function parameter 'lpfc_nvme_lport' description in 'lpfc_nvme_ls_req'
 drivers/scsi/lpfc/lpfc_nvme.c:801: warning: Excess function parameter 'lpfc_nvme_rport' description in 'lpfc_nvme_ls_req'
 drivers/scsi/lpfc/lpfc_nvme.c:937: warning: Function parameter or member 'pnvme_lport' not described in 'lpfc_nvme_ls_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:937: warning: Function parameter or member 'pnvme_rport' not described in 'lpfc_nvme_ls_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:937: warning: Function parameter or member 'pnvme_lsreq' not described in 'lpfc_nvme_ls_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:937: warning: Excess function parameter 'lpfc_nvme_lport' description in 'lpfc_nvme_ls_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:937: warning: Excess function parameter 'lpfc_nvme_rport' description in 'lpfc_nvme_ls_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1075: warning: Function parameter or member 'phba' not described in 'lpfc_nvme_io_cmd_wqe_cmpl'
 drivers/scsi/lpfc/lpfc_nvme.c:1075: warning: Function parameter or member 'pwqeIn' not described in 'lpfc_nvme_io_cmd_wqe_cmpl'
 drivers/scsi/lpfc/lpfc_nvme.c:1075: warning: Function parameter or member 'wcqe' not described in 'lpfc_nvme_io_cmd_wqe_cmpl'
 drivers/scsi/lpfc/lpfc_nvme.c:1075: warning: Excess function parameter 'lpfc_pnvme' description in 'lpfc_nvme_io_cmd_wqe_cmpl'
 drivers/scsi/lpfc/lpfc_nvme.c:1075: warning: Excess function parameter 'lpfc_nvme_lport' description in 'lpfc_nvme_io_cmd_wqe_cmpl'
 drivers/scsi/lpfc/lpfc_nvme.c:1075: warning: Excess function parameter 'lpfc_nvme_rport' description in 'lpfc_nvme_io_cmd_wqe_cmpl'
 drivers/scsi/lpfc/lpfc_nvme.c:1313: warning: Function parameter or member 'vport' not described in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1313: warning: Function parameter or member 'lpfc_ncmd' not described in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1313: warning: Function parameter or member 'pnode' not described in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1313: warning: Function parameter or member 'cstat' not described in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1313: warning: Excess function parameter 'lpfc_pnvme' description in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1313: warning: Excess function parameter 'lpfc_nvme_lport' description in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1313: warning: Excess function parameter 'lpfc_nvme_rport' description in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1313: warning: Excess function parameter 'lpfc_nvme_fcreq' description in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1313: warning: Excess function parameter 'hw_queue_handle' description in 'lpfc_nvme_prep_io_cmd'
 drivers/scsi/lpfc/lpfc_nvme.c:1420: warning: Function parameter or member 'vport' not described in 'lpfc_nvme_prep_io_dma'
 drivers/scsi/lpfc/lpfc_nvme.c:1420: warning: Function parameter or member 'lpfc_ncmd' not described in 'lpfc_nvme_prep_io_dma'
 drivers/scsi/lpfc/lpfc_nvme.c:1420: warning: Excess function parameter 'lpfc_pnvme' description in 'lpfc_nvme_prep_io_dma'
 drivers/scsi/lpfc/lpfc_nvme.c:1420: warning: Excess function parameter 'lpfc_nvme_lport' description in 'lpfc_nvme_prep_io_dma'
 drivers/scsi/lpfc/lpfc_nvme.c:1420: warning: Excess function parameter 'lpfc_nvme_rport' description in 'lpfc_nvme_prep_io_dma'
 drivers/scsi/lpfc/lpfc_nvme.c:1420: warning: Excess function parameter 'lpfc_nvme_fcreq' description in 'lpfc_nvme_prep_io_dma'
 drivers/scsi/lpfc/lpfc_nvme.c:1420: warning: Excess function parameter 'hw_queue_handle' description in 'lpfc_nvme_prep_io_dma'
 drivers/scsi/lpfc/lpfc_nvme.c:1598: warning: bad line:  indicated in @lpfc_nvme_rport.
 drivers/scsi/lpfc/lpfc_nvme.c:1609: warning: Function parameter or member 'pnvme_lport' not described in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1609: warning: Function parameter or member 'pnvme_rport' not described in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1609: warning: Function parameter or member 'pnvme_fcreq' not described in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1609: warning: Excess function parameter 'lpfc_pnvme' description in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1609: warning: Excess function parameter 'lpfc_nvme_lport' description in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1609: warning: Excess function parameter 'lpfc_nvme_rport' description in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1609: warning: Excess function parameter 'lpfc_nvme_fcreq' description in 'lpfc_nvme_fcp_io_submit'
 drivers/scsi/lpfc/lpfc_nvme.c:1856: warning: Function parameter or member 'abts_cmpl' not described in 'lpfc_nvme_abort_fcreq_cmpl'
 drivers/scsi/lpfc/lpfc_nvme.c:1856: warning: Excess function parameter 'rspiocb' description in 'lpfc_nvme_abort_fcreq_cmpl'
 drivers/scsi/lpfc/lpfc_nvme.c:1892: warning: Function parameter or member 'pnvme_lport' not described in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1892: warning: Function parameter or member 'pnvme_rport' not described in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1892: warning: Function parameter or member 'pnvme_fcreq' not described in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1892: warning: Excess function parameter 'lpfc_pnvme' description in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1892: warning: Excess function parameter 'lpfc_nvme_lport' description in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1892: warning: Excess function parameter 'lpfc_nvme_rport' description in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:1892: warning: Excess function parameter 'lpfc_nvme_fcreq' description in 'lpfc_nvme_fcp_abort'
 drivers/scsi/lpfc/lpfc_nvme.c:2093: warning: Function parameter or member 'ndlp' not described in 'lpfc_get_nvme_buf'
 drivers/scsi/lpfc/lpfc_nvme.c:2093: warning: Function parameter or member 'idx' not described in 'lpfc_get_nvme_buf'
 drivers/scsi/lpfc/lpfc_nvme.c:2093: warning: Function parameter or member 'expedite' not described in 'lpfc_get_nvme_buf'
 drivers/scsi/lpfc/lpfc_nvme.c:2197: warning: Function parameter or member 'vport' not described in 'lpfc_nvme_create_localport'
 drivers/scsi/lpfc/lpfc_nvme.c:2330: warning: Function parameter or member 'vport' not described in 'lpfc_nvme_destroy_localport'
 drivers/scsi/lpfc/lpfc_nvme.c:2330: warning: Excess function parameter 'pnvme' description in 'lpfc_nvme_destroy_localport'
 drivers/scsi/lpfc/lpfc_nvme.c:2543: warning: Function parameter or member 'vport' not described in 'lpfc_nvme_rescan_port'
 drivers/scsi/lpfc/lpfc_nvme.c:2543: warning: Function parameter or member 'ndlp' not described in 'lpfc_nvme_rescan_port'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 38 ++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index fdfca02704dc0..91696814174eb 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -234,8 +234,10 @@ lpfc_nvme_prep_abort_wqe(struct lpfc_iocbq *pwqeq, u16 xritag, u8 opt)
 
 /**
  * lpfc_nvme_create_queue -
+ * @pnvme_lport: Transport localport that LS is to be issued from
  * @lpfc_pnvme: Pointer to the driver's nvme instance data
  * @qidx: An cpu index used to affinitize IO queues and MSIX vectors.
+ * @qsize: Size of the queue in bytes
  * @handle: An opaque driver handle used in follow-up calls.
  *
  * Driver registers this routine to preallocate and initialize any
@@ -292,7 +294,7 @@ lpfc_nvme_create_queue(struct nvme_fc_local_port *pnvme_lport,
 
 /**
  * lpfc_nvme_delete_queue -
- * @lpfc_pnvme: Pointer to the driver's nvme instance data
+ * @pnvme_lport: Transport localport that LS is to be issued from
  * @qidx: An cpu index used to affinitize IO queues and MSIX vectors.
  * @handle: An opaque driver handle from lpfc_nvme_create_queue
  *
@@ -672,6 +674,7 @@ lpfc_nvme_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
  * @vport: The local port issuing the LS
  * @ndlp: The remote port to send the LS to
  * @pnvme_lsreq: Pointer to LS request structure from the transport
+ * @gen_req_cmp: Completion call-back
  *
  * Routine validates the ndlp, builds buffers and sends a GEN_REQUEST
  * WQE to perform the LS operation.
@@ -783,9 +786,9 @@ __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 /**
  * lpfc_nvme_ls_req - Issue an NVME Link Service request
- * @lpfc_nvme_lport: Transport localport that LS is to be issued from.
- * @lpfc_nvme_rport: Transport remoteport that LS is to be sent to.
- * @pnvme_lsreq - the transport nvme_ls_req structure for the LS
+ * @pnvme_lport: Transport localport that LS is to be issued from.
+ * @nvme_rport: Transport remoteport that LS is to be sent to.
+ * @pnvme_lsreq: the transport nvme_ls_req structure for the LS
  *
  * Driver registers this routine to handle any link service request
  * from the nvme_fc transport to a remote nvme-aware port.
@@ -923,9 +926,9 @@ lpfc_nvme_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 
 /**
  * lpfc_nvme_ls_abort - Abort a prior NVME LS request
- * @lpfc_nvme_lport: Transport localport that LS is to be issued from.
- * @lpfc_nvme_rport: Transport remoteport that LS is to be sent to.
- * @pnvme_lsreq - the transport nvme_ls_req structure for the LS
+ * @pnvme_lport: Transport localport that LS is to be issued from.
+ * @pnvme_rport: Transport remoteport that LS is to be sent to.
+ * @pnvme_lsreq: the transport nvme_ls_req structure for the LS
  *
  * Driver registers this routine to abort a NVME LS request that is
  * in progress (from the transports perspective).
@@ -1055,11 +1058,8 @@ lpfc_nvme_adj_fcp_sgls(struct lpfc_vport *vport,
 }
 
 
-/**
+/*
  * lpfc_nvme_io_cmd_wqe_cmpl - Complete an NVME-over-FCP IO
- * @lpfc_pnvme: Pointer to the driver's nvme instance data
- * @lpfc_nvme_lport: Pointer to the driver's local port data
- * @lpfc_nvme_rport: Pointer to the rport getting the @lpfc_nvme_ereq
  *
  * Driver registers this routine as it io request handler.  This
  * routine issues an fcp WQE with data from the @lpfc_nvme_fcpreq
@@ -1291,11 +1291,10 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 
 /**
  * lpfc_nvme_prep_io_cmd - Issue an NVME-over-FCP IO
- * @lpfc_pnvme: Pointer to the driver's nvme instance data
- * @lpfc_nvme_lport: Pointer to the driver's local port data
- * @lpfc_nvme_rport: Pointer to the rport getting the @lpfc_nvme_ereq
- * @lpfc_nvme_fcreq: IO request from nvme fc to driver.
- * @hw_queue_handle: Driver-returned handle in lpfc_nvme_create_queue
+ * @vport: pointer to a host virtual N_Port data structure
+ * @lpfcn_cmd: Pointer to lpfc scsi command
+ * @pnode: pointer to a node-list data structure
+ * @cstat: pointer to the control status structure
  *
  * Driver registers this routine as it io request handler.  This
  * routine issues an fcp WQE with data from the @lpfc_nvme_fcpreq
@@ -1400,11 +1399,8 @@ lpfc_nvme_prep_io_cmd(struct lpfc_vport *vport,
 
 /**
  * lpfc_nvme_prep_io_dma - Issue an NVME-over-FCP IO
- * @lpfc_pnvme: Pointer to the driver's nvme instance data
- * @lpfc_nvme_lport: Pointer to the driver's local port data
- * @lpfc_nvme_rport: Pointer to the rport getting the @lpfc_nvme_ereq
- * @lpfc_nvme_fcreq: IO request from nvme fc to driver.
- * @hw_queue_handle: Driver-returned handle in lpfc_nvme_create_queue
+ * @vport: pointer to a host virtual N_Port data structure
+ * @lpfcn_cmd: Pointer to lpfc scsi command
  *
  * Driver registers this routine as it io request handler.  This
  * routine issues an fcp WQE with data from the @lpfc_nvme_fcpreq
-- 
2.25.1

