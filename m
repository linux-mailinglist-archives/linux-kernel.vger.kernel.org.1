Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3EE2A13BB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 06:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgJaFwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 01:52:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:53377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgJaFwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 01:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604123562;
        bh=QHmh+jZEfMa4F8NVmtrH3nEaOaoMhGYo0JuAnkPmlDw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=aWA0CXwwpO8hCKc6hcwiJb7tt54UsUsepzVUGPWSm9PokTJf5mI8mQGp2kEenEgFC
         4Hwf61lBR8sx2oN7zSud1tPkBFDVrW4sK4tDFfc0o0j9cPA8hHNRbmlb0S//vIwyDn
         b3mpbrcDD9Ef70gLFKkyPXKxQucaKv3gSjbp3fbM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.146.51.69]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv2xO-1kGvso2uGG-00qzqr; Sat, 31
 Oct 2020 06:52:42 +0100
Message-ID: <b4d10b7e3af878ec88bbaccc819c8ba3ec9beb34.camel@gmx.de>
Subject: ltp::mmap05  -->  BUG: using __this_cpu_read() in preemptible
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 31 Oct 2020 06:52:40 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C9DI0gm99FF6DoKBZ6HuvNnlBjvOcA0iyDPpoZJUj5RKYEsgQNM
 QXOoltS8qKndna73EDOgTiElDC5xlJmnzAb2jmzPTaJuXVXfXki0AVhV7C0EgG/7WBzIOwH
 F5mhwno6CNZ5vHTm2lMDWjCAQeO476rUNYfkgz1UwkfGd/mIy4AFGnufv3EUh40XYXoUbJg
 brP4Mx15W7SZxt5r9g+xA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nJqj8PVFrrc=:I3uAVinK31VIDLR0bYauYQ
 lAvI1/2fhsziWZXoU/uMxDCT1dxPREebLueddcCh+Xmtcma1bH6679gSmk5XF3/m1+4ApXdP8
 7hAuEoleVy74t2LDLUB5e/7XRGoTZ3QD+ApPnlvr8HkYXPJnESNnCQSl1YRCLzLhbfO3vvhP+
 JaIldzoF6qLiYBtXsDqjlop23z6YW+92TX8CpDpUN0xW5HKtOmYcJxvb/KGmMN7eQpdDOx3jX
 5fpWD3EUxXDreMKNKou3YOZnXyhcFhZ7TvjOu0t0PM3UKwiLprZmNjwDwYizhf7IrMS+52hp3
 Hg/n6z4LaHRclhmG+ZwV5aS+RqLRLVt5ABQAPWrIPjdq1Ibi/Teo/wS+KSnd69D9WKFsa/w/b
 5oRBoR975+lRfrlhgN/Hcxe3PjUANGYtUaFofR38ydlbauq7TK5nWsk9aqFhPTj9cUHGEOPZ9
 /kxA6lp2Wfw2Wdspk0zGISf8PxbX2JHxqzxX+nqTIMW+jCOYdNBwBbM4jO3G/KeHiTJ4qOGwS
 5XYSf3a+3Gsp6EIfPb6YJMvjNOzV8RPQBGvwL8cX5MzCFza7Ba4HJRGEK2CVmN/+IAH5RmvcN
 5hz0vI/Ab7TjqoQjSU+yHYlJ5FGd0tf/pptBwiJiqd1kCLBNCiuGxKX0O6g7BRCdvETchn5G1
 g1j7+3lFdrxHdrwu+86I4bZ04M3PzAZzSvJ7b75q5d+/HkFN8o9wCuAytQJtdS+P8AluNr+Tz
 tsk+26vRqRJnpoIRDxvUlaUjwD5j90GfHCXrNAx7JnGia2re1N8RSQFSfnmVGYxpsNtgKk/1G
 fhrMnDciX5S/PaxyMlZHgVeaJxEW5y0oDKYLF05fLRGz5MHNz4nX4YGS9SAU4EWuM8ShxPFby
 4wzH8O8gZWL8qMpIPJVA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[  138.620544] BUG: using __this_cpu_read() in preemptible [00000000] code=
