Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED8D2C3F39
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgKYLlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgKYLlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:41:12 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8983DC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:41:12 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so2087675pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gQ+v++jpPeKhNq44GEfnnAm5hy7WJGRSg9tzpqA2KfY=;
        b=ru3r7Z2K3dPdK9M53EGXwzIGphvjVdgGpzgcbousUorI988LxJYbIuMMDhhtbPL4nY
         WTjeTfa0I+RhxcbB2gV4S9XR6HPGQCDBfyEzcjCMipbf6WBssDnOUyo/xi4STLZPXLwA
         NYbgyU5kloglPPzAxi3V7ziD46gYg9ioz4LzbX7s2sXbnyh4EnPvi2qEveE4vTW+Osh9
         JFcyQSo/ldRQVzHaPoo6crLOzn23Ni17vjFfm6t3R7c1zLErHfoW2+1QFweSH9si9hYY
         PlN7QTZU7vCUYKL1GdY83yGdXu+hjuvjJJfRmid440fMkn8pzfng0dC5uINtjAQ7VjTY
         sGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gQ+v++jpPeKhNq44GEfnnAm5hy7WJGRSg9tzpqA2KfY=;
        b=hLL+UslWqMQz7hGLRTZOeUjvB4XROE9zdOhtiacnaaa8a8iR6U1IgFZ4zLSBU0+k2y
         8E43ONhctpWiaP773AV1jddex0/CZ8bwMV969+kzeMR4vrEYE4Kg63TOthJzdsOnDenA
         FEzvNFecruiKpxUCVJQBMOEsIQdv+kNjvCu1Suj1qxk5Ian+SeCGdtTfG6iqbBsnMRQU
         AnOhs8ihdWAsY3SGtLJP7SQQCtIfw8SMkky3neeT3h0FQi0/jAyjQK8jC6tu+RaWvpSQ
         ddooqiawQ3if8K//RZ12UEqqB/GrYVWSKCgjyscBDw8o3EkIQigcCxUDheLw8WNDM/EL
         Yy9g==
X-Gm-Message-State: AOAM530MuCMMC964PwnP+hksioVxhf3s5hq20eC+SoGY9pJ6AgjDs8u+
        kZfJwghLHMzMjadcBTwuGuB3Be3HquH2WMhCwQs=
X-Google-Smtp-Source: ABdhPJwaoTqITc0BiWAjyH8uESASPwGAMbVHZg/HFnZQoJiVi697Swt7d2sXtLKfCYV0pct334MKjg==
X-Received: by 2002:a17:90b:14d3:: with SMTP id jz19mr1509687pjb.196.1606304471867;
        Wed, 25 Nov 2020 03:41:11 -0800 (PST)
Received: from localhost.localdomain (61-220-206-157.HINET-IP.hinet.net. [61.220.206.157])
        by smtp.gmail.com with ESMTPSA id q13sm2655942pjq.15.2020.11.25.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 03:41:11 -0800 (PST)
From:   Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark_hsieh@wistron.com, linux-mips@vger.kernel.org,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Subject: [PATCH] nvme-pci: disable write zeros support on specific SSDs
Date:   Wed, 25 Nov 2020 19:41:06 +0800
Message-Id: <20201125114106.7251-1-mark_hsieh@wistron.corp-partner.google.com>
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

