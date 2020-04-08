Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5F1A2CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 01:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgDHXxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 19:53:43 -0400
Received: from mail5.windriver.com ([192.103.53.11]:40794 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgDHXxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 19:53:42 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 038NqZ8o002758
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 8 Apr 2020 16:52:45 -0700
Received: from sc2600cp.corp.ad.wrs.com (128.224.56.62) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 16:52:24 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] perf/x86/intel/pt: drop pointless NULL assignment.
Date:   Wed, 8 Apr 2020 19:52:16 -0400
Message-ID: <20200408235216.108980-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only a few lines below this removed line is this:

  attrs = kzalloc(size, GFP_KERNEL);

and since there is no code path where this could be avoided, the
NULL assignment is a pointless relic of history and can be removed.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 1db7a51d9792..e94af4a54d0d 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -226,8 +226,6 @@ static int __init pt_pmu_hw_init(void)
 			pt_pmu.vmx = true;
 	}
 
-	attrs = NULL;
-
 	for (i = 0; i < PT_CPUID_LEAVES; i++) {
 		cpuid_count(20, i,
 			    &pt_pmu.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM],
-- 
2.17.1

