Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06A22F6E74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbhANWox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730781AbhANWov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:44:51 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C1EC061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:43:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o13so10421238lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l1d2nvjFKMdXQytwoO5LRen1nyfBChU0wfrT0E5nnt4=;
        b=LWY4pTTSzl3f5neUGxITtPPItV0ulV+JaV1ZrQu/pNgOsXwoxxiMjyx/cIpSuuRsNf
         yM4LMY1Hyba27MfTe5ZSxIWAmFHxPsOPfr30P1+8bsFjNWcJaco1tTC+0JdyBBf/zkDn
         KkfH27ScehAcARLYPkDOtsFyHdqFW1kdcJglugmsYLQiUiQluR5qPw0pcAHexBbmHbvr
         kDdp9X8CCshGijeuqF8fpm9AY4QyCeWN3kvSLbf3w2XDnaxdLB67l0+XNj8IRwV2DFc4
         Vbwrwnl6VwFfU6cfvJh4vWJfE5iaV9/3Y2kDiPlB0SMNAaREjG5sQQHLgSpmehOkASOY
         UThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l1d2nvjFKMdXQytwoO5LRen1nyfBChU0wfrT0E5nnt4=;
        b=GXT2lLXBNlCqASwKXN6tzFUEjsta83eN5fMxMydRWvlhEgU8RBKvvFxHD7VEWjmCrI
         OGFe/dGh6zWXL9uYgXLMYv8RbpUjxwTKG+EZTiWdoX3qK1aN/uWLGfaOmNNbvorb2f/R
         /lx33hT3tCK8RWxED93y7suWsEhPnL76QvOXTnAIagljcRIuJ/C8PNrgMgpqZF3RxrKb
         Kl/Yv2QfU7gLnN4QdkfqgJ1GhVw2IURS0NEdALLGnRwfSXZrXrRoyNwA380fxFakpYBv
         Xm0OZxe5/YjXMOOXC4iNYu7kE5lsy0ipeVUb3ik+l9AMKgW5kJJGaoZRKsv4ei0Dkxn1
         SGKw==
X-Gm-Message-State: AOAM531wSkTbiekLCXV5rWrz81HpvQf9PBcnNiIRzlg316BzqZrcwd0l
        QaqP1fbW+1p6b+0PovBrkBfHa3kQuHYaoMNNwQx/rFUpQ/URdO0e
X-Google-Smtp-Source: ABdhPJwbNrV4dulQUBkfjcRCevNCy1Kw2yf4Y7BasBw9anREsfkgKJ9n55E30B2Eksvb+wS77o7DH0EynF94YZElPZQ=
X-Received: by 2002:a05:6512:2242:: with SMTP id i2mr4175986lfu.573.1610664217191;
 Thu, 14 Jan 2021 14:43:37 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
 <816e944c-72bc-d94d-449f-bfb915382290@amd.com> <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
 <CABXGCsM8yYNz7gQW26a4hHwBR+MunXoopHEiyDJdC-muNrRxkQ@mail.gmail.com>
 <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com> <CABXGCsOcBMT4rL-bb4K_TzK70YmQsgNX37sHEHiqp_1kK1_UEQ@mail.gmail.com>
 <5f9e7752-68e8-aa5f-80ff-bb1196ea458d@amd.com>
In-Reply-To: <5f9e7752-68e8-aa5f-80ff-bb1196ea458d@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 15 Jan 2021 03:43:24 +0500
Message-ID: <CABXGCsP4KFFeSMLovCPV2yw17Pm9ovzwV5gp3CaQ9vUwx=Y-TA@mail.gmail.com>
Subject: Re: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 at 18:56, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
> Unfortunately not of hand.
>
> I also don't see any bug reports from other people and can't reproduce
> the last backtrace you send out TTM here.

Because only the most desperate will install kernels with enabled
debug flags and then load the system by opening a huge number of
programs and tabs. So you shouldn't be surprised that I'm the only one
here.
This is what my desktop looks like every day: https://imgur.com/a/Kxlmrem

> Do you have any local modifications or special setup in your system?
> Like bpf scripts or something like that?

No, my I didn't write any bpf scripts, but looks like my distribution
Fedora Rawhide uses some bpf scripts by default out of box:

# bpftool prog
20: cgroup_device  tag 40ddf486530245f5  gpl
    loaded_at 2021-01-15T01:30:04+0500  uid 0
    xlated 504B  jited 309B  memlock 4096B
21: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:04+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
22: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:04+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
23: cgroup_device  tag ca8e50a3c7fb034b  gpl
    loaded_at 2021-01-15T01:30:05+0500  uid 0
    xlated 496B  jited 307B  memlock 4096B
24: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:05+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
25: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:05+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
26: cgroup_device  tag be31ae23198a0378  gpl
    loaded_at 2021-01-15T01:30:13+0500  uid 0
    xlated 464B  jited 288B  memlock 4096B
27: cgroup_device  tag ee0e253c78993a24  gpl
    loaded_at 2021-01-15T01:30:13+0500  uid 0
    xlated 416B  jited 255B  memlock 4096B
28: cgroup_device  tag 438c5618576e5b0c  gpl
    loaded_at 2021-01-15T01:30:13+0500  uid 0
    xlated 568B  jited 354B  memlock 4096B
29: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:13+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
30: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:13+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
31: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:13+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
32: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:13+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
33: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:14+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
34: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:14+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
35: cgroup_device  tag ee0e253c78993a24  gpl
    loaded_at 2021-01-15T01:30:14+0500  uid 0
    xlated 416B  jited 255B  memlock 4096B
