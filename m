Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE4201F58
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 02:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgFTA6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 20:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731105AbgFTA6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:58:20 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C292D22B45;
        Sat, 20 Jun 2020 00:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592614699;
        bh=UOA15RhJAgb7M40tHY+iZioIy8bLsTRprxuHgmn+SRI=;
        h=Date:From:To:Cc:Subject:From;
        b=jEEBMqK6zqXacbnI/fsTkMHX5oWrCUtfxRBO2DuKCYAbpLnDZti1k8esJqGCEfFYG
         n0wZkG6tQXhF9b5QScqaHZyVek+CZMf0O/dud84MDdyGGYQSo2hnJUkufZ4Wnr96zN
         kP2jTeNG/KHniI4ik/eni8gvNOtYXL4Qu6MCnkvU=
Date:   Fri, 19 Jun 2020 20:03:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] perf/x86/intel/uncore: Use struct_size() in
 kzalloc_node()
Message-ID: <20200620010344.GA1899@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes. Also, remove unnecessary
variable _size_.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/x86/events/intel/uncore.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index cf76d6631afa..958c6baaf200 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -313,12 +313,10 @@ static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
 static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
 						 int node)
 {
-	int i, size, numshared = type->num_shared_regs ;
+	int i, numshared = type->num_shared_regs;
 	struct intel_uncore_box *box;
 
-	size = sizeof(*box) + numshared * sizeof(struct intel_uncore_extra_reg);
-
-	box = kzalloc_node(size, GFP_KERNEL, node);
+	box = kzalloc_node(struct_size(box, shared_regs, numshared), GFP_KERNEL, node);
 	if (!box)
 		return NULL;
 
-- 
2.27.0

