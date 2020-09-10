Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA958265301
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgIJV1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:27:44 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:44014 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731099AbgIJOJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:09:48 -0400
Received: by mail-il1-f205.google.com with SMTP id o2so4623850ilg.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zVqSsWX+nI5HXEyIHZ7ZaxwHe+dDtC+0l7LqQAeVjBM=;
        b=Cwa3Rg3U52RM0l29YOh+ZVmKwzefVAlsiDX6jMKaQoCpBtxE+yzu8a7aKdgEeKLKM1
         ul28/kjYifK3sFqcNeTWgO8UeGqVZyHKAbroiBi9sgcDeeHSePwsOGFbZOH7TaTCJZUj
         EU1S8rXBnYiZqir70rH/84j09j3kqShFXOGE2I2oB6q6vC1vNaaTJlFr+iBijld0Dwcm
         RrNqOJPeODAVlUOF6UdDjfmWDawk130ZFn9ag9zIa83PPRCD9hhk81mXj0kCZrr90auq
         FtS4B2Q8ljns7pDgQv/XvmW6UJ5EbfyUH2sgPKXn5jczSHQOiZFAVabIIClH9tLrBkjA
         LRnQ==
X-Gm-Message-State: AOAM533f3B3hGB0xcZhNeiBONRTtVVB2DoCh/7qmep3GfCEbN6rAqH7z
        52L+ooeSsYyj8Jh6sHHqvMwgkEOyOyH6CDu0bqUp4yXV77GZ
X-Google-Smtp-Source: ABdhPJxPWT1Q8/TP1NXh/xIeSW78G9A8i63k6ycgGU/3/OEQZmP1D6dEMJqfScus9pU65THHIFnKDRqW7jtXdrB/AvOYzftXQJOE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e87:: with SMTP id m7mr7487680iow.106.1599746964353;
 Thu, 10 Sep 2020 07:09:24 -0700 (PDT)
Date:   Thu, 10 Sep 2020 07:09:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a7ae505aef61db1@google.com>
Subject: KMSAN: uninit-value in aes_encrypt (4)
From:   syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3b3ea602 x86: add failure injection to get/put/clear_user
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1030dda5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee5f7a0b2e48ed66
dashboard link: https://syzkaller.appspot.com/bug?extid=828dfc12440b4f6f305d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b15055900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12931621900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in subshift lib/crypto/aes.c:149 [inline]
BUG: KMSAN: uninit-value in aes_encrypt+0x12c5/0x1bc0 lib/crypto/aes.c:282
CPU: 0 PID: 8537 Comm: syz-executor872 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 subshift lib/crypto/aes.c:149 [inline]
 aes_encrypt+0x12c5/0x1bc0 lib/crypto/aes.c:282
 aesti_encrypt+0xe8/0x130 crypto/aes_ti.c:31
 cipher_crypt_one crypto/cipher.c:75 [inline]
 crypto_cipher_encrypt_one+0x1e2/0x3a0 crypto/cipher.c:82
 crypto_cbcmac_digest_update+0x3e3/0x560 crypto/ccm.c:830
 crypto_shash_update+0x455/0x5a0 crypto/shash.c:119
 shash_ahash_finup+0x20b/0x7a0 crypto/shash.c:291
 shash_async_finup+0xbb/0x110 crypto/shash.c:306
 crypto_ahash_op+0x1c3/0x770 crypto/ahash.c:370
 crypto_ahash_finup+0x8c/0xb0 crypto/ahash.c:395
 crypto_ccm_auth+0x16b6/0x1780 crypto/ccm.c:221
 crypto_ccm_encrypt+0x285/0x850 crypto/ccm.c:300
 crypto_aead_encrypt+0x107/0x190 crypto/aead.c:94
 tls_do_encryption net/tls/tls_sw.c:528 [inline]
 tls_push_record+0x3cb9/0x4fc0 net/tls/tls_sw.c:762
 bpf_exec_tx_verdict+0x195a/0x29e0 net/tls/tls_sw.c:802
 tls_sw_do_sendpage+0x138a/0x1e30 net/tls/tls_sw.c:1213
 tls_sw_sendpage+0x1da/0x250 net/tls/tls_sw.c:1277
 inet_sendpage+0x1dc/0x2f0 net/ipv4/af_inet.c:828
 kernel_sendpage net/socket.c:3642 [inline]
 sock_sendpage+0x1dc/0x2b0 net/socket.c:945
 pipe_to_sendpage+0x3f4/0x530 fs/splice.c:448
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x5e3/0xff0 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 generic_splice_sendpage+0x1d5/0x2d0 fs/splice.c:834
 do_splice_from fs/splice.c:846 [inline]
 do_splice+0x2727/0x39e0 fs/splice.c:1144
 __do_sys_splice fs/splice.c:1419 [inline]
 __se_sys_splice+0x323/0x500 fs/splice.c:1401
 __x64_sys_splice+0x6e/0x90 fs/splice.c:1401
 do_syscall_64+0xad/0x160 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446a29
