Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10127FE8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbgJALjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:39:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43175 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbgJALjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:39:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kNwvN-0006JR-28; Thu, 01 Oct 2020 11:39:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/events/amd/iommu: fix sizeof mismatch
Date:   Thu,  1 Oct 2020 12:39:00 +0100
Message-Id: <20201001113900.58889-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An incorrect sizeof is being used, struct attribute ** is not correct,
it should be struct attribute *. Note that since ** is the same size as
* this is not causing any issues.  Improve this fix by using sizeof(*attrs)
as this allows us to not even reference the type of the pointer.

Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
Fixes: 51686546304f ("x86/events/amd/iommu: Fix sysfs perf attribute groups")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/events/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index fb616203ce42..be50ef8572cc 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -379,7 +379,7 @@ static __init int _init_events_attrs(void)
 	while (amd_iommu_v2_event_descs[i].attr.attr.name)
 		i++;
 
-	attrs = kcalloc(i + 1, sizeof(struct attribute **), GFP_KERNEL);
+	attrs = kcalloc(i + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs)
 		return -ENOMEM;
 
-- 
2.27.0

