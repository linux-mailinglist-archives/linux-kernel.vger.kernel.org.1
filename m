Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFFB287A75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbgJHRAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbgJHRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:00:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4971FC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 10:00:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f21so6531037ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ElqjDD+KuSdGx1ZK3dS8OR8m+3CotQHbgBgwVvlOLiU=;
        b=dhTeWjKmujAAhykiIuX27hxN9iWQeMDHquo4hW7adR8EdZq5nHusM6Y6TsuZZOKmjv
         lZeZXW+8FTAYNVg4S0KlX2XXHMSjXTuk/THx3u7JQfBf+vhqfCDHBW6cYtkpjf6Vakfw
         FhO6zUlpe9aNpVFB5n7SZktHztSlSaVN3NFFCTQ+wL81Qop1UNqJX7I2W+JmrgxK/LuW
         cZt3vWsq6uNe4x4iIzf3kIy73z/W3PRqvs6Pxp7xM0OHf/5+a09QVEzGoasdpWeBXUrv
         O0wuuQZffijfMYDRyKP0S/0p8kMuivkGvMVQ4GSRjc5fEC/ieqflDrhU0ajnZstIMTq4
         S63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ElqjDD+KuSdGx1ZK3dS8OR8m+3CotQHbgBgwVvlOLiU=;
        b=IZ/s1F/Jq5fxE3CAL7KbOATqAbdcJSJgTeNLQoqtis3h/ZPVWb+3kL400z7inKC3R5
         Pn/M1tQ+9Ih8quZJQw7X8gPhdUEEBc0VF1ok6gZDFjtM5fcXuznkLkq0ubW7TU6QLG3W
         wauqeJoN87QqUau58Eq6I6ZDCW7nWsGl0dONZTTqa+IPOywHCvXK8ClZTGdUVghvFspT
         YrmxssnhcxjgAv0MkJUryHiLFrZ5ZnCFmzup24r6DDYTQMq5kGQEpjEWwWz1aF4mXn7w
         a5alpaFnmCQOADyPgi6yT9UN6tEnz3dVw8Oj5JiKWPklbZYYRTVPtFKt3d6eyLpSRuWD
         Q67g==
X-Gm-Message-State: AOAM5312Hbfk6HfWQVU2JqMoJg2459960JjVXQSE5YgASgF4D2eylPaF
        STM67DZJlNRo+5s/jcYOs/djfWvM94ZdHudEjR4=
X-Google-Smtp-Source: ABdhPJwFQUPuMMnbWXVo5ViqQN+uqCnWqG+awPLCPF3SixH5chtCTo+rjAz3OMJDw9yZNpkTwqpJovhk+fkNLQe1Huc=
X-Received: by 2002:a2e:7213:: with SMTP id n19mr3569218ljc.326.1602176412731;
 Thu, 08 Oct 2020 10:00:12 -0700 (PDT)
MIME-Version: 1.0
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Fri, 9 Oct 2020 01:00:03 +0800
Message-ID: <CAFcO6XN=cd=_K_2AY9OL7f+HWsazY-nJ81Ufrw4azvkjj-Mpng@mail.gmail.com>
Subject: UBSAN: array-index-out-of-bounds in dbAdjTree
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I report a array-index-out-of-bounds bug (in linux-5.9.0-rc6) found by
kernel fuzz.

kernel config: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.9.0-rc6-config

and can reproduce.

the dmtree_t is that
typedef union dmtree {
struct dmaptree t1;
struct dmapctl t2;
} dmtree_t;

the dmaptree is that
struct dmaptree {
__le32 nleafs; /* 4: number of tree leafs */
__le32 l2nleafs; /* 4: l2 number of tree leafs */
__le32 leafidx; /* 4: index of first tree leaf */
__le32 height; /* 4: height of the tree */
s8 budmin; /* 1: min l2 tree leaf value to combine */
s8 stree[TREESIZE]; /* TREESIZE: tree */
u8 pad[2]; /* 2: pad to word boundary */
};
the TREESIZE is totally 341, but the leafidx type is __le32.

the crash log is asblow:

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2897:19
index 341 is out of range for type 's8 [341]'
CPU: 1 PID: 10535 Comm: syz-executor.3 Not tainted 5.9.0-rc6+ #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:356
 dbAdjTree+0x34c/0x360 fs/jfs/jfs_dmap.c:2897
 dbAdjCtl+0x2a3/0x830 fs/jfs/jfs_dmap.c:2556
 dbAllocDmap+0xb7/0x110 fs/jfs/jfs_dmap.c:2069
 dbAllocNext+0x35b/0x420 fs/jfs/jfs_dmap.c:1212
 dbAlloc+0x357/0xb60 fs/jfs/jfs_dmap.c:778
 ea_get+0xa54/0x11a0 fs/jfs/xattr.c:514
 __jfs_setxattr+0x1b0/0xfa0 fs/jfs/xattr.c:718
 __jfs_xattr_set+0xc9/0x150 fs/jfs/xattr.c:917
 __vfs_setxattr+0x10e/0x170 fs/xattr.c:177
 __vfs_setxattr_noperm+0x11a/0x4c0 fs/xattr.c:208
 __vfs_setxattr_locked+0x1bf/0x250 fs/xattr.c:266
 vfs_setxattr+0xe5/0x270 fs/xattr.c:283
 setxattr+0x23d/0x330 fs/xattr.c:548
 path_setxattr+0x170/0x190 fs/xattr.c:567
 __do_sys_setxattr fs/xattr.c:582 [inline]
 __se_sys_setxattr fs/xattr.c:578 [inline]
 __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:578
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4693c9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe67df97c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 0000000000739140 RCX: 00000000004693c9
RDX: 00000000200003c0 RSI: 0000000020000100 RDI: 0000000020000140
RBP: 00000000004c291b R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000000c1 R11: 0000000000000246 R12: 000000000076cf20
R13: 0000000000000000 R14: 000000000076cf20 R15: 00007ffc7d66ec90
================================================================================

Regard,
 butt3rflyh4ck.
