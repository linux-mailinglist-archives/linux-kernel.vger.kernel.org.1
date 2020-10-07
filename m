Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794DB2857DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 06:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgJGEmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 00:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgJGEmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 00:42:07 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00057C0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 21:42:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s19so380000plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 21:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=6hV7PJClGfgaN5TCcjKdtC8dZqi0TjTnFZSL7SHtRuk=;
        b=r9QQJRGq2UX+dSVZL/fR3XmybvGJIgZzq0FLrJJ43YYy9IyqxVh7NDKehe8vsJshLL
         bVlWcgA9MWs7Ep9oflUaDlzuzyar89lgCjHOH7gICwNEOSfwM2urzubwnhNbTeUa2FJf
         m7h1/DkQ9rbdZ9vnaSop6DoIl/W/IyBWjsq99cyX8wTeTCioqhMERSAD6y6XLLM5GXcM
         PvIh+KZUo2ZDb2N2gj71YiTPfWOmCLjDWwo5fBOK0kJN2N2pWoyH56WVN8uWw+7fYNBq
         NVjz8V55KeB1D4SLLBcxmOD8loAvzHtLQbx3prf9GDJgGtPwpkGhCApoyi4nneCklcJS
         jWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=6hV7PJClGfgaN5TCcjKdtC8dZqi0TjTnFZSL7SHtRuk=;
        b=rmz/ez6K5smS2eWVvj/p0Vlb/Mibefg26+pGPVDvaaGYjuSW82lGiUM5U/1bjS23S7
         Q0Z9U7vIEfDUmX5ObjGxThWVt2RoJWRO9SKVOA4zW3ZMDczks4Tb6EV0WVpu4lZZp+La
         0/Ldy2vGe3JDL/OC5K+WxsAdM8YFjQtF7QMc3DDrGwiNegIh6VZu3lCGAt3+1o2Ob45L
         UclLuv7Uet31COemmkHPAM7ETJvkE9GK93jt3Jm89JuQIf9aEZwQHqJxS2SM81GknVHn
         w/ID9N1ZerqVYOErXab37XHAAqRVB3vlVMSaBSh+HekSkOZ/DtBpa3O9ZmZkHuARdhHT
         TeNw==
X-Gm-Message-State: AOAM532zzE7A4SrCLfeGkjYB5Vo+AhO2gmeDDV8ttORSzl5mHgbUh/rK
        i58RUkRhpxgsbE58sTLPissqYQ==
X-Google-Smtp-Source: ABdhPJwaS+EmWu2efvslIkfhHgsUztVkk5DjTz6MyWALnWp0y67KQavW2S159oKbzBZHFo8LLal8QQ==
X-Received: by 2002:a17:902:ee01:b029:d1:8c50:aa89 with SMTP id z1-20020a170902ee01b02900d18c50aa89mr1354147plb.6.1602045726343;
        Tue, 06 Oct 2020 21:42:06 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id gd14sm647305pjb.31.2020.10.06.21.42.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 21:42:05 -0700 (PDT)
Message-ID: <9b02f544d1c5d4a90da268ba063f1ffe4ac098ca.camel@areca.com.tw>
Subject: [PATCH v2 2/2] scsi: arcmsr: use round_up() instead of logical
 operation
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 07 Oct 2020 12:42:05 +0800
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

