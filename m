Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD592C02E8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgKWKDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgKWKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:03:05 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CCEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:03:05 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lv15so16574775ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=h6C7EoTLArMMVvu3JmE9UHMGRmlJ5CaWa3z5C+js+OY=;
        b=kWCHLxEOHlni3gTPeVp4T9X7sZ0O3xhoUX7ROxQHr7vrCNjfILxSN8IrAX4vUasPMl
         0VjrAoHYsrDe6Ei4M3me8WO8AbDU8DkWQe2fOR3fOhy6vqzZqUsXl9zpoPsJv5CXWD4l
         tQYDNNMs7YPpwaPUe+37L05KivFI7SUrnZ4RoObxDIjJtYa0r5lwci0Aw5A6KjOiVQ2X
         PDB7QGD8j0TWulYJ2l0lbO7FzJApOUndlxJN2kVEAHAJuY3gAxFAB3r/26KSB8lRymeJ
         gXzytlV4fQ/1BT4PhMxQrs5rOcaCZP92cgmhE9qGp1gR+KNlRK9T/AhDfrGuVLdP/0QN
         fFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=h6C7EoTLArMMVvu3JmE9UHMGRmlJ5CaWa3z5C+js+OY=;
        b=Ul69dqfiRGrmhNbaaWhVJDYTFjiP/Po1Em8if3P6c0wpa+JWXo+9Te3wTn4znGcTg8
         xE5hVByWwsGv/ra0qHQp5LgxXae1LSnWHv2jhqlaS2wwjTxXWqKcXSmfKjiKAidTb20T
         IYw3x63ujzIwbYto70t1pAVWhB+fH/+MuFWrwHBm/2dRqF8DGJpodRa1cfsY1b6WL5UM
         gdlv43viK+34Qpq1dZ3IfLkjSLihjvn0GqbklKDnk+66VTC0qwz0UyLWsWS+KTR0DSTM
         CTtl35KHmU/Q573zRXYzmlIiZa92GQXcSOcAOz6UpXl6eigXv/fdpf08+G808MIhxitE
         VtyQ==
X-Gm-Message-State: AOAM531IA3ltt/oJSaha8JQg7MCUWYN6oMTGTxjM3EmNTBxgy67aAqjc
        2jIexb7/EdGb6dt8hQeHV91ftxqMTarkzWpggwBIZbEpxp1B+GBs
X-Google-Smtp-Source: ABdhPJzeb/Ij75Sgx4A827AfwkX0i0Ip27uTxn6CS7kCzgdEWjkWFlB5+ADYnqv0y76GUQn0r6a9gsQbrt7c8G3x/3A=
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr5233121eju.375.1606125781507;
 Mon, 23 Nov 2020 02:03:01 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 23 Nov 2020 15:32:49 +0530
Message-ID: <CA+G9fYsqsEjsNiZUSBRaOeXrB-PaK09yr89P2Wx_p0+1UxKsAQ@mail.gmail.com>
Subject: [arm] Internal error: Oops: 17 : __traceiter_kmem_cache_alloc
To:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP tracing on qemu_arm the following kernel crash was noticed
on the linux mainline master branch kernel.

Please find these easy steps to reproduce the kernel build and test steps

step to reproduce:
# please install tuxmake
# sudo pip3 install -U tuxmake
# cd linux
# tuxmake --runtime docker --target-arch arm --toolchain gcc-9
--kconfig defconfig --kconfig-add
https://builds.tuxbuild.com/1kfUeRj2jJIxnGeUvaqc3X5AffD/config
# Boot the qemu_arm
# /usr/bin/qemu-system-aarch64 -cpu host,aarch64=off -machine
virt-2.10,accel=kvm -nographic -net
nic,model=virtio,macaddr=BA:DD:AD:CC:09:07 -net tap -m 2048 -monitor
none -kernel /kernel/zImage --append "console=ttyAMA0 root=/dev/vda
rw" -hda /rootfs/rpb-console-image-lkft-am57xx-evm-20201022181203-3085.rootfs.ext4
-m 4096 -smp 2 -nographic

# run ltp tracing
# cd /opt/ltp
# ./runltp -f tracing

