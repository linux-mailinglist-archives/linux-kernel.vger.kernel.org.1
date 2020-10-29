Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A71E29EAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgJ2Lty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:49:54 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:37021 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2Ltx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:49:53 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id 5FA4820136;
        Thu, 29 Oct 2020 12:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1603972191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJT3j/NIWLP4R0ukUYUh1MfJEJRI4an9G0Vrqmy4RVg=;
        b=hUHncc8JlqXGt6AhgKtNO7VBm+Z2X//HaONzD0CgCWlqnstOVZmQfYiOQJfv/wV7t2OOXB
        A1EIMIqggK4wUB9bgDb3nGjR9ehHK1bJTyuVmB4SqfEog/XkrHeWMj5yMtc1yKYJmisliD
        PpEzs6cSvHAjjcESXKL9oIBAC6zb2gGUg44/lPYkqX7WIlwtFVVbS54zlhYxRIeFPOwIWS
        5QwZWWM4bwddCIz0xsARlnKVqS/xdzArFh/NRJVX2LNhb55uTtsc2fnf3ghGjFioKb7jTm
        fhccHrbLcShBFiosp44HlaEGvq9av7b6Uml188DNVn3M5DjhDrAtPs5gkJzTKQ==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Thu, 29 Oct
 2020 12:49:50 +0100
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.2106.002; Thu, 29 Oct 2020 12:49:50 +0100
From:   Walter Harms <wharms@bfs.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>
Subject: AW: [PATCH] x86/unwind: remove unneeded initialization
Thread-Topic: [PATCH] x86/unwind: remove unneeded initialization
Thread-Index: AQHWrZZp9P4B5XWLnkejzPAeNoVG0Kmudb7J
Date:   Thu, 29 Oct 2020 11:49:50 +0000
Message-ID: <a28022479f594650a6d98adac3c4a6f0@bfs.de>
References: <20201028122102.24202-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20201028122102.24202-1-lukas.bulwahn@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
x-tm-as-product-ver: SMEX-14.0.0.3031-8.6.1012-25754.006
x-tm-as-result: No-10--0.988400-5.000000
x-tmase-matchedrid: TE7h93R7O3jRubRCcrbc5pzEHTUOuMX33dCmvEa6IiGoLZarzrrPmeb5
        gCbPfcioIC52rSBOy+gmQDJE1lzoKPGU4m5A0eV9z1H9SpactbiNY/pqxovzxYN0CMTKQ9ev/9W
        PA4ZFFzrZjNZ12FSpFs8bFMQN3nGuMyy9eqWWzjvThGbP9qB93DjHtx4N53dRVsObDLfVQsThCQ
        UB+puAZk12Dax6d5UQxBbcGLES8TueTWqY85I+X7oLyaVI8w2XWDLajM22ETZLxCuBTCXaKrCza
        +U6obX487yjVwmj7q2zCx0lbV31dsxAixoJws1YA9lly13c/gHYuVu0X/rOkKcxvibtoCq3HP39
        F6H4hveqHvcnMH4C7u9EJt2F5Oksv1l2Uvx6idoLbigRnpKlKZx+7GyJjhAUOLgvIsXATHC2ohu
        Rgjqs900g0pBwme1+LRFzqCTzDFDuvr+O/VqMU6mrjuLrmYul6A2mBlkBcjqN9FRlnbL3hF5MAv
        x/fsUBxutS1t8Wq0GIonbnNHgEwM/qYWYfQTGnSQOPumGIku0fwV6sBPR0lg==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--0.988400-5.000000
x-tmase-version: SMEX-14.0.0.3031-8.6.1012-25754.006
x-tm-snts-smtp: 1946DC9CBA21DAD32119240325D8B1EA458CA5236B8211B1D739423198A805262000:9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=1.46
X-Spam-Level: *
Authentication-Results: mx01-sz.bfs.de;
        none
X-Spamd-Result: default: False [1.46 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_MATCH_FROM(0.00)[];
         URIBL_BLOCKED(0.00)[googlegroups.com:email,elisa.tech:email];
         DKIM_SIGNED(0.00)[];
         BAYES_HAM(-0.04)[58.60%];
         RCPT_COUNT_TWELVE(0.00)[14];
         NEURAL_HAM(-0.00)[-1.012];
         FREEMAIL_TO(0.00)[gmail.com,linutronix.de,redhat.com,alien8.de,kernel.org];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[zytor.com,infradead.org,gmail.com,google.com,vger.kernel.org,googlegroups.com,lists.elisa.tech];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this looks like a reimplementation of bsearch()
perhaps the maintainer can add a comment why the=20
kernel implementation is not suitable here ?


jm2c
wh

________________________________________
Von: Lukas Bulwahn [lukas.bulwahn@gmail.com]
Gesendet: Mittwoch, 28. Oktober 2020 13:21
An: Thomas Gleixner; Ingo Molnar; Borislav Petkov; Josh Poimboeuf; x86@kern=
el.org
Cc: H . Peter Anvin; Peter Zijlstra; Nathan Chancellor; Nick Desaulniers; l=
inux-kernel@vger.kernel.org; clang-built-linux@googlegroups.com; kernel-jan=
itors@vger.kernel.org; linux-safety@lists.elisa.tech; Lukas Bulwahn
Betreff: [PATCH] x86/unwind: remove unneeded initialization

make clang-analyzer on x86_64 defconfig caught my attention with:

  arch/x86/kernel/unwind_orc.c:38:7: warning: Value stored to 'mid' during
  its initialization is never read [clang-analyzer-deadcode.DeadStores]
          int *mid =3D first, *found =3D first;
               ^

Commit ee9f8fce9964 ("x86/unwind: Add the ORC unwinder") introduced
__orc_find() with this unneeded dead-store initialization.

Put the variable in local scope and initialize only once the value is
needed to make clang-analyzer happy.

As compilers will detect this unneeded assignment and optimize this
anyway, the resulting object code is effectively identical before and
after this change.

No functional change. Effectively, no change to object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201028

Josh, please ack.
Ingo, Borislav, please pick this minor non-urgent clean-up patch.

 arch/x86/kernel/unwind_orc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 6a339ce328e0..5c64eed08257 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -35,7 +35,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct=
 orc_entry *u_table,
 {
        int *first =3D ip_table;
        int *last =3D ip_table + num_entries - 1;
-       int *mid =3D first, *found =3D first;
+       int *found =3D first;

        if (!num_entries)
                return NULL;
@@ -47,7 +47,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct=
 orc_entry *u_table,
         * ignored when they conflict with a real entry.
         */
        while (first <=3D last) {
-               mid =3D first + ((last - first) / 2);
+               int *mid =3D first + ((last - first) / 2);

                if (orc_ip(mid) <=3D ip) {
                        found =3D mid;
--
2.17.1

