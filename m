Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC9A1FD739
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFQV2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 17:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQV2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:28:46 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DEFF2168B;
        Wed, 17 Jun 2020 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592429326;
        bh=IBFohY0NkQV6wxVWydl+9zLFk4xIZ9akrDNFlU3W6Uo=;
        h=Date:From:To:Cc:Subject:From;
        b=Y6dpZh7bJ3CfbAnLWwakIP0aW30Um9NyESw2YkrN7MB+b1GOEXvGSlJIn+Wujoipi
         0yWJhrM9Iyd9LtnxrTYTU06A7f1WHIm6oVWIHYwTPT5tR9kJoY9+DAwwshCZpXKIFQ
         P5LizBptF6eP71PzEjvncvwupt6zpuAaJmR5xOS0=
Date:   Wed, 17 Jun 2020 16:34:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] arm64: kexec_file: Use struct_size() in kmalloc()
Message-ID: <20200617213407.GA1385@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/arm64/kernel/machine_kexec_file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 522e6f517ec0..361a1143e09e 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -219,8 +219,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 					MEMBLOCK_NONE, &start, &end, NULL)
 		nr_ranges++;
 
-	cmem = kmalloc(sizeof(struct crash_mem) +
-			sizeof(struct crash_mem_range) * nr_ranges, GFP_KERNEL);
+	cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
 	if (!cmem)
 		return -ENOMEM;
 
-- 
2.27.0