Crash log
--------------
ftrace-stress-test 1 TINFO: Start pid15=684
/opt/ltp/testcases/bin/ftrace_stress/ftrace_buffer_size_kb.sh
ftrace-stress-test 1 TINFO: Start pid16=690
/opt/ltp/testcases/bin/ftrace_stress/ftrace_tracing_cpumask.sh
ftrace-stress-test 1 TINFO: Start pid17=692
/opt/ltp/testcases/bin/ftrace_stress/ftrace_set_ftrace_filter.sh
[   25.092146] 8<--- cut here ---
[   25.093626] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[   25.097020] pgd = 4cf4586c
[   25.098184] [00000000] *pgd=fb30f835
[   25.100095] Internal error: Oops: 17 [#1] SMP ARM
[   25.102080] Modules linked in: crc32_arm_ce sha2_arm_ce sha256_arm
sha1_arm_ce sha1_arm aes_arm_ce crypto_simd
[   25.106741] CPU: 1 PID: 659 Comm: sh Not tainted 5.10.0-rc5 #2
[   25.109355] Hardware name: Generic DT based system
[   25.111768] PC is at __traceiter_kmem_cache_alloc+0x38/0x70
[   25.114516] LR is at kmem_cache_alloc+0x4ac/0x598
[   25.116855] pc : [<c04aebd8>]    lr : [<c04f44fc>]    psr: 60000013
[   25.120096] sp : c4683e28  ip : c04aebb8  fp : c4683e5c
[   25.122777] r10: c051dbbc  r9 : 00001000  r8 : 00000cc0
[   25.125367] r7 : c21da000  r6 : 00001000  r5 : 00000000  r4 : 00000000
[   25.128579] r3 : 00001000  r2 : c21da000  r1 : c051dbbc  r0 : c1f32e60
[   25.131988] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   25.135803] Control: 10c5383d  Table: 4401406a  DAC: 00000051
[   25.138762] Process sh (pid: 659, stack limit = 0xcb88fdd8)
[   25.141679] Stack: (0xc4683e28 to 0xc4684000)
[   25.144063] 3e20:                   00000006 c1d04f08 c20f9480
c20f9480 00000000 c21da000
[   25.148378] 3e40: 00000cc0 c1d056cc c1f9d20c 00024937 c4683e9c
c4683e60 c03131b4 c04aebac
[   25.152710] 3e60: 00001000 00000cc0 c051dbbc c21dc000 00000000
00000000 00000000 00105748
[   25.157000] 3e80: 00000000 00000000 c1d05890 ffffff9c c4683ecc
c4683ea0 c03131b4 c04f405c
[   25.161193] 3ea0: 00000001 00000000 00000000 00000000 00000000
c4683f38 00000000 ffffff9c
[   25.165376] 3ec0: c4683edc c4683ed0 c03131b4 c051db94 c4683f34
c4683ee0 c03131b4 c051dcec
[   25.169368] 3ee0: c03f5374 c4683f90 c0509598 00000002 00020241
c03081b6 00000002 00000300
[   25.173435] 3f00: 00000001 c1d04f08 00104a68 000001b6 00000000
00020241 00000000 ffffff9c
[   25.177849] 3f20: 00105748 00000142 c4683f94 c4683f38 c03131b4
c0507b48 00020241 00000000
[   25.181908] 3f40: 000001b6 00000000 00000000 00000000 00020241
00000000 000001b6 00000000
[   25.185915] 3f60: 00000000 00000000 00104a68 c1d04f08 00104a68
00000000 00000002 00000142
[   25.190042] 3f80: c0300284 c4682000 c4683fa4 c4683f98 c03131b4
c050947c 00000000 c4683fa8
[   25.194293] 3fa0: c03131b4 c0509588 00104a68 00000000 ffffff9c
00105748 00020241 000001b6
[   25.198263] 3fc0: 00104a68 00000000 00000002 00000142 00000003
00105748 b6f522f0 be80bf74
[   25.202447] 3fe0: 00000064 be80be30 b6ede000 b6e60668 60000010
ffffff9c 00000000 00000000
[   25.206570] Backtrace:
[   25.207873] [<c04aeba0>] (__traceiter_kmem_cache_alloc) from
[<c03131b4>] (return_to_handler+0x0/0x18)
[   25.212483]  r10:00024937 r9:c1f9d20c r8:c1d056cc r7:00000cc0
r6:c21da000 r5:00000000
[   25.216468]  r4:c20f9480
[   25.217838] [<c04f4050>] (kmem_cache_alloc) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   25.222105]  r10:ffffff9c r9:c1d05890 r8:00000000 r7:00000000
r6:00105748 r5:00000000
[   25.225926]  r4:00000000
[   25.227298] [<c051db88>] (getname_flags) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   25.231382]  r10:ffffff9c r9:00000000 r8:c4683f38 r7:00000000
r6:00000000 r5:00000000
[   25.235203]  r4:00000000 r3:00000001
[   25.237027] [<c051dce0>] (getname) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   25.240709] [<c0507b3c>] (do_sys_openat2) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   25.244824]  r10:00000142 r9:00105748 r8:ffffff9c r7:00000000
r6:00020241 r5:00000000
[   25.248778]  r4:000001b6
[   25.250190] [<c0509470>] (do_sys_open) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   25.254172]  r9:c4682000 r8:c0300284 r7:00000142 r6:00000002
r5:00000000 r4:00104a68
[   25.257969] [<c050957c>] (sys_openat) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   25.261786] Code: e590403c e1a07002 e59b8008 e1a06003 (e5945000)
[   25.265178] ---[ end trace ce6fdcdd133daa28 ]---
[   27.003188] 8<--- cut here ---
[   27.004635] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[   27.007952] pgd = 932e7ef5
[   27.009128] [00000000] *pgd=fb2eb835
[   27.010918] Internal error: Oops: 17 [#2] SMP ARM
[   27.013298] Modules linked in: crc32_arm_ce sha2_arm_ce sha256_arm
sha1_arm_ce sha1_arm aes_arm_ce crypto_simd
[   27.018390] CPU: 0 PID: 720 Comm: sh Tainted: G      D
5.10.0-rc5 #2
[   27.021918] Hardware name: Generic DT based system
[   27.024296] PC is at __traceiter_rcu_dyntick+0x34/0x68
[   27.026836] LR is at rcu_nmi_enter+0x14c/0x158
[   27.029062] pc : [<c03c839c>]    lr : [<c123a8a8>]    psr: 600d0193
[   27.032178] sp : c4749cb8  ip : c03c8380  fp : c4749ce4
[   27.034764] r10: 0000006b  r9 : c18e0b5c  r8 : 0011c3fa
[   27.037369] r7 : 40000000  r6 : 40000002  r5 : ee4d5ec0  r4 : 00000000
[   27.040596] r3 : 40000002  r2 : 40000000  r1 : c18e0b5c  r0 : c1f31d80
[   27.043812] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[   27.047394] Control: 10c5383d  Table: 446dc06a  DAC: 00000051
[   27.050239] Process sh (pid: 720, stack limit = 0xab7b3677)
[   27.053024] Stack: (0xc4749cb8 to 0xc474a000)
[   27.055215] 9ca0:
    c04485a0 c0424b40
[   27.059197] 9cc0: 00000002 ee4d5ec0 c1d04f58 00000000 0000001f
00000000 c4749d14 c4749ce8
[   27.063169] 9ce0: c03131b4 c03c8374 0011c3fa c4749cf8 c03134dc
600d0193 c04243cc c4748000
[   27.067238] 9d00: c1f32460 c04486c8 c4749d24 c4749d18 c123a8c4
c123a768 c4749d3c c4749d28
[   27.071236] 9d20: c03d5394 c123a8c0 c1cbbc10 c04243cc c4749d64
c4749d40 c03131b4 c03d5378
[   27.075225] 9d40: ee4cfbc0 c4749d90 49832e2c 00000006 00000000
000d0113 c4749d8c c4749d68
[   27.079216] 9d60: c04243cc c0443044 c031cf2c c03184a4 49832e2c
00000006 ff87959f c32c3180
[   27.083208] 9d80: c4749dcc c4749d90 c04486c8 c04242bc c03184a4
00000000 49832e2c 00000006
[   27.087198] 9da0: 49837274 00000006 00000007 c1d04f08 ff87959f
000ff879 c330d6c0 00000000
[   27.091201] 9dc0: c4749df4 c4749dd0 c03131c0 c0448638 00000001
00000001 ffffffff 00000000
[   27.095222] 9de0: ffefe758 effe8104 c4749e14 c4749df8 c03131b4
c031cef8 c4749e44 ff87959f
[   27.099234] 9e00: c03131c0 c4749ec8 c4749e44 c4749e18 c03131b4
c031ddb4 effe8120 effe8104
[   27.103234] 9e20: 00000001 00000406 00000402 c4749ec8 c32c3180
0000006b c4749ea4 c4749e48
[   27.107227] 9e40: c03131b4 c04c2734 effe8120 00000062 c2ca9420
00000000 c031f4fc c2ca9424
[   27.111218] 9e60: 00000062 00220000 c2c73ab0 00000000 00000000
c1d04f08 00000254 00000254
[   27.115217] 9e80: b6ddf000 0000005c 00000040 c4749fb0 0000006b
c4749ec8 c4749f2c c4749ea8
[   27.119222] 9ea0: c03131b4 c0481970 c4749edc c4749eb8 c04243cc
c0443044 c1242404 c04c6218
[   27.123546] 9ec0: 496c8640 b6ddf000 c330d6c0 00000254 00100cca
0000006b b6dd6000 c46dedb0
[   27.127869] 9ee0: c46dedb0 00000000 00000000 00000000 ffefe758
eff45470 00000000 c1d04f08
[   27.131949] 9f00: c4749fb0 c4749fb0 b6ddfd74 80000007 c473a400
c473a444 00000000 00000254
[   27.135930] 9f20: c4749f74 c4749f30 c03131b4 c04c2b18 10c5383d
10c5387d c4749f5c c4749f48
[   27.139904] 9f40: c03134dc c04484ac b6ddfd74 00000007 c1d0b9e0
b6ddfd74 c4749fb0 c12422fc
[   27.143826] 9f60: 000c8b64 000f60ac c4749fac c4749f78 c03131b4
c1242308 c1d93f00 c1cb7b08
[   27.147820] 9f80: 2c818000 00020783 b6ddfd74 b6ddfd74 600d0010
ffffffff 10c5383d 10c5387d
[   27.151819] 9fa0: 00000000 c4749fb0 c03131b4 c0318400 b6eb07dc
00103688 00000000 00000b39
[   27.155822] 9fc0: 001035c0 000000ff 000f4d5c 000002d0 00000000
000c8b64 000f60ac 00102440
[   27.159899] 9fe0: 000ef094 beef2628 000683f8 b6ddfd74 600d0010
ffffffff 00000000 00000000
[   27.163927] Backtrace:
[   27.165235] [<c03c8368>] (__traceiter_rcu_dyntick) from
[<c03131b4>] (return_to_handler+0x0/0x18)
[   27.169524]  r9:00000000 r8:0000001f r7:00000000 r6:c1d04f58
r5:ee4d5ec0 r4:00000002
[   27.173340] [<c123a75c>] (rcu_nmi_enter) from [<c123a8c4>]
(rcu_irq_enter+0x10/0x14)
[   27.177170]  r8:c04486c8 r7:c1f32460 r6:c4748000 r5:c04243cc r4:600d0193
[   27.180507] [<c123a8b4>] (rcu_irq_enter) from [<c03d5394>]
(rcu_irq_enter_irqson+0x28/0x44)
[   27.184606] [<c03d536c>] (rcu_irq_enter_irqson) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   27.188847]  r5:c04243cc r4:c1cbbc10
[   27.190673] [<c0443038>] (trace_hardirqs_on) from [<c04243cc>]
(profile_graph_return+0x11c/0x1a4)
[   27.195072]  r9:000d0113 r8:00000000 r7:00000006 r6:49832e2c
r5:c4749d90 r4:ee4cfbc0
[   27.198881] [<c04242b0>] (profile_graph_return) from [<c04486c8>]
(ftrace_return_to_handler+0x9c/0x150)
[   27.203459]  r9:c32c3180 r8:ff87959f r7:00000006 r6:49832e2c
r5:c03184a4 r4:c031cf2c
[   27.207323] [<c044862c>] (ftrace_return_to_handler) from
[<c03131c0>] (return_to_handler+0xc/0x18)
[   27.211740]  r7:00000000 r6:c330d6c0 r5:000ff879 r4:ff87959f
[   27.214585] [<c031ceec>] (__sync_icache_dcache) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   27.218843]  r5:effe8104 r4:ffefe758
[   27.220652] [<c031dda8>] (set_pte_at) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   27.224463]  r4:c4749ec8
[   27.225781] [<c04c2728>] (alloc_set_pte) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   27.229713]  r10:0000006b r9:c32c3180 r8:c4749ec8 r7:00000402
r6:00000406 r5:00000001
[   27.233562]  r4:effe8104 r3:effe8120
[   27.235377] [<c0481964>] (filemap_map_pages) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   27.239487]  r10:c4749ec8 r9:0000006b r8:c4749fb0 r7:00000040
r6:0000005c r5:b6ddf000
[   27.243384]  r4:00000254
[   27.244705] [<c04c2b0c>] (handle_mm_fault) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   27.248734]  r10:00000254 r9:00000000 r8:c473a444 r7:c473a400
r6:80000007 r5:b6ddfd74
[   27.252596]  r4:c4749fb0
[   27.253940] [<c12422fc>] (do_page_fault) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   27.257918]  r10:000f60ac r9:000c8b64 r8:c12422fc r7:c4749fb0
r6:b6ddfd74 r5:c1d0b9e0
[   27.261779]  r4:00000007
[   27.263082] [<c03183f4>] (do_PrefetchAbort) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   27.267143]  r8:10c5387d r7:10c5383d r6:ffffffff r5:600d0010 r4:b6ddfd74
[   27.270446] Code: e1a09001 e590415c e1a07002 e1a06003 (e5945000)
[   27.273460] ---[ end trace ce6fdcdd133daa29 ]---
[   50.299401] rcu: INFO: rcu_sched self-detected stall on CPU
[   50.301847] rcu: 0-....: (2100 ticks this GP) idle=412/1/0x40000002
softirq=8327/8327 fqs=1050
[   50.305470] (t=2101 jiffies g=2009 q=19405)
[   50.305477] NMI backtrace for cpu 0
[   50.308732] CPU: 0 PID: 720 Comm: sh Tainted: G      D
5.10.0-rc5 #2
[   50.311706] Hardware name: Generic DT based system
[   50.313709] Backtrace:
[   50.314838] [<c122432c>] (dump_backtrace) from [<c12246ec>]
(show_stack+0x20/0x24)
[   50.317983]  r7:c1df85ac r6:60000193 r5:00000000 r4:c1df85ac
[   50.320340] [<c12246cc>] (show_stack) from [<c122a034>]
(dump_stack+0xe4/0x104)
[   50.323613] [<c1229f50>] (dump_stack) from [<c084bd0c>]
(nmi_cpu_backtrace+0xd0/0xfc)
[   50.326920]  r10:80000193 r9:c18dfafc r8:c13080c8 r7:00000000
r6:00000000 r5:00000000
[   50.330156]  r4:00000000 r3:c1d04f08
[   50.331677] [<c084bc3c>] (nmi_cpu_backtrace) from [<c084be2c>]
(nmi_trigger_cpumask_backtrace+0xf4/0x13c)
[   50.335648]  r5:c1d0597c r4:c0310e24
[   50.337199] [<c084bd38>] (nmi_trigger_cpumask_backtrace) from
[<c03120e8>] (arch_trigger_cpumask_backtrace+0x20/0x24)
[   50.341567]  r7:c1d8e680 r6:c1d04f5c r5:c1d05008 r4:00000000
[   50.343929] [<c03120c8>] (arch_trigger_cpumask_backtrace) from
[<c12269fc>] (rcu_dump_cpu_stacks+0x10c/0x144)
[   50.348007] [<c12268f0>] (rcu_dump_cpu_stacks) from [<c03d5cb8>]
(rcu_sched_clock_irq+0x7e0/0xa64)
[   50.351676]  r10:2c818000 r9:c1d03d00 r8:c1cbdec0 r7:c1f31d80
r6:00000000 r5:ee4d5ec0
[   50.354905]  r4:c1d8e680
[   50.356002] [<c03d54d8>] (rcu_sched_clock_irq) from [<c03e104c>]
(update_process_times+0x70/0x98)
[   50.359635]  r10:20000193 r9:c4748000 r8:00000000 r7:c4749948
r6:b3bae668 r5:00000000
[   50.362859]  r4:ffffe000
[   50.363963] [<c03e0fdc>] (update_process_times) from [<c03f5aec>]
(tick_sched_handle+0x64/0x68)
[   50.367533]  r5:0000000b r4:ee4cf9a8
[   50.369049] [<c03f5a88>] (tick_sched_handle) from [<c03f5d80>]
(tick_sched_timer+0x5c/0xb8)
[   50.372478] [<c03f5d24>] (tick_sched_timer) from [<c03e1fc8>]
(__hrtimer_run_queues+0xf8/0x3c0)
[   50.376058]  r7:c03f5d24 r6:ee4cf640 r5:ee4cf9a8 r4:ee4cf680
[   50.378394] [<c03e1ed0>] (__hrtimer_run_queues) from [<c03e2ef4>]
(hrtimer_interrupt+0x130/0x2d4)
[   50.382052]  r10:ffffffff r9:ee4cf6c8 r8:ee4cf6f0 r7:ee4cf718
r6:00000003 r5:20000193
[   50.385345]  r4:ee4cf640
[   50.386429] [<c03e2dc4>] (hrtimer_interrupt) from [<c0fee024>]
(arch_timer_handler_virt+0x38/0x40)
[   50.390123]  r10:c4749ae8 r9:c4749948 r8:c20c0800 r7:c2004fc0
r6:0000001a r5:c1d059f8
[   50.393352]  r4:c20f6500
[   50.394436] [<c0fedfec>] (arch_timer_handler_virt) from
[<c03c0244>] (handle_percpu_devid_irq+0x9c/0x22c)
[   50.398431] [<c03c01a8>] (handle_percpu_devid_irq) from
[<c03b9034>] (generic_handle_irq+0x44/0x54)
[   50.402242]  r7:00000000 r6:00000001 r5:00000000 r4:c1cbc244
[   50.404632] [<c03b8ff0>] (generic_handle_irq) from [<c03b9788>]
(__handle_domain_irq+0x6c/0xc0)
[   50.408217] [<c03b971c>] (__handle_domain_irq) from [<c03018ec>]
(gic_handle_irq+0xa0/0xc0)
[   50.411653]  r9:c4749948 r8:f082000c r7:c1cbc250 r6:f0820000
r5:c1df8e08 r4:c1d059f8
[   50.414844] [<c030184c>] (gic_handle_irq) from [<c0300b70>]
(__irq_svc+0x70/0x98)
[   50.417940] Exception stack(0xc4749948 to 0xc4749990)
[   50.420066] 9940:                   eff45470 00000002 00000001
00000001 c330d6c0 b6d75000
[   50.423391] 9960: ffefd5d0 00000000 c4748000 b6d74000 c4749ae8
c47499a4 c47499a8 c4749998
[   50.426779] 9980: c04c0348 c1241fdc 80000013 ffffffff
[   50.428908]  r9:c4748000 r8:c4748000 r7:c474997c r6:ffffffff
r5:80000013 r4:c1241fdc
[   50.432134] [<c1241f98>] (_raw_spin_lock) from [<c04c0348>]
(unmap_page_range+0x1b8/0x824)
[   50.435530] [<c04c0190>] (unmap_page_range) from [<c04c0a44>]
(unmap_single_vma+0x90/0x98)
[   50.438974]  r10:c2316540 r9:ffffe000 r8:00000000 r7:c4749ae8
r6:b6e9f000 r5:b6d74000
[   50.442236]  r4:c330d6c0
[   50.443318] [<c04c09b4>] (unmap_single_vma) from [<c04c0ba4>]
(unmap_vmas+0x3c/0x6c)
[   50.446524]  r7:00000000 r6:c4749ae8 r5:ffffffff r4:c330d6c0
[   50.448885] [<c04c0b68>] (unmap_vmas) from [<c04c8880>]
(exit_mmap+0xec/0x190)
[   50.451872]  r8:00000000 r7:c473a444 r6:c473a400 r5:00000000 r4:c370b660
[   50.454642] [<c04c8794>] (exit_mmap) from [<c034acb8>] (mmput+0x64/0x128)
[   50.457450]  r6:ffffe000 r5:c473a400 r4:c473a400
[   50.459374] [<c034ac54>] (mmput) from [<c0354f20>] (do_exit+0x368/0xab8)
[   50.462149]  r5:c473a400 r4:c2316540
[   50.463653] [<c0354bb8>] (do_exit) from [<c030e434>] (die+0x380/0x38c)
[   50.466418]  r7:c1d0ae6c
[   50.467493] [<c030e0b4>] (die) from [<c03131b4>] (return_to_handler+0x0/0x18)
[   50.470440]  r10:0000006b r9:c4748000 r8:ffffe000 r7:c473a400
r6:00000017 r5:c4749c68
[   50.473667]  r4:00000000
[   50.474744] [<c03181f8>] (__do_kernel_fault.part.0) from
[<c03131b4>] (return_to_handler+0x0/0x18)
[   50.478431]  r7:c473a400 r4:c4749c68
[   50.479967] [<c12422fc>] (do_page_fault) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   50.483257]  r10:0000006b r9:c4748000 r8:c4749c68 r7:c12422fc
r6:00000000 r5:00000017
[   50.486482]  r4:c1d0b7e0
[   50.487571] [<c0318324>] (do_DataAbort) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   50.490870]  r8:0011c3fa r7:c4749c9c r6:ffffffff r5:600d0193 r4:c03c839c
[   50.493674] [<c03c8368>] (__traceiter_rcu_dyntick) from
[<c03131b4>] (return_to_handler+0x0/0x18)
[   50.497329]  r9:00000000 r8:0000001f r7:00000000 r6:c1d04f58
r5:ee4d5ec0 r4:00000002
[   50.500532] [<c123a75c>] (rcu_nmi_enter) from [<c123a8c4>]
(rcu_irq_enter+0x10/0x14)
[   50.503713]  r8:c04486c8 r7:c1f32460 r6:c4748000 r5:c04243cc r4:600d0193
[   50.506501] [<c123a8b4>] (rcu_irq_enter) from [<c03d5394>]
(rcu_irq_enter_irqson+0x28/0x44)
[   50.509949] [<c03d536c>] (rcu_irq_enter_irqson) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   50.513552]  r5:c04243cc r4:c1cbbc10
[   50.515057] [<c0443038>] (trace_hardirqs_on) from [<c04243cc>]
(profile_graph_return+0x11c/0x1a4)
[   50.518698]  r9:000d0113 r8:00000000 r7:00000006 r6:49832e2c
r5:c4749d90 r4:ee4cfbc0
[   50.521904] [<c04242b0>] (profile_graph_return) from [<c04486c8>]
(ftrace_return_to_handler+0x9c/0x150)
[   50.525767]  r9:c32c3180 r8:ff87959f r7:00000006 r6:49832e2c
r5:c03184a4 r4:c031cf2c
[   50.528953] [<c044862c>] (ftrace_return_to_handler) from
[<c03131c0>] (return_to_handler+0xc/0x18)
[   50.532633]  r7:00000000 r6:c330d6c0 r5:000ff879 r4:ff87959f
[   50.534969] [<c031ceec>] (__sync_icache_dcache) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   50.538506]  r5:effe8104 r4:ffefe758
[   50.540008] [<c031dda8>] (set_pte_at) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   50.543178]  r4:c4749ec8
[   50.544275] [<c04c2728>] (alloc_set_pte) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   50.547560]  r10:0000006b r9:c32c3180 r8:c4749ec8 r7:00000402
r6:00000406 r5:00000001
[   50.550777]  r4:effe8104 r3:effe8120
[   50.552298] [<c0481964>] (filemap_map_pages) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   50.555717]  r10:c4749ec8 r9:0000006b r8:c4749fb0 r7:00000040
r6:0000005c r5:b6ddf000
[   50.558956]  r4:00000254
[   50.560065] [<c04c2b0c>] (handle_mm_fault) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   50.563451]  r10:00000254 r9:00000000 r8:c473a444 r7:c473a400
r6:80000007 r5:b6ddfd74
[   50.566676]  r4:c4749fb0
[   50.567759] [<c12422fc>] (do_page_fault) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   50.571062]  r10:000f60ac r9:000c8b64 r8:c12422fc r7:c4749fb0
r6:b6ddfd74 r5:c1d0b9e0
[   50.574298]  r4:00000007
[   50.575373] [<c03183f4>] (do_PrefetchAbort) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[   50.578764]  r8:10c5387d r7:10c5383d r6:ffffffff r5:600d0010 r4:b6ddfd74
[   56.829452] rcu: INFO: rcu_sched detected expedited stalls on
CPUs/tasks: { 0-... } 2112 jiffies s: 105 root: 0x1/.
[   56.833647] rcu: blocking rcu_node structures:
[   56.835568] Task dump for CPU 0:
[   56.836953] task:sh              state:R  running task     stack:
 0 pid:  720 ppid:   690 flags:0x00000002
