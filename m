Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F3285994
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgJGHbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgJGHbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:31:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DFDC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:31:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a200so829742pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=6hV7PJClGfgaN5TCcjKdtC8dZqi0TjTnFZSL7SHtRuk=;
        b=xys4W4ypmtRSJhPuvzq7s7axuVnaIiwpBUAUfnpo3KP7OiUS7EPpweAu0+QNIy7gz/
         m92F1Mns/2D+LivzbQ2pD7lHWvB/JlX+EF0I2p45tDKi+friRCqi0MIjWrVC+808yT3t
         kHPVF5iCy9mdBMqHcbawN7bJVWaE7KaMxDxEiVMUXRxh1UVwYS+jInOLOPm5bOt19K02
         nY5JJxDFJGHStYdVzRLX9mlwU/NY+QwLjVMxzdObGqnz2RgKHtBlffpiTHquToIFrAov
         dedhuUoSNf6n6/Bip5VawgAr8tjh9ORsGVM3Ka3ZPHXZlYcnDOHcfI7ejuh9IaAq+3tA
         pvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=6hV7PJClGfgaN5TCcjKdtC8dZqi0TjTnFZSL7SHtRuk=;
        b=JVVPw6uJmp3tWHA8xIfAX2wzNNFCG+36f9ARpL/il/oPsKdJIFexlvGy/rVxmmfFge
         YxTH4zD3m0zmBTZx8zvxERwvXvVHIHgMkAPbYAdPU95+1u2pU4a7kddDYtoWX6ntV6BO
         alndc0fPqwsb1PVEp16S1BXq2/qJ2f1zSclg14MfTF42kRditjM+afmjE+VB5wIuaUwj
         y9UGKw2ijEAm1LWdWPjek3tQGFvccymP1OH3ntZt8Zyxyh5En9mo8ikEuNoIvG+yxRpS
         ZH99L7Dbv9f/GYY8ch+R171ax1YdhtUIixQCGdK7IBBKmYD718cWMYLeTT3M643K+ClM
         gXPQ==
X-Gm-Message-State: AOAM532xZGCeyurPjQ4dO5/0JPomSuNzS/rUq0uf+bZdS5l+Qgvq1LrA
        f7KCwziAAAOwRrAzezDOwnzCqg==
X-Google-Smtp-Source: ABdhPJzkvpBvMcshEG/PBntDPZnKQ0S/7L3SIzNxi8KvQ81B4ZFVi+qGVidyehgCG3ndaMOz6HyKpQ==
X-Received: by 2002:a63:5663:: with SMTP id g35mr1917905pgm.163.1602055905370;
        Wed, 07 Oct 2020 00:31:45 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id o17sm1224263pji.30.2020.10.07.00.31.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 00:31:44 -0700 (PDT)
Message-ID: <fd826c8ec91cfc49a17eb107a2e81087dfcde3cb.camel@areca.com.tw>
Subject: [PATCH v3 2/2] scsi: arcmsr: use round_up() instead of logical
 operation
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 07 Oct 2020 15:31:44 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

Use round_up() instead of logical operation.

Reported-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 55d85c9..1e358d9 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -644,13 +644,12 @@ static void arcmsr_hbaF_assign_regAddr(struct AdapterControlBlock *acb)
 	struct MessageUnit_F __iomem *pmuF;
 
 	memset(acb->dma_coherent2, 0xff, acb->completeQ_size);
-	acb->message_wbuffer = (uint32_t *)((((unsigned long)acb->dma_coherent2 +
-		acb->completeQ_size + 3) >> 2) << 2);
+	acb->message_wbuffer = (uint32_t *)round_up((unsigned long)acb->dma_coherent2 +
+		acb->completeQ_size, 4);
 	acb->message_rbuffer = ((void *)acb->message_wbuffer) + 0x100;
 	acb->msgcode_rwbuffer = ((void *)acb->message_wbuffer) + 0x200;
 	memset((void *)acb->message_wbuffer, 0, MESG_RW_BUFFER_SIZE);
-	host_buffer_dma = ((acb->dma_coherent_handle2 + acb->completeQ_size +
-		3) >> 2) << 2;
+	host_buffer_dma = round_up(acb->dma_coherent_handle2 + acb->completeQ_size, 4);
 	pmuF = acb->pmuF;
 	/* host buffer low address, bit0:1 all buffer active */
 	writel(lower_32_bits(host_buffer_dma | 1), &pmuF->inbound_msgaddr0);

