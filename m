Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF52B4D18
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbgKPRdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:33:47 -0500
Received: from m12-15.163.com ([220.181.12.15]:54057 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730530AbgKPRdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=gaBXx
        82WVsWKkR6CZlkmjRMLTicfHqGEOrLTe7VIbfg=; b=pag0mhG49oRfdTNPMjMev
        mplvPEThQCGBI+t9cP61CJocpUVfKt1J79dlL9sFIYvJl3SG1oy4vhjiBZrS050V
        JPPOkIv1MT55Q+ivUKD7TjjiD4bxswopUDaHcUqFdieYu1/Qew+2q/Q9r94rBJwt
        vV3a1bGIGBhEFzyo1Y5kw4=
Received: from [192.168.0.103] (unknown [120.229.59.172])
        by smtp11 (Coremail) with SMTP id D8CowABXp0Ojt7JfVhHGBQ--.41963S3;
        Tue, 17 Nov 2020 01:32:22 +0800 (CST)
Subject: Re: [lib] 6ee736dc92: BUG:unable_to_handle_page_fault_for_address
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        0day robot <lkp@intel.com>, lkp@lists.01.org
References: <20201112064531.GB17067@xsang-OptiPlex-9020>
From:   Zhaoxiu Zeng <zengzhaoxiu@163.com>
Message-ID: <30a3c75c-972e-5fe9-ab46-dde7fd57e0d8@163.com>
Date:   Tue, 17 Nov 2020 01:32:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201112064531.GB17067@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowABXp0Ojt7JfVhHGBQ--.41963S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFWDZr1Dtw1kCFWkZFyUtrb_yoW3Xw1UpF
        1Sk3yakr40gryUAa4Iy3W0yryDtrs3CFWDJry7JF48ZF13Crn5ur15JrnY9Fy7Xrn2gFy7
        CwsIyr1DtFWrAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jLL0nUUUUU=
X-Originating-IP: [120.229.59.172]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/1tbiowbegFUMU1PTegAAsL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/11/12 14:45, kernel test robot 写道:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 6ee736dc922a5f81a3a60a72a54ec9392ccfe787 ("[PATCH 2/3] lib: zlib_inflate: improves decompression performance")
> url: https://github.com/0day-ci/linux/commits/zengzhaoxiu-163-com/lib-Introduce-copy_from_back/20201110-033522
> base: https://git.kernel.org/cgit/linux/kernel/git/soc/soc.git for-next
> 
> in testcase: nvml
> version: nvml-x86_64-9a558d859-1_20201111
> with following parameters:
> 
> 	test: pmem
> 	group: util
> 	nr_pmem: 1
> 	fs: ext4
> 	mount_option: dax
> 	bp_memmap: 32G!4G
> 	ucode: 0x7000019
> 
> 
> 
> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 48G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [    5.134501] BUG: unable to handle page fault for address: ffff88880249a4bf
> [    5.134783] #PF: supervisor read access in kernel mode
> [    5.134783] #PF: error_code(0x0000) - not-present page
> [    5.134783] PGD c7f401067 P4D c7f401067 PUD 0 
> [    5.134783] Oops: 0000 [#1] SMP PTI
> [    5.134783] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1-00071-g6ee736dc922a #1
> [    5.134783] Hardware name: Supermicro SYS-5018D-FN4T/X10SDV-8C-TLN4F, BIOS 1.1 03/02/2016
> [    5.134783] RIP: 0010:inflate_fast+0x474/0x600
> [    5.134783] Code: cc fd ff ff 48 c7 43 30 e5 6d 5a 82 c7 07 1b 00 00 00 e9 ff fc ff ff 48 c7 43 30 cf 6d 5a 82 c7 07 1b 00 00 00 e9 ec fc ff ff <0f> b6 09 48 83 ed 01 49 83 c0 01 41 88 48 ff 48 83 fd 01 76 3f 44
> [    5.134783] RSP: 0000:ffffc90000047c38 EFLAGS: 00010246
> [    5.134783] RAX: 000000000000000d RBX: ffff888901886780 RCX: ffff88880249a4bf
> [    5.134783] RDX: ffffffff0001a4bd RSI: 0000000000000006 RDI: ffff888902490000
> [    5.134783] RBP: 0000000000000007 R08: ffff888902480002 R09: 0000000000000001
> [    5.134783] R10: ffff888902490548 R11: ffff888c5af6a3bf R12: 00000000fffe5b43
> [    5.134783] R13: 0000000000000007 R14: ffff888c7c9ffe23 R15: ffff888902490ef0
> [    5.134783] FS:  0000000000000000(0000) GS:ffff888c7fa00000(0000) knlGS:0000000000000000
> [    5.134783] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.134783] CR2: ffff88880249a4bf CR3: 0000000c7e20a001 CR4: 00000000003706f0
> [    5.134783] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    5.134783] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    5.134783] Call Trace:
> [    5.134783]  zlib_inflate+0x99a/0x1780
> [    5.134783]  ? do_copy+0xe3/0x103
> [    5.134783]  ? write_buffer+0x37/0x37
> [    5.134783]  ? initrd_load+0x3f/0x3f
> [    5.134783]  ? write_buffer+0x37/0x37
> [    5.134783]  __gunzip+0x242/0x30c
> [    5.134783]  ? bunzip2+0x39d/0x39d
> [    5.134783]  ? __gunzip+0x30c/0x30c
> [    5.134783]  gunzip+0xe/0x11
> [    5.134783]  ? initrd_load+0x3f/0x3f
> [    5.134783]  unpack_to_rootfs+0x17d/0x2c1
> [    5.134783]  ? initrd_load+0x3f/0x3f
> [    5.134783]  ? do_copy+0x103/0x103
> [    5.134783]  populate_rootfs+0x59/0x109
> [    5.134783]  ? do_copy+0x103/0x103
> [    5.134783]  do_one_initcall+0x44/0x200
> [    5.134783]  kernel_init_freeable+0x1da/0x241
> [    5.134783]  ? rest_init+0xd0/0xd0
> [    5.134783]  kernel_init+0xa/0x110
> [    5.134783]  ret_from_fork+0x22/0x30
> [    5.134783] Modules linked in:
> [    5.134783] CR2: ffff88880249a4bf
> [    5.134783] ---[ end trace a0a85397603c3dac ]---
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> 
> 
> Thanks,
> Oliver Sang
> 

