Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0763005A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbhAVOhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:37:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728835AbhAVOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611326131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LQyF+HvI2kyISxweGPzscU/va3PLmqEKg6fBJl2vlZ8=;
        b=B+DkxZPr8h9V7L2qmFgoIed9KSydNYOUG/V9jTGB2+6f7ULmav/YND+ZHl0nbIoHDWNc78
        dIerh3J3GB8gn5xlJF1fT9Fsu7+OKWublr8Nar5z/cqG2VPbSaUKSaOvHIxwKKCBnamwgV
        I5uME/KXdGnVajhKnKrKh97rPlNfmQY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-KGWUscrcPw67X4bxChi1ZA-1; Fri, 22 Jan 2021 09:35:29 -0500
X-MC-Unique: KGWUscrcPw67X4bxChi1ZA-1
Received: by mail-qk1-f200.google.com with SMTP id i11so4131050qkn.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQyF+HvI2kyISxweGPzscU/va3PLmqEKg6fBJl2vlZ8=;
        b=Vtfb0ffAHy9gBU25aNT2gW2lQpgORYEpyp6fkmJx8X5VkdtHpmeDG0IdwBLm3gTpiY
         pWisbiHiVvmAESoU1Zh1GvIl4m1Dhzzu3qfDhqAkK19JAypZYbrqg/fkk1lR1TsE+gg7
         ifwtwZedARkC045OtQGZ5sv36t25bCYGGyaQ+CdM8OWA05PbFH4c4tiSu8uvT/vSoE0W
         zSkH7GigZGgv8R/bLUg/W/75BhHo1AgNc5epA3GUzg0nSK+OKGqdUYRxgvNnSSZHEcnh
         wrgjCHwDFhOvo6MNkMbDcfbgatni+pFViG6vOiN6O8CMymVExZQS6ANGWAKslPtUNG1K
         phPw==
X-Gm-Message-State: AOAM533P2baeaF6a1fBkkIJY4iI6/YrC3NcRSnWHNwiNNPmIuNsPb8Fp
        WQSzQnUuYWwcppww6LnrUGg97XkduP6KHf5GUtEkDlbs0YywzUxeBVlzjMPyV9GHcN/YrFk1dkU
        t/3PXNoB2MHLov7NkjDOmQlcQ
X-Received: by 2002:a05:6214:6a1:: with SMTP id s1mr4831098qvz.20.1611326129224;
        Fri, 22 Jan 2021 06:35:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcqvMfUvaE2tN1vEdzhCsoxnf8/L4VLzX3cVy9gLxkAEp+fnqTM+NsxqxKqqiCoS9XPqe5Ig==
X-Received: by 2002:a05:6214:6a1:: with SMTP id s1mr4831076qvz.20.1611326128936;
        Fri, 22 Jan 2021 06:35:28 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v67sm6715255qkd.94.2021.01.22.06.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:35:28 -0800 (PST)
From:   trix@redhat.com
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ata: sata_nv: remove h from printk format specifier
Date:   Fri, 22 Jan 2021 06:35:21 -0800
Message-Id: <20210122143521.1598974-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
  unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/ata/sata_nv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 20190f66ced9..81b75e513266 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -603,7 +603,7 @@ static void nv_adma_register_mode(struct ata_port *ap)
 		count++;
 	}
 	if (count == 20)
-		ata_port_warn(ap, "timeout waiting for ADMA IDLE, stat=0x%hx\n",
+		ata_port_warn(ap, "timeout waiting for ADMA IDLE, stat=0x%x\n",
 			      status);
 
 	tmp = readw(mmio + NV_ADMA_CTL);
@@ -618,7 +618,7 @@ static void nv_adma_register_mode(struct ata_port *ap)
 	}
 	if (count == 20)
 		ata_port_warn(ap,
-			      "timeout waiting for ADMA LEGACY, stat=0x%hx\n",
+			      "timeout waiting for ADMA LEGACY, stat=0x%x\n",
 			      status);
 
 	pp->flags |= NV_ADMA_PORT_REGISTER_MODE;
@@ -648,7 +648,7 @@ static void nv_adma_mode(struct ata_port *ap)
 	}
 	if (count == 20)
 		ata_port_warn(ap,
-			"timeout waiting for ADMA LEGACY clear and IDLE, stat=0x%hx\n",
+			"timeout waiting for ADMA LEGACY clear and IDLE, stat=0x%x\n",
 			status);
 
 	pp->flags &= ~NV_ADMA_PORT_REGISTER_MODE;
@@ -736,7 +736,7 @@ static int nv_adma_slave_config(struct scsi_device *sdev)
 	blk_queue_segment_boundary(sdev->request_queue, segment_boundary);
 	blk_queue_max_segments(sdev->request_queue, sg_tablesize);
 	ata_port_info(ap,
-		      "DMA mask 0x%llX, segment boundary 0x%lX, hw segs %hu\n",
+		      "DMA mask 0x%llX, segment boundary 0x%lX, hw segs %u\n",
 		      (unsigned long long)*ap->host->dev->dma_mask,
 		      segment_boundary, sg_tablesize);
 
-- 
2.27.0

