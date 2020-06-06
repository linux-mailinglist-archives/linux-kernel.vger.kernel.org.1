Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD041F0856
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 21:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgFFTZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 15:25:54 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:56662 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726113AbgFFTZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 15:25:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8BA54837F24C;
        Sat,  6 Jun 2020 19:25:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3870:3871:3872:3874:4250:5007:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12296:12297:12438:12555:12760:13069:13255:13311:13357:13439:14181:14659:14721:21080:21627:21990:30054:30070:30089,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rose92_5c14e3626dab
X-Filterd-Recvd-Size: 1817
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat,  6 Jun 2020 19:25:51 +0000 (UTC)
Message-ID: <b9b27f2233bd1fa31d72ff937beefdae0e2104e5.camel@perches.com>
Subject: [Possible PATCH]arm64: ftrace: Change CONFIG_FTRACE_WITH_REGS to
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 06 Jun 2020 12:25:50 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_FTRACE_WITH_REGS does not exist as a Kconfig symbol.

Signed-off-by: Joe Perches <joe@perches.com>
---

I don't have the hardware, so I can't tell if this is a
correct change, but it is a logical one.

Found by a test script that looks for IS_ENABLED(FOO)
where FOO must also exist in Kconfig files.

 arch/arm64/kernel/ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 8618faa82e6d..86a5cf9bc19a 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -69,7 +69,8 @@ static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 
 	if (addr == FTRACE_ADDR)
 		return &plt[FTRACE_PLT_IDX];
-	if (addr == FTRACE_REGS_ADDR && IS_ENABLED(CONFIG_FTRACE_WITH_REGS))
+	if (addr == FTRACE_REGS_ADDR &&
+	    IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
 		return &plt[FTRACE_REGS_PLT_IDX];
 #endif
 	return NULL;