[   56.841166] Backtrace:
[   56.842171] [<c474998c>] (0xc474998c) from [<c47499a8>] (0xc47499a8)
[   56.844650] [<c473a3f4>] (0xc473a3f4) from [<c4749af0>] (0xc4749af0)
[   56.847122] Backtrace aborted due to bad frame pointer <ed5443ef>
[  113.329402] rcu: INFO: rcu_sched self-detected stall on CPU
[  113.332023] rcu: 0-....: (8376 ticks this GP) idle=412/1/0x40000002
softirq=8327/8327 fqs=4170
[  113.335788] (t=8404 jiffies g=2009 q=76289)
[  113.335795] NMI backtrace for cpu 0
[  113.339113] CPU: 0 PID: 720 Comm: sh Tainted: G      D
5.10.0-rc5 #2
[  113.342132] Hardware name: Generic DT based system
[  113.344136] Backtrace:
[  113.345257] [<c122432c>] (dump_backtrace) from [<c12246ec>]
(show_stack+0x20/0x24)
[  113.348663]  r7:c1df85ac r6:60000193 r5:00000000 r4:c1df85ac
[  113.351115] [<c12246cc>] (show_stack) from [<c122a034>]
(dump_stack+0xe4/0x104)
[  113.354303] [<c1229f50>] (dump_stack) from [<c084bd0c>]
(nmi_cpu_backtrace+0xd0/0xfc)
[  113.357578]  r10:80000193 r9:c18dfafc r8:c13080c8 r7:00000000
r6:00000000 r5:00000000
[  113.360808]  r4:00000000 r3:c1d04f08
[  113.362373] [<c084bc3c>] (nmi_cpu_backtrace) from [<c084be2c>]
(nmi_trigger_cpumask_backtrace+0xf4/0x13c)
[  113.366758]  r5:c1d0597c r4:c0310e24
[  113.368346] [<c084bd38>] (nmi_trigger_cpumask_backtrace) from
[<c03120e8>] (arch_trigger_cpumask_backtrace+0x20/0x24)
[  113.372954]  r7:c1d8e680 r6:c1d04f5c r5:c1d05008 r4:00000000
[  113.375420] [<c03120c8>] (arch_trigger_cpumask_backtrace) from
[<c12269fc>] (rcu_dump_cpu_stacks+0x10c/0x144)
[  113.379611] [<c12268f0>] (rcu_dump_cpu_stacks) from [<c03d5cb8>]
(rcu_sched_clock_irq+0x7e0/0xa64)
[  113.383441]  r10:2c818000 r9:c1d03d00 r8:c1cbdec0 r7:c1f31d80
r6:00000000 r5:ee4d5ec0
[  113.386861]  r4:c1d8e680
[  113.387975] [<c03d54d8>] (rcu_sched_clock_irq) from [<c03e104c>]
(update_process_times+0x70/0x98)
[  113.391750]  r10:20000193 r9:c4748000 r8:00000000 r7:c4749948
r6:609c59e4 r5:00000000
[  113.395122]  r4:ffffe000
[  113.396234] [<c03e0fdc>] (update_process_times) from [<c03f5aec>]
(tick_sched_handle+0x64/0x68)
[  113.399929]  r5:0000001a r4:ee4cf9a8
[  113.401505] [<c03f5a88>] (tick_sched_handle) from [<c03f5d80>]
(tick_sched_timer+0x5c/0xb8)
[  113.405106] [<c03f5d24>] (tick_sched_timer) from [<c03e1fc8>]
(__hrtimer_run_queues+0xf8/0x3c0)
[  113.408848]  r7:c03f5d24 r6:ee4cf640 r5:ee4cf9a8 r4:ee4cf680
[  113.411369] [<c03e1ed0>] (__hrtimer_run_queues) from [<c03e2ef4>]
(hrtimer_interrupt+0x130/0x2d4)
[  113.415431]  r10:ffffffff r9:ee4cf6c8 r8:ee4cf6f0 r7:ee4cf718
r6:00000003 r5:20000193
[  113.418910]  r4:ee4cf640
[  113.420136] [<c03e2dc4>] (hrtimer_interrupt) from [<c0fee024>]
(arch_timer_handler_virt+0x38/0x40)
[  113.424271]  r10:c4749ae8 r9:c4749948 r8:c20c0800 r7:c2004fc0
r6:0000001a r5:c1d059f8
[  113.427549]  r4:c20f6500
[  113.428622] [<c0fedfec>] (arch_timer_handler_virt) from
[<c03c0244>] (handle_percpu_devid_irq+0x9c/0x22c)
[  113.432921] [<c03c01a8>] (handle_percpu_devid_irq) from
[<c03b9034>] (generic_handle_irq+0x44/0x54)
[  113.436681]  r7:00000000 r6:00000001 r5:00000000 r4:c1cbc244
[  113.439058] [<c03b8ff0>] (generic_handle_irq) from [<c03b9788>]
(__handle_domain_irq+0x6c/0xc0)
[  113.442618] [<c03b971c>] (__handle_domain_irq) from [<c03018ec>]
(gic_handle_irq+0xa0/0xc0)
[  113.446381]  r9:c4749948 r8:f082000c r7:c1cbc250 r6:f0820000
r5:c1df8e08 r4:c1d059f8
[  113.449733] [<c030184c>] (gic_handle_irq) from [<c0300b70>]
(__irq_svc+0x70/0x98)
[  113.452928] Exception stack(0xc4749948 to 0xc4749990)
[  113.469892] 9940:                   eff45470 00000002 00000001
00000001 c330d6c0 b6d75000
[  113.512042] 9960: ffefd5d0 00000000 c4748000 b6d74000 c4749ae8
c47499a4 c47499a8 c4749998
[  113.515704] 9980: c04c0348 c1241fd8 80000013 ffffffff
[  113.517991]  r9:c4748000 r8:c4748000 r7:c474997c r6:ffffffff
r5:80000013 r4:c1241fd8
[  113.521186] [<c1241f98>] (_raw_spin_lock) from [<c04c0348>]
(unmap_page_range+0x1b8/0x824)
[  113.524653] [<c04c0190>] (unmap_page_range) from [<c04c0a44>]
(unmap_single_vma+0x90/0x98)
[  113.528076]  r10:c2316540 r9:ffffe000 r8:00000000 r7:c4749ae8
r6:b6e9f000 r5:b6d74000
[  113.531326]  r4:c330d6c0
[  113.532397] [<c04c09b4>] (unmap_single_vma) from [<c04c0ba4>]
(unmap_vmas+0x3c/0x6c)
[  113.535570]  r7:00000000 r6:c4749ae8 r5:ffffffff r4:c330d6c0
[  113.537922] [<c04c0b68>] (unmap_vmas) from [<c04c8880>]
(exit_mmap+0xec/0x190)
[  113.540919]  r8:00000000 r7:c473a444 r6:c473a400 r5:00000000 r4:c370b660
[  113.543707] [<c04c8794>] (exit_mmap) from [<c034acb8>] (mmput+0x64/0x128)
[  113.546527]  r6:ffffe000 r5:c473a400 r4:c473a400
[  113.548435] [<c034ac54>] (mmput) from [<c0354f20>] (do_exit+0x368/0xab8)
[  113.551203]  r5:c473a400 r4:c2316540
[  113.552697] [<c0354bb8>] (do_exit) from [<c030e434>] (die+0x380/0x38c)
[  113.555389]  r7:c1d0ae6c
[  113.556457] [<c030e0b4>] (die) from [<c03131b4>] (return_to_handler+0x0/0x18)
[  113.559406]  r10:0000006b r9:c4748000 r8:ffffe000 r7:c473a400
r6:00000017 r5:c4749c68
[  113.562632]  r4:00000000
[  113.563711] [<c03181f8>] (__do_kernel_fault.part.0) from
[<c03131b4>] (return_to_handler+0x0/0x18)
[  113.567363]  r7:c473a400 r4:c4749c68
[  113.568829] [<c12422fc>] (do_page_fault) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[  113.572157]  r10:0000006b r9:c4748000 r8:c4749c68 r7:c12422fc
r6:00000000 r5:00000017
[  113.575465]  r4:c1d0b7e0
[  113.576551] [<c0318324>] (do_DataAbort) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[  113.579788]  r8:0011c3fa r7:c4749c9c r6:ffffffff r5:600d0193 r4:c03c839c
[  113.582553] [<c03c8368>] (__traceiter_rcu_dyntick) from
[<c03131b4>] (return_to_handler+0x0/0x18)
[  113.586196]  r9:00000000 r8:0000001f r7:00000000 r6:c1d04f58
r5:ee4d5ec0 r4:00000002
[  113.642656] [<c123a75c>] (rcu_nmi_enter) from [<c123a8c4>]
(rcu_irq_enter+0x10/0x14)
[  113.645985]  r8:c04486c8 r7:c1f32460 r6:c4748000 r5:c04243cc r4:600d0193
[  113.648793] [<c123a8b4>] (rcu_irq_enter) from [<c03d5394>]
(rcu_irq_enter_irqson+0x28/0x44)
[  113.652321] [<c03d536c>] (rcu_irq_enter_irqson) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[  113.655956]  r5:c04243cc r4:c1cbbc10
[  113.657459] [<c0443038>] (trace_hardirqs_on) from [<c04243cc>]
(profile_graph_return+0x11c/0x1a4)
[  113.661051]  r9:000d0113 r8:00000000 r7:00000006 r6:49832e2c
r5:c4749d90 r4:ee4cfbc0
[  113.664255] [<c04242b0>] (profile_graph_return) from [<c04486c8>]
(ftrace_return_to_handler+0x9c/0x150)
[  113.668060]  r9:c32c3180 r8:ff87959f r7:00000006 r6:49832e2c
r5:c03184a4 r4:c031cf2c
[  113.671233] [<c044862c>] (ftrace_return_to_handler) from
[<c03131c0>] (return_to_handler+0xc/0x18)
[  113.674871]  r7:00000000 r6:c330d6c0 r5:000ff879 r4:ff87959f
[  113.677225] [<c031ceec>] (__sync_icache_dcache) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[  113.680721]  r5:effe8104 r4:ffefe758
[  113.682213] [<c031dda8>] (set_pte_at) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[  113.685492]  r4:c4749ec8
[  113.686597] [<c04c2728>] (alloc_set_pte) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[  113.689965]  r10:0000006b r9:c32c3180 r8:c4749ec8 r7:00000402
r6:00000406 r5:00000001
[  113.693281]  r4:effe8104 r3:effe8120
[  113.694820] [<c0481964>] (filemap_map_pages) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[  113.698536]  r10:c4749ec8 r9:0000006b r8:c4749fb0 r7:00000040
r6:0000005c r5:b6ddf000
[  113.701827]  r4:00000254
[  113.702931] [<c04c2b0c>] (handle_mm_fault) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[  113.706352]  r10:00000254 r9:00000000 r8:c473a444 r7:c473a400
r6:80000007 r5:b6ddfd74
[  113.721917]  r4:c4749fb0
[  113.751301] [<c12422fc>] (do_page_fault) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[  113.767276]  r10:000f60ac r9:000c8b64 r8:c12422fc r7:c4749fb0
r6:b6ddfd74 r5:c1d0b9e0
[  113.770706]  r4:00000007
[  113.771784] [<c03183f4>] (do_PrefetchAbort) from [<c03131b4>]
(return_to_handler+0x0/0x18)
[  113.775293]  r8:10c5387d r7:10c5383d r6:ffffffff r5:600d0010 r4:b6ddfd74
/opt/ltp/testcases/bin/ftrace_lib.sh: line 176:   659 Segmentation
fault      sh ftrace_${target}.sh
ftrace-stress-test 1 TINFO: killing 658
<>
[  965.948651] Out of memory and no killable processes...
[  965.950965] Kernel panic - not syncing: System is deadlocked on memory

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git commit: 418baf2c28f3473039f2f7377760bd8f6897ae18
  git describe: v5.10-rc5
  make_kernelversion: 5.10.0-rc5
  kernel-config: https://builds.tuxbuild.com/1kfUeRj2jJIxnGeUvaqc3X5AffD/config

full test log link,
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.10-rc5/testrun/3476119/suite/linux-log-parser/test/check-kernel-oops-1967813/log

-- 
Linaro LKFT
https://lkft.linaro.org
