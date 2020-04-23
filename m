Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D270E1B68FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 01:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgDWXTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 19:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729809AbgDWXTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:19:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CF92192A;
        Thu, 23 Apr 2020 23:19:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jRl7o-000YtH-L0; Thu, 23 Apr 2020 19:19:20 -0400
Message-Id: <20200423231920.532930181@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Apr 2020 19:18:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hulk Robot <hulkci@huawei.com>, Jason Yan <yanaijie@huawei.com>
Subject: [for-linus][PATCH 4/4] tracing: Convert local functions in tracing_map.c to static
References: <20200423231838.682478056@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Yan <yanaijie@huawei.com>

Fix the following sparse warning:

kernel/trace/tracing_map.c:286:6: warning: symbol
'tracing_map_array_clear' was not declared. Should it be static?
kernel/trace/tracing_map.c:297:6: warning: symbol
'tracing_map_array_free' was not declared. Should it be static?
kernel/trace/tracing_map.c:319:26: warning: symbol
'tracing_map_array_alloc' was not declared. Should it be static?

Link: http://lkml.kernel.org/r/20200410073312.38855-1-yanaijie@huawei.com

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/tracing_map.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9e31bfc818ff..74738c9856f1 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -283,7 +283,7 @@ int tracing_map_add_key_field(struct tracing_map *map,
 	return idx;
 }
 
-void tracing_map_array_clear(struct tracing_map_array *a)
+static void tracing_map_array_clear(struct tracing_map_array *a)
 {
 	unsigned int i;
 
@@ -294,7 +294,7 @@ void tracing_map_array_clear(struct tracing_map_array *a)
 		memset(a->pages[i], 0, PAGE_SIZE);
 }
 
-void tracing_map_array_free(struct tracing_map_array *a)
+static void tracing_map_array_free(struct tracing_map_array *a)
 {
 	unsigned int i;
 
@@ -316,7 +316,7 @@ void tracing_map_array_free(struct tracing_map_array *a)
 	kfree(a);
 }
 
-struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
+static struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
 						  unsigned int entry_size)
 {
 	struct tracing_map_array *a;
-- 
2.26.1


