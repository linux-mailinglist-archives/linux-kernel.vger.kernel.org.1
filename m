Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5CA2D254C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgLHIBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:01:04 -0500
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:40687 "EHLO
        2.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgLHIBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:01:03 -0500
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2020 03:01:02 EST
Received: from player734.ha.ovh.net (unknown [10.108.54.119])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id CCA95B3363
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 08:49:54 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player734.ha.ovh.net (Postfix) with ESMTPSA id 0AFE618C8C42C;
        Tue,  8 Dec 2020 07:49:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006381ab9e9-fc16-4135-a55f-45b014094f44,
                    F7F8495E9FE719388847EB9DDB8A3A77E3CADC2E) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: clean up sysctl/kernel: titles, version
Date:   Tue,  8 Dec 2020 08:49:22 +0100
Message-Id: <20201208074922.30359-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3468334663265963397
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudejhedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up a few titles with extra colons, and removes the
reference to kernel 2.2. The docs don't yet cover *all* of 5.10 or
5.11, but I think they're close enough. Most entries are documented,
and have been checked against current kernels.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d4b32cc32bb7..7d53146798c0 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -14,7 +14,7 @@ For general info and legal blurb, please look in :doc:`index`.
 ------------------------------------------------------------------------------
 
 This file contains documentation for the sysctl files in
-``/proc/sys/kernel/`` and is valid for Linux kernel version 2.2.
+``/proc/sys/kernel/``.
 
 The files in this directory can be used to tune and monitor
 miscellaneous and general things in the operation of the Linux
@@ -1095,8 +1095,8 @@ Enables/disables scheduler statistics. Enabling this feature
 incurs a small amount of overhead in the scheduler but is
 useful for debugging and performance tuning.
 
-sched_util_clamp_min:
-=====================
+sched_util_clamp_min
+====================
 
 Max allowed *minimum* utilization.
 
@@ -1106,8 +1106,8 @@ It means that any requested uclamp.min value cannot be greater than
 sched_util_clamp_min, i.e., it is restricted to the range
 [0:sched_util_clamp_min].
 
-sched_util_clamp_max:
-=====================
+sched_util_clamp_max
+====================
 
 Max allowed *maximum* utilization.
 
@@ -1117,8 +1117,8 @@ It means that any requested uclamp.max value cannot be greater than
 sched_util_clamp_max, i.e., it is restricted to the range
 [0:sched_util_clamp_max].
 
-sched_util_clamp_min_rt_default:
-================================
+sched_util_clamp_min_rt_default
+===============================
 
 By default Linux is tuned for performance. Which means that RT tasks always run
 at the highest frequency and most capable (highest capacity) CPU (in

base-commit: 0477e92881850d44910a7e94fc2c46f96faa131f
-- 
2.20.1

