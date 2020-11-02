Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8532A2A2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgKBL5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgKBL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:40 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90545C061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:39 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id i16so8845529wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4OaFqQapHo8kjxQ8b1JCEqEmva3JkMUSlJKMXA1e00=;
        b=sjkPiIvlmOT+02faCh4tZFhQs7U7EJ3Md3BfHT7eZELVePegkyysgskFsEcwoLagaF
         1IibS8XaclLqF7L+p+xAFc5O0kdwfMAeVawVbEvFk3QYSuVYJU9jWPlxcbgJeoCUP1aR
         gg04rZtIyrKo2OBU+BSZyrKQvwRFrKwql79nx043/7al12RjAm/rQcZ0lZI6uvqOLdQr
         hOCdqaec7id3eat7vqNCtHjm+gI7G19OO3/dFk2n76mrW081CZzRX5JzhsUhS4/AFugg
         IwMdYG/j4VSkGdRZcEBVIbP9qt6AR8/KC/9AgBILBcU24PzMAX/NJZQkxVXPoNJCzoW0
         oOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4OaFqQapHo8kjxQ8b1JCEqEmva3JkMUSlJKMXA1e00=;
        b=YzST3AggsTicHLQ4vaffqsceiGPUaeLh7Gl+NgHSQ2Rhumnh6ZyeQ4+ufb4Ubmz2Sd
         4Nm05zKNyDhMznu55noUACUdUvnNDmmU1OvFI8vWswx0vxRR3aJFJWhiDnNmYw5y08pU
         lYnaXuDYkY4Ix98fbbkKKwhzzPX1iQwuXSTnMTLsOveiqXZuNgU7syLDydjMkiBFjKHm
         KGrQQXrj+BnauQyMBZ1ObQki//NoQOwNKvcoaTOWiZIfxCcqXCxVye4jnNeYkUWtq8iv
         z0efLYal82JT4xDdp4700xPoVXRRTGTvdyjK9pXqEJqc1QA/rfPBp7kCPYWRlubK1G1B
         avKg==
X-Gm-Message-State: AOAM530ZJCChYmGwFPdgh/hiRWC1sjVaWDscrtN7dmkhOYrMFGwJ+UiT
        VEmQa+dUN3XpdtN0zbNa9gpzVg==
X-Google-Smtp-Source: ABdhPJxGiNQX9dARW2Ppxk5GGBx9DwBXfNRCq6GR8Hl8NQzpzru2q39M8W/bdA5i3A2lYGjzPSEgXA==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr19578005wru.110.1604318258282;
        Mon, 02 Nov 2020 03:57:38 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 05/19] scsi: lpfc: lpfc_attr: Fix-up a bunch of kernel-doc misdemeanours
