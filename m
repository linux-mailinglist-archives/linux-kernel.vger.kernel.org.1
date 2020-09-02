Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2538225B5EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIBVdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 17:33:45 -0400
Received: from mx.exactcode.de ([144.76.154.42]:54022 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgIBVdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 17:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:From:Subject:Cc:To:Message-Id:Date; bh=6bBb4qME0YpjrTNE8YMkGUwmqTwDmdhbR53+RLZlOp0=;
        b=wwXI8J6aISQ37j7XEn4Xlh4Y0Ix7bt2fFmeHESKEKVH3kGW9bUN9D33LN6jc4UUddk1m/rQQuckMfJUk+RE4jcrHt3vyfOH0KS1mvo+ZU2qYYdYwCcIk7+i+ml2sEqaT6vA+4bOMFce4E7KMYQehafn938sM61XbYwIoOPynoqA=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1kDaOO-0007rf-U5; Wed, 02 Sep 2020 21:34:09 +0000
Received: from ip5f5af2bb.dynamic.kabel-deutschland.de ([95.90.242.187] helo=localhost)
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1kDaJd-0001f0-Q6; Wed, 02 Sep 2020 21:29:16 +0000
Date:   Wed, 02 Sep 2020 23:29:49 +0200 (CEST)
Message-Id: <20200902.232949.1343752343092794969.rene@exactcode.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, himanshu.madhani@oracle.com
Subject: [PATCH v2] use cpu_to_le{16,32} instead of __constant_cpu_to_*
From:   Rene Rebe <rene@exactcode.com>
In-Reply-To: <c7daea00-410d-2073-bf52-2abda9acdf8e@acm.org>
References: <b7719680-e451-5687-1fb7-c8c059a880d4@acm.org>
        <2C755628-1426-4BA4-B2A3-AD059BB0F605@exactcode.com>
        <c7daea00-410d-2073-bf52-2abda9acdf8e@acm.org>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.5 (/)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> wrote:

> Hi Ren=E9,
> =

> Whether __constant_cpu_to_le16() is used or cpu_to_le16(), the compil=
er
> generates exactly the same code. The name of the cpu_to_le16() functi=
on however
> is shorter. I recommend cpu_to_le16() because of its shorter name and=
 because
> that's what other kernel drivers use.

As per recommendation, convert a few remaining __constant_cpu_to_le{16,=
32}
instances in the qla2xxx, qla4xxx and cifs to just cpu_to_le{16,32}.

The later was apparently left over in f5307104e757 ("cifs: don't use
__constant_cpu_to_le32()").

Signed-off-by: Ren=E9 Rebe <rene@exactcode.de>

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/q=
la_target.c
index fbb80a043b4f..3de6bf94ccc0 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3583,7 +3583,7 @@ static int __qlt_send_term_imm_notif(struct scsi_=
qla_host *vha,
 =

 	/* terminate */
 	nack->u.isp24.flags |=3D
-		__constant_cpu_to_le16(NOTIFY_ACK_FLAGS_TERMINATE);
+		cpu_to_le16(NOTIFY_ACK_FLAGS_TERMINATE);
 =

 	nack->u.isp24.srr_rx_id =3D ntfy->u.isp24.srr_rx_id;
 	nack->u.isp24.status =3D ntfy->u.isp24.status;
diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla=
_tmpl.c
index 8dc82cfd38b2..f83b2f5fb490 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -912,7 +912,7 @@ qla27xx_driver_info(struct qla27xx_fwdt_template *t=
mp)
 	tmp->driver_info[0] =3D cpu_to_le32(
 		v[3] << 24 | v[2] << 16 | v[1] << 8 | v[0]);
 	tmp->driver_info[1] =3D cpu_to_le32(v[5] << 8 | v[4]);
-	tmp->driver_info[2] =3D __constant_cpu_to_le32(0x12345678);
+	tmp->driver_info[2] =3D cpu_to_le32(0x12345678);
 }
 =

 static void
diff --git a/drivers/scsi/qla4xxx/ql4_init.c b/drivers/scsi/qla4xxx/ql4=
_init.c
index 4a7ef971a387..cc4cd54eb7a8 100644
--- a/drivers/scsi/qla4xxx/ql4_init.c
+++ b/drivers/scsi/qla4xxx/ql4_init.c
@@ -120,8 +120,8 @@ int qla4xxx_init_rings(struct scsi_qla_host *ha)
 		 * the interrupt_handler to think there are responses to be
 		 * processed when there aren't.
 		 */
-		ha->shadow_regs->req_q_out =3D __constant_cpu_to_le32(0);
-		ha->shadow_regs->rsp_q_in =3D __constant_cpu_to_le32(0);
+		ha->shadow_regs->req_q_out =3D cpu_to_le32(0);
+		ha->shadow_regs->rsp_q_in =3D cpu_to_le32(0);
 		wmb();
 =

 		writel(0, &ha->reg->req_q_in);
diff --git a/drivers/scsi/qla4xxx/ql4_iocb.c b/drivers/scsi/qla4xxx/ql4=
_iocb.c
index a8df2d7eb069..dd25f917b5e6 100644
--- a/drivers/scsi/qla4xxx/ql4_iocb.c
+++ b/drivers/scsi/qla4xxx/ql4_iocb.c
@@ -161,7 +161,7 @@ static void qla4xxx_build_scsi_iocbs(struct srb *sr=
b,
 =

 	if (!scsi_bufflen(cmd) || cmd->sc_data_direction =3D=3D DMA_NONE) {
 		/* No data being transferred */
-		cmd_entry->ttlByteCnt =3D __constant_cpu_to_le32(0);
+		cmd_entry->ttlByteCnt =3D cpu_to_le32(0);
 		return;
 	}
 =

diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_=
mbx.c
index bc8de7d402d5..02396da2acd4 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -646,8 +646,8 @@ int qla4xxx_initialize_fw_cb(struct scsi_qla_host *=
 ha)
 	/* Fill in the request and response queue information. */
 	init_fw_cb->rqq_consumer_idx =3D cpu_to_le16(ha->request_out);
 	init_fw_cb->compq_producer_idx =3D cpu_to_le16(ha->response_in);
-	init_fw_cb->rqq_len =3D __constant_cpu_to_le16(REQUEST_QUEUE_DEPTH);
-	init_fw_cb->compq_len =3D __constant_cpu_to_le16(RESPONSE_QUEUE_DEPTH=
);
+	init_fw_cb->rqq_len =3D cpu_to_le16(REQUEST_QUEUE_DEPTH);
+	init_fw_cb->compq_len =3D cpu_to_le16(RESPONSE_QUEUE_DEPTH);
 	init_fw_cb->rqq_addr_lo =3D cpu_to_le32(LSDW(ha->request_dma));
 	init_fw_cb->rqq_addr_hi =3D cpu_to_le32(MSDW(ha->request_dma));
 	init_fw_cb->compq_addr_lo =3D cpu_to_le32(LSDW(ha->response_dma));
@@ -657,20 +657,20 @@ int qla4xxx_initialize_fw_cb(struct scsi_qla_host=
 * ha)
 =

 	/* Set up required options. */
 	init_fw_cb->fw_options |=3D
-		__constant_cpu_to_le16(FWOPT_SESSION_MODE |
+		cpu_to_le16(FWOPT_SESSION_MODE |
 				       FWOPT_INITIATOR_MODE);
 =

 	if (is_qla80XX(ha))
 		init_fw_cb->fw_options |=3D
-		    __constant_cpu_to_le16(FWOPT_ENABLE_CRBDB);
+		    cpu_to_le16(FWOPT_ENABLE_CRBDB);
 =

-	init_fw_cb->fw_options &=3D __constant_cpu_to_le16(~FWOPT_TARGET_MODE=
);
+	init_fw_cb->fw_options &=3D cpu_to_le16(~FWOPT_TARGET_MODE);
 =

 	init_fw_cb->add_fw_options =3D 0;
 	init_fw_cb->add_fw_options |=3D
-			__constant_cpu_to_le16(ADFWOPT_SERIALIZE_TASK_MGMT);
+			cpu_to_le16(ADFWOPT_SERIALIZE_TASK_MGMT);
 	init_fw_cb->add_fw_options |=3D
-			__constant_cpu_to_le16(ADFWOPT_AUTOCONN_DISABLE);
+			cpu_to_le16(ADFWOPT_AUTOCONN_DISABLE);
 =

 	if (qla4xxx_set_ifcb(ha, &mbox_cmd[0], &mbox_sts[0], init_fw_cb_dma)
 		!=3D QLA_SUCCESS) {
@@ -1614,7 +1614,7 @@ int qla4xxx_get_chap(struct scsi_qla_host *ha, ch=
ar *username, char *password,
 =

 	strlcpy(password, chap_table->secret, QL4_CHAP_MAX_SECRET_LEN);
 	strlcpy(username, chap_table->name, QL4_CHAP_MAX_NAME_LEN);
-	chap_table->cookie =3D __constant_cpu_to_le16(CHAP_VALID_COOKIE);
+	chap_table->cookie =3D cpu_to_le16(CHAP_VALID_COOKIE);
 =

 exit_get_chap:
 	dma_pool_free(ha->chap_dma_pool, chap_table, chap_dma);
@@ -1656,7 +1656,7 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, ch=
ar *username, char *password,
 	chap_table->secret_len =3D strlen(password);
 	strncpy(chap_table->secret, password, MAX_CHAP_SECRET_LEN - 1);
 	strncpy(chap_table->name, username, MAX_CHAP_NAME_LEN - 1);
-	chap_table->cookie =3D __constant_cpu_to_le16(CHAP_VALID_COOKIE);
+	chap_table->cookie =3D cpu_to_le16(CHAP_VALID_COOKIE);
 =

 	if (is_qla40XX(ha)) {
 		chap_size =3D MAX_CHAP_ENTRIES_40XX * sizeof(*chap_table);
@@ -1722,7 +1722,7 @@ int qla4xxx_get_uni_chap_at_index(struct scsi_qla=
_host *ha, char *username,
 =

 	mutex_lock(&ha->chap_sem);
 	chap_table =3D (struct ql4_chap_table *)ha->chap_list + chap_index;
-	if (chap_table->cookie !=3D __constant_cpu_to_le16(CHAP_VALID_COOKIE)=
) {
+	if (chap_table->cookie !=3D cpu_to_le16(CHAP_VALID_COOKIE)) {
 		rval =3D QLA_ERROR;
 		goto exit_unlock_uni_chap;
 	}
@@ -1785,7 +1785,7 @@ int qla4xxx_get_chap_index(struct scsi_qla_host *=
ha, char *username,
 	for (i =3D 0; i < max_chap_entries; i++) {
 		chap_table =3D (struct ql4_chap_table *)ha->chap_list + i;
 		if (chap_table->cookie !=3D
-		    __constant_cpu_to_le16(CHAP_VALID_COOKIE)) {
+		    cpu_to_le16(CHAP_VALID_COOKIE)) {
 			if (i > MAX_RESRV_CHAP_IDX && free_index =3D=3D -1)
 				free_index =3D i;
 			continue;
@@ -2106,18 +2106,18 @@ int qla4xxx_set_param_ddbentry(struct scsi_qla_=
host *ha,
 =

 	if (conn->max_recv_dlength)
 		fw_ddb_entry->iscsi_max_rcv_data_seg_len =3D
-		  __constant_cpu_to_le16((conn->max_recv_dlength / BYTE_UNITS));
+		  cpu_to_le16((conn->max_recv_dlength / BYTE_UNITS));
 =

 	if (sess->max_r2t)
 		fw_ddb_entry->iscsi_max_outsnd_r2t =3D cpu_to_le16(sess->max_r2t);
 =

 	if (sess->first_burst)
 		fw_ddb_entry->iscsi_first_burst_len =3D
-		       __constant_cpu_to_le16((sess->first_burst / BYTE_UNITS));
+		       cpu_to_le16((sess->first_burst / BYTE_UNITS));
 =

 	if (sess->max_burst)
 		fw_ddb_entry->iscsi_max_burst_len =3D
-			__constant_cpu_to_le16((sess->max_burst / BYTE_UNITS));
+			cpu_to_le16((sess->max_burst / BYTE_UNITS));
 =

 	if (sess->time2wait)
 		fw_ddb_entry->iscsi_def_time2wait =3D
diff --git a/drivers/scsi/qla4xxx/ql4_nx.c b/drivers/scsi/qla4xxx/ql4_n=
x.c
index 038e19b1e3c2..484f5093ff71 100644
--- a/drivers/scsi/qla4xxx/ql4_nx.c
+++ b/drivers/scsi/qla4xxx/ql4_nx.c
@@ -3678,7 +3678,7 @@ qla4_82xx_read_flash_data(struct scsi_qla_host *h=
a, uint32_t *dwptr,
 			    "Do ROM fast read failed\n");
 			goto done_read;
 		}
-		dwptr[i] =3D __constant_cpu_to_le32(val);
+		dwptr[i] =3D cpu_to_le32(val);
 	}
 =

 done_read:
@@ -3741,9 +3741,9 @@ qla4_8xxx_get_flt_info(struct scsi_qla_host *ha, =
uint32_t flt_addr)
 			goto no_flash_data;
 	}
 =

-	if (*wptr =3D=3D __constant_cpu_to_le16(0xffff))
+	if (*wptr =3D=3D cpu_to_le16(0xffff))
 		goto no_flash_data;
-	if (flt->version !=3D __constant_cpu_to_le16(1)) {
+	if (flt->version !=3D cpu_to_le16(1)) {
 		DEBUG2(ql4_printk(KERN_INFO, ha, "Unsupported FLT detected: "
 			"version=3D0x%x length=3D0x%x checksum=3D0x%x.\n",
 			le16_to_cpu(flt->version), le16_to_cpu(flt->length),
@@ -3846,7 +3846,7 @@ qla4_82xx_get_fdt_info(struct scsi_qla_host *ha)
 	qla4_82xx_read_optrom_data(ha, (uint8_t *)ha->request_ring,
 	    hw->flt_region_fdt << 2, OPTROM_BURST_SIZE);
 =

-	if (*wptr =3D=3D __constant_cpu_to_le16(0xffff))
+	if (*wptr =3D=3D cpu_to_le16(0xffff))
 		goto no_flash_data;
 =

 	if (fdt->sig[0] !=3D 'Q' || fdt->sig[1] !=3D 'L' || fdt->sig[2] !=3D =
'I' ||
@@ -3903,7 +3903,7 @@ qla4_82xx_get_idc_param(struct scsi_qla_host *ha)=

 	qla4_82xx_read_optrom_data(ha, (uint8_t *)ha->request_ring,
 			QLA82XX_IDC_PARAM_ADDR , 8);
 =

-	if (*wptr =3D=3D __constant_cpu_to_le32(0xffffffff)) {
+	if (*wptr =3D=3D cpu_to_le32(0xffffffff)) {
 		ha->nx_dev_init_timeout =3D ROM_DEV_INIT_TIMEOUT;
 		ha->nx_reset_timeout =3D ROM_DRV_RESET_ACK_TIMEOUT;
 	} else {
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_o=
s.c
index bab87e47b238..0dd472131db0 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -704,7 +704,7 @@ static int qla4xxx_get_chap_by_index(struct scsi_ql=
a_host *ha,
 =

 	*chap_entry =3D (struct ql4_chap_table *)ha->chap_list + chap_index;
 	if ((*chap_entry)->cookie !=3D
-	     __constant_cpu_to_le16(CHAP_VALID_COOKIE)) {
+	     cpu_to_le16(CHAP_VALID_COOKIE)) {
 		rval =3D QLA_ERROR;
 		*chap_entry =3D NULL;
 	} else {
@@ -748,7 +748,7 @@ static int qla4xxx_find_free_chap_index(struct scsi=
_qla_host *ha,
 		chap_table =3D (struct ql4_chap_table *)ha->chap_list + i;
 =

 		if ((chap_table->cookie !=3D
-		    __constant_cpu_to_le16(CHAP_VALID_COOKIE)) &&
+		    cpu_to_le16(CHAP_VALID_COOKIE)) &&
 		   (i > MAX_RESRV_CHAP_IDX)) {
 				free_index =3D i;
 				break;
@@ -797,7 +797,7 @@ static int qla4xxx_get_chap_list(struct Scsi_Host *=
shost, uint16_t chap_tbl_idx,
 	for (i =3D chap_tbl_idx; i < max_chap_entries; i++) {
 		chap_table =3D (struct ql4_chap_table *)ha->chap_list + i;
 		if (chap_table->cookie !=3D
-		    __constant_cpu_to_le16(CHAP_VALID_COOKIE))
+		    cpu_to_le16(CHAP_VALID_COOKIE))
 			continue;
 =

 		chap_rec->chap_tbl_idx =3D i;
@@ -928,7 +928,7 @@ static int qla4xxx_delete_chap(struct Scsi_Host *sh=
ost, uint16_t chap_tbl_idx)
 		goto exit_delete_chap;
 	}
 =

-	chap_table->cookie =3D __constant_cpu_to_le16(0xFFFF);
+	chap_table->cookie =3D cpu_to_le16(0xFFFF);
 =

 	offset =3D FLASH_CHAP_OFFSET |
 			(chap_tbl_idx * sizeof(struct ql4_chap_table));
@@ -6050,7 +6050,7 @@ static int qla4xxx_get_bidi_chap(struct scsi_qla_=
host *ha, char *username,
 	for (i =3D 0; i < max_chap_entries; i++) {
 		chap_table =3D (struct ql4_chap_table *)ha->chap_list + i;
 		if (chap_table->cookie !=3D
-		    __constant_cpu_to_le16(CHAP_VALID_COOKIE)) {
+		    cpu_to_le16(CHAP_VALID_COOKIE)) {
 			continue;
 		}
 =

diff --git a/fs/cifs/smb2status.h b/fs/cifs/smb2status.h
index 7505056e9580..3d5ef02f1416 100644
--- a/fs/cifs/smb2status.h
+++ b/fs/cifs/smb2status.h
@@ -29,7 +29,7 @@
  *  C is set if "customer defined" error, N bit is reserved and MBZ
  */
 =

-#define STATUS_SEVERITY_SUCCESS __constant_cpu_to_le32(0x0000)
+#define STATUS_SEVERITY_SUCCESS cpu_to_le32(0x0000)
 #define STATUS_SEVERITY_INFORMATIONAL cpu_to_le32(0x0001)
 #define STATUS_SEVERITY_WARNING cpu_to_le32(0x0002)
 #define STATUS_SEVERITY_ERROR cpu_to_le32(0x0003)

-- =

  Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
  https://exactcode.com | https://t2sde.org | https://rene.rebe.de
