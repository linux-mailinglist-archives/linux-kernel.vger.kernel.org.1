Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F612A2A36
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgKBL6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgKBL5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:52 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8D1C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:51 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x7so14281224wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGRjtEO3+/S0NupDYXoJNbgD6kgyMEDCzJJaiz4KGno=;
        b=TMUgvw4edfmH9wdIQ1NPOj8XCbwovAHUVy8xRh+mwkFp17j/N0+HJ++xV5RLM9jsoF
         5Wg8VgcrhGEuEm8js2dw0LVdodGLh0ohTnZNfA1Pm5TdPAgfPrqlDLKleCHuhQ0OeOBZ
         ShGrnFXWMGTyfUvupdC7JopEfFoE02UiZATuQWBYTywrmKkthFpE9RCm6a98k4VRmlox
         uVnUx39Mvi9w0F0CUTyG1C3e5g+d5HlRtSIRKboNWqDlnmTTP/WZuQT1Ja0G9fwTgNLO
         X5crFU3XcskKzALR+SdlVS5zST/xjVtBxm2347ni43ELSvj1+6imPcjfx0AbV7ixjHXz
         buIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGRjtEO3+/S0NupDYXoJNbgD6kgyMEDCzJJaiz4KGno=;
        b=meTN3QlwrMXB1uCF48Bgjt68iAK2RqCTGrbFJERc2JgAc2At2CxOOhV0nmX9b3WUM3
         kZ0YQL7gX2fEKcrbSkYI0OUr/D+5quhWcqKNy5NxQIS63hAlajXvtr4BQIZfsqDXoAKl
         obLEDAbs5PncnrZ2DeQ1gEyXViOtqY17zG/1LlHiAQqHU6muQTp3ikPX8sRxrGk0RfPN
         tY0ejZ1R/mKwhBQ1af66NM66brdVbGGxLt8KZO3zAcxzWcPTcFTodMou2zO1DPO2VULF
         O1acomOPsnEPVW9KSQsycfMyIr7PEPyRm0WYyH1jrhGZ8suQMmIf4MUlG1ELnYEpOOLE
         +h3Q==
X-Gm-Message-State: AOAM531MInZiuf5N18/y4MzjNxVSKS5ohYRwGl76x3/DzoQ0jDCxY/XF
        a8UYrJsDp1G/mTQ9l8AEafWHeA==
X-Google-Smtp-Source: ABdhPJzoTYl3v0yxl4hNWQGHd9tPzr25MazEI22ion266JU09d4OAzR0Pp3OMmSWQXEDNAiwdJjAzQ==
X-Received: by 2002:adf:df91:: with SMTP id z17mr19170173wrl.379.1604318270615;
        Mon, 02 Nov 2020 03:57:50 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 16/19] scsi: advansys: Relocate or remove unused variables
Date:   Mon,  2 Nov 2020 11:57:25 +0000
Message-Id: <20201102115728.1077697-17-lee.jones@linaro.org>
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

 drivers/scsi/advansys.c: In function ‘asc_prt_asc_board_eeprom’:
 drivers/scsi/advansys.c:2879:15: warning: variable ‘asc_dvc_varp’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/advansys.c: In function ‘asc_prt_driver_conf’:
 drivers/scsi/advansys.c:3174:6: warning: variable ‘chip_scsi_id’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/advansys.c: In function ‘AdvISR’:
 drivers/scsi/advansys.c:6114:9: warning: variable ‘target_bit’ set but not used [-Wunused-but-set-variable]

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/advansys.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index c2c7850ff7b42..79830e77afa97 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -2876,15 +2876,15 @@ static int asc_get_eeprom_string(ushort *serialnum, uchar *cp)
 static void asc_prt_asc_board_eeprom(struct seq_file *m, struct Scsi_Host *shost)
 {
 	struct asc_board *boardp = shost_priv(shost);
-	ASC_DVC_VAR *asc_dvc_varp;
 	ASCEEP_CONFIG *ep;
 	int i;
+	uchar serialstr[13];
 #ifdef CONFIG_ISA
+	ASC_DVC_VAR *asc_dvc_varp;
 	int isa_dma_speed[] = { 10, 8, 7, 6, 5, 4, 3, 2 };
-#endif /* CONFIG_ISA */
-	uchar serialstr[13];
 
 	asc_dvc_varp = &boardp->dvc_var.asc_dvc_var;
+#endif /* CONFIG_ISA */
 	ep = &boardp->eep_config.asc_eep;
 
 	seq_printf(m,
@@ -3171,7 +3171,6 @@ static void asc_prt_adv_board_eeprom(struct seq_file *m, struct Scsi_Host *shost
 static void asc_prt_driver_conf(struct seq_file *m, struct Scsi_Host *shost)
 {
 	struct asc_board *boardp = shost_priv(shost);
-	int chip_scsi_id;
 
 	seq_printf(m,
 		"\nLinux Driver Configuration and Information for AdvanSys SCSI Host %d:\n",
@@ -3197,12 +3196,6 @@ static void asc_prt_driver_conf(struct seq_file *m, struct Scsi_Host *shost)
 		   boardp->asc_n_io_port);
 
 	seq_printf(m, " io_port 0x%lx\n", shost->io_port);
-
-	if (ASC_NARROW_BOARD(boardp)) {
-		chip_scsi_id = boardp->dvc_cfg.asc_dvc_cfg.chip_scsi_id;
-	} else {
-		chip_scsi_id = boardp->dvc_var.adv_dvc_var.chip_scsi_id;
-	}
 }
 
 /*
@@ -6111,7 +6104,6 @@ static int AdvISR(ADV_DVC_VAR *asc_dvc)
 {
 	AdvPortAddr iop_base;
 	uchar int_stat;
-	ushort target_bit;
 	ADV_CARR_T *free_carrp;
 	__le32 irq_next_vpa;
 	ADV_SCSI_REQ_Q *scsiq;
@@ -6198,8 +6190,6 @@ static int AdvISR(ADV_DVC_VAR *asc_dvc)
 		asc_dvc->carr_freelist = free_carrp;
 		asc_dvc->carr_pending_cnt--;
 
-		target_bit = ADV_TID_TO_TIDMASK(scsiq->target_id);
-
 		/*
 		 * Clear request microcode control flag.
 		 */
-- 
2.25.1

