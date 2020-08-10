Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B370240306
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHJHzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 03:55:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49596 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJHzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:55:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k52eC-0003WT-RC; Mon, 10 Aug 2020 07:55:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH] x86/resctrl: fix spelling mistake "Could't" -> "Couldn't"
Date:   Mon, 10 Aug 2020 08:55:08 +0100
Message-Id: <20200810075508.46490-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in pr_warn messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6a9df71c1b9e..98606689f5ca 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -562,7 +562,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	d = rdt_find_domain(r, id, &add_pos);
 	if (IS_ERR(d)) {
-		pr_warn("Could't find cache id for cpu %d\n", cpu);
+		pr_warn("Couldn't find cache id for cpu %d\n", cpu);
 		return;
 	}
 
@@ -607,7 +607,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 	d = rdt_find_domain(r, id, NULL);
 	if (IS_ERR_OR_NULL(d)) {
-		pr_warn("Could't find cache id for cpu %d\n", cpu);
+		pr_warn("Couldn't find cache id for cpu %d\n", cpu);
 		return;
 	}
 
-- 
2.27.0

