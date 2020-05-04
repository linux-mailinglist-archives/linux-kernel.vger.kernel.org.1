Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FAE1C42C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 19:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgEDR3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730336AbgEDR3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:29:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC18C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=M6Hol8lVrYTT/lqsdSfNEOam4R/3TesIx/BPey5hvag=; b=MRrLMwIj+wlcXelBijzTg74b+W
        fgxJxMBaa4TmevZBonEZOFQHRaq69d6UpZhg8SpekQM1XMdUFNb5zCmFHGzXbJIcXBC026B9yPZYj
        Wznzktq9fHaUSrwolvX7/VaAzz+/qDokN42621KtDFuONXLrC/P80GMkBgWOsya/oeZbXZUPWO0IV
        7uRG2WeE7yMpQLH8TdUtANVxRfLv0vWA6arJx8LIfjbbqfQDpmkWqlvqfkslS07yMiJ3ME4jwmte+
        xtP2VEhjw91CDf8ABUDIljLzqfiHCryptCU5aCP1EKbQ978wB+q+jg3UhRk7QDeBpFdflnWcZvUB0
        DdHFuEPw==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVets-0004Iy-IC; Mon, 04 May 2020 17:29:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] x86/uv: Remove the unused _uv_cpu_blade_processor_id macro
Date:   Mon,  4 May 2020 19:15:27 +0200
Message-Id: <20200504171527.2845224-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504171527.2845224-1-hch@lst.de>
References: <20200504171527.2845224-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users anywhere in the kernel tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/uv/uv_hub.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 9eabd7e52fd15..60ca0afdeaf9f 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -659,7 +659,6 @@ static inline int uv_cpu_blade_processor_id(int cpu)
 {
 	return uv_cpu_info_per(cpu)->blade_cpu_id;
 }
-#define _uv_cpu_blade_processor_id 1	/* indicate function available */
 
 /* Blade number to Node number (UV1..UV4 is 1:1) */
 static inline int uv_blade_to_node(int blade)
-- 
2.26.2

