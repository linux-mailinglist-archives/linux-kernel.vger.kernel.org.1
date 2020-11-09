Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BC2ABC50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbgKINgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:36:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51656 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbgKINEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:04:51 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kc6ql-0006it-A6; Mon, 09 Nov 2020 13:04:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] cpumask: allocate enough space for string and trailing '\0' char
Date:   Mon,  9 Nov 2020 13:04:47 +0000
Message-Id: <20201109130447.2080491-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the allocation of cpulist is based on the length of buf but does
not include the addition end of string '\0' terminator. Static analysis is
reporting this as a potential out-of-bounds access on cpulist. Fix this by
allocating enough space for the additional '\0' terminator.

Addresses-Coverity: ("Out-of-bounds access")
Fixes: 65987e67f7ff ("cpumask: add "last" alias for cpu list specifications")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/cpumask.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 34ecb3005941..cb8a3ef0e73e 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -185,7 +185,7 @@ int __ref cpulist_parse(const char *buf, struct cpumask *dstp)
 {
 	int r;
 	char *cpulist, last_cpu[5];	/* NR_CPUS <= 9999 */
-	size_t len = strlen(buf);
+	size_t len = strlen(buf) + 1;
 	bool early = !slab_is_available();
 
 	if (!strcmp(buf, "all")) {
-- 
2.28.0

