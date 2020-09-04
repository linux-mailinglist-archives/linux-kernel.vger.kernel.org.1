Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A425D646
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgIDKbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 06:31:45 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:55606 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbgIDKbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:31:03 -0400
X-Greylist: delayed 1803 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Sep 2020 06:31:03 EDT
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 4 Sep 2020 19:00:43 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: matia.kim@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.221.52)
        by 156.147.1.121 with ESMTP; 4 Sep 2020 19:00:43 +0900
X-Original-SENDERIP: 10.177.221.52
X-Original-MAILFROM: matia.kim@lge.com
From:   Haesung Kim <matia.kim@lge.com>
To:     jirislaby@kernel.org, mark.rutland@arm.com,
        akpm@linux-foundation.org, mingo@kernel.org, geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, Haesung Kim <matia.kim@lge.com>
Subject: [PATCH] stacktrace: print real address of trace entries
Date:   Fri,  4 Sep 2020 19:00:24 +0900
Message-Id: <1599213624-14632-1-git-send-email-matia.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If function is marked as static and compiler decies to lnline function
with or without inline keyword, the function has no symbol.
We just know symbol located near the address of the inline function
by %pS type that shows symbol and offset. But we don't know function
name.
The real address let us extract the function name and location of
source code by debugging tools such as addr2line. This is helpful to
debug.

Signed-off-by: Haesung Kim <matia.kim@lge.com>
---
 kernel/stacktrace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 946f44a..b7168c5 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -24,12 +24,15 @@ void stack_trace_print(const unsigned long *entries, unsigned int nr_entries,
 		       int spaces)
 {
 	unsigned int i;
+	unsigned long ip;
 
 	if (WARN_ON(!entries))
 		return;
 
 	for (i = 0; i < nr_entries; i++)
-		printk("%*c%pS\n", 1 + spaces, ' ', (void *)entries[i]);
+		ip = entries[i];
+		printk("%*c[<%px>] %pS\n",
+			1 + spaces, ' ', (void *) ip, (void *) ip);
 }
 EXPORT_SYMBOL_GPL(stack_trace_print);
 
@@ -47,13 +50,15 @@ int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
 			unsigned int nr_entries, int spaces)
 {
 	unsigned int generated, i, total = 0;
+	unsigned long ip;
 
 	if (WARN_ON(!entries))
 		return 0;
 
 	for (i = 0; i < nr_entries && size; i++) {
-		generated = snprintf(buf, size, "%*c%pS\n", 1 + spaces, ' ',
-				     (void *)entries[i]);
+		ip = entries[i];
+		generated = snprintf(buf, size, "%*c[<%px>] %pS\n",
+				     1 + spaces, ' ', (void *) ip, (void *) ip);
 
 		total += generated;
 		if (generated >= size) {
-- 
2.7.4

