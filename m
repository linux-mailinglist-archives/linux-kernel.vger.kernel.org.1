Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5721D19DAD7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 18:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404068AbgDCQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 12:06:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50688 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403868AbgDCQGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:06:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id t128so7710124wma.0;
        Fri, 03 Apr 2020 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V5MB+WtQu9ahIUpMYQeTRqtUIiPA2kDNSM91G2ycfpU=;
        b=ABxkTteAogfNSTy7j/q/j0sEXQPVmkLLtJiuSPrb0xoJhhIAiUpG1/FtKfALP8DRvx
         pDhazkk5ik2t2rD1n/OOYr60bBZBk7sYGN+ntSlRnS131EfxxWKsNGdUXVNlFU8Oec/v
         9SG1F53+VCl8NlpB+Z9nNzsEJ5h1+hkJsj067Bp0cyY4EqHk3f41bXdpuP5MrBmVgtHN
         qPBnZeCwFvASL2nKrQTSuPsoGRsRrbgqehDOYnLRJpNKYdGP87f7pchPdcw00ijM3/zn
         vgCsl6jPa2iHxLXA1omI7QGk44XMnSyTOAAjaUcbAFzn/heTtp7auLLAlfARbEJWb80d
         5mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V5MB+WtQu9ahIUpMYQeTRqtUIiPA2kDNSM91G2ycfpU=;
        b=VYBBilb4p0fZ9axQ6l2jf6zd5W2NWJXKfWPJbRYxo0C5Fwz72sp9aRIdbIIJcfdbgB
         O+e7ODufI6waiMmd++WgWMOppDgBqaKS6cNZu71A1+f3/FTIVISnndPY1LI3VjtIrmkn
         oExCLosBhF14N3Q++Jc6RV5MeP08N2N2dewQrHO9/F+T5HzEDciUqcxkIST5g7F0m97v
         8yzbJPnlQR2E9Gd/u4vBDXGGPsNl+fq3bnG1z563YboWcUtaXUOQ5521T9RJUdsBluV5
         cLHrH0x+kO7zW7NPnVmHii61SQEHvNWVYzN+aSElVXDdf9FVVePkLysUM9UEygoWtMfx
         +syA==
X-Gm-Message-State: AGi0PuZBgj44mo35kAYsXN2EMdw4zT4rje4ZiZ6xCM0btUrBTWTcFeG4
        YPcy3UZFLHD/vjyO20k8ay1tW6VD/M81
X-Google-Smtp-Source: APiQypLtrmkqehiA7/4rvL/eb3/98litdJNVfP3I6BVqju/U8OIWBeCMkDEsifz06mbvnW6h2XqXyQ==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr9492879wml.104.1585929961453;
        Fri, 03 Apr 2020 09:06:01 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id l12sm12351426wrt.73.2020.04.03.09.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:06:01 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers))
Subject: [PATCH 4/5] libata: Add missing annotation for ata_scsi_rbuf_get() and ata_scsi_rbuf_fill()
Date:   Fri,  3 Apr 2020 17:05:04 +0100
Message-Id: <20200403160505.2832-5-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403160505.2832-1-jbi.octave@gmail.com>
References: <0/5>
 <20200403160505.2832-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at ata_scsi_rbuf_fill() and ata_scsi_rbuf_get()

 warning: context imbalance in ata_scsi_rbuf_get() - wrong count at exit
warning: context imbalance in ata_scsi_rbuf_fill() - unexpected unlock

The root cause is the missing annotation at ata_scsi_rbuf_fill()
	and ata_scsi_rbuf_get()

Add the missing __acquires(&ata_scsi_rbuf_lock)
Add the missing __releases(&ata_scsi_rbuf_lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/ata/libata-scsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index eb2eb599e602..3436b782053d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2082,6 +2082,7 @@ struct ata_scsi_args {
  */
 static void *ata_scsi_rbuf_get(struct scsi_cmnd *cmd, bool copy_in,
 			       unsigned long *flags)
+	__acquires(&ata_scsi_rbuf_lock)
 {
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, *flags);
 
@@ -2106,6 +2107,7 @@ static void *ata_scsi_rbuf_get(struct scsi_cmnd *cmd, bool copy_in,
  */
 static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, bool copy_out,
 				     unsigned long *flags)
+	__releases(&ata_scsi_rbuf_lock)
 {
 	if (copy_out)
 		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
-- 
2.24.1

