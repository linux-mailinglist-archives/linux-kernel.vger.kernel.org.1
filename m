Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C872C421D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgKYOU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbgKYOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:20:29 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2310EC061A4E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 06:20:29 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so2565783pge.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 06:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gQ+v++jpPeKhNq44GEfnnAm5hy7WJGRSg9tzpqA2KfY=;
        b=FpUMMFdCVqEIhqDfRS3YQfiym5wpPly+Hk8qhK+eHEQFS1hx56vXKw27Zpi5xrcnsQ
         IkEDADMrdURsO5ij2WsZexofnd/1Ypl6mxn6CuKzaCIWWsEtoQzApfMUxlHLEqvYMM4l
         g5FSs6TIL6GhlltMyTC6VPu7sNdwz6AIOpHyRJXaPdw/P2gFYkdWJ+Sc19zpCxpG+Zcz
         EiHK92UblbE6GtuH7hO8+/bHzK8MJk7v6XTXn8Hs9Hln6qSpi+fI1+qQZznWAE3JtNTU
         xgyUwuy/DHpoyMa4ZiBgYEUvDLcrF8DC4RL7NJC96M9Hw4B3GsHQaEdtLFAN9J1WqFx6
         ThZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gQ+v++jpPeKhNq44GEfnnAm5hy7WJGRSg9tzpqA2KfY=;
        b=QCLrsf5gCWgl8uhV6vmPHM2grRI4irsiwY19HO4MBQo3KRUoFDkofy2Q/vXNUucnXj
         2AlvTE6sDRe6bN5OdRnnfwf/Gds6Z4SQ0J4k0RY424fsnbWLgaD6AHT2oznmhIVHJHRh
         q9Wv0ptFITehQbfDCYLjJj728+WZ1ydWl8vh6Nj6zkV/LS054xaL/ooQ1/OtYTzxt5GR
         O8llFfeTrBhqMJ3lYd0KoPI3r5z9AbF0v9kHpNCzoadlQpx66s8oNrYY5IHYVnC82XMG
         BL4B4QYWhB9fRer+OnrYdkXc6kg1ndavSvS8QRWd4z/Vp1h4Cgf6OyHRr5ur5+hGpZ/m
         rziA==
X-Gm-Message-State: AOAM532D1X+hw2/g3145cMAgH/TC/4jQsoYgce+d7Ctj86Wl4qU9wrja
        gDGImIhXhcmtRMTlkluFb+i9AXL9N41Z9/0fayY=
X-Google-Smtp-Source: ABdhPJyOYlBp5SnuiWRENQsa2uYLYFdcN+bNSh9ktmEvUKXIdbeD2w9u2BWqPgcLpuyZZyikGVhXmQ==
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr4652450pjq.13.1606314028625;
        Wed, 25 Nov 2020 06:20:28 -0800 (PST)
Received: from localhost.localdomain (60-251-182-145.HINET-IP.hinet.net. [60.251.182.145])
        by smtp.gmail.com with ESMTPSA id c11sm3260861pjn.26.2020.11.25.06.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 06:20:28 -0800 (PST)
From:   Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
To:     paulburton@kernel.org
Cc:     ralf@linux-mips.org, jhogan@kernel.org, christian@brauner.io,
        linux-kernel@vger.kernel.org, mark_hsieh@wistron.com,
        linux-mips@vger.kernel.org,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Subject: [PATCH] nvme-pci: disable write zeros support on specific SSDs
Date:   Wed, 25 Nov 2020 22:20:23 +0800
Message-Id: <20201125142023.21469-1-mark_hsieh@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
Write Zeroes command"), Samsung, Phison and Kingston have the same issue:
[ 6305.633887] blk_update_request: operation not supported error, dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0

So also disable Write Zeroes command on Samsung, Phison and Kingston.

Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
---
 drivers/nvme/host/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..ceedb5dcb54c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3202,6 +3202,12 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung 128HBHQ and 256HAJD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1987, 0x5013),   /* Phison PS5013 E13 */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x500d),   /* Kingston OM3PDP3256B-AH 256G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.17.1