It's not common for copying from the window.
This new patch maybe fix the bug, I build the fedora33's kernel and started it successfully.


Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
---
 lib/zlib_inflate/inffast.c | 115 ++++++-------------------------------
 1 file changed, 19 insertions(+), 96 deletions(-)

diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index ed1f3df27260..8c9cc928cf71 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -4,29 +4,13 @@
  */
 
 #include <linux/zutil.h>
+#include <asm/copy_from_back.h>
 #include "inftrees.h"
 #include "inflate.h"
 #include "inffast.h"
 
 #ifndef ASMINF
 
-union uu {
-	unsigned short us;
-	unsigned char b[2];
-};
-
-/* Endian independed version */
-static inline unsigned short
-get_unaligned16(const unsigned short *p)
-{
-	union uu  mm;
-	unsigned char *b = (unsigned char *)p;
-
-	mm.b[0] = b[0];
-	mm.b[1] = b[1];
-	return mm.us;
-}
-
 /*
    Decode literal, length, and distance codes and write out the resulting
    literal and match bytes until either not enough input or output is
@@ -177,52 +161,34 @@ void inflate_fast(z_streamp strm, unsigned start)
                 hold >>= op;
                 bits -= op;
                 op = (unsigned)(out - beg);     /* max distance in output */
-                if (dist > op) {                /* see if copy from window */
+                if (unlikely(dist > op)) {      /* see if copy from window */
                     op = dist - op;             /* distance back in window */
                     if (op > whave) {
                         strm->msg = (char *)"invalid distance too far back";
                         state->mode = BAD;
                         break;
                     }
-                    from = window;
-                    if (write == 0) {           /* very common case */
-                        from += wsize - op;
-                        if (op < len) {         /* some from window */
-                            len -= op;
-                            do {
-                                *out++ = *from++;
-                            } while (--op);
-                            from = out - dist;  /* rest from output */
-                        }
-                    }
-                    else if (write < op) {      /* wrap around window */
-                        from += wsize + write - op;
-                        op -= write;
-                        if (op < len) {         /* some from end of window */
-                            len -= op;
-                            do {
-                                *out++ = *from++;
-                            } while (--op);
-                            from = window;
-                            if (write < len) {  /* some from start of window */
-                                op = write;
+                    from = window + write - op;
+                    if (write < op) {           /* very common case */
+                        from += wsize;
+                        if (write) {            /* wrap around window */
+                            op -= write;
+                            if (op < len) {     /* some from end of window */
                                 len -= op;
                                 do {
                                     *out++ = *from++;
                                 } while (--op);
-                                from = out - dist;      /* rest from output */
+                                from = window;  /* some from start of window */
+                                op = write;
                             }
                         }
                     }
-                    else {                      /* contiguous in window */
-                        from += write - op;
-                        if (op < len) {         /* some from window */
-                            len -= op;
-                            do {
-                                *out++ = *from++;
-                            } while (--op);
-                            from = out - dist;  /* rest from output */
-                        }
+                    if (op < len) {             /* some from window */
+                        len -= op;
+                        do {
+                            *out++ = *from++;
+                        } while (--op);
+                        from = out - dist;      /* rest from output */
                     }
                     while (len > 2) {
                         *out++ = *from++;
@@ -235,52 +201,9 @@ void inflate_fast(z_streamp strm, unsigned start)
                         if (len > 1)
                             *out++ = *from++;
                     }
-                }
-                else {
-		    unsigned short *sout;
-		    unsigned long loops;
-
-                    from = out - dist;          /* copy direct from output */
-		    /* minimum length is three */
-		    /* Align out addr */
-		    if (!((long)(out - 1) & 1)) {
-			*out++ = *from++;
-			len--;
-		    }
-		    sout = (unsigned short *)(out);
-		    if (dist > 2) {
-			unsigned short *sfrom;
-
-			sfrom = (unsigned short *)(from);
-			loops = len >> 1;
-			do
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-			    *sout++ = *sfrom++;
-#else
-			    *sout++ = get_unaligned16(sfrom++);
-#endif
-			while (--loops);
-			out = (unsigned char *)sout;
-			from = (unsigned char *)sfrom;
-		    } else { /* dist == 1 or dist == 2 */
-			unsigned short pat16;
-
-			pat16 = *(sout-1);
-			if (dist == 1) {
-				union uu mm;
-				/* copy one char pattern to both bytes */
-				mm.us = pat16;
-				mm.b[0] = mm.b[1];
-				pat16 = mm.us;
-			}
-			loops = len >> 1;
-			do
-			    *sout++ = pat16;
-			while (--loops);
-			out = (unsigned char *)sout;
-		    }
-		    if (len & 1)
-			*out++ = *from++;
+                } else {
+                    /* copy direct from output */
+                    out = copy_from_back(out, dist, len);
                 }
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
-- 
2.28.0


