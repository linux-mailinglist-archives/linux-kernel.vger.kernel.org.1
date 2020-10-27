Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A5E29A359
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440724AbgJ0Dbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:31:34 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40942 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408645AbgJ0Dbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:31:33 -0400
Received: by mail-pj1-f66.google.com with SMTP id l2so54098pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=JIqvo1SmTvJJlWmNsKQ6y5LN9w+nEb8ooG3L8JYz5F4=;
        b=O5Fi3nfeR1o0l3o0c450phJtpsg1Eb8tBJQh/85Qgw2PwU6MDVsHoEfUSQGZyOXqEj
         SwAAOvhTEz+/45Z1/ScpQfzJln58xjQFMilrj7gsb/fTukw9F+Pv2+yqIZzd2CQCV0oN
         pHtflJ1ewGl8k7QVxd2MWrIWjq2w3B+1wPT3lOEKeuhDXiSfyqJzUm+BGNAvHvL2hpx2
         9RR9nHboDxNf2rAvhjeqmrjWQlfJG+zYX8b46cLg1yxmZ9cbOhsI9Htvu4xeN5rBLH33
         n6wJQP09iEN9psm9WI16H4yuEcVr2avbl/rKmCFXqpas7XFEVVW64usVu3NCkLXG5S3m
         dqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=JIqvo1SmTvJJlWmNsKQ6y5LN9w+nEb8ooG3L8JYz5F4=;
        b=OOx45fuNyxTW29jGJRSGouszQOVSU26ePxMwqOQJR/rueq2GNlQTZwotXXNfjGKLwI
         GFkpGoAdXRGIqa6UKsZ6fTfMwwlosjo2X5xmvTIQQGAjnMGvKy0patYV+iTICbXUCkg0
         /IOH6nPfiX8p8B+eJM6qXQga+/4gDh3S2SC/Use97PsRnkyQQUicq+gFVG7jDlQpydFw
         4iIwazFrkgUyDelWEenNVxOZlOlNIdG3unYYMDdxH5zd6fYV2P1zfrXBrbNx2/OOfugD
         DwReGOISSYioX6yb6K0bCt+XS640SnAS8uANgSAR6ta/AV/7K7FnYvhnFl5gZY8GXE6I
         Gy9g==
X-Gm-Message-State: AOAM530wuG8rPaD515GuAvjVtKnFhH2bPmQiiu+/0rwa2JVpVn1k/cqw
        M1XfaWHPnPrfS2tj3ZXKUp49zQ==
X-Google-Smtp-Source: ABdhPJzPZRReh45Xo8wC1NlB4rv8JCxecl6FB/aSzayUVunn28J+mgoXnp+1p/1aMuTBjjbHPcbSgw==
X-Received: by 2002:a17:902:c405:b029:d6:5616:9aef with SMTP id k5-20020a170902c405b02900d656169aefmr411385plk.61.1603769492943;
        Mon, 26 Oct 2020 20:31:32 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id y27sm217619pfr.122.2020.10.26.20.31.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 20:31:32 -0700 (PDT)
Message-ID: <27c0cda7fd103f05021adaf67490e9298ed5cc3f.camel@areca.com.tw>
Subject: [PATCH v2 1/2] scsi: arcmsr: configure the default SCSI device
 command timeout value
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Oct 2020 11:31:31 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

Configure the default SCSI device command timeout value.

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 5d054d5..0f6abd2 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -83,6 +83,7 @@ struct device_attribute;
 #define PCI_DEVICE_ID_ARECA_1886	0x188A
 #define	ARCMSR_HOURS			(1000 * 60 * 60 * 4)
 #define	ARCMSR_MINUTES			(1000 * 60 * 60)
+#define ARCMSR_DEFAULT_TIMEOUT		90
 /*
 **********************************************************************************
 **
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index e4fdb47..7cfae1d 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -99,6 +99,10 @@ static int set_date_time = 0;
 module_param(set_date_time, int, S_IRUGO);
 MODULE_PARM_DESC(set_date_time, " send date, time to iop(0 ~ 1), set_date_time=1(enable), default(=0) is disable");
 
+static int cmd_timeout = ARCMSR_DEFAULT_TIMEOUT;
+module_param(cmd_timeout, int, S_IRUGO);
+MODULE_PARM_DESC(cmd_timeout, " scsi cmd timeout(0 ~ 120 sec.), default is 90");
+
 #define	ARCMSR_SLEEPTIME	10
 #define	ARCMSR_RETRYCOUNT	12
 
@@ -140,6 +144,7 @@ static irqreturn_t arcmsr_interrupt(struct AdapterControlBlock *acb);
 static void arcmsr_free_irq(struct pci_dev *, struct AdapterControlBlock *);
 static void arcmsr_wait_firmware_ready(struct AdapterControlBlock *acb);
 static void arcmsr_set_iop_datetime(struct timer_list *);
+static int arcmsr_slave_config(struct scsi_device *sdev);
 static int arcmsr_adjust_disk_queue_depth(struct scsi_device *sdev, int queue_depth)
 {
 	if (queue_depth > ARCMSR_MAX_CMD_PERLUN)
@@ -155,6 +160,7 @@ static struct scsi_host_template arcmsr_scsi_host_template = {
 	.eh_abort_handler	= arcmsr_abort,
 	.eh_bus_reset_handler	= arcmsr_bus_reset,
 	.bios_param		= arcmsr_bios_param,
+	.slave_configure	= arcmsr_slave_config,
 	.change_queue_depth	= arcmsr_adjust_disk_queue_depth,
 	.can_queue		= ARCMSR_DEFAULT_OUTSTANDING_CMD,
 	.this_id		= ARCMSR_SCSI_INITIATOR_ID,
@@ -3256,6 +3262,16 @@ static int arcmsr_queue_command_lck(struct scsi_cmnd *cmd,
 
 static DEF_SCSI_QCMD(arcmsr_queue_command)
 
+static int arcmsr_slave_config(struct scsi_device *sdev)
+{
+	unsigned int	dev_timeout;
+
+	dev_timeout = sdev->request_queue->rq_timeout;
+	if ((cmd_timeout > 0) && ((cmd_timeout * HZ) > dev_timeout))
+		blk_queue_rq_timeout(sdev->request_queue, cmd_timeout * HZ);
+	return 0;
+}
+
 static void arcmsr_get_adapter_config(struct AdapterControlBlock *pACB, uint32_t *rwbuffer)
 {
 	int count;

