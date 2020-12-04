Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975D52CE743
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 06:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgLDFHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 00:07:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgLDFHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 00:07:49 -0500
From:   Andy Lutomirski <luto@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 0/4] membarrier fixes
Date:   Thu,  3 Dec 2020 21:07:02 -0800
Message-Id: <cover.1607058304.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various membarrier fixes.

Changes from v2:
 - Added reviewed-bys
 - Don't rseq_preempt the caller (Mathieu)
 - Fix single-thread short circuit (Mathieu)

Changes from v1:
 - patch 1: comment fixes from Mathieu
 - patch 2: improved comments
 - patch 3: split out as a separate patch
 - patch 4: now has a proper explanation

Mathieu, I think we have to make sync_core sync the caller.  See patch 4.

Andy Lutomirski (4):
  x86/membarrier: Get rid of a dubious optimization
  membarrier: Add an actual barrier before rseq_preempt()
  membarrier: Explicitly sync remote cores when SYNC_CORE is requested
  membarrier: Execute SYNC_CORE on the calling thread

 arch/x86/include/asm/sync_core.h |  9 ++--
 arch/x86/mm/tlb.c                | 10 ++++-
 kernel/sched/membarrier.c        | 77 ++++++++++++++++++++++++--------
 3 files changed, 72 insertions(+), 24 deletions(-)

-- 
2.28.0

