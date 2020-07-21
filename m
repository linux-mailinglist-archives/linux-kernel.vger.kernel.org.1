Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B41227C55
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 12:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgGUKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 06:00:11 -0400
Received: from 8bytes.org ([81.169.241.247]:58318 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgGUKAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:00:08 -0400
Received: from cap.home.8bytes.org (p5b006776.dip0.t-ipconnect.de [91.0.103.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 80F481AD;
        Tue, 21 Jul 2020 12:00:06 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] x86/mm/64: Remove vmalloc/ioremap pgtable synchronization
Date:   Tue, 21 Jul 2020 11:59:50 +0200
Message-Id: <20200721095953.6218-1-joro@8bytes.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

here is the third version of the patches to pre-allocate P4D/PUD pages
for the vmalloc/ioremap areas on x86-64. This makes the page-table
synchronization code obsolete and so it is also removed.

Please review.

Thanks,

	Joerg

Changes to v2:

	- Rebased to tip/master
	- Some rewording of the commit-messages 

Joerg Roedel (3):
  x86/mm: Pre-allocate p4d/pud pages for vmalloc area
  x86/mm/64: Do not sync vmalloc/ioremap mappings
  x86/mm/64: Make sync_global_pgds() static

 arch/x86/include/asm/pgtable_64.h       |  2 -
 arch/x86/include/asm/pgtable_64_types.h |  2 -
 arch/x86/mm/init_64.c                   | 59 ++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 10 deletions(-)

-- 
2.27.0

