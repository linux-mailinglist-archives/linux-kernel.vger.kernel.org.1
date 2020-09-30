Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2705527E77E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgI3LO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:14:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgI3LO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:14:28 -0400
Received: from zn.tnic (p200300ec2f092a005c3b806e425f5e5c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2a00:5c3b:806e:425f:5e5c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87E181EC0288;
        Wed, 30 Sep 2020 13:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601464466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aPWYZ1q3fOniefLzk7p2xWmEpeprxPWws28KMdGZwOA=;
        b=CVdgttPkl8cmlGmITfxVjU80f3bmKxANJbREmrGNjEY2uNpVjrNh8w8wvIh4Fa90jUhZ8x
        DZ2HLzEImmqJH0/s0EsXZhkjyJ3n7HThy9MygJlLQLG+yB851PmOahm3zWSUbmIJC5vDRT
        48jY8Xvxdh9uIUwBS9fVA5vGk/82tnI=
Date:   Wed, 30 Sep 2020 13:14:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marc Zyngier <maz@misterjones.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Rabin Vincent <rabin@rab.in>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] scripts/decodecode: Add the capability to supply the program
 counter
Message-ID: <20200930111416.GF6810@zn.tnic>
References: <20200929113238.GC21110@zn.tnic>
 <b18c145f7b96cace7cd503de33c08311@misterjones.org>
 <20200929132255.GE21110@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200929132255.GE21110@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>
Date: Tue, 29 Sep 2020 18:45:56 +0200

... so that comparing with objdump output from vmlinux can ease
pinpointing where the trapping instruction actually is. An example is
better than a thousand words:

  $ PC=0xffffffff8329a927 ./scripts/decodecode < ~/tmp/syz/gfs2.splat
  [ 477.379104][T23917] Code: 48 83 ec 28 48 89 3c 24 48 89 54 24 08 e8 c1 b4 4a fe 48 8d bb 00 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 97 05 00 00 48 8b 9b 00 01 00 00 48 85 db 0f 84
  All code
  ========
  ffffffff8329a8fd:       48 83 ec 28             sub    $0x28,%rsp
  ffffffff8329a901:       48 89 3c 24             mov    %rdi,(%rsp)
  ffffffff8329a905:       48 89 54 24 08          mov    %rdx,0x8(%rsp)
  ffffffff8329a90a:       e8 c1 b4 4a fe          callq  0xffffffff81745dd0
  ffffffff8329a90f:       48 8d bb 00 01 00 00    lea    0x100(%rbx),%rdi
  ffffffff8329a916:       48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
  ffffffff8329a91d:       fc ff df
  ffffffff8329a920:       48 89 fa                mov    %rdi,%rdx
  ffffffff8329a923:       48 c1 ea 03             shr    $0x3,%rdx
  ffffffff8329a927:*      80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)               <-- trapping instruction
  ffffffff8329a92b:       0f 85 97 05 00 00       jne    0xffffffff8329aec8
  ffffffff8329a931:       48 8b 9b 00 01 00 00    mov    0x100(%rbx),%rbx
  ffffffff8329a938:       48 85 db                test   %rbx,%rbx
  ffffffff8329a93b:       0f                      .byte 0xf
  ffffffff8329a93c:       84                      .byte 0x84

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200929113238.GC21110@zn.tnic
---
 scripts/decodecode | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/scripts/decodecode b/scripts/decodecode
index fbdb325cdf4f..31d884e35f2f 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -6,6 +6,7 @@
 # options: set env. variable AFLAGS=options to pass options to "as";
 # e.g., to decode an i386 oops on an x86_64 system, use:
 # AFLAGS=--32 decodecode < 386.oops
+# PC=hex - the PC (program counter) the oops points to
 
 cleanup() {
 	rm -f $T $T.s $T.o $T.oo $T.aa $T.dis
@@ -67,15 +68,19 @@ if [ -z "$ARCH" ]; then
     esac
 fi
 
+# Params: (tmp_file, pc_sub)
 disas() {
-	${CROSS_COMPILE}as $AFLAGS -o $1.o $1.s > /dev/null 2>&1
+	t=$1
+	pc_sub=$2
+
+	${CROSS_COMPILE}as $AFLAGS -o $t.o $t.s > /dev/null 2>&1
 
 	if [ "$ARCH" = "arm" ]; then
 		if [ $width -eq 2 ]; then
 			OBJDUMPFLAGS="-M force-thumb"
 		fi
 
-		${CROSS_COMPILE}strip $1.o
+		${CROSS_COMPILE}strip $t.o
 	fi
 
 	if [ "$ARCH" = "arm64" ]; then
@@ -83,11 +88,18 @@ disas() {
 			type=inst
 		fi
 
-		${CROSS_COMPILE}strip $1.o
+		${CROSS_COMPILE}strip $t.o
 	fi
 
-	${CROSS_COMPILE}objdump $OBJDUMPFLAGS -S $1.o | \
-		grep -v "/tmp\|Disassembly\|\.text\|^$" > $1.dis 2>&1
+	if [ $pc_sub -ne 0 ]; then
+		if [ $PC ]; then
+			adj_vma=$(( $PC - $pc_sub ))
+			OBJDUMPFLAGS="$OBJDUMPFLAGS --adjust-vma=$adj_vma"
+		fi
+	fi
+
+	${CROSS_COMPILE}objdump $OBJDUMPFLAGS -S $t.o | \
+		grep -v "/tmp\|Disassembly\|\.text\|^$" > $t.dis 2>&1
 }
 
 marker=`expr index "$code" "\<"`
@@ -95,14 +107,17 @@ if [ $marker -eq 0 ]; then
 	marker=`expr index "$code" "\("`
 fi
 
+
 touch $T.oo
 if [ $marker -ne 0 ]; then
+	# 2 opcode bytes and a single space
+	pc_sub=$(( $marker / 3 ))
 	echo All code >> $T.oo
 	echo ======== >> $T.oo
 	beforemark=`echo "$code"`
 	echo -n "	.$type 0x" > $T.s
 	echo $beforemark | sed -e 's/ /,0x/g; s/[<>()]//g' >> $T.s
-	disas $T
+	disas $T $pc_sub
 	cat $T.dis >> $T.oo
 	rm -f $T.o $T.s $T.dis
 
@@ -114,7 +129,7 @@ echo =========================================== >> $T.aa
 code=`echo $code | sed -e 's/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
 echo -n "	.$type 0x" > $T.s
 echo $code >> $T.s
-disas $T
+disas $T 0
 cat $T.dis >> $T.aa
 
 # (lines of whole $T.oo) - (lines of $T.aa, i.e. "Code starting") + 3,
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
