Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A052ACB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 04:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgKJDUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 22:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729243AbgKJDUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604978405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fComietV2Xy04Op2oaFnL4e3cxl53kC87DE99e9O/4M=;
        b=a7quuinmZcV9svrRM6V1yxx7Z46DtQ3TYO6nmvFAuSmvoWD5XiJzb3lHxCvXEc1XLIL9/f
        a+LmWKkgIFjO8QdFIef17J3O9TkFXnuRPijJUkD7/RP5UWCx9ArvC2sj+vJ/9MDylqTjgU
        zz5HPO5Z10XL5IoNrTNyR4d8PrvAFUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-ir4H9PqMNWuGzwx5fvkkjg-1; Mon, 09 Nov 2020 22:20:00 -0500
X-MC-Unique: ir4H9PqMNWuGzwx5fvkkjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92897809DD6;
        Tue, 10 Nov 2020 03:19:59 +0000 (UTC)
Received: from treble (ovpn-112-15.rdu2.redhat.com [10.10.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 515525C1D0;
        Tue, 10 Nov 2020 03:19:58 +0000 (UTC)
Date:   Mon, 9 Nov 2020 21:19:55 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201110031955.flxf7iq5yoxjzmsg@treble>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201106180628.r4emdw3yoxfzryzu@treble>
 <20201109091037.6upb63tclk4nhvl7@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201109091037.6upb63tclk4nhvl7@shindev.dhcp.fujisawa.hgst.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 09:10:38AM +0000, Shinichiro Kawasaki wrote:
> On Nov 06, 2020 / 12:06, Josh Poimboeuf wrote:
> > On Fri, Nov 06, 2020 at 06:04:15AM +0000, Shinichiro Kawasaki wrote:
> > > Greetings,
> > > 
> > > I observe "WARNING: can't access registers at asm_common_interrupt+0x1e/0x40"
> > > in my kernel test system repeatedly, which is printed by unwind_next_frame() in
> > > "arch/x86/kernel/unwind_orc.c". Syzbot already reported that [1]. Similar
> > > warning was reported and discussed [2], but I suppose the cause is not yet
> > > clarified.
> > > 
> > > The warning was observed with v5.10-rc2 and older tags. I bisected and found
> > > that the commit 044d0d6de9f5 ("lockdep: Only trace IRQ edges") in v5.9-rc3
> > > triggered the warning. Reverting that from 5.10-rc2, the warning disappeared.
> > > May I ask comment by expertise on CC how this commit can relate to the warning?
> > > 
> > > The test condition to reproduce the warning is rather unique (blktests,
> > > dm-linear and ZNS device emulation by QEMU). If any action is suggested for
> > > further analysis, I'm willing to take it with my test system.
> > 
> > Hi,
> > 
> > Thanks for reporting this issue.  This might be a different issue from
> > [2].
> > 
> > Can you send me the arch/x86/entry/entry_64.o file from your build?
> 
> Hi Josh, thank you for your response. As a separated e-mail, I have sent the
> entry_64.o only to your address, since I hesitate to send around the 76kb
> attachment file to LKML. In case it does not reach to you, please let me know.

Got it, thanks.  Unfortunately I'm still confused.

Can you test with the following patch, and boot with 'unwind_debug'?
That should hopefully dump a lot of useful data along with the warning.

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/unwind/orc: Add 'unwind_debug' cmdline option

Sometimes the one-line ORC unwinder warnings aren't very helpful.  Add a
new 'unwind_debug' cmdline option which will dump the full stack
contents of the current task when an error condition is encountered.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 arch/x86/kernel/unwind_orc.c                  | 48 ++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..4bed92c51723 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5512,6 +5512,12 @@
 	unknown_nmi_panic
 			[X86] Cause panic on unknown NMI.
 
+	unwind_debug	[X86-64]
+			Enable unwinder debug output.  This can be
+			useful for debugging certain unwinder error
+			conditions, including corrupt stacks and
+			bad/missing unwinder metadata.
+
 	usbcore.authorized_default=
 			[USB] Default USB device authorization:
 			(default -1 = authorized except for wireless USB,
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 73f800100066..44bae03f9bfc 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -13,8 +13,13 @@
 
 #define orc_warn_current(args...)					\
 ({									\
-	if (state->task == current)					\
+	static bool dumped_before;					\
+	if (state->task == current) {					\
 		orc_warn(args);						\
+		if (unwind_debug && !dumped_before)			\
+			unwind_dump(state);				\
+		dumped_before = true;					\
+	}								\
 })
 
 extern int __start_orc_unwind_ip[];
@@ -23,8 +28,49 @@ extern struct orc_entry __start_orc_unwind[];
 extern struct orc_entry __stop_orc_unwind[];
 
 static bool orc_init __ro_after_init;
+static bool unwind_debug __ro_after_init;
 static unsigned int lookup_num_blocks __ro_after_init;
 
+static int __init unwind_debug_cmdline(char *str)
+{
+	unwind_debug = true;
+
+	return 0;
+}
+early_param("unwind_debug", unwind_debug_cmdline);
+
+static void unwind_dump(struct unwind_state *state)
+{
+	static bool dumped_before;
+	unsigned long word, *sp;
+	struct stack_info stack_info = {0};
+	unsigned long visit_mask = 0;
+
+	if (dumped_before)
+		return;
+
+	dumped_before = true;
+
+	printk_deferred("unwind stack type:%d next_sp:%p mask:0x%lx graph_idx:%d\n",
+			state->stack_info.type, state->stack_info.next_sp,
+			state->stack_mask, state->graph_idx);
+
+	for (sp = __builtin_frame_address(0); sp;
+	     sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+		if (get_stack_info(sp, state->task, &stack_info, &visit_mask))
+			break;
+
+		for (; sp < stack_info.end; sp++) {
+
+			word = READ_ONCE_NOCHECK(*sp);
+
+			printk_deferred("%0*lx: %0*lx (%pB)\n", BITS_PER_LONG/4,
+					(unsigned long)sp, BITS_PER_LONG/4,
+					word, (void *)word);
+		}
+	}
+}
+
 static inline unsigned long orc_ip(const int *ip)
 {
 	return (unsigned long)ip + *ip;
-- 
2.25.4