Code: Bad RIP value.
RSP: 002b:00007f91f8c0bd98 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dbc48 RCX: 0000000000446a29
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dbc40 R08: 00080000fffffffc R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc4c
R13: 0000000020000680 R14: 00000000004ae948 R15: 20c49ba5e353f7cf

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 __crypto_xor+0x251/0x1610 crypto/algapi.c:1000
 crypto_xor include/crypto/algapi.h:152 [inline]
 crypto_cbcmac_digest_update+0x2b8/0x560 crypto/ccm.c:824
 crypto_shash_update+0x455/0x5a0 crypto/shash.c:119
 shash_ahash_finup+0x20b/0x7a0 crypto/shash.c:291
 shash_async_finup+0xbb/0x110 crypto/shash.c:306
 crypto_ahash_op+0x1c3/0x770 crypto/ahash.c:370
 crypto_ahash_finup+0x8c/0xb0 crypto/ahash.c:395
 crypto_ccm_auth+0x16b6/0x1780 crypto/ccm.c:221
 crypto_ccm_encrypt+0x285/0x850 crypto/ccm.c:300
 crypto_aead_encrypt+0x107/0x190 crypto/aead.c:94
 tls_do_encryption net/tls/tls_sw.c:528 [inline]
 tls_push_record+0x3cb9/0x4fc0 net/tls/tls_sw.c:762
 bpf_exec_tx_verdict+0x195a/0x29e0 net/tls/tls_sw.c:802
 tls_sw_do_sendpage+0x138a/0x1e30 net/tls/tls_sw.c:1213
 tls_sw_sendpage+0x1da/0x250 net/tls/tls_sw.c:1277
 inet_sendpage+0x1dc/0x2f0 net/ipv4/af_inet.c:828
 kernel_sendpage net/socket.c:3642 [inline]
 sock_sendpage+0x1dc/0x2b0 net/socket.c:945
 pipe_to_sendpage+0x3f4/0x530 fs/splice.c:448
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x5e3/0xff0 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 generic_splice_sendpage+0x1d5/0x2d0 fs/splice.c:834
 do_splice_from fs/splice.c:846 [inline]
 do_splice+0x2727/0x39e0 fs/splice.c:1144
 __do_sys_splice fs/splice.c:1419 [inline]
 __se_sys_splice+0x323/0x500 fs/splice.c:1401
 __x64_sys_splice+0x6e/0x90 fs/splice.c:1401
 do_syscall_64+0xad/0x160 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:144
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:269 [inline]
 kmsan_alloc_page+0xc5/0x1a0 mm/kmsan/kmsan_shadow.c:293
 __alloc_pages_nodemask+0xdf0/0x1030 mm/page_alloc.c:4889
 alloc_pages_current+0x685/0xb50 mm/mempolicy.c:2292
 alloc_pages include/linux/gfp.h:545 [inline]
 skb_page_frag_refill+0x540/0x780 net/core/sock.c:2487
 sk_page_frag_refill+0xa3/0x3b0 net/core/sock.c:2507
 sk_msg_alloc+0x26e/0x1340 net/core/skmsg.c:38
 tls_alloc_encrypted_msg net/tls/tls_sw.c:289 [inline]
 tls_sw_do_sendpage+0xb0d/0x1e30 net/tls/tls_sw.c:1191
 tls_sw_sendpage+0x1da/0x250 net/tls/tls_sw.c:1277
 inet_sendpage+0x1dc/0x2f0 net/ipv4/af_inet.c:828
 kernel_sendpage net/socket.c:3642 [inline]
 sock_sendpage+0x1dc/0x2b0 net/socket.c:945
 pipe_to_sendpage+0x3f4/0x530 fs/splice.c:448
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x5e3/0xff0 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 generic_splice_sendpage+0x1d5/0x2d0 fs/splice.c:834
 do_splice_from fs/splice.c:846 [inline]
 do_splice+0x2727/0x39e0 fs/splice.c:1144
 __do_sys_splice fs/splice.c:1419 [inline]
 __se_sys_splice+0x323/0x500 fs/splice.c:1401
 __x64_sys_splice+0x6e/0x90 fs/splice.c:1401
 do_syscall_64+0xad/0x160 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
