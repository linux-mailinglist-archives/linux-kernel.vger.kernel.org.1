Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D85729E8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgJ2KS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ2KS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:18:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFFC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Zns1ysEyW/6YEAQtEOc2r63tr9Y6svfKyny2d9qVHyM=; b=r4pJ7G6qvKdBOk+QTWN21fiCfd
        LpNaHk07zgUMFQpHZPBK59I1JRAJ9h+2q1m1JNgphyY6SpfCsNWW5WJVHnNqj4mzrHJLa/mcQbtM2
        lPAxdBH8GmSocF07pX8G7QqLV5sRHXY5EjMbPe2dpvRtgswDN9o/vKwnGHeuYNzI2iB1TJPOC8Pl4
        Vnrcklckg5tUpYBSe1k2vh/EWF38hj8BYNRzAANTbr56cV2nrW5JksH82ZTg5noEUhZE4Hknsbswj
        a3YD9sansNmeA1mAmfTrFXwPAexev3mgl0Jz6he4YhZw6yRo/mV83XL14bKBzZLa7wN2nSZT9GasX
        jBohiqzg==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY51B-0004BL-O5; Thu, 29 Oct 2020 10:18:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] mm: unexport follow_pte_pmd
Date:   Thu, 29 Oct 2020 11:14:31 +0100
Message-Id: <20201029101432.47011-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029101432.47011-1-hch@lst.de>
References: <20201029101432.47011-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow_pte_pmd is only used by the DAX code, which can't be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e50268..00458e7b49fef8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4787,7 +4787,6 @@ int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 						    ptepp, pmdpp, ptlp)));
 	return res;
 }
-EXPORT_SYMBOL(follow_pte_pmd);
 
 /**
  * follow_pfn - look up PFN at a user virtual address
-- 
2.28.0

