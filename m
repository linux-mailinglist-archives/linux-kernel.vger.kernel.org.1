Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033E62DE7B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgLRQ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:57:34 -0500
Received: from sym2.noone.org ([178.63.92.236]:53016 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgLRQ5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:57:33 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4CyFQC6yzYzvjkl; Fri, 18 Dec 2020 17:56:51 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/timens: add futex binary to .gitignore
Date:   Fri, 18 Dec 2020 17:56:51 +0100
Message-Id: <20201218165651.4538-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the futex test binary introduced by commit a4fd8414659b
("selftests/timens: Add a test for futex()") to .gitignore.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/testing/selftests/timens/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 2e43851b47c1..fe1eb8271b35 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 clock_nanosleep
 exec
+futex
 gettime_perf
 gettime_perf_cold
 procfs
-- 
2.29.0

