Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DBF2857D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 06:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgJGEgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 00:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgJGEgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 00:36:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E25C0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 21:36:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id x5so418000pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 21:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=nozvEbVQdKm0fWbmXW8P7leHQ60pH5dp+Q3W9Dcy5V4=;
        b=n1WW5YcrI53xIITQW3rS0ytcseBT+T/RQHMz3Zqp57IfDZrghK4GL5kgXuXXsYB0LA
         zSdCBzRFTOQsz43WW+6+V7Hc1AJf0PN8PWnN43z8hyL0BmVX5BCY74vQiIzg2uhaHI+R
         hQs92hJpSCDmeJ5brsdGX26zRB1Dfnwfq5bHgpWGJrnl4++alCtBe3C/JRIYjAIqVYtu
         4JOF9bQMwP1px9XxHgG7U7GObWf6C02N9k+3uA5aEgBDuH0qiZbJLijGL6OIQj3sFSHi
         BlS4UlCi0G6HMxvPI33SJnrxMjZfCBYVmTKRdyw+Q4/3PD+O/ez+KzFceGdqAyuDN0h8
         1JXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=nozvEbVQdKm0fWbmXW8P7leHQ60pH5dp+Q3W9Dcy5V4=;
        b=eZ6maCNz+FYGaYZ8BAuEQYHeBk+r0dW/G0DhmEqE5tjHDvgkl/lNCw0SgeycZV10b3
         4JrXHb4HTqhUrexSN/mX4tBc8aw94W0Ma8dELKOF3vyj5DWQGk0sMEAAMxg4bcX98f+l
         4lyCJlTob2M7hYvk3m1fGjc/mQ2qgL9jQPb98sDCfmDXHuTASqTcwpUWHULgc8jNWjhu
         Kw1INuHK8GsimMDmNCspkyTLho5o25proI1LsyMvmpkD9+I3ImSuIFsn2mNEHXMWGldi
         mOku1cvdnpM8QZsFKbeHsBPGbyoIry4sRxCbwMWnEPCq2rT2lEkcpUQW0EjuzdAl17DV
         mJLw==
X-Gm-Message-State: AOAM532EeE4hOwB0gkrhRtk8GVa4h4RY26JWStHBNJmYgi6cEULttop+
        fvEjZWfXB5Eu5aMZMtRBVU3fUA==
X-Google-Smtp-Source: ABdhPJxD9yyAyA87nV4FleOY3/vQD8S5Z/YHoXq5MgZ1A7+P7KjsluKA5L+jUdSNE3BKauTwlUSlDw==
X-Received: by 2002:a17:90b:1a89:: with SMTP id ng9mr825551pjb.24.1602045410632;
        Tue, 06 Oct 2020 21:36:50 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id g9sm901513pgm.79.2020.10.06.21.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 21:36:50 -0700 (PDT)
Message-ID: <df0a9995a15ff6ec03caf3329c81bf09792b892c.camel@areca.com.tw>
Subject: [PATCH v2 1/2] scsi: arcmsr: fix warning: right shift count >=
 width of type
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     kbuild test robot <lkp@intel.com>
Date:   Wed, 07 Oct 2020 12:36:49 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

Fix warning: right shift count >= width of type.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index be6fb72..55d85c9 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -653,9 +653,9 @@ static void arcmsr_hbaF_assign_regAddr(struct AdapterControlBlock *acb)
 		3) >> 2) << 2;
 	pmuF = acb->pmuF;
 	/* host buffer low address, bit0:1 all buffer active */
-	writel((uint32_t)(host_buffer_dma | 1), &pmuF->inbound_msgaddr0);
+	writel(lower_32_bits(host_buffer_dma | 1), &pmuF->inbound_msgaddr0);
 	/* host buffer high address */
-	writel((uint32_t)(host_buffer_dma >> 32), &pmuF->inbound_msgaddr1);
+	writel(upper_32_bits(host_buffer_dma), &pmuF->inbound_msgaddr1);
 	/* set host buffer physical address */
 	writel(ARCMSR_HBFMU_DOORBELL_SYNC1, &pmuF->iobound_doorbell);
 }
@@ -4057,11 +4057,8 @@ static int arcmsr_iop_confirm(struct AdapterControlBlock *acb)
 		writel(cdb_phyaddr, &reg->msgcode_rwbuffer[2]);
 		writel(cdb_phyaddr_hi32, &reg->msgcode_rwbuffer[3]);
 		writel(acb->ccbsize, &reg->msgcode_rwbuffer[4]);
-		dma_coherent_handle = acb->dma_coherent_handle2;
-		cdb_phyaddr = (uint32_t)(dma_coherent_handle & 0xffffffff);
-		cdb_phyaddr_hi32 = (uint32_t)((dma_coherent_handle >> 16) >> 16);
-		writel(cdb_phyaddr, &reg->msgcode_rwbuffer[5]);
-		writel(cdb_phyaddr_hi32, &reg->msgcode_rwbuffer[6]);
+		writel(lower_32_bits(acb->dma_coherent_handle2), &reg->msgcode_rwbuffer[5]);
+		writel(upper_32_bits(acb->dma_coherent_handle2), &reg->msgcode_rwbuffer[6]);
 		writel(acb->ioqueue_size, &reg->msgcode_rwbuffer[7]);
 		writel(ARCMSR_INBOUND_MESG0_SET_CONFIG, &reg->inbound_msgaddr0);
 		acb->out_doorbell ^= ARCMSR_HBEMU_DRV2IOP_MESSAGE_CMD_DONE;
@@ -4081,11 +4078,8 @@ static int arcmsr_iop_confirm(struct AdapterControlBlock *acb)
 		acb->msgcode_rwbuffer[2] = cdb_phyaddr;
 		acb->msgcode_rwbuffer[3] = cdb_phyaddr_hi32;
 		acb->msgcode_rwbuffer[4] = acb->ccbsize;
-		dma_coherent_handle = acb->dma_coherent_handle2;
-		cdb_phyaddr = (uint32_t)dma_coherent_handle;
-		cdb_phyaddr_hi32 = (uint32_t)(dma_coherent_handle >> 32);
-		acb->msgcode_rwbuffer[5] = cdb_phyaddr;
-		acb->msgcode_rwbuffer[6] = cdb_phyaddr_hi32;
+		acb->msgcode_rwbuffer[5] = lower_32_bits(acb->dma_coherent_handle2);
+		acb->msgcode_rwbuffer[6] = upper_32_bits(acb->dma_coherent_handle2);
 		acb->msgcode_rwbuffer[7] = acb->completeQ_size;
 		writel(ARCMSR_INBOUND_MESG0_SET_CONFIG, &reg->inbound_msgaddr0);
 		acb->out_doorbell ^= ARCMSR_HBEMU_DRV2IOP_MESSAGE_CMD_DONE;

