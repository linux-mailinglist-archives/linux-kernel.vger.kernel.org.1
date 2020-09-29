Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBFC27CB81
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbgI2M2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgI2Lcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:32:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FF2C0613DF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:32:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ead007c081ed47b63bef9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:7c08:1ed4:7b63:bef9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79C2A1EC037C;
        Tue, 29 Sep 2020 13:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601379167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=/NTu5hd5HMffm2LYOAJjPbi5TKLhp6HAg2+yNArjdwc=;
        b=ZJJcQs1U2r2k3yJYuocXMZobfMWzC7gDN33nUvPYFwC5qMHmAd0n8wUL1/CoSD6pFtnRx1
        cOJgXY97eW2OaMpwcdgC7IXkNjp4uMJH8/Q7nDcEDhli2hxpkiD98rZBd+WRsg0Q6NdWIL
        jYfwjTyEF5gNfR8xl+hFI4mDOTO59Nc=
Date:   Tue, 29 Sep 2020 13:32:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>, Rabin Vincent <rabin@rab.in>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] Add RIP to scripts/decodecode
Message-ID: <20200929113238.GC21110@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

how about we add RIP to decodecode output? See below.

I've added the couple of people to Cc who seem to use this thing. The
patch is dirty and needs cleaning still but I think it would be cool to
have the actual addresses in that output so that when you compare with
objdump output in another window, you can find the code very quickly.

You'd need to supply the rIP from the splat, though, as an env var:

$ RIP=0xffffffff8329a927 ./scripts/decodecode < ~/tmp/syz/gfs2.splat
[ 477.379104][T23917] Code: 48 83 ec 28 48 89 3c 24 48 89 54 24 08 e8 c1 b4 4a fe 48 8d bb 00 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 97 05 00 00 48 8b 9b 00 01 00 00 48 85 db 0f 84
Cleaned: [48 83 ec 28 48 89 3c 24 48 89 54 24 08 e8 c1 b4 4a fe 48 8d bb 00 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 97 05 00 00 48 8b 9b 00 01 00 00 48 85 db 0f 84]
Marker: 127
rIP_sub: 42
adj_vma: 0xffffffff8329a8fd
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

Code starting with the faulting instruction
===========================================
ffffffff8329a8fd:       80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
ffffffff8329a901:       0f 85 97 05 00 00       jne    0xffffffff8329ae9e
ffffffff8329a907:       48 8b 9b 00 01 00 00    mov    0x100(%rbx),%rbx
ffffffff8329a90e:       48 85 db                test   %rbx,%rbx
ffffffff8329a911:       0f                      .byte 0xf
ffffffff8329a912:       84                      .byte 0x84

---

diff --git a/scripts/decodecode b/scripts/decodecode
index fbdb325cdf4f..f6b799e3e51a 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -6,6 +6,7 @@
 # options: set env. variable AFLAGS=options to pass options to "as";
 # e.g., to decode an i386 oops on an x86_64 system, use:
 # AFLAGS=--32 decodecode < 386.oops
+# RIP=hex - the rIP the splat points to
 
 cleanup() {
 	rm -f $T $T.s $T.o $T.oo $T.aa $T.dis
@@ -52,6 +53,8 @@ fi
 echo $code
 code=`echo $code | sed -e 's/.*Code: //'`
 
+echo "Cleaned: [$code]"
+
 width=`expr index "$code" ' '`
 width=$((($width-1)/2))
 case $width in
@@ -67,15 +70,19 @@ if [ -z "$ARCH" ]; then
     esac
 fi
 
+# Params: (tmp_file, rip_sub)
 disas() {
-	${CROSS_COMPILE}as $AFLAGS -o $1.o $1.s > /dev/null 2>&1
+	t=$1
+	rip_sub=$2
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
@@ -83,11 +90,19 @@ disas() {
 			type=inst
 		fi
 
-		${CROSS_COMPILE}strip $1.o
+		${CROSS_COMPILE}strip $t.o
+	fi
+
+	if [ $rip_sub -ne 0 ]; then
+		if [ $RIP ]; then
+			adj_vma=$(( $RIP - $rip_sub ))
+			printf "adj_vma: 0x%lx\n" $adj_vma
+			OBJDUMPFLAGS="$OBJDUMPFLAGS --adjust-vma=$adj_vma"
+		fi
 	fi
 
-	${CROSS_COMPILE}objdump $OBJDUMPFLAGS -S $1.o | \
-		grep -v "/tmp\|Disassembly\|\.text\|^$" > $1.dis 2>&1
+	${CROSS_COMPILE}objdump $OBJDUMPFLAGS -S $t.o | \
+		grep -v "/tmp\|Disassembly\|\.text\|^$" > $t.dis 2>&1
 }
 
 marker=`expr index "$code" "\<"`
@@ -95,14 +110,19 @@ if [ $marker -eq 0 ]; then
 	marker=`expr index "$code" "\("`
 fi
 
+
 touch $T.oo
 if [ $marker -ne 0 ]; then
+	echo "Marker: $marker"
+	# 2 opcode bytes and a single space
+	rip_sub=$(( $marker / 3 ))
+	echo "rIP_sub: $rip_sub"
 	echo All code >> $T.oo
 	echo ======== >> $T.oo
 	beforemark=`echo "$code"`
 	echo -n "	.$type 0x" > $T.s
 	echo $beforemark | sed -e 's/ /,0x/g; s/[<>()]//g' >> $T.s
-	disas $T
+	disas $T $rip_sub
 	cat $T.dis >> $T.oo
 	rm -f $T.o $T.s $T.dis
 
@@ -114,7 +134,7 @@ echo =========================================== >> $T.aa
 code=`echo $code | sed -e 's/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
 echo -n "	.$type 0x" > $T.s
 echo $code >> $T.s
-disas $T
+disas $T 0
 cat $T.dis >> $T.aa
 
 # (lines of whole $T.oo) - (lines of $T.aa, i.e. "Code starting") + 3,

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
