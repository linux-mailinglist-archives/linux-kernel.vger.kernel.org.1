Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE9224D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgGRQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 12:49:43 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:55988
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgGRQtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:49:43 -0400
X-IronPort-AV: E=Sophos;i="5.75,367,1589234400"; 
   d="scan'208";a="354738634"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 18 Jul 2020 18:49:41 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] docs: timers: drop documentation about LB_BIAS
Date:   Sat, 18 Jul 2020 18:08:38 +0200
Message-Id: <1595088518-28116-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LB_BIAS feature was removed in commit 1c1b8a7b03ef ("sched/fair:
Replace source_load() & target_load() with weighted_cpuload()"), so drop
the mention that it is disabled in the no_hz case.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 Documentation/timers/no_hz.rst |    2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index 065db21..c4c70e1 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -171,8 +171,6 @@ not come for free:
 	slightly differently than those for non-adaptive-tick CPUs.
 	This might in turn perturb load-balancing of real-time tasks.
 
-6.	The LB_BIAS scheduler feature is disabled by adaptive ticks.
-
 Although improvements are expected over time, adaptive ticks is quite
 useful for many types of real-time and compute-intensive applications.
 However, the drawbacks listed above mean that adaptive ticks should not

