Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A477E233A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 22:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgG3Uvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 16:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgG3Uvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:51:35 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F738C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:51:35 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dl10so18875547qvb.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ydEFx7nL1QHetJ3IzZOqahIDDjnqGsyqZ8n++t96BPs=;
        b=h7wTTnVreiKdJy+S3fm1G5Q+3oIaI3sFumAyVhgRi/n9ezm7wRwkGq12SeApvBf77Z
         yX7kGgMRDPif/nTYK3URgcmC1Hxjt9vaylvzFShL86Y577Y6AIKwncRD7f+EY3NuLIgC
         p7gZGl2vcGUf1bULilSS8BokmMppT1Dk6tDPMc2loxDlz/Sj0BwExazMghpSO2ttTSYm
         QZT41EGqN8BUowWyiJBATS4vAbv+FJCk9y9IxDLnYkcJddcQ3rn2W7WaH/CaXUGuKrou
         Q/E6wrfVPA3s3Q8HvtnjIGhotWF6O53G/C61bFtcN5o/TijH9HAU744EsMUgY5wpo+GY
         jLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ydEFx7nL1QHetJ3IzZOqahIDDjnqGsyqZ8n++t96BPs=;
        b=jaUwLhWoYPQ+WAzURTszJpUxA0E6ndeG4dz4XUP3w3WYa6mmJNmc/mTB7voF/7XCXn
         sDmGhRjJ2AIIRwVp+B0jJrtQkWEiE4xxbg9/kd/oqtqOSVCxvmQigwXU6M6TYUqz1f6E
         aJFsW2WvFvv1FJQ4nW5Hu9PXxc7R1qnC00fEBrqZJgkEcW2IX/CLSf1OYhr2Wpge/WF7
         F4aiRzZLBTv5yz4HFh/UEeQy8hdQ3pLcd+fuebVvMDPbOmpQCGEpYTPlcr5sQSrCJK90
         yY5hdnw77Fs6joteM1j75FD31zo+KkkMmtzJZpBu8QkVMZwKRSS7VW07UuVoXIZVKeSI
         9FbQ==
X-Gm-Message-State: AOAM533FrRB8H66QXAsaXuvMEjdJDDXLNHV/5csdm3TlKLhxAeiS2FTi
        Tiet9MXCO9nfnxV5W9OVlHutIhqeqmn5dbXAuZM=
X-Google-Smtp-Source: ABdhPJypnfQMkIkUmhttCt6JJcEy5+kESjzSY6DmkgV227v2mbIs9Wfta5Fz6VMfPMaMbwf8XRvCb9EMykZZanPJTgU=
X-Received: by 2002:a0c:b891:: with SMTP id y17mr1039225qvf.2.1596142294513;
 Thu, 30 Jul 2020 13:51:34 -0700 (PDT)
Date:   Thu, 30 Jul 2020 13:51:11 -0700
In-Reply-To: <20200730205112.2099429-1-ndesaulniers@google.com>
Message-Id: <20200730205112.2099429-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200730205112.2099429-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 3/4] ARM: backtrace-clang: give labels more descriptive names
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Nathan Huckleberry <nhuck15@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        clang-built-linux@googlegroups.com,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Lvqiang Huang <lvqiang.huang@unisoc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the 1004 label; it was neither a control flow target, nor an
instruction we expect to produce a fault.

Gives the labels slightly more readable names. The `b` suffixes are
handy to disambiguate between labels of the same identifier when there's
more than one. Since these labels are unique, let's just give them
names.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/lib/backtrace-clang.S | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
index 40eb2215eaf4..7dad2a6843a5 100644
--- a/arch/arm/lib/backtrace-clang.S
+++ b/arch/arm/lib/backtrace-clang.S
@@ -121,8 +121,8 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
  * start. This value gets updated to be the function start later if it is
  * possible.
  */
-1001:		ldr	sv_pc, [frame, #4]	@ get saved 'pc'
-1002:		ldr	sv_fp, [frame, #0]	@ get saved fp
+load_pc:	ldr	sv_pc, [frame, #4]	@ get saved 'pc'
+load_fp:	ldr	sv_fp, [frame, #0]	@ get saved fp
 
 		teq	sv_fp, mask		@ make sure next frame exists
 		beq	no_frame
@@ -142,7 +142,7 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
  * registers for the current function, but the stacktrace is still printed
  * properly.
  */
-1003:		ldr	sv_lr, [sv_fp, #4]	@ get saved lr from next frame
+load_lr:	ldr	sv_lr, [sv_fp, #4]	@ get saved lr from next frame
 
 		tst	sv_lr, #0		@ If there's no previous lr,
 		beq	finished_setup		@ we're done.
@@ -166,8 +166,7 @@ finished_setup:
 /*
  * Print the function (sv_pc) and where it was called from (sv_lr).
  */
-1004:		mov	r0, sv_pc
-
+		mov	r0, sv_pc
 		mov	r1, sv_lr
 		mov	r2, frame
 		bic	r1, r1, mask		@ mask PC/LR for the mode
@@ -182,7 +181,7 @@ finished_setup:
  * pointer the comparison will fail and no registers will print. Unwinding will
  * continue as if there had been no registers stored in this frame.
  */
-1005:		ldr	r1, [sv_pc, #0]		@ if stmfd sp!, {..., fp, lr}
+load_stmfd:	ldr	r1, [sv_pc, #0]		@ if stmfd sp!, {..., fp, lr}
 		ldr	r3, .Lopcode		@ instruction exists,
 		teq	r3, r1, lsr #11
 		ldr	r0, [frame]		@ locals are stored in
@@ -201,7 +200,7 @@ finished_setup:
 		mov	frame, sv_fp		@ above the current frame
 		bhi	for_each_frame
 
-1006:		adr	r0, .Lbad
+bad_frame:	adr	r0, .Lbad
 		mov	r1, loglvl
 		mov	r2, frame
 		bl	printk
@@ -216,11 +215,10 @@ bad_lr:		mov	sv_fp, #0
 ENDPROC(c_backtrace)
 		.pushsection __ex_table,"a"
 		.align	3
-		.long	1001b, 1006b
-		.long	1002b, 1006b
-		.long	1003b, 1006b
-		.long	1004b, 1006b
-		.long   1005b, 1006b
+		.long	load_pc, bad_frame
+		.long	load_fp, bad_frame
+		.long	load_lr, bad_frame
+		.long	load_stmfd, bad_frame
 		.long	prev_call, bad_lr
 		.popsection
 
-- 
2.28.0.163.g6104cc2f0b6-goog

