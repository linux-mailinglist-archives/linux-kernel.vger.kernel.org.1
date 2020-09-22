Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41218273859
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgIVCJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 22:09:48 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:46314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728776AbgIVCJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:09:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 93575182CED28;
        Tue, 22 Sep 2020 02:09:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3167:3352:3865:3866:3867:3871:3872:4321:5007:6119:7974:9592:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12114:12297:12438:12555:12740:12760:12895:13069:13138:13231:13311:13357:13439:14181:14394:14659:14721:21080:21433:21524:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: blood31_2d07bdd2714a
X-Filterd-Recvd-Size: 2699
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 22 Sep 2020 02:09:45 +0000 (UTC)
Message-ID: <613f58fe866eb6cc8a043aac5ec97fe9d8a0126d.camel@perches.com>
Subject: [PATCH V2] x86/vector: print_APIC_field - use print_hex_dump_debug
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Marc Zyngier <maz@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 21 Sep 2020 19:09:44 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the printk(KERN_DEBUG) / pr_cont uses to print_hex_dump_debug.

Output is now single line with spaces between output u32s.

Signed-off-by: Joe Perches <joe@perches.com>
---
> On Mon, 2020-09-21 at 21:35 +0200, Borislav Petkov wrote:
> Forgot to use checkpatch on your patch:

V2: I've heard of it but rarely use it myself.

 arch/x86/kernel/apic/vector.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index f8a56b5dc29f..fd4b630ac4c1 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1051,16 +1051,16 @@ int lapic_can_unplug_cpu(void)
 #endif /* HOTPLUG_CPU */
 #endif /* SMP */
 
-static void __init print_APIC_field(int base)
+static void __init print_APIC_field(const char *prefix, int base)
 {
 	int i;
+	u32 reads[8];
 
-	printk(KERN_DEBUG);
+	for (i = 0; i < ARRAY_SIZE(reads); i++)
+		reads[i] = apic_read(base + i*0x10);
 
-	for (i = 0; i < 8; i++)
-		pr_cont("%08x", apic_read(base + i*0x10));
-
-	pr_cont("\n");
+	print_hex_dump_debug(prefix, DUMP_PREFIX_NONE, 32, 4,
+			     reads, sizeof(reads), false);
 }
 
 static void __init print_local_APIC(void *dummy)
@@ -1109,12 +1109,9 @@ static void __init print_local_APIC(void *dummy)
 	v = apic_read(APIC_SPIV);
 	pr_debug("... APIC SPIV: %08x\n", v);
 
-	pr_debug("... APIC ISR field:\n");
-	print_APIC_field(APIC_ISR);
-	pr_debug("... APIC TMR field:\n");
-	print_APIC_field(APIC_TMR);
-	pr_debug("... APIC IRR field:\n");
-	print_APIC_field(APIC_IRR);
+	print_APIC_field("... APIC ISR field: ", APIC_ISR);
+	print_APIC_field("... APIC TMR field: ", APIC_TMR);
+	print_APIC_field("... APIC IRR field: ", APIC_IRR);
 
 	/* !82489DX */
 	if (APIC_INTEGRATED(ver)) {