Date:   Mon,  2 Nov 2020 11:57:14 +0000
Message-Id: <20201102115728.1077697-6-lee.jones@linaro.org>
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

 from drivers/scsi/lpfc/lpfc_attr.c:26:
 inlined from ‘lpfc_stat_data_ctrl_store’ at drivers/scsi/lpfc/lpfc_attr.c:4165:3:
 drivers/scsi/lpfc/lpfc_attr.c:2537: warning: Function parameter or member 'attr' not described in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2537: warning: Function parameter or member 'default' not described in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2537: warning: Function parameter or member 'minval' not described in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2537: warning: Function parameter or member 'maxval' not described in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2537: warning: Excess function parameter 'phba' description in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2537: warning: Excess function parameter 'val' description in 'lpfc_vport_param_init'
 drivers/scsi/lpfc/lpfc_attr.c:2792: warning: Function parameter or member 'dev' not described in 'lpfc_soft_wwpn_store'
 drivers/scsi/lpfc/lpfc_attr.c:2886: warning: Function parameter or member 'dev' not described in 'lpfc_soft_wwnn_store'
 drivers/scsi/lpfc/lpfc_attr.c:2886: warning: Function parameter or member 'attr' not described in 'lpfc_soft_wwnn_store'
 drivers/scsi/lpfc/lpfc_attr.c:2886: warning: Excess function parameter 'cdev' description in 'lpfc_soft_wwnn_store'
 drivers/scsi/lpfc/lpfc_attr.c:3224: warning: Function parameter or member 'vpt_wwpn' not described in 'lpfc_oas_lun_state_set'
 drivers/scsi/lpfc/lpfc_attr.c:3224: warning: Function parameter or member 'tgt_wwpn' not described in 'lpfc_oas_lun_state_set'
 drivers/scsi/lpfc/lpfc_attr.c:3224: warning: Function parameter or member 'pri' not described in 'lpfc_oas_lun_state_set'
 drivers/scsi/lpfc/lpfc_attr.c:3224: warning: Excess function parameter 'ndlp' description in 'lpfc_oas_lun_state_set'
 drivers/scsi/lpfc/lpfc_attr.c:3264: warning: Function parameter or member 'lun_pri' not described in 'lpfc_oas_lun_get_next'
 drivers/scsi/lpfc/lpfc_attr.c:3302: warning: Function parameter or member 'pri' not described in 'lpfc_oas_lun_state_change'
 drivers/scsi/lpfc/lpfc_attr.c:3376: warning: Function parameter or member 'count' not described in 'lpfc_oas_lun_store'
 drivers/scsi/lpfc/lpfc_attr.c:3835: warning: Function parameter or member 'vport' not described in 'lpfc_tgt_queue_depth_set'
 drivers/scsi/lpfc/lpfc_attr.c:3835: warning: Excess function parameter 'phba' description in 'lpfc_tgt_queue_depth_set'
 drivers/scsi/lpfc/lpfc_attr.c:4026: warning: Function parameter or member 'dev' not described in 'lpfc_topology_store'
 drivers/scsi/lpfc/lpfc_attr.c:4026: warning: Function parameter or member 'attr' not described in 'lpfc_topology_store'
 drivers/scsi/lpfc/lpfc_attr.c:4026: warning: Function parameter or member 'buf' not described in 'lpfc_topology_store'
 drivers/scsi/lpfc/lpfc_attr.c:4026: warning: Function parameter or member 'count' not described in 'lpfc_topology_store'
 drivers/scsi/lpfc/lpfc_attr.c:4026: warning: Excess function parameter 'phba' description in 'lpfc_topology_store'
 drivers/scsi/lpfc/lpfc_attr.c:4026: warning: Excess function parameter 'val' description in 'lpfc_topology_store'
 drivers/scsi/lpfc/lpfc_attr.c:4148: warning: Function parameter or member 'attr' not described in 'lpfc_stat_data_ctrl_store'
 drivers/scsi/lpfc/lpfc_attr.c:4302: warning: Function parameter or member 'attr' not described in 'lpfc_stat_data_ctrl_show'
 drivers/scsi/lpfc/lpfc_attr.c:4383: warning: Function parameter or member 'buf' not described in 'sysfs_drvr_stat_data_read'
 drivers/scsi/lpfc/lpfc_attr.c:4383: warning: Excess function parameter 'buff' description in 'sysfs_drvr_stat_data_read'
 drivers/scsi/lpfc/lpfc_attr.c:4476: warning: Function parameter or member 'dev' not described in 'lpfc_link_speed_store'
 drivers/scsi/lpfc/lpfc_attr.c:4476: warning: Function parameter or member 'attr' not described in 'lpfc_link_speed_store'
 drivers/scsi/lpfc/lpfc_attr.c:4476: warning: Function parameter or member 'buf' not described in 'lpfc_link_speed_store'
 drivers/scsi/lpfc/lpfc_attr.c:4476: warning: Function parameter or member 'count' not described in 'lpfc_link_speed_store'
 drivers/scsi/lpfc/lpfc_attr.c:4476: warning: Excess function parameter 'phba' description in 'lpfc_link_speed_store'
 drivers/scsi/lpfc/lpfc_attr.c:4476: warning: Excess function parameter 'val' description in 'lpfc_link_speed_store'
 drivers/scsi/lpfc/lpfc_attr.c:7117: warning: Function parameter or member 'verbose' not described in 'lpfc_hba_log_verbose_init'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_attr.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 6a33f0607cc8b..ada231d4f0c6a 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -2771,7 +2771,7 @@ lpfc_soft_wwpn_show(struct device *dev, struct device_attribute *attr,
 
 /**
  * lpfc_soft_wwpn_store - Set the ww port name of the adapter
- * @dev class device that is converted into a Scsi_host.
+ * @dev: class device that is converted into a Scsi_host.
  * @attr: device attribute, not used.
  * @buf: contains the wwpn in hexadecimal.
  * @count: number of wwpn bytes in buf
@@ -2868,7 +2868,8 @@ lpfc_soft_wwnn_show(struct device *dev, struct device_attribute *attr,
 
 /**
  * lpfc_soft_wwnn_store - sets the ww node name of the adapter
- * @cdev: class device that is converted into a Scsi_host.
+ * @dev: class device that is converted into a Scsi_host.
+ * @attr: device attribute, not used.
  * @buf: contains the ww node name in hexadecimal.
  * @count: number of wwnn bytes in buf.
  *
@@ -3204,9 +3205,11 @@ static DEVICE_ATTR(lpfc_xlane_lun_status, S_IRUGO,
  * lpfc_oas_lun_state_set - enable or disable a lun for Optimized Access Storage
  *			   (OAS) operations.
  * @phba: lpfc_hba pointer.
- * @ndlp: pointer to fcp target node.
+ * @vpt_wwpn: wwpn of the vport associated with the returned lun
+ * @tgt_wwpn: wwpn of the target associated with the returned lun
  * @lun: the fc lun for setting oas state.
  * @oas_state: the oas state to be set to the lun.
+ * @pri: priority
  *
  * Returns:
  * SUCCESS : 0
@@ -3244,6 +3247,7 @@ lpfc_oas_lun_state_set(struct lpfc_hba *phba, uint8_t vpt_wwpn[],
  * @vpt_wwpn: wwpn of the vport associated with the returned lun
  * @tgt_wwpn: wwpn of the target associated with the returned lun
  * @lun_status: status of the lun returned lun
+ * @lun_pri: priority of the lun returned lun
  *
  * Returns the first or next lun enabled for OAS operations for the vport/target
  * specified.  If a lun is found, its vport wwpn, target wwpn and status is
@@ -3282,6 +3286,7 @@ lpfc_oas_lun_get_next(struct lpfc_hba *phba, uint8_t vpt_wwpn[],
  * @tgt_wwpn: target wwpn by reference.
  * @lun: the fc lun for setting oas state.
  * @oas_state: the oas state to be set to the oas_lun.
+ * @pri: priority
  *
  * This routine enables (OAS_LUN_ENABLE) or disables (OAS_LUN_DISABLE)
  * a lun for OAS operations.
@@ -3356,6 +3361,7 @@ lpfc_oas_lun_show(struct device *dev, struct device_attribute *attr,
  * @dev: class device that is converted into a Scsi_host.
  * @attr: device attribute, not used.
  * @buf: buffer for passing information.
+ * @count: size of the formatting string
  *
  * This function sets the OAS state for lun.  Before this function is called,
  * the vport wwpn, target wwpn, and oas state need to be set.
@@ -3817,7 +3823,7 @@ lpfc_vport_param_init(tgt_queue_depth, LPFC_MAX_TGT_QDEPTH,
 
 /**
  * lpfc_tgt_queue_depth_store: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @vport: lpfc vport structure pointer.
  * @val: integer attribute value.
  *
  * Description: Sets the parameter to the new value.
@@ -4002,8 +4008,10 @@ LPFC_ATTR(topology, 0, 0, 6,
 
 /**
  * lpfc_topology_set - Set the adapters topology field
- * @phba: lpfc_hba pointer.
- * @val: topology value.
+ * @dev: class device that is converted into a scsi_host.
+ * @attr:device attribute, not used.
+ * @buf: buffer for passing information.
+ * @count: size of the data buffer.
  *
  * Description:
  * If val is in a valid range then set the adapter's topology field and
@@ -4122,6 +4130,7 @@ static DEVICE_ATTR_RO(lpfc_static_vport);
 /**
  * lpfc_stat_data_ctrl_store - write call back for lpfc_stat_data_ctrl sysfs file
  * @dev: Pointer to class device.
+ * @attr: Unused.
  * @buf: Data buffer.
  * @count: Size of the data buffer.
  *
@@ -4285,7 +4294,8 @@ lpfc_stat_data_ctrl_store(struct device *dev, struct device_attribute *attr,
 
 /**
  * lpfc_stat_data_ctrl_show - Read function for lpfc_stat_data_ctrl sysfs file
- * @dev: Pointer to class device object.
+ * @dev: Pointer to class device.
+ * @attr: Unused.
  * @buf: Data buffer.
  *
  * This function is the read call back function for
@@ -4364,7 +4374,7 @@ static DEVICE_ATTR_RW(lpfc_stat_data_ctrl);
  * @filp: sysfs file
  * @kobj: Pointer to the kernel object
  * @bin_attr: Attribute object
- * @buff: Buffer pointer
+ * @buf: Buffer pointer
  * @off: File offset
  * @count: Buffer size
  *
@@ -4451,8 +4461,10 @@ static struct bin_attribute sysfs_drvr_stat_data_attr = {
 */
 /**
  * lpfc_link_speed_set - Set the adapters link speed
- * @phba: lpfc_hba pointer.
- * @val: link speed value.
+ * @dev: Pointer to class device.
+ * @attr: Unused.
+ * @buf: Data buffer.
+ * @count: Size of the data buffer.
  *
  * Description:
  * If val is in a valid range then set the adapter's link speed field and
@@ -7111,6 +7123,7 @@ lpfc_set_vport_symbolic_name(struct fc_vport *fc_vport)
 /**
  * lpfc_hba_log_verbose_init - Set hba's log verbose level
  * @phba: Pointer to lpfc_hba struct.
+ * @verbose: Verbose level to set.
  *
  * This function is called by the lpfc_get_cfgparam() routine to set the
  * module lpfc_log_verbose into the @phba cfg_log_verbose for use with
-- 
2.25.1

