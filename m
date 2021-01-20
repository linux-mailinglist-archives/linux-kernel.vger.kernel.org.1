Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE52FC92B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbhATDht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:37:49 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:29127 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731242AbhATDhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 22:37:32 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 10K3Z2cj005354;
        Wed, 20 Jan 2021 12:35:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 10K3Z2cj005354
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611113703;
        bh=TVy/bi2QE4oN2L/eUtJRIzqXEnYfLr1n5cPiKLOkSqM=;
        h=From:To:Cc:Subject:Date:From;
        b=HuTs1HHtGSk8zx9u6x+7/DNLQA5dEb9UIJv7z/3DLsiUE7VrGq2C+IB2GNJV+TgeQ
         C4apLWSYJDe5G6z0iWosMrBFt3QrBTm+XBjn6QZY6NhKonNQQQ79ooN7I4cAZtalLq
         F1UfW2jrfFSsgXMwwXCqzkJHx7BQPNo2m9UUpZSRin1qn3PWx6f0IMOvLeiNNEAIM4
         6g85ck2DaeE0yzh9/UruEEoxX+sqzZ5vwSIb7cFEvEuQFxZLQcv/kuvIg5JlMP0GPA
         8fLLGHhnlVJJ11yySw27HIQ+UmEYOmfMuWlkWKUybWrorA7CvaTDdVeSViGIkoCbPN
         NRlm1lYpY+Obw==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Guilak <guilak@linux.vnet.ibm.com>,
        Lee Revell <rlrevell@joe-job.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] init/version.c: remove Version_<LINUX_VERSION_CODE> symbol
Date:   Wed, 20 Jan 2021 12:34:52 +0900
Message-Id: <20210120033452.2895170-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code hunk creates a Version_<LINUX_VERSION_CODE> symbol if
CONFIG_KALLSYMS is disabled. For example, building the kernel v5.10
for allnoconfig creates the following symbol:

  $ nm vmlinux | grep Version_
  c116b028 B Version_330240

There is no in-tree user of this symbol.

Commit 197dcffc8ba0 ("init/version.c: define version_string only if
CONFIG_KALLSYMS is not defined") mentions that Version_* is only used
with ksymoops.

However, a commit in the pre-git era [1] had added the statement,
"ksymoops is useless on 2.6.  Please use the Oops in its original format".

That statement existed until commit 4eb9241127a0 ("Documentation:
admin-guide: update bug-hunting.rst") finally removed the stale
ksymoops information.

This symbol is no longer needed.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=ad68b2f085f5c79e4759ca2d13947b3c885ee831

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 init/version.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/init/version.c b/init/version.c
index 80d2b7566b39..92afc782b043 100644
--- a/init/version.c
+++ b/init/version.c
@@ -16,14 +16,6 @@
 #include <linux/version.h>
 #include <linux/proc_ns.h>
 
-#ifndef CONFIG_KALLSYMS
-#define version(a) Version_ ## a
-#define version_string(a) version(a)
-
-extern int version_string(LINUX_VERSION_CODE);
-int version_string(LINUX_VERSION_CODE);
-#endif
-
 struct uts_namespace init_uts_ns = {
 	.ns.count = REFCOUNT_INIT(2),
 	.name = {
-- 
2.27.0

