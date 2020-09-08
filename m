Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33230260BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 09:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgIHHTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 03:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729143AbgIHHTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599549592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XSFiEZcqfJEBBEvzp31kFgNny4R3P+ux/iaf3qvr4So=;
        b=T/vTl6oBY1BFj9RSx7Kfh8aPOdIHN/Y0DfxDxD/klee32c5Kso6w6+7idELhVCqoEXw6ht
        aQrnKnI3yEMkzxQj/Ts7akwKPkSVvL6GQIxJJNsKG41g0LF4Q41wD4krysclO5GDSa5or8
        dAzl9VM16nlDN7DzOBf2ejQ0H1Pguw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-euEA41YVO5yC2VZdg7pSXA-1; Tue, 08 Sep 2020 03:19:50 -0400
X-MC-Unique: euEA41YVO5yC2VZdg7pSXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AC5918B9F0B;
        Tue,  8 Sep 2020 07:19:49 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-90.bne.redhat.com [10.64.54.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DFCE27BBA;
        Tue,  8 Sep 2020 07:19:46 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, anshuman.khandual@arm.com, shan.gavin@gmail.com
Subject: [PATCH 1/2] arm64/mm: Remove CONT_RANGE_OFFSET
Date:   Tue,  8 Sep 2020 17:19:30 +1000
Message-Id: <20200908071931.47767-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro was introduced by commit <ecf35a237a85> ("arm64: PTE/PMD
contiguous bit definition") at the beginning. It's only used by
commit <348a65cdcbbf> ("arm64: Mark kernel page ranges contiguous"),
which was reverted later by commit <667c27597ca8>. This makes the
macro unused.

This removes the unused macro (CONT_RANGE_OFFSET).

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index d400a4d9aee2..8a399e666837 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -98,8 +98,6 @@
 #define CONT_PMDS		(1 << (CONT_PMD_SHIFT - PMD_SHIFT))
 #define CONT_PMD_SIZE		(CONT_PMDS * PMD_SIZE)
 #define CONT_PMD_MASK		(~(CONT_PMD_SIZE - 1))
-/* the numerical offset of the PTE within a range of CONT_PTES */
-#define CONT_RANGE_OFFSET(addr) (((addr)>>PAGE_SHIFT)&(CONT_PTES-1))
 
 /*
  * Hardware page table definitions.
-- 
2.23.0

