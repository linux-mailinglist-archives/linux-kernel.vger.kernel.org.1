Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86C28278F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 02:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgJDAS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 20:18:28 -0400
Received: from smtprelay0118.hostedemail.com ([216.40.44.118]:50136 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726108AbgJDAS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 20:18:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8E98412D0;
        Sun,  4 Oct 2020 00:18:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1515:1534:1540:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3351:3872:3876:4321:5007:6261:10004:10848:11026:11658:11914:12043:12048:12296:12297:12438:12555:12895:12986:13069:13161:13229:13311:13357:13894:14096:14181:14384:14394:14721:21080:21627:21990,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: chain76_2508979271b1
X-Filterd-Recvd-Size: 1973
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun,  4 Oct 2020 00:18:22 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] rcu/tree: Make struct kernel_param_ops definitions const
Date:   Sat,  3 Oct 2020 17:18:08 -0700
Message-Id: <c5e4bf0622e261f474b213c9eb0b646f7cca2a72.1601770305.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1601770305.git.joe@perches.com>
References: <cover.1601770305.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These should be const, so make it so.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f78ee759af9c..c4732bb80818 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -552,12 +552,12 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	return ret;
 }
 
-static struct kernel_param_ops first_fqs_jiffies_ops = {
+static const struct kernel_param_ops first_fqs_jiffies_ops = {
 	.set = param_set_first_fqs_jiffies,
 	.get = param_get_ulong,
 };
 
-static struct kernel_param_ops next_fqs_jiffies_ops = {
+static const struct kernel_param_ops next_fqs_jiffies_ops = {
 	.set = param_set_next_fqs_jiffies,
 	.get = param_get_ulong,
 };
-- 
2.26.0

