Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D212C4DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbgKZDTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733226AbgKZDTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:19:09 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FE3C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:19:09 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so431521pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gQ+v++jpPeKhNq44GEfnnAm5hy7WJGRSg9tzpqA2KfY=;
        b=ngAuJfgnxB3fIyAdgCO8hkQNc/BizceAf7HeLNGFuQP5o5y0SDYoIty51pScSCwgaU
         ChAe9f3E8poTSBcyxhqvfQOIB1KdIpNo74+PvVqpeomIoA513DywavhXFdC+RfX+E4Io
         de2Mb0y86Z31zdUf0VAUGvZg7gcVb3rgUQR0Vf/0LNJMSWM8A13T0zEwS/scLyZVnctK
         ncVc9KgVnlaT78cv9lgS8j/UEh92LswZY4wH2h5E/Lg4JEBHONc3s7yh7Ei1VkKGLZk6
         BH9GEyUzJazu6zZczSosULBwpQhlbrGz2xpwZbWgxtBFFEvsFlQ0PD6pS3t8aB0YftXM
         4qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gQ+v++jpPeKhNq44GEfnnAm5hy7WJGRSg9tzpqA2KfY=;
        b=fgnGocXS+eEuTviMt7nW9E6eOV0eEUruncHqH/Rvv9y+8YgpuEaRnedAWPbjGac5bL
         6tw//b8i0mZxqfo0W39L00u7b4M4tuNogkJbHvKATzCGhTF/fm3jAC7MH6rAD1ofoDuF
         G4QdOsroJ1axknuq65yCIdvL9efKur+dD/LkRZAL8q7fohiqmYkjZ1z/NXsP+U/0fDl6
         SgAwyFyD/ll/4ZToE4oLFaUDsVcXOavBSIDfMsW4zBkF6A4Kg7CKH0LtyLxlUJ/x6L6F
         spMftHbCG3HgtUIIc4RtyTEiymIVD6vm5m/bjxKV4fy2jRAm7CpmpkjZW+NY4mz3XeEW
         cgBw==
X-Gm-Message-State: AOAM531o/ujYdAXuv6DCyLOBfCk3izTby3lVLhXBcneT7uZStMpKGAoZ
        AFI0cCNJ3ihMxK4NendXb/HXzQ==
X-Google-Smtp-Source: ABdhPJzSDCIijzhZl9eZyIIcfgqsjBkQ8ASb65hLtD8qZzRTDtVrh912muzvkjlNcy3pfvV93Wg5Hw==
X-Received: by 2002:a17:902:a5c1:b029:da:1140:df85 with SMTP id t1-20020a170902a5c1b02900da1140df85mr1027672plq.46.1606360749123;
        Wed, 25 Nov 2020 19:19:09 -0800 (PST)
Received: from localhost.localdomain (60-251-182-145.HINET-IP.hinet.net. [60.251.182.145])
        by smtp.gmail.com with ESMTPSA id g3sm3110390pfr.145.2020.11.25.19.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 19:19:08 -0800 (PST)
From:   Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
To:     kbusch@kernel.org
Cc:     linux-kernel@vger.kernel.org, mark_hsieh@wistron.com,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Subject: [PATCH] nvme-pci: disable write zeros support on specific SSDs
Date:   Thu, 26 Nov 2020 11:19:05 +0800
Message-Id: <20201126031905.29481-1-mark_hsieh@wistron.corp-partner.google.com>
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

