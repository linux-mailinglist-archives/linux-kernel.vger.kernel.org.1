Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC382B1E42
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgKMPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:08:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbgKMPIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605280099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C9rPuSXlrjcqDgyEAQl7K983fiCHNWFVeaKbQl3STrQ=;
        b=GDyoVQ4ISM6qsvfx2tFdksgot+zQdGTdLwVlGwdF7h787a2LHGxl1BzVIyI22/eOcyt+C/
        vN2irlfcWZRBAPyPBkXtqcXWQrZfswk+9BLGlx3K+4rn+rO5d01Shp3lOfD12YS2aKInVL
        8BmigoKLSJfYsAPQ24lxJgFwCd4Qu3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-56L1U8yvMGSeLKDSQSgE_g-1; Fri, 13 Nov 2020 10:08:15 -0500
X-MC-Unique: 56L1U8yvMGSeLKDSQSgE_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFDD21891E8E;
        Fri, 13 Nov 2020 15:08:13 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 000F162A16;
        Fri, 13 Nov 2020 15:08:11 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot/compressed/64: Drop the now-unused finalize_identity_maps()
Date:   Fri, 13 Nov 2020 16:08:10 +0100
Message-Id: <20201113150810.1233016-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8570978ea030 ("x86/boot/compressed/64: Don't pre-map memory in
KASLR code") finalize_identity_maps() has no users, drop it.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index a5e5db6ada3c..6bf20223dc0f 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -167,16 +167,6 @@ void initialize_identity_maps(void *rmode)
 	write_cr3(top_level_pgt);
 }
 
-/*
- * This switches the page tables to the new level4 that has been built
- * via calls to add_identity_map() above. If booted via startup_32(),
- * this is effectively a no-op.
- */
-void finalize_identity_maps(void)
-{
-	write_cr3(top_level_pgt);
-}
-
 static pte_t *split_large_pmd(struct x86_mapping_info *info,
 			      pmd_t *pmdp, unsigned long __address)
 {
-- 
2.26.2

