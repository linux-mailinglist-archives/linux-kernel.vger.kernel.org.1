Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E79D263B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 05:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgIJD0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 23:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgIJD0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:26:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30541C061756;
        Wed,  9 Sep 2020 20:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pCnlLQfEIR7ZWPphaupIzC2PB27NlllGaC4CxBPgDrc=; b=iOPfXYn1R19lM2WR9nrx0bevHM
        wrP/kUUb1f9d6sjuhkVkEmvZKgN6Y0OUct2zdYAFHjpU0ubhqXEINoa8DSt3ipv9Hun5KOo8twrPV
        4wbGpJ+KmNZYEMseHPN4I2YghdFXmqZXknT9/sc9Pyf+6pZBZzvNz+GDpCyRW4HxvhOKJf8XcFGE+
        +fv0qP+77BwKflONtfyy9vPzmgWXARXhIfZbYBc3IaMMlsYR5IK+c9VyhqscXcSQCPYNuRVNUK2hf
        y56NdIb4KpJqTcK5tLw/Z8qPVPQU/oEmgBQSUPekENhlDBAgL7xd1GtrYG4aRutrBsQCLF4Pe9bxb
        23a4wM3w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGDDw-000659-PN; Thu, 10 Sep 2020 03:26:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 1/3] Documentation/admin-guide: kernel-parameters: update CMA entries
Date:   Wed,  9 Sep 2020 20:26:04 -0700
Message-Id: <20200910032606.7355-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910032606.7355-1-rdunlap@infradead.org>
References: <20200910032606.7355-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qualifying build option legend [CMA] to kernel boot options
that requirce CMA support to be enabled for them to be usable.

Also capitalize 'CMA' when it is used as an acronym.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20200909.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20200909/Documentation/admin-guide/kernel-parameters.txt
@@ -591,7 +591,7 @@
 			some critical bits.
 
 	cma=nn[MG]@[start[MG][-end[MG]]]
-			[ARM,X86,KNL]
+			[ARM,X86,KNL,CMA]
 			Sets the size of kernel global memory area for
 			contiguous memory allocations and optionally the
 			placement constraint by the physical address range of
@@ -600,7 +600,7 @@
 			include/linux/dma-contiguous.h
 
 	cma_pernuma=nn[MG]
-			[ARM64,KNL]
+			[ARM64,KNL,CMA]
 			Sets the size of kernel per-numa memory area for
 			contiguous memory allocations. A value of 0 disables
 			per-numa CMA altogether. And If this option is not
@@ -1524,12 +1524,12 @@
 	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
-	hugetlb_cma=	[HW] The size of a cma area used for allocation
+	hugetlb_cma=	[HW,CMA] The size of a CMA area used for allocation
 			of gigantic hugepages.
 			Format: nn[KMGTPE]
 
-			Reserve a cma area of given size and allocate gigantic
-			hugepages using the cma allocator. If enabled, the
+			Reserve a CMA area of given size and allocate gigantic
+			hugepages using the CMA allocator. If enabled, the
 			boot-time allocation of gigantic hugepages is skipped.
 
 	hugepages=	[HW] Number of HugeTLB pages to allocate at boot.