: mmap05/4858
[  138.620737] caller is lockdep_hardirqs_on_prepare+0x2f/0x1b0
[  138.620880] CPU: 2 PID: 4858 Comm: mmap05 Kdump: loaded Tainted: G S   =
       E     5.10.0.g07e0887-master #18
[  138.621097] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[  138.621243] Call Trace:
[  138.621330]  dump_stack+0x77/0x97
[  138.621434]  check_preemption_disabled+0xb4/0xc0
[  138.621551]  ? __bad_area_nosemaphore+0x63/0x1e0
[  138.621636]  lockdep_hardirqs_on_prepare+0x2f/0x1b0
[  138.621697]  ? __bad_area_nosemaphore+0x63/0x1e0
[  138.621758]  trace_hardirqs_on+0x33/0xf0
[  138.621813]  __bad_area_nosemaphore+0x63/0x1e0
[  138.621887]  exc_page_fault+0x1a4/0x670
[  138.621956]  ? asm_exc_page_fault+0x8/0x30
[  138.622017]  asm_exc_page_fault+0x1e/0x30
[  138.622073] RIP: 0033:0x403ef6
[  138.622118] Code: 48 83 c0 01 89 15 aa 1f 22 00 0f 84 d7 00 00 00 be 01=
 00 00 00 bf 00 07 62 00 e8 65 fd ff ff 85 c0 75 0a 48 8b 05 da c8 21 00 <=
0f> b6 00 8b 05 c9 c8 21 00 85 c0 74 43 b9 49 4e 41 00 31 d2 be 6e
[  138.622314] RSP: 002b:00007fff18c776e0 EFLAGS: 00010246
[  138.622384] RAX: 00007faf439cc000 RBX: 0000000000000003 RCX: 00007faf43=
2077d0
[  138.622466] RDX: 0000000000620748 RSI: 0000000000000001 RDI: 0000000000=
000000
[  138.622547] RBP: 00007faf4397f6c0 R08: 0000000000000003 R09: 0000000000=
000000
[  138.622628] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000=
4040a0
[  138.622709] R13: 00007fff18c777e0 R14: 0000000000000000 R15: 0000000000=
000000
[  138.622840] BUG: using __this_cpu_read() in preemptible [00000000] code=
: mmap05/4858
[  138.622931] caller is lockdep_hardirqs_on+0x38/0x110
[  138.622994] CPU: 2 PID: 4858 Comm: mmap05 Kdump: loaded Tainted: G S   =
       E     5.10.0.g07e0887-master #18
[  138.623102] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[  138.623184] Call Trace:
[  138.623234]  dump_stack+0x77/0x97
[  138.623292]  check_preemption_disabled+0xb4/0xc0
[  138.623355]  ? __bad_area_nosemaphore+0x63/0x1e0
[  138.623422]  lockdep_hardirqs_on+0x38/0x110
[  138.623484]  __bad_area_nosemaphore+0x63/0x1e0
[  138.623561]  exc_page_fault+0x1a4/0x670
[  138.623630]  ? asm_exc_page_fault+0x8/0x30
[  138.623695]  asm_exc_page_fault+0x1e/0x30
[  138.623751] RIP: 0033:0x403ef6
[  138.623797] Code: 48 83 c0 01 89 15 aa 1f 22 00 0f 84 d7 00 00 00 be 01=
 00 00 00 bf 00 07 62 00 e8 65 fd ff ff 85 c0 75 0a 48 8b 05 da c8 21 00 <=
0f> b6 00 8b 05 c9 c8 21 00 85 c0 74 43 b9 49 4e 41 00 31 d2 be 6e
[  138.623993] RSP: 002b:00007fff18c776e0 EFLAGS: 00010246
[  138.624065] RAX: 00007faf439cc000 RBX: 0000000000000003 RCX: 00007faf43=
2077d0
[  138.624150] RDX: 0000000000620748 RSI: 0000000000000001 RDI: 0000000000=
000000
[  138.624235] RBP: 00007faf4397f6c0 R08: 0000000000000003 R09: 0000000000=
000000
[  138.624319] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000=
4040a0
[  138.624404] R13: 00007fff18c777e0 R14: 0000000000000000 R15: 0000000000=
000000
   A.

