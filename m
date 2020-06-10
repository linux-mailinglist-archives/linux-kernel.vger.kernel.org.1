Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1511F5698
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 16:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgFJOK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 10:10:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:37284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgFJOK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:10:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 36262ABC7;
        Wed, 10 Jun 2020 14:10:58 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] efi: avoid error message when booting under Xen
Date:   Wed, 10 Jun 2020 16:10:52 +0200
Message-Id: <20200610141052.13258-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efifb_probe() will issue an error message in case the kernel is booted
as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
that message by calling efi_mem_desc_lookup() only if EFI_PARAVIRT
isn't set.

Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/video/fbdev/efifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 65491ae74808..f5eccd1373e9 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -453,7 +453,7 @@ static int efifb_probe(struct platform_device *dev)
 	info->apertures->ranges[0].base = efifb_fix.smem_start;
 	info->apertures->ranges[0].size = size_remap;
 
-	if (efi_enabled(EFI_BOOT) &&
+	if (efi_enabled(EFI_BOOT) && !efi_enabled(EFI_PARAVIRT) &&
 	    !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
 		if ((efifb_fix.smem_start + efifb_fix.smem_len) >
 		    (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
-- 
2.26.2

