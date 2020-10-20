Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892A6284C77
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgJFNWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgJFNWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:22:05 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B29A0207EA;
        Tue,  6 Oct 2020 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601990525;
        bh=1/kFfg9hujBwZxGEftYmiwKOgEMoFAcLI8AXaUaaBDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjzTHKh67xcKKGKrwfLA2hpgj+6S5zKJuRIXgRbveo+b2ZcwTHaSPPsCesyWMv0TY
         V0FbUkl/NBpjrb2D2yTMtYzPNtsfBWhJa/RQKqZIohE6wGNfgr+xYQTI4Tj4MBbVph
         7p1TuHqzXxCoANZi3U4wQcdFujUDE+rgMgIXEFKw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPmuM-0018Kn-7w; Tue, 06 Oct 2020 15:21:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH 3/4] docs: RCU: Requirements.rst: fix a list block
Date:   Tue,  6 Oct 2020 15:21:32 +0200
Message-Id: <9f666389cd803b392bf422d31e50c5f9f8c9474c.1601990386.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601990386.git.mchehab+huawei@kernel.org>
References: <cover.1601990386.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by Sphinx:
	.../Documentation/RCU/Design/Requirements/Requirements.rst:1959: WARNING: Unexpected indentation.

The list block is missing a space before it, making Sphinx
to get it wrong.

Fixes: 2a721e5f0b2c ("docs: Update RCU's hotplug requirements with a bit about design")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 98557fee90cc..9f362827133a 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1954,6 +1954,7 @@ offline CPUs.  However, as a debugging measure, the FQS loop does splat
 if offline CPUs block an RCU grace period for too long.
 
 An offline CPU's quiescent state will be reported either:
+
 1.  As the CPU goes offline using RCU's hotplug notifier (``rcu_report_dead()``).
 2.  When grace period initialization (``rcu_gp_init()``) detects a
     race either with CPU offlining or with a task unblocking on a leaf
-- 
2.26.2

