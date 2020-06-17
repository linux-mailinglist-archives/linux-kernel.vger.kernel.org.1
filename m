Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96941FC671
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgFQGxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 02:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgFQGxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:53:52 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0DCC2098B;
        Wed, 17 Jun 2020 06:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592376832;
        bh=hOOYeNVKTRN0wjya9eQvdE0drqLhfAmB9YP+e/7dQ7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBrONBq05gIzc0HWixCMU6K5rBNmrjH+6uq9PF5qq2s76KlynYiHs9nrjpagGz0PO
         Ij0RAh2OruD5cmjMUR6FSdEO+WHI3IVbR44OHlc6RvmIa2AhOZRpFD+4WqDmiUrXAF
         7qdszqUDXn3lISPcktyBB37KpyWggM/ogz/yk7fA=
From:   Mike Rapoport <rppt@kernel.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/2] m68k: mm: fix node memblock init
Date:   Wed, 17 Jun 2020 09:53:41 +0300
Message-Id: <20200617065341.32160-3-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617065341.32160-1-rppt@kernel.org>
References: <20200617065341.32160-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Dureghello <angelo.dureghello@timesys.com>

After pulling 5.7.0 (linux-next merge), mcf5441x mmu boot was
hanging silently.

memblock_add() seems not appropriate, since using MAX_NUMNODES
as node id, while memblock_add_node() sets up memory for node id 0.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/m68k/mm/mcfmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 29f47923aa46..7d04210d34f0 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -174,7 +174,7 @@ void __init cf_bootmem_alloc(void)
 	m68k_memory[0].addr = _rambase;
 	m68k_memory[0].size = _ramend - _rambase;
 
-	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
+	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
 
 	/* compute total pages in system */
 	num_pages = PFN_DOWN(_ramend - _rambase);
-- 
2.26.2