38: cgroup_device  tag 3a0ef5414c2f6fca  gpl
    loaded_at 2021-01-15T01:30:14+0500  uid 0
    xlated 744B  jited 447B  memlock 4096B
39: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:14+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
40: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:14+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
41: cgroup_device  tag ee0e253c78993a24  gpl
    loaded_at 2021-01-15T01:30:18+0500  uid 0
    xlated 416B  jited 255B  memlock 4096B
42: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:18+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B
43: cgroup_skb  tag 6deef7357e7b4530  gpl
    loaded_at 2021-01-15T01:30:18+0500  uid 0
    xlated 64B  jited 54B  memlock 4096B

I catched yet another couples of leaks , but nothing new:
https://pastebin.com/2EgvYJdz

[1] do_detailed_mode+0x7c1/0x13d0 [drm]
[2] drm_mode_duplicate+0x45/0x220 [drm]
[3] do_seccomp+0x215/0x2280
[4] __vmalloc_node_range+0x464/0x7b0
[5] bpf_prog_alloc_no_stats+0xa2/0x2b0
[6] bpf_prog_store_orig_filter+0x7b/0x1c0
[7] kmemdup+0x1a/0x40

Did the following trace message confuse anyone?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in
kfd_create_crat_image_virtual+0x12d2/0x1380 [amdgpu]
Read of size 1 at addr ffff88812a6b4181 by task systemd-udevd/491

CPU: 20 PID: 491 Comm: systemd-udevd Not tainted
5.11.0-0.rc3.20210114git65f0d2414b70.125.fc34.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 2802 10/21/2020
Call Trace:
 dump_stack+0xae/0xe5
 print_address_description.constprop.0+0x18/0x160
 ? kfd_create_crat_image_virtual+0x12d2/0x1380 [amdgpu]
 kasan_report.cold+0x7f/0x10e
 ? kfd_create_crat_image_virtual+0x12d2/0x1380 [amdgpu]
 kfd_create_crat_image_virtual+0x12d2/0x1380 [amdgpu]
 ? kfd_create_crat_image_acpi+0x340/0x340 [amdgpu]
 ? __raw_spin_lock_init+0x39/0x110
 kfd_topology_init+0x2ac/0x400 [amdgpu]
 ? kfd_create_topology_device+0x320/0x320 [amdgpu]
 ? __class_register+0x2ad/0x430
 ? __class_create+0xc5/0x130
 kgd2kfd_init+0x95/0xf0 [amdgpu]
 amdgpu_amdkfd_init+0x7f/0xb0 [amdgpu]
 ? smuio_v11_0_update_rom_clock_gating+0x1d0/0x1d0 [amdgpu]
 ? record_print_text.cold+0x11/0x11
 ? kmem_cache_create_usercopy+0x25c/0x310
 amdgpu_init+0x59/0x1000 [amdgpu]
 ? 0xffffffffc1f12000
 do_one_initcall+0xfb/0x530
 ? perf_trace_initcall_level+0x3d0/0x3d0
 ? __memset+0x29/0x30
 ? unpoison_range+0x3a/0x60
 do_init_module+0x1ce/0x7a0
 load_module+0x9841/0xa380
 ? module_frob_arch_sections+0x20/0x20
 ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
 ? sched_clock_cpu+0x18/0x170
 ? irqtime_account_irq+0x44/0x1e0
 ? sched_clock+0x5/0x10
 ? lock_acquire+0x2dd/0x7a0
 ? sched_clock+0x5/0x10
 ? lock_is_held_type+0xb8/0xf0
 ? __do_sys_init_module+0x18b/0x220
 __do_sys_init_module+0x18b/0x220
 ? load_module+0xa380/0xa380
 ? ktime_get_coarse_real_ts64+0x12f/0x160
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fc22aecaeee
Code: 48 8b 0d 85 1f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 52 1f 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc62d60e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
RAX: ffffffffffffffda RBX: 0000560489080060 RCX: 00007fc22aecaeee
RDX: 0000560489080f70 RSI: 0000000001e2e8f6 RDI: 00007fc226471010
RBP: 00007fc226471010 R08: 000056048907d470 R09: 00007ffc62d5d606
R10: 00005601e94f449d R11: 0000000000000246 R12: 0000560489080f70
R13: 000056048907c9b0 R14: 0000000000000000 R15: 00005604890814e0

Allocated by task 491:
 kasan_save_stack+0x1b/0x40
 ____kasan_kmalloc.constprop.0+0x84/0xa0
 kfd_create_crat_image_virtual+0x13b/0x1380 [amdgpu]
 kfd_topology_init+0x2ac/0x400 [amdgpu]
 kgd2kfd_init+0x95/0xf0 [amdgpu]
 amdgpu_amdkfd_init+0x7f/0xb0 [amdgpu]
 amdgpu_init+0x59/0x1000 [amdgpu]
 do_one_initcall+0xfb/0x530
 do_init_module+0x1ce/0x7a0
 load_module+0x9841/0xa380
 __do_sys_init_module+0x18b/0x220
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88812a6b4100
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 1 bytes to the right of
 128-byte region [ffff88812a6b4100, ffff88812a6b4180)
The buggy address belongs to the page:
page:00000000edb67e0c refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x12a6b4
flags: 0x17ffffc0000200(slab)
raw: 0017ffffc0000200 ffffea000406a140 0000000500000005 ffff888100041640
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88812a6b4080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88812a6b4100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88812a6b4180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88812a6b4200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88812a6b4280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Disabling lock debugging due to kernel taint


Full kernel log: https://pastebin.com/bUiXRVYw
Kernel build options: https://pastebin.com/v3zsC03i

--
Best Regards,
Mike Gavrilov.
