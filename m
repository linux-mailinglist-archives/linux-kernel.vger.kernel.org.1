Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E41C42A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgEDRYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 13:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729602AbgEDRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:24:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DBBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2aCmnBaqhKxEDPj0Sl3PYBND3G5FDsOAhMdFBN3ZP+U=; b=L8dfagxOoRuwAQumYw5aEs33bY
        Y++giE4ctIO7ZQzoS+ZhQ0XmZccsJe9u63Sz5K7O5VEwzjaScDLDKM0TqG7pYrX7QYQzJejzJK3CL
        Co11jATNCPREY2iNbctyLVTRzSbG27IoMOJQ6Mcru3bCWvQNMoopPYjtLmkJHkpeQp1j+oFssrCIX
        YXavMyEQpgUob5UMiBjuPlNURQjWIKlxwwsHXL4Qdd2Km0Nrq2LTIExHRmSpE6U97Cf9JWh8E48az
        dKbFUVCnk2YE9HCZCqTiyhc5mzjN6URBZRCPqPp27hTLdmT/UvnLrbkByCgkRyGoeq9wYHNjVkZoH
        CeWETQtw==;
Received: from 089144205116.atnat0014.highway.webapn.at ([89.144.205.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVepJ-0001BW-4z; Mon, 04 May 2020 17:24:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] x86/uv: Unexport sn_coherency_id
Date:   Mon,  4 May 2020 19:15:19 +0200
Message-Id: <20200504171527.2845224-4-hch@lst.de>
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

sn_coherency_id is only used by x2apic_uv_x.c, and uv_sysfs.c, both
of which can't be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/platform/uv/bios_uv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index ca287554e2342..5d675c4f459b4 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -80,7 +80,6 @@ static s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 long sn_partition_id;
 EXPORT_SYMBOL_GPL(sn_partition_id);
 long sn_coherency_id;
-EXPORT_SYMBOL_GPL(sn_coherency_id);
 long sn_region_size;
 EXPORT_SYMBOL_GPL(sn_region_size);
 long system_serial_number;
-- 
2.26.2

